import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class AuthRepository {
  async authenticateUser(email, password) {
    let pool;
    try {
      pool = await getConnection();
      const result = await pool.request()
        .input('email', sql.VarChar, email)
        .input('password', sql.VarChar, password)
        .query('SELECT * FROM Usuarios WHERE mail = @email AND contrasena = @password');
        
      return result.recordset.length > 0; 
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }
}
