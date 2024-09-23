import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class TagsRepository {

    async getIngredientes(nombre) {
        let query = `
          SELECT id, nombre AS name
          FROM dbo.Ingredientes
        `;
        
        // Inicializa la solicitud
        const pool = await getConnection();
        const request = pool.request();
    
        if (nombre) {
          // Si se proporciona un nombre, añade la cláusula WHERE
          query += ` WHERE nombre LIKE '%' + @Nombre + '%'`;
          request.input('Nombre', sql.NVarChar(50), nombre); // Agrega el parámetro aquí
        }
        
        try {
          console.log(query);
          const result = await request.query(query); // Ejecuta la consulta
          return result.recordset;
        } catch (error) {
          console.error('Error al obtener los ingredientes:', error);
          throw error;
        }
      }
}
