import getConnection from '../configs/db-config.js';

class IngredientesService {
  async getIngredientes() {
    try {
      const pool = await getConnection();
      const result = await pool.request().query('SELECT * FROM ingredientes');
      return result.recordset; // Ajusta según la estructura de tu base de datos
    } catch (error) {
      console.error('Error al obtener los ingredientes:', error);
      throw error;
    }
  }
}

export default IngredientesService;
