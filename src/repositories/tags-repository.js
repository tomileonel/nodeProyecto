import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class TagsRepository {

    async getIngredientes(nombre) {
        const query = `
          SELECT id, nombre AS name
          FROM dbo.Ingredientes  

        `;
        if(nombre){
            query += ` WHERE nombre LIKE '%' + @Nombre + '%'`
            .input('Nombre', sql.NVarChar(50), nombre)

        }
        try {
          const pool = await getConnection();
          const result = await pool.request()
            .query(query);
          return result.recordset;
        } catch (error) {
          console.error('Error al obtener los ingredientes:', error);
          throw error;
        }
      }
}
