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
  async getUserByEmail(email) {
    let pool;
    try {
      pool = await getConnection();
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
        .input('nombreusuario', sql.NVarChar, username) // Nombre de usuario
        .input('nombre', sql.NVarChar, name) // Nombre
        .input('apellido', sql.NVarChar, lastName) // Apellido
        .input('telefono', sql.VarChar, phone) // Teléfono
        .input('mail', sql.VarChar, email) // Email
        .input('contrasena', sql.VarChar, password) // Contraseña
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