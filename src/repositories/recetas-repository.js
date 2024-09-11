import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class RecetasRepository {

   async getRecipesByTag(userTags) {
    let pool;
    try {
      pool = await getConnection();

      if (userTags.length === 0) {
        const result = await pool.request().query(`
          SELECT DISTINCT r.*
          FROM recetas r
        `);
        return result.recordset;
      }

      const tagPlaceholders = userTags.map((_, index) => `@tag${index}`).join(', ');

      const query = `
        SELECT r.*
        FROM recetas r
        JOIN TagRecetas TR ON TR.idReceta = r.id
        WHERE TR.idTag IN (${tagPlaceholders})
        AND r.id IN (
          SELECT TR2.idReceta
          FROM TagRecetas TR2
          WHERE TR2.idTag IN (${tagPlaceholders})
          GROUP BY TR2.idReceta
          HAVING COUNT(DISTINCT TR2.idTag) = @totalTags
        )
        GROUP BY r.id, r.nombre, r.rating, r.imagen, r.idcreador, r.tiempoMins, r.calorias, 
                 r.carboidratos, r.proteina, r.grasas, r.precio, r.fechaPublicacion, r.descripcion
      `;

      const request = pool.request();
      userTags.forEach((tag, index) => {
        request.input(`tag${index}`, sql.Int, tag);
      });
      request.input('totalTags', sql.Int, userTags.length);

      const result = await request.query(query);
      return result.recordset;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }
  async getFilteredRecipesByPrice({ search, tiempoMax, caloriasMax, ingredientes, tags, precioMin, precioMax }) {
    let query = `
    SELECT DISTINCT r.*
    FROM recetas r
    LEFT JOIN TagRecetas rt ON r.id = rt.idReceta
    WHERE 1=1
  `;
  
  // Filtro de búsqueda
  if (search) {
    query += ' AND r.nombre LIKE @search';
  }
  
  // Filtro de tiempo
  if (tiempoMax) {
    query += ' AND r.tiempoMins <= @tiempoMax';
  }
  
  // Filtro de calorías
  if (caloriasMax) {
    query += ' AND r.calorias <= @caloriasMax';
  }
  
  // Filtro de ingredientes
  if (ingredientes.length > 0) {
    query += ' AND r.id IN (SELECT DISTINCT ri.idReceta FROM IngredientePorReceta ri WHERE ri.idIngrediente IN (';
    query += ingredientes.map((_, index) => `@ingrediente${index}`).join(',') + ')';
  }
  
  // Filtro de tags
  if (tags.length > 0) {
    query += ' AND r.id IN (SELECT DISTINCT rt.idReceta FROM TagRecetas rt WHERE rt.idTag IN (';
    query += tags.map((_, index) => `@tag${index}`).join(',') + ')';
  }
  
  // Filtro de precio
  if (precioMin != null && precioMax != null) {
    query += ' AND r.precio BETWEEN @precioMin AND @precioMax';
  }
  
    let pool;
    try {
      pool = await getConnection();
      const request = pool.request();
  
      // Añadir parámetros a la consulta
      if (search) request.input('search', sql.VarChar, `%${search}%`);
      if (tiempoMax) request.input('tiempoMax', sql.Int, tiempoMax);
      if (caloriasMax) request.input('caloriasMax', sql.Int, caloriasMax);
      ingredientes.forEach((ing, index) => request.input(`ingrediente${index}`, sql.Int, ing));
      tags.forEach((tag, index) => request.input(`tag${index}`, sql.Int, tag));
      if (precioMin != null) request.input('precioMin', sql.Decimal, precioMin);
      if (precioMax != null) request.input('precioMax', sql.Decimal, precioMax);
  
      // Ejecutar la consulta
      const result = await request.query(query);
  
      // Retornar resultados
      return [result.recordset, 200];
    } catch (error) {
      console.error('Error al obtener recetas filtradas por precio:', error);
      return [["No se encuentran recetas"], 500];
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }
  
  

  async getUserTags(userId) {
    let pool;
    try {
      pool = await getConnection();
      const result = await pool.request()
        .input('userId', sql.Int, userId)
        .query(`
          SELECT TU.idTag 
          FROM usuarios 
          JOIN TagUsuario as TU on TU.idUsuario = usuarios.id
          WHERE usuarios.id = @userId
        `);
      return result.recordset.map(record => record.idTag);
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }

  async getRecipesByTagAndUser(tagId, userTags) {
    let pool;
    try {
      pool = await getConnection();

      const request = pool.request();

      let query;

      if (userTags.length === 0 || userTags.includes(0)) {
        query = `
          SELECT DISTINCT r.*
          FROM recetas r
          JOIN TagRecetas TR ON TR.idReceta = r.id
          WHERE TR.idTag = @tagId
        `;
        request.input('tagId', sql.Int, tagId);
      } else {
        const tagPlaceholders = userTags.map((_, index) => `@tag${index}`).join(', ');

        query = `
          SELECT DISTINCT r.*
          FROM recetas r
          JOIN TagRecetas TR ON TR.idReceta = r.id
          WHERE TR.idTag = @tagId
            AND r.id IN (
              SELECT TR2.idReceta
              FROM TagRecetas TR2
              WHERE TR2.idTag IN (${tagPlaceholders})
              GROUP BY TR2.idReceta
              HAVING COUNT(DISTINCT TR2.idTag) = @totalTags
            )
        `;

        request.input('tagId', sql.Int, tagId);

        userTags.forEach((tag, index) => {
          request.input(`tag${index}`, sql.Int, tag);
        });

        request.input('totalTags', sql.Int, userTags.length);
      }

      const result = await request.query(query);
      return result.recordset;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }



  async searchRecipes(userTags, tipoCocina, ingredientes, maxCalorias, maxTiempo) {
    let pool;
    try {
      pool = await getConnection();

      let query = 'SELECT r.* FROM recetas r WHERE 1=1';
      const request = pool.request();

      if (tipoCocina) {
        query += ' AND r.tipo_cocina IN (@tipoCocina)';
        request.input('tipoCocina', sql.NVarChar(sql.MAX), tipoCocina);
      }

      if (ingredientes) {
        query += `
          AND r.id IN (
            SELECT ri.receta_id FROM receta_ingredientes ri 
            JOIN ingredientes i ON i.id = ri.ingrediente_id 
            WHERE i.nombre IN (@ingredientes)
          )
        `;
        request.input('ingredientes', sql.NVarChar(sql.MAX), ingredientes);
      }

      if (maxCalorias) {
        query += ' AND r.calorias <= @maxCalorias';
        request.input('maxCalorias', sql.Int, maxCalorias);
      }

      if (maxTiempo) {
        query += ' AND r.tiempo <= @maxTiempo';
        request.input('maxTiempo', sql.Int, maxTiempo);
      }

      const result = await request.query(query);
      return result.recordset;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }
  async getIdByName(nombre){
    let pool;
  try{
    pool = await getConnection();
    const result = await pool.request()
    .input('nombre', sql.VarChar(sql.MAX), nombre)
    .query(`SELECT id FROM Recetas WHERE nombre = @nombre`);
    return result;
  }finally {
    if (pool) {
      await pool.close();
    }
  }
  }
  async getLatestRecipes(userTags) {
    let pool;
    try {
      pool = await getConnection();
      
      let query;
      const request = pool.request();

      if (userTags.length === 0 || userTags.includes(0)) {
        query = `
          SELECT r.*, U.imagen as imagenUsuario, U.nombreusuario
          FROM recetas r
          JOIN Usuarios U ON U.id = r.idcreador
          WHERE r.rating > 4
          ORDER BY r.fechaPublicacion DESC
          OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY
        `;
      } else {
        const tagPlaceholders = userTags.map((_, index) => `@tag${index}`).join(', ');

        query = `
          SELECT r.*, U.imagen as imagenUsuario, U.nombreusuario
          FROM recetas r
          JOIN TagRecetas TR ON TR.idReceta = r.id
          JOIN Usuarios U ON U.id = r.idcreador
          WHERE TR.idTag IN (${tagPlaceholders})
            AND r.rating > 4
            AND r.id IN (
              SELECT TR2.idReceta
              FROM TagRecetas TR2
              WHERE TR2.idTag IN (${tagPlaceholders})
              GROUP BY TR2.idReceta
              HAVING COUNT(DISTINCT TR2.idTag) = @totalTags
            )
          ORDER BY r.fechaPublicacion DESC
          OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY
        `;

        userTags.forEach((tag, index) => {
          request.input(`tag${index}`, sql.Int, tag);
        });
        request.input('totalTags', sql.Int, userTags.length);
      }

      const result = await request.query(query);
      return result.recordset;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }

  async getSpecialTags ()
  {
    let pool;
    try {
      pool = await getConnection();
      const request = pool.request();
  
      const query = `
        SELECT *
        FROM tags
        WHERE specialTag = 1
      `;
  
      const result = await request.query(query);
      return result.recordset;
    } catch (error) {
      console.error(`Error al obtener los tags especiales: ${error}`);
      throw new Error('Error al obtener los tags especiales');
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  };

  async getRecipesByTagWithUser(tagId, userId) {
    let pool;
    try {
      pool = await getConnection();
      
      // Primero, obtener las recetas del usuario que coincidan con el tag seleccionado.
      const userRecipesQuery = `
        SELECT r.*, u.nombre AS creadorNombre, u.imagen AS creadorFoto
        FROM recetas r
        JOIN Usuarios u ON r.idCreador = u.id
        JOIN TagRecetas TR ON TR.idReceta = r.id
        WHERE TR.idTag = @tagId
          AND r.idCreador = @userId
      `;
  
      const userRecipesResult = await pool.request()
        .input('tagId', sql.Int, tagId)
        .input('userId', sql.Int, userId)
        .query(userRecipesQuery);
  
      let recipes = userRecipesResult.recordset;
  
      // Si el usuario no tiene recetas con ese tag, obtener todas las recetas con ese tag.
      if (recipes.length === 0) {
        const allRecipesQuery = `
          SELECT r.*, u.nombre AS creadorNombre, u.imagen AS creadorFoto
          FROM recetas r
          JOIN Usuarios u ON r.idCreador = u.id
          JOIN TagRecetas TR ON TR.idReceta = r.id
          WHERE TR.idTag = @tagId
        `;
  
        const allRecipesResult = await pool.request()
          .input('tagId', sql.Int, tagId)
          .query(allRecipesQuery);
  
        recipes = allRecipesResult.recordset;
      }
  
      return recipes;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }

   async getFilteredRecipes({ search, tiempoMax, caloriasMax, ingredientes, tags }) {
    let query = `
      SELECT DISTINCT r.*
      FROM recetas r
      LEFT JOIN TagRecetas rt ON r.id = rt.idReceta
      WHERE 1=1
    `;

    // Filtro de búsqueda
    if (search) {
      query += ` AND r.nombre LIKE '%' + @search + '%'`;
    }

    // Filtro de tiempo
    if (tiempoMax) {
      query += ` AND r.tiempoMins <= @tiempoMax`;
    }

    // Filtro de calorías
    if (caloriasMax) {
      query += ` AND r.calorias <= @caloriasMax`;
    }

    // Filtro de ingredientes
    if (ingredientes.length > 0) {
      const placeholders = ingredientes.map((_, index) => `@ingrediente${index}`).join(',');
      query += `
        AND r.id IN (
          SELECT DISTINCT ri.idReceta
          FROM IngredientePorReceta ri
          WHERE ri.idIngrediente IN (${placeholders})
        )
      `;
    }

    // Filtro de tags
    if (tags.length > 0) {
      const tagPlaceholders = tags.map((_, index) => `@tag${index}`).join(',');
      query += `
        AND r.id IN (
          SELECT DISTINCT rt.idReceta
          FROM tagRecetas rt
          WHERE rt.idTag IN (${tagPlaceholders})
        )
      `;
    }

    let pool;
    try {
      pool = await getConnection();
      const request = pool.request();

      // Añadir parámetros a la consulta
      if (search) request.input('search', sql.VarChar, search);
      if (tiempoMax) request.input('tiempoMax', sql.Int, tiempoMax);
      if (caloriasMax) request.input('caloriasMax', sql.Int, caloriasMax);
      ingredientes.forEach((ing, index) => request.input(`ingrediente${index}`, sql.Int, ing));
      tags.forEach((tag, index) => request.input(`tag${index}`, sql.Int, tag));

      // Ejecutar la consulta
      const result = await request.query(query);

      // Retornar resultados
      return [result.recordset, 200];
    } catch (error) {
      console.error(`Error fetching filtered recipes: ${error}`);
      return [["No se encuentran recetas"], 500];
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }
  async pasosCount(id){
    let pool;
    try {
      pool = await getConnection();
      const result = await pool.request()
        .input('id', sql.Int, id)
        .query(`
          SELECT * FROM PasosReceta WHERE idReceta = @id
      
        `);
      return result.recordset;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }
  
  async getFullRecipeById(recipeId) {
    try {
        const pool = await getConnection();

        // Obtener la receta base
        const recipeQuery = `
            SELECT * FROM Recetas WHERE id = @recipeId;
        `;
        const recipeResult = await pool.request()
            .input('recipeId', sql.Int, recipeId)
            .query(recipeQuery);

        if (recipeResult.recordset.length === 0) {
            return null; // No se encontró la receta
        }

        const receta = recipeResult.recordset[0];

        // Obtener los ingredientes
        const ingredientsQuery = `
        SELECT i.*, ipr.cant FROM Ingredientes i
        INNER JOIN IngredientePorReceta ipr ON i.id = ipr.Idingrediente
        WHERE ipr.IdReceta = @recipeId;
        `;
        const ingredientsResult = await pool.request()
            .input('recipeId', sql.Int, recipeId)
            .query(ingredientsQuery);

        receta.ingredientes = ingredientsResult.recordset;

        // Obtener los pasos
        const stepsQuery = `
            SELECT * FROM PasosReceta WHERE IdReceta = @recipeId ORDER BY nro;
        `;
        const stepsResult = await pool.request()
            .input('recipeId', sql.Int, recipeId)
            .query(stepsQuery);

        receta.pasos = stepsResult.recordset;

        // Obtener los tags
        const tagsQuery = `
            SELECT t.* FROM Tags t
            INNER JOIN TagRecetas tr ON t.id = tr.Idtag
            WHERE tr.IdReceta = @recipeId;
        `;
        const tagsResult = await pool.request()
            .input('recipeId', sql.Int, recipeId)
            .query(tagsQuery);

        receta.tags = tagsResult.recordset;

        // Obtener la información del creador
        const creatorQuery = `
            SELECT u.id, u.nombreusuario, u.imagen FROM Usuarios u
            WHERE u.id = @creatorId;
        `;
        const creatorResult = await pool.request()
            .input('creatorId', sql.Int, receta.idcreador)
            .query(creatorQuery);

        receta.creador = creatorResult.recordset.length > 0 ? creatorResult.recordset[0] : null;

        return receta;
    } catch (error) {
        console.error('Error al obtener la receta completa:', error);
        throw error;
    }
}

async createRecipe({ nombre, descripcion, ingredientes, pasos, tags }) {
  let pool;
  try {
    pool = await getConnection();

    // Iniciar una transacción
    const transaction = new sql.Transaction(pool);
    await transaction.begin();

    const request = new sql.Request(transaction);

    // Insertar la receta
    const result = await request
      .input('nombre', sql.VarChar, nombre)
      .input('descripcion', sql.Text, descripcion)
      .query(
        `INSERT INTO Recetas (nombre, descripcion) 
         VALUES (@nombre, @descripcion); 
         SELECT SCOPE_IDENTITY() AS id`
      );

    const recipeId = result.recordset[0].id;

    // Insertar ingredientes
    for (const ingrediente of ingredientes) {
      await request
        .input('recetaId', sql.Int, recipeId)
        .input('ingredienteId', sql.Int, ingrediente.id)
        .input('cantidad', sql.Decimal, ingrediente.cantidad)
        .query(
          `INSERT INTO IngredientePorReceta (idReceta, idIngrediente, cantidad) 
           VALUES (@recetaId, @ingredienteId, @cantidad)`
        );
    }

    // Insertar pasos
    for (const paso of pasos) {
      await request
        .input('recetaId', sql.Int, recipeId)
        .input('numero', sql.Int, paso.numero)
        .input('descripcion', sql.Text, paso.descripcion)
        .query(
          `INSERT INTO PasosReceta (idReceta, nro, descripcion) 
           VALUES (@recetaId, @numero, @descripcion)`
        );
    }

    // Insertar tags
    for (const tag of tags) {
      await request
        .input('recetaId', sql.Int, recipeId)
        .input('tagId', sql.Int, tag)
        .query(
          `INSERT INTO TagRecetas (idReceta, idTag) 
           VALUES (@recetaId, @tagId)`
        );
    }

    // Confirmar la transacción
    await transaction.commit();

    return { id: recipeId };
  } catch (error) {
    console.error(`Error al crear receta: ${error.message}`); 
    throw error;
  } finally {
    if (pool) {
      await pool.close();
    }
  }

  }
  // In the service


// In the repository
async rateReceta({ rating, recetaId, userId }) {
  let pool;
  try {
    pool = await getConnection();
    const result = await pool.request()
      .input('rate', sql.Int, rating)
      .input('user', sql.Int, userId)
      .input('receta', sql.Int, recetaId)
      .query(`INSERT INTO Rating (rating, idUsuario, idReceta) VALUES (@rate, @user, @receta)`);
    return result;
  } finally {
    if (pool) {
      await pool.close();
    }
  }
  
}
async updateReceta({ rating, recetaId, userId }) {
  let pool;
  try {
    pool = await getConnection();
    const result = await pool.request()
      .input('rate', sql.Int, rating)
      .input('user', sql.Int, userId)
      .input('receta', sql.Int, recetaId)
      .query(`UPDATE Rating SET rating = @rate `);
    return result;
  } finally {
    if (pool) {
      await pool.close();
    }
  }
  
}

}



  
