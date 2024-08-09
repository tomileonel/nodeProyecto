import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class RecetasRepository {

   async getRecipesByTag(userTags) {
    let pool;
    try {
      pool = await getConnection();

      if (userTags.length === 0) {
        const result = await pool.request().query(`
          SELECT DISTINCT r.*
          FROM recetas r
        `);
        return result.recordset;
      }

      const tagPlaceholders = userTags.map((_, index) => `@tag${index}`).join(', ');

      const query = `
        SELECT r.*
        FROM recetas r
        JOIN TagRecetas TR ON TR.idReceta = r.id
        WHERE TR.idTag IN (${tagPlaceholders})
        AND r.id IN (
          SELECT TR2.idReceta
          FROM TagRecetas TR2
          WHERE TR2.idTag IN (${tagPlaceholders})
          GROUP BY TR2.idReceta
          HAVING COUNT(DISTINCT TR2.idTag) = @totalTags
        )
        GROUP BY r.id, r.nombre, r.rating, r.imagen, r.idcreador, r.tiempoMins, r.calorias, 
                 r.carboidratos, r.proteina, r.grasas, r.precio, r.fechaPublicacion, r.descripcion
      `;

      const request = pool.request();
      userTags.forEach((tag, index) => {
        request.input(`tag${index}`, sql.Int, tag);
      });
      request.input('totalTags', sql.Int, userTags.length);

      const result = await request.query(query);
      return result.recordset;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }


  async getUserTags(userId) {
    let pool;
    try {
      pool = await getConnection();
      const result = await pool.request()
        .input('userId', sql.Int, userId)
        .query(`
          SELECT TU.idTag 
          FROM usuarios 
          JOIN TagUsuario as TU on TU.idUsuario = usuarios.id
          WHERE usuarios.id = @userId
        `);
      return result.recordset.map(record => record.idTag);
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }

  async getRecipesByTagAndUser(tagId, userTags) {
    let pool;
    try {
      pool = await getConnection();

      const request = pool.request();

      let query;

      if (userTags.length === 0 || userTags.includes(0)) {
        query = `
          SELECT DISTINCT r.*
          FROM recetas r
          JOIN TagRecetas TR ON TR.idReceta = r.id
          WHERE TR.idTag = @tagId
        `;
        request.input('tagId', sql.Int, tagId);
      } else {
        const tagPlaceholders = userTags.map((_, index) => `@tag${index}`).join(', ');

        query = `
          SELECT DISTINCT r.*
          FROM recetas r
          JOIN TagRecetas TR ON TR.idReceta = r.id
          WHERE TR.idTag = @tagId
            AND r.id IN (
              SELECT TR2.idReceta
              FROM TagRecetas TR2
              WHERE TR2.idTag IN (${tagPlaceholders})
              GROUP BY TR2.idReceta
              HAVING COUNT(DISTINCT TR2.idTag) = @totalTags
            )
        `;

        request.input('tagId', sql.Int, tagId);

        userTags.forEach((tag, index) => {
          request.input(`tag${index}`, sql.Int, tag);
        });

        request.input('totalTags', sql.Int, userTags.length);
      }

      const result = await request.query(query);
      return result.recordset;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }



  async searchRecipes(userTags, tipoCocina, ingredientes, maxCalorias, maxTiempo) {
    let pool;
    try {
      pool = await getConnection();

      let query = 'SELECT r.* FROM recetas r WHERE 1=1';
      const request = pool.request();

      if (tipoCocina) {
        query += ' AND r.tipo_cocina IN (@tipoCocina)';
        request.input('tipoCocina', sql.NVarChar(sql.MAX), tipoCocina);
      }

      if (ingredientes) {
        query += `
          AND r.id IN (
            SELECT ri.receta_id FROM receta_ingredientes ri 
            JOIN ingredientes i ON i.id = ri.ingrediente_id 
            WHERE i.nombre IN (@ingredientes)
          )
        `;
        request.input('ingredientes', sql.NVarChar(sql.MAX), ingredientes);
      }

      if (maxCalorias) {
        query += ' AND r.calorias <= @maxCalorias';
        request.input('maxCalorias', sql.Int, maxCalorias);
      }

      if (maxTiempo) {
        query += ' AND r.tiempo <= @maxTiempo';
        request.input('maxTiempo', sql.Int, maxTiempo);
      }

      const result = await request.query(query);
      return result.recordset;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }
  async getIdByName(nombre){
    let pool;
  try{
    pool = await getConnection();
    const result = await pool.request()
    .input('nombre', sql.VarChar(sql.MAX), nombre)
    .query(`SELECT id FROM Recetas WHERE nombre = @nombre`);
    return result;
  }finally {
    if (pool) {
      await pool.close();
    }
  }
  }
  async getLatestRecipes(userTags) {
    let pool;
    try {
      pool = await getConnection();
      
      let query;
      const request = pool.request();

      if (userTags.length === 0 || userTags.includes(0)) {
        query = `
          SELECT r.*, U.imagen as imagenUsuario, U.nombreusuario
          FROM recetas r
          JOIN Usuarios U ON U.id = r.idcreador
          WHERE r.rating > 1.5
          ORDER BY r.fechaPublicacion DESC
          OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY
        `;
      } else {
        const tagPlaceholders = userTags.map((_, index) => `@tag${index}`).join(', ');

        query = `
          SELECT r.*, U.imagen as imagenUsuario, U.nombreusuario
          FROM recetas r
          JOIN TagRecetas TR ON TR.idReceta = r.id
          JOIN Usuarios U ON U.id = r.idcreador
          WHERE TR.idTag IN (${tagPlaceholders})
            AND r.rating > 4.5
            AND r.id IN (
              SELECT TR2.idReceta
              FROM TagRecetas TR2
              WHERE TR2.idTag IN (${tagPlaceholders})
              GROUP BY TR2.idReceta
              HAVING COUNT(DISTINCT TR2.idTag) = @totalTags
            )
          ORDER BY r.fechaPublicacion DESC
          OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY
        `;

        userTags.forEach((tag, index) => {
          request.input(`tag${index}`, sql.Int, tag);
        });
        request.input('totalTags', sql.Int, userTags.length);
      }

      const result = await request.query(query);
      return result.recordset;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }
  
}
