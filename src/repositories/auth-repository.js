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

  async editProfile(id, username, name, lastName, phone, email, description, img, tags) {
    let transaction;
    try {
        const pool = await getConnection();
        transaction = new sql.Transaction(pool);
        await transaction.begin();

        const request = transaction.request().input('id', sql.Int, id);

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
        if (description) {
            setClauses.push('descripcion = @description');
            request.input('description', sql.NVarChar, description);
        }
        if (img) {
            setClauses.push('imagen = @img');
            request.input('img', sql.VarChar, img);
        }

        let profileUpdated = true;
        
        if (setClauses.length > 0) {
            const updateQuery = `
                UPDATE Usuarios
                SET ${setClauses.join(', ')}
                WHERE id = @id
            `;
            const result = await request.query(updateQuery);
            profileUpdated = result.rowsAffected > 0;
        }

        let tagsArray = tags;
        if (typeof tags === 'string') {
            try {
                tagsArray = JSON.parse(tags);
            } catch (e) {
                tagsArray = [];
            }
        }

        const deleteTagsRequest = transaction.request()
            .input('userId', sql.Int, id);
        await deleteTagsRequest.query('DELETE FROM TagUsuario WHERE idUsuario = @userId');

        if (!Array.isArray(tagsArray) || tagsArray.length === 0) {
            await transaction.commit();
            return profileUpdated;
        }

        for (const tagId of tagsArray) {
            const insertQuery = `
                INSERT INTO TagUsuario (idUsuario, idTag)
                VALUES (@userId, @tagId)
            `;
            
            await transaction.request()
                .input('userId', sql.Int, id)
                .input('tagId', sql.Int, parseInt(tagId))
                .query(insertQuery);
        }

        await transaction.commit();
        return profileUpdated;

    } catch (error) {
        if (transaction) {
            try {
                await transaction.rollback();
            } catch (rollbackError) {
                console.error('Error durante el rollback:', rollbackError);
            }
        }
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