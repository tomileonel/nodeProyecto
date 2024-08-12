import sql from 'mssql';

const dbConfig = {
  user: 'tomi',
  password: 'helicopterO1',
  server: 'localhost',
  port: 1433,
  database: 'PocketChefDB',
  options: {
    encrypt: true,
    trustServerCertificate: true,
  },
};

export default async function getConnection() {
  try {
    const pool = await sql.connect(dbConfig);
    return pool;
  } catch (error) {
    console.error(`Error al conectar a la base de datos: ${error}`);
    throw error;
  }
}
