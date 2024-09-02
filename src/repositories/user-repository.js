// src/repositories/user-repository.js
import getConnection from '../configs/db-config.js';
import sql from 'mssql';

class UserRepository {
  async getUserByEmail(email) {
    try {
      const pool = await getConnection();
      const result = await pool.request()
        .input('email', sql.NVarChar, email) // Cambiado a NVarChar para coincidir con la definición
        .query('SELECT * FROM dbo.Usuarios WHERE mail = @email'); // Actualizado el nombre de la tabla y la columna
      return result.recordset[0];
    } catch (error) {
      console.error(`Error en la consulta de usuario: ${error}`);
      throw error;
    }
  }


  async getUserById(id) {
    try {
      const pool = await getConnection();
      const result = await pool.request()
        .input('id', sql.Int, id)
        .query('SELECT * FROM Usuarios WHERE id = @id');
      return result.recordset[0]; // Devuelve el primer registro encontrado
    } catch (error) {
      console.error(`Error en la consulta de usuario por ID: ${error}`);
      throw error;
    }
  }
}

export default UserRepository;
