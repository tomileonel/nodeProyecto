import sql from 'mssql';
import dbConfig from '../configs/db-config';

const getUserByEmail = async (email) => {
  const pool = await sql.connect(dbConfig);
  const result = await pool.request()
    .input('email', sql.NVarChar, email)
    .query('SELECT * FROM Usuarios WHERE mail = @email');

  return result.recordset[0];
};

const createUser = async (userData) => {
  const { nombreusuario, contrasena, mail, nombre, apellido, telefono } = userData;
  const pool = await sql.connect(dbConfig);
  await pool.request()
    .input('nombreusuario', sql.NVarChar, nombreusuario)
    .input('contrasena', sql.NVarChar, contrasena)
    .input('mail', sql.NVarChar, mail)
    .input('nombre', sql.NVarChar, nombre)
    .input('apellido', sql.NVarChar, apellido)
    .input('telefono', sql.Int, telefono)
    .query(`
      INSERT INTO Usuarios (nombreusuario, contrasena, mail, nombre, apellido, telefono)
      VALUES (@nombreusuario, @contrasena, @mail, @nombre, @apellido, @telefono)
    `);
};

export { getUserByEmail, createUser };
