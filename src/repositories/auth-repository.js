import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class AuthRepository {
  async getUserByEmail(email) {
    try {
      const pool = await getConnection();
      const result = await pool.request()
        .input('email', sql.VarChar, email)
        .query('SELECT * FROM Usuarios WHERE mail = @email');
      return result.recordset[0];
    } catch (error) {
      console.error(`Error en la consulta de usuario por email: ${error}`);
      throw error;
    }
  }

  async registerUser(username, name, lastName, phone, email, hashedPassword) {
    try {
      const pool = await getConnection();
      const result = await pool.request()
        .input('username', sql.VarChar, username)
        .input('name', sql.NVarChar, name)
        .input('lastName', sql.NVarChar, lastName)
        .input('phone', sql.Int, phone)
        .input('email', sql.VarChar, email)
        .input('password', sql.VarChar, hashedPassword)
        .query('INSERT INTO Usuarios (nombreusuario, nombre, apellido, telefono, mail, contrasena) VALUES (@username, @name, @lastName, @phone, @email, @password)');
      return result.rowsAffected[0] > 0;
    } catch (error) {
      console.error(`Error al registrar el usuario: ${error}`);
      throw error;
    }
  }


async getUserById(userId)  {
  try {
    const pool = await getConnection();
    const result = await pool.request()
      .input('userId', sql.Int, userId)  // Usa el ID del usuario para la consulta
      .query('SELECT * FROM Usuarios WHERE id = @userId');  // Ajusta la consulta según tu esquema de base de datos

    return result.recordset[0];  // Devuelve el primer registro (el perfil del usuario)
  } catch (error) {
    console.error(`Error al obtener el perfil del usuario por ID: ${error}`);
    throw error;
  }
}

}