import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class RecetasRepository {
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

  async getRecipesByTag(userTags) {
    let pool;
    try {
      pool = await getConnection();

      const request = pool.request();

      if (userTags.includes(0) || userTags.length === 0) {
        // Si userTags incluye 0 o está vacío, traer todas las recetas
        const result = await request.query('SELECT * FROM recetas');
        return result.recordset;
      } else {
        // Crear una lista de parámetros para usar en la cláusula IN
        const tagPlaceholders = userTags.map((_, index) => `@tag${index}`).join(', ');

        // Crear la consulta parametrizada
        const query = `
          SELECT r.*
          FROM recetas r
          WHERE r.id IN (
            SELECT TR.idReceta
            FROM TagRecetas TR
            WHERE TR.idTag IN (${tagPlaceholders})
            GROUP BY TR.idReceta
            HAVING COUNT(DISTINCT TR.idTag) = @totalTags
          )
        `;

        // Añadir parámetros a la consulta
        userTags.forEach((tag, index) => {
          request.input(`tag${index}`, sql.Int, tag);
        });

        // Añadir el parámetro del total de tags
        request.input('totalTags', sql.Int, userTags.length);

        const result = await request.query(query);
        return result.recordset;
      }
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
          SELECT idTag 
          FROM TagUsuario
          WHERE idUsuario = @userId
        `);
      return result.recordset.map(record => record.idTag);
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

  async getLatestRecipes(userTags) {
    let pool;
    try {
      pool = await getConnection();
      const userTagsString = userTags.join(',');
      const result = await pool.request()
        .input('userTags', sql.NVarChar(sql.MAX), `%${userTagsString}%`)
        .query(`
        SELECT r.*, U.imagen as imagenUsuario,U.nombreusuario
        FROM recetas r 
        JOIN TagRecetas as TR on TR.idReceta = r.id
        JOIN  Usuarios as U on U.id = r.idcreador
        WHERE TR.idTag LIKE 1 AND r.rating > 4.5 
        ORDER BY r.fechaPublicacion DESC 
        OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY
        `);
      return result.recordset;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }

  
  async getAllTags() {
    let pool;
    try {
      pool = await getConnection();
      const result = await pool.request()
        .query('SELECT * FROM tags where specialTag = 1');  
      return result.recordset; 
    } catch (error) {
      console.error('Error fetching tags:', error);
      throw error;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }
}
