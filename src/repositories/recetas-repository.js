import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class RecetasRepository {

  async getRecipesByTag(userTags) {
    let pool;
    try {
      pool = await getConnection();
  
      const request = pool.request();
      let query;
  
      if (userTags.length === 0) {
        // Cuando no se especifican tags, hacemos un SELECT * para obtener todas las recetas
        query = `
          SELECT *
          FROM Recetas
        `;
      } else {
        // Cuando hay tags, se filtra la consulta para devolver solo las recetas con los tags especificados
        const tagPlaceholders = userTags.map((_, index) => `@tag${index}`).join(', ');
  
        query = `
          SELECT r.*
          FROM Recetas r
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
                   r.carbohidratos, r.proteina, r.grasas, r.precio, r.fechaPublicacion, r.descripcion
        `;
  
        // Añadir los tags como parámetros de la consulta
        userTags.forEach((tag, index) => {      
          request.input(`tag${index}`, sql.Int, tag);
        });
        request.input('totalTags', sql.Int, userTags.length);
      }
  
      // Ejecutar la consulta y devolver los resultados
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

  async getRecipesByUser(userId) {
    let pool;
    try {
      pool = await getConnection();
      const result = await pool.request()
        .input('userId', sql.Int, userId)
        .query(`
          SELECT *
          FROM Recetas 
          WHERE idcreador = @userId
        `);
      return result.recordset
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
          WHERE r.rating >= 4
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
            AND r.rating >= 4
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

  async delete(id) {
    let pool;
    try {
      pool = await getConnection();
      const request = pool.request();
      
      request.input('id', id);
  
      const query = `

        DELETE FROM RecetaCarrito 
        Where idReceta = @id
        DELETE FROM Carrito 
        Where idReceta = @id
DELETE FROM IngredientePorReceta
		WHERE idreceta =  @id
		DELETE FROM PasosReceta
		WHERE idreceta =  @id
		DELETE FROM TagRecetas
		WHERE idreceta =  @id
		DELETE FROM recetas
        WHERE id =  @id

      `;
  
      const result = await request.query(query);
      return result.rowsAffected; 
    } catch (error) {
      console.error(`Error al eliminar la receta con id ${id}: ${error}`);
      throw new Error('Error al eliminar la receta');
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }
  

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
      SELECT r.*
      FROM recetas r
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
          SELECT rt.idReceta
          FROM TagRecetas rt
          WHERE rt.idTag IN (${tagPlaceholders})
          GROUP BY rt.idReceta
          HAVING COUNT(DISTINCT rt.idTag) = ${tags.length}
        )
      `;
    }
  
    // Agrupar por todos los campos de recetas y añadir el ordenamiento por rating
    query += `
      GROUP BY r.id, r.nombre, r.rating, r.imagen, r.idcreador, r.tiempoMins, 
               r.calorias, r.carbohidratos, r.proteina, r.grasas, r.precio, 
               r.fechaPublicacion, r.descripcion
      ORDER BY r.rating DESC
    `;
  
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
async  createRecipe({ nombre, descripcion, ingredientes, pasos, tags, idcreador, imagen }) {
  let pool;
  try {
    pool = await getConnection();
    const transaction = new sql.Transaction(pool);
    await transaction.begin();

    let request = new sql.Request(transaction);
    const result = await request
      .input('nombre', sql.NVarChar(50), nombre)
      .input('descripcion', sql.NVarChar(100), descripcion || "")
      .input('rating', sql.Float, 0)
      .input('imagen', sql.NVarChar(300), imagen || "")
      .input('idcreador', sql.Int, idcreador || 0)
      .input('tiempoMins', sql.Float, 0)
      .input('calorias', sql.Float, 0)
      .input('carbohidratos', sql.Float, 0)
      .input('proteina', sql.Float, 0)
      .input('grasas', sql.Float, 0)
      .input('precio', sql.Float, 0)
      .input('fechaPublicacion', sql.Date, new Date())
      .query(
        `INSERT INTO Recetas 
          (nombre, descripcion, rating, imagen, idcreador, tiempoMins, calorias, carbohidratos, proteina, grasas, precio, fechaPublicacion) 
         VALUES 
          (@nombre, @descripcion, @rating, @imagen, @idcreador, @tiempoMins, @calorias, @carbohidratos, @proteina, @grasas, @precio, @fechaPublicacion); 
         SELECT SCOPE_IDENTITY() AS id`
      );

    const recipeId = result.recordset[0].id;
    let totalCalorias = 0;
    let totalCarbohidratos = 0;
    let totalProteinas = 0;
    let totalGrasas = 0;
    let totalPrecio = 0;
    let totalTime = 0;

    for (const paso of pasos) {
      totalTime += paso.duracionMin || 0; 
      const stepRequest = new sql.Request(transaction);
      await stepRequest
        .input('recetaId', sql.Int, recipeId)
        .input('nro', sql.Int, paso.numero)
        .input('titulo', sql.NVarChar(100), paso.titulo)
        .input('descripcion', sql.NVarChar(300), paso.descripcion)
        .input('duracionMin', sql.Float, paso.duracionMin || 0)
        .query(`
          INSERT INTO PasosReceta 
          (idReceta, nro, titulo, descripcion, duracionMin) 
          VALUES 
          (@recetaId, @nro, @titulo, @descripcion, @duracionMin)
        `);
    }

    for (const ingrediente of ingredientes) {
      const ingredientRequest = new sql.Request(transaction);

      if (!ingrediente.cantidad || ingrediente.cantidad <= 0) {
        throw new Error('La cantidad de ingrediente es inválida o no está presente');
      }

      await ingredientRequest
        .input('recetaId', sql.Int, recipeId)
        .input('ingredienteId', sql.Int, ingrediente.id)
        .input('cant', sql.Float, ingrediente.cantidad)
        .query(
          `INSERT INTO IngredientePorReceta 
            (idReceta, idIngrediente, cant) 
           VALUES 
            (@recetaId, @ingredienteId, @cant)`
        );

      const nutritionRequest = new sql.Request(transaction);
      const nutricion = await nutritionRequest
        .input('ingredienteId', sql.Int, ingrediente.id)
        .query(
          `SELECT calorias, carbohidratos, proteinas, grasas, precio 
           FROM Ingredientes 
           WHERE id = @ingredienteId`
        );

      if (nutricion.recordset.length > 0) {
        const { calorias = 0, carbohidratos = 0, proteinas = 0, grasas = 0, precio = 0 } = nutricion.recordset[0];

        totalCalorias += (calorias / 100) * ingrediente.cantidad;
        totalCarbohidratos += (carbohidratos / 100) * ingrediente.cantidad;
        totalProteinas += (proteinas / 100) * ingrediente.cantidad;
        totalGrasas += (grasas / 100) * ingrediente.cantidad;
        totalPrecio += (precio / 100) * ingrediente.cantidad;
      }
    }

    const updateRequest = new sql.Request(transaction);
    await updateRequest
      .input('recetaId', sql.Int, recipeId)
      .input('calorias', sql.Float, totalCalorias || 0)
      .input('carbohidratos', sql.Float, totalCarbohidratos || 0)
      .input('proteinas', sql.Float, totalProteinas || 0)
      .input('grasas', sql.Float, totalGrasas || 0)
      .input('precio', sql.Float, totalPrecio || 0)
      .input('tiempoMins', sql.Float, totalTime || 0) // Añadimos el tiempo total de los pasos
      .query(
        `UPDATE Recetas
         SET calorias = @calorias,
             carbohidratos = @carbohidratos,
             proteina = @proteinas,
             grasas = @grasas,
             precio = @precio,
             tiempoMins = @tiempoMins
         WHERE id = @recetaId`
      );

    for (const tag of tags) {
      const tagRequest = new sql.Request(transaction);
      await tagRequest
        .input('idTag', sql.Int, tag.id)
        .input('idReceta', sql.Int, recipeId)
        .query(
          `INSERT INTO TagRecetas (idTag, idReceta)
           VALUES (@idTag, @idReceta)`
        );
    }

    await transaction.commit();
    return { id: recipeId };
  } catch (error) {
    console.error(`Error al crear receta: ${error.message}`);
    if (transaction) {
      try {
        await transaction.rollback();
      } catch (rollbackError) {
        console.error(`Error al hacer rollback de la transacción: ${rollbackError.message}`);
      }
    }
    throw error;
  } finally {
    if (pool) {
      await pool.close();
    }
  }
}



  // In the service

async rateReceta({ rating, recetaId, userId }) {
  let pool;
  console.log(userId)
  try {
    pool = await getConnection();
    console.log(recetaId)
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
async updateRating({ rating, recetaId, userId }) {
  let pool;

  try {
    pool = await getConnection();
    const result = await pool.request()
      .input('rate', sql.Int, rating)
      .input('user', sql.Int, userId)
      .input('receta', sql.Int, recetaId)
      .query(`UPDATE Rating SET rating = @rate WHERE idUsuario = @user AND idReceta = @receta`);
    return result;
  } finally {
    if (pool) {
      await pool.close();
    }
  }
  
}
async getRate(rid,uid) {
  let pool;
  try {
    pool = await getConnection();
    const result = await pool.request()
    .input('recipeId', sql.Int, rid)  
    .input('userId', sql.Int, uid)
      
      .query(`
        SELECT rating FROM Rating WHERE idReceta = @recipeId AND idUsuario = @userId 
      `);
    return result;
  } finally {
    if (pool) {
      await pool.close();
    }
  }
}
async updateRatingReceta(recetaId){
  
  let pool  
  try{
    pool = await getConnection();
    const result = await pool.request()
    .input('id', sql.Int, recetaId)
    .query(`DECLARE @promedio FLOAT;
    SET @promedio = (SELECT SUM(rating) * 1.0 / COUNT(rating) 
    FROM Rating 
    WHERE idReceta = @id);
    UPDATE Recetas 
    SET rating = @promedio 
    WHERE id = @id;
    `)
    return result;
  }finally{
    if(pool){
      await pool.close();
    }
  }
}
async getReviews(rid) {
  let pool;
  try {
    pool = await getConnection();
    const result = await pool.request()
    .input('recipeId', sql.Int, rid)  
    .query(`
      SELECT rev.comentario, rev.fecha, rev.rating, rev.id, u.nombreusuario, u.imagen, rec.id,
      (SELECT COUNT(*) FROM Reviews WHERE idReceta = @recipeId) AS total_reviews,
      (SELECT COUNT (*) FROM Favoritos WHERE idReceta = @recipeId) AS total_bookmarked
      FROM Reviews rev
      JOIN Usuarios u ON u.id = rev.idUsuario
      JOIN Recetas rec ON rec.id = rev.idReceta
      WHERE rec.id = @recipeId
      ORDER BY rev.fecha DESC;
    `);
    return result;
  } finally {
    if (pool) {
      await pool.close();
    }
  }
}
async postComment(rid,uid,msg,date,rating){
  let pool;
  try {
    pool = await getConnection();
    const result = await pool.request()
    .input('recipeId', sql.Int, rid)
    .input('userId', sql.Int, uid)
    .input('comment', sql.NVarChar(500), msg)
    .input('fecha', sql.DateTime, date)
    .input('rating', sql.Int, rating)  
    .query(`
      INSERT INTO Reviews (comentario,fecha,rating,idUsuario,idReceta ) VALUES (@comment, @fecha,@rating, @userId,@recipeId)
    `);
    return result;
  } finally {
    if (pool) {
      await pool.close();
    }
  }
}
async ratingInCommentary(uid){
  let pool;
  try {
    pool = await getConnection();
    const result = await pool.request()
    .input('userId', sql.Int, uid)  
    .query(`SELECT * FROM Rating WHERE idUsuario = @userId
    `);
    if(result != null){
      return result.recordset
    }else {
      return 0
    }
  } finally {
    if (pool) {
      await pool.close();
    }
  }
}
async deleteComment(msg,userId){
  let pool;
  try {
    pool = await getConnection();
    const result = await pool.request()
    
    .input('userId', sql.Int, userId)
    .input('comment', sql.NVarChar(500), msg)
    .query(`
      DELETE FROM Reviews WHERE comentario = @comment AND idUsuario = @userId 
    `);
    return result;
  } finally {
    if (pool) {
      await pool.close();
    }
  }
}
async updateComment(oldmsg,userId,msg,date){
  let pool;
  try {
    pool = await getConnection();
    const result = await pool.request()
    .input('mensaje', sql.NVarChar(500), oldmsg)
    .input('userId', sql.Int, userId)
    .input('comment', sql.NVarChar(500), msg)
    .input('fecha', sql.DateTime, date)  
    .query(`
      UPDATE Reviews SET comentario = @comment, fecha = @fecha WHERE idUsuario = @userId AND comentario = @mensaje
    `);
    return result;
  } finally {
    if (pool) {
      await pool.close();
    }
  }
}
async findCommentByText(commentText) {
  let pool;
  try {
    pool = await getConnection();
    const result = await pool.request()
      .input('commentText', sql.VarChar, commentText)
      .query(`SELECT id FROM Reviews WHERE comentario = @commentText`);
    
    return result.recordset.length > 0 ? result.recordset[0].id : null;
  } finally {
    if (pool) {
      await pool.close();
    }
  }
}


}



  
