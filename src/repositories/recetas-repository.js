import { Client } from 'pg';
import dbConfig from '../configs/db-config.js';

export default class RecetasRepository {
  async getUserTags(userId) {
    const client = new Client(dbConfig);
    await client.connect();

    try {
      const res = await client.query('SELECT tags FROM usuarios WHERE id = $1', [userId]);
      return res.rows[0].tags;
    } finally {
      await client.end();
    }
  }

  async getRecipesByTag(userTags) {
    const client = new Client(dbConfig);
    await client.connect();

    try {
      const recipes = await client.query('SELECT * FROM recetas WHERE tags && $1', [userTags]);
      return recipes.rows;
    } finally {
      await client.end();
    }
  }

  async searchRecipes(userTags, tipoCocina, ingredientes, maxCalorias, maxTiempo) {
    const client = new Client(dbConfig);
    await client.connect();

    let query = 'SELECT r.* FROM recetas r WHERE r.tags && $1';
    let queryParams = [userTags];

    if (tipoCocina) {
      query += ' AND r.tipo_cocina = ANY($2)';
      queryParams.push(tipoCocina);
    }

    if (ingredientes) {
      query +=
        ' AND r.id IN (' +
        'SELECT ri.receta_id FROM receta_ingredientes ri ' +
        'INNER JOIN ingredientes i ON i.id = ri.ingrediente_id ' +
        'WHERE i.nombre = ANY($3)' +
        ')';
      queryParams.push(ingredientes);
    }

    if (maxCalorias) {
      query += ' AND r.calorias <= $4';
      queryParams.push(maxCalorias);
    }

    if (maxTiempo) {
      query += ' AND r.tiempo <= $5';
      queryParams.push(maxTiempo);
    }

    try {
      const recipes = await client.query(query, queryParams);
      return recipes.rows;
    } finally {
      await client.end();
    }
  }

  async getLatestRecipes(userTags) {
    const client = new Client(dbConfig);
    await client.connect();

    try {
      const recipes = await client.query(
        'SELECT r.* FROM recetas r WHERE r.tags && $1 AND r.puntuacion > 4.5 ' +
          'ORDER BY r.fechaPublicacion DESC LIMIT 10',
        [userTags]
      );
      return recipes.rows;
    } finally {
      await client.end();
    }
  }
}
