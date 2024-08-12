import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class AuthRepository {
  async authenticateUser(email, password) {
    let pool;
    try {
      pool = await getConnection();
      const result = await pool.request()
        .input('email', sql.VarChar, email)
        .query('SELECT * FROM Usuarios WHERE mail = @email');
      
      return result.recordset[0]; // Devuelve el usuario encontrado
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }

  async getUserByEmail(email) {
    let pool;
    try {
      pool = await getConnection();
      console.log(`Querying user with email: ${email}`);
      const result = await pool.request()
        .input('email', sql.VarChar, email)
        .query('SELECT * FROM Usuarios WHERE mail = @email');
      return result.recordset[0];
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }

  async registerUser(username, name, lastName, phone, email, password) {
    let pool;
    try {
      pool = await getConnection();
      const result = await pool.request()
        .input('nombreusuario', sql.NVarChar, username)
        .input('nombre', sql.NVarChar, name)
        .input('apellido', sql.NVarChar, lastName)
        .input('telefono', sql.VarChar, phone)
        .input('mail', sql.VarChar, email)
        .input('contrasena', sql.VarChar, password)
        .query(`
          INSERT INTO Usuarios (nombreusuario, nombre, apellido, telefono, mail, contrasena) 
          VALUES (@nombreusuario, @nombre, @apellido, @telefono, @mail, @contrasena)
        `);
      return result.rowsAffected[0] > 0;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }
}
