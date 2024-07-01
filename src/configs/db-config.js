
import sql from 'mssql';
const dbConfig = {
    user: 'tomi',
    password: 'helicopterO1',
    server: 'localhost',
    port: 1433, // Asegúrate de incluir el puerto
    database: 'PocketChefDB',
    options: {
      encrypt: true, // Usar en Azure
      trustServerCertificate: true // Esto deshabilita la verificación de certificados
    }
  };
  
  export default async function getConnection() {
    const pool = await sql.connect(dbConfig);
    return pool;
  }
  