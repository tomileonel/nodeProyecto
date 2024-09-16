import getConnection from '../configs/db-config.js';
import sql from 'mssql'; 

class IngredientesService {
  async getFilteredIngredientes(searchTerm) {
    const query = 'SELECT id, nombre AS name FROM ingredientes WHERE nombre LIKE @searchTerm';
    try {
      const pool = await getConnection();
      const request = pool.request();
      request.input('searchTerm', sql.VarChar, `%${searchTerm}%`);
      const result = await request.query(query);
      return result.recordset;
    } catch (error) {
      console.error('Error al obtener los ingredientes:', error);
      throw error;
    }
  }


  async addIngredientToRecipe(idreceta, idingrediente, cantidad) {
    const query = `
      INSERT INTO IngredientePorReceta (idreceta, idingrediente, cant)
      VALUES (@idreceta, @idingrediente, @cant)
    `;
    try {
      const pool = await getConnection();
      const request = pool.request();
      request.input('idreceta', sql.Int, idreceta);
      request.input('idingrediente', sql.Int, idingrediente);
      request.input('cant', sql.Decimal, cantidad);
      await request.query(query);
    } catch (error) {
      console.error('Error al agregar ingrediente a receta:', error);
      throw error;
    }
  }

}


export async function getIngredientes(Nombre) {
  const query = `
    SELECT id, nombre AS name
    FROM ingredientes
    WHERE nombre LIKE  '%@Nombre%'
  `;
  try {
    const pool = await getConnection();
    const result = await pool.request()
      .input('Nombre', sql.NVarChar(50), Nombre)
      .query(query);
    return result.recordset;
  } catch (error) {
    console.error('Error al obtener los ingredientes:', error);
    throw error;
  }
}



export default IngredientesService;
