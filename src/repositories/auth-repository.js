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

  async getUserByPhone(phone) {
    phone = parseInt(phone)
    try {
      const pool = await getConnection();
      const result = await pool.request()
        .input('phone', sql.BigInt, phone)
        .query('SELECT * FROM Usuarios WHERE telefono = @phone');
      return result.recordset[0];
    } catch (error) {
      console.error(`Error en la consulta de usuario por telefono: ${error}`);
      throw error;
    }
  }

  async getUserByUsername(username) {
    try {
      const pool = await getConnection();
      const result = await pool.request()
        .input('username', sql.VarChar, username)
        .query('SELECT * FROM Usuarios WHERE nombreusuario = @username');
      return result.recordset[0];
    } catch (error) {
      console.error(`Error en la consulta de usuario por nombre de usuario: ${error}`);
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
        .input('phone', sql.BigInt, phone)
        .input('email', sql.VarChar, email)
        .input('password', sql.VarChar, hashedPassword)
        .query('INSERT INTO Usuarios (nombreusuario, nombre, apellido, telefono, mail, contrasena) VALUES (@username, @name, @lastName, @phone, @email, @password)');
      return result.rowsAffected[0] > 0;
    } catch (error) {
      console.error(`Error al registrar el usuario: ${error}`);
      throw error;
    }
  }

  async editProfile(id, username, name, lastName, phone, email, password, description, img) {
    try {
      const pool = await getConnection();
      const request = pool.request().input('id', sql.Int, id);
  
      // Construir dinámicamente la consulta SQL y añadir los parámetros solo si están definidos
      const setClauses = [];
  
      if (username) {
        setClauses.push('nombreusuario = @username');
        request.input('username', sql.VarChar, username);
      }
      if (name) {
        setClauses.push('nombre = @name');
        request.input('name', sql.NVarChar, name);
      }
      if (lastName) {
        setClauses.push('apellido = @lastName');
        request.input('lastName', sql.NVarChar, lastName);
      }
      if (phone) {
        setClauses.push('telefono = @phone');
        request.input('phone', sql.BigInt, phone);
      }
      if (email) {
        setClauses.push('mail = @email');
        request.input('email', sql.VarChar, email);
      }
      if (password) {
        setClauses.push('contrasena = @password');
        request.input('password', sql.VarChar, password);
      }
      if (description) {
        setClauses.push('descripcion = @description');
        request.input('description', sql.NVarChar, description);
      }
      if (img) {
        setClauses.push('imagen = @img');
        request.input('img', sql.VarChar, img);
      }
  
      // Si no hay campos para actualizar, devolver false
      if (setClauses.length === 0) {
        console.warn('No hay campos para actualizar');
        return false;
      }
  
      // Construir la consulta completa de actualización
      const updateQuery = `
        UPDATE Usuarios
        SET ${setClauses.join(', ')}
        WHERE id = @id
      `;
  
      // Ejecutar la consulta
      const result = await request.query(updateQuery);
  
      // Verificar si se afectó alguna fila (es decir, si el usuario fue actualizado)
      return result.rowsAffected > 0;
    } catch (error) {
      console.error('Error al actualizar perfil:', error);
      console.log(error)
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