import sql from 'mssql';

const dbConfig = {
  user: 'sa',
  password: '12345678',
  server: 'localhost', // Nombre de la instancia
  port: 1433,
  database: 'PocketChefDB',
  options: {
    encrypt: true, // Prueba con false si no estás usando conexiones cifradas
    trustServerCertificate: true,
  },
};

export default async function getConnection() {
  try {
    const pool = await sql.connect(dbConfig);
    return pool;
  } catch (error) {
    console.error(`Error al conectar a la base de datos: ${error.message}`);
    throw error;
  }
}