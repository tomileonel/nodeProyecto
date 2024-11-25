import getConnection from '../configs/db-config.js';
import sql from 'mssql'; 

class IngredientesService {
  async getFilteredIngredientes(searchTerm) {
    // Seleccionamos solo los 5 primeros resultados más relevantes
    const query = `
      SELECT TOP 5 id, nombre , calorias 
      FROM ingredientes 
      WHERE nombre LIKE @searchTerm
      ORDER BY CHARINDEX(@searchTerm, nombre) ASC, nombre
    `;
    try {
      const pool = await getConnection();
      const request = pool.request();
      // El patrón de búsqueda incluye los comodines `%` para la consulta LIKE
      request.input('searchTerm', sql.VarChar, `%${searchTerm}%`);
      const result = await request.query(query);
      return result.recordset;
    } catch (error) {
      console.error('Error al obtener los ingredientes:', error);
      throw error;
    }
  }

  async addIngredientToRecipe(idreceta, idingrediente, cant) {
    // Consultar valores nutricionales del ingrediente
    const queryGetNutritionalValues = `
      SELECT calorias, carbohidratos, proteina, grasas
      FROM Ingredientes
      WHERE id = @idingrediente
    `;
    const queryInsertIngredient = `
      INSERT INTO IngredientePorReceta (idreceta, idingrediente, cant, calorias, carbohidratos, proteina, grasas)
      VALUES (@idreceta, @idingrediente, @cant, @calorias, @carbohidratos, @proteina, @grasas)
    `;
    
    try {
      const pool = await getConnection();
      const request = pool.request();

      // Obtener valores nutricionales por 100g del ingrediente
      request.input('idingrediente', sql.Int, idingrediente);
      const result = await request.query(queryGetNutritionalValues);
      
      // Verificar que se obtuvieron los valores nutricionales
      if (result.recordset.length === 0) {
        throw new Error('Ingrediente no encontrado');
      }

      const { calorias, carbohidratos, proteina, grasas } = result.recordset[0];

      // Depuración de valores nutricionales
      console.log('Valores nutricionales:', { calorias, carbohidratos, proteina, grasas });

      // Calcular valores ajustados en función de la cant
      const factor = cant / 100;
      const caloriasAjustadas = calorias * factor;
      const carbohidratosAjustados = carbohidratos * factor;
      const proteinaAjustada = proteina * factor;
      const grasasAjustadas = grasas * factor;

      // Depuración de valores ajustados
      console.log('Valores ajustados:', {
        caloriasAjustadas, carbohidratosAjustados, proteinaAjustada, grasasAjustadas
      });

      // Insertar los valores ajustados en la tabla IngredientePorReceta
      const requestInsert = pool.request();
      requestInsert.input('idreceta', sql.Int, idreceta);
      requestInsert.input('idingrediente', sql.Int, idingrediente);
      requestInsert.input('cant', sql.Decimal, cant); // Asegúrate de que 'cant' es un número
      requestInsert.input('calorias', sql.Decimal, caloriasAjustadas);
      requestInsert.input('carbohidratos', sql.Decimal, carbohidratosAjustados);
      requestInsert.input('proteina', sql.Decimal, proteinaAjustada);
      requestInsert.input('grasas', sql.Decimal, grasasAjustadas);
      await requestInsert.query(queryInsertIngredient);

      // Depuración de los valores que se están insertando
      console.log('Valores que se están insertando:', {
        idreceta, idingrediente, cant, caloriasAjustadas, carbohidratosAjustados, proteinaAjustada, grasasAjustadas
      });

      await requestInsert.query(queryInsertIngredient);
      
    } catch (error) {
      console.error('Error al agregar ingrediente a receta:', error);
      throw error;
    }
  }
}

export async function getIngredientes(Nombre) {
  const query = `
    SELECT id, nombre AS name
    FROM dbo.Ingredientes  
    WHERE nombre LIKE '%' + @Nombre + '%'
  `;
  try {
    const pool = await getConnection();
    const result = await pool.request()
      .input('Nombre', sql.NVarChar(50), Nombre)
      .query(query);
    return result.recordset;
  } catch (error) {
    console.error('Error al obtener los ingredientes:', error);
    throw error;
  }
}

async function getIngredientById(id) {
  try {
      // Conectar a la base de datos
      const pool = await sql.connect(config);
      
      // Ejecutar la consulta
      const result = await pool.request()
          .input('id', sql.Int, id) // Asegúrate de que el ID es el correcto
          .query('SELECT nombre, calorias, carbohidratos, grasas, proteinas FROM Ingredientes WHERE id = @id');

      // Verificar si hay resultados
      if (result.recordset.length > 0) {
          const ingredient = result.recordset[0];
          console.log('Ingrediente:', ingredient);
          return ingredient; // Devuelve el primer ingrediente encontrado
      } else {
          console.log('No se encontró el ingrediente con ID:', id);
          return null;
      }
  } catch (error) {
      console.error('Error al obtener el ingrediente:', error);
  } finally {
      // Cerrar la conexión
      await sql.close();
  }
}

export default IngredientesService;
