import RecetasRepository from '../repositories/recetas-repository.js';

export default class RecetasService {
  constructor() {
    this.recetasRepository = new RecetasRepository();
  }

  async getRecipesByTag(userId) {
    try {
      const userTags = await this.recetasRepository.getUserTags(userId);
      const recipes = await this.recetasRepository.getRecipesByTag(userTags);
      return [recipes, 200];
    } catch (error) {
      console.error(`Error fetching recipes by tag: ${error}`);
      return ["No se encuentran recetas", 404];
    }
  }

  async getRecipesByUser(userId) {
    try {
      const recipes = await this.recetasRepository.getRecipesByUser(userId);
      return [recipes, 200];
    } catch (error) {
      console.error(`Error fetching recipes by tag: ${error}`);
      return ["No se encuentran recetas", 404];
    }
  }

   async getFilteredRecipes(params) {
    try {
      const [recipes, status] = await this.recetasRepository.getFilteredRecipes(params);
      return { recipes, status: Number.isInteger(status) ? status : 200 };
    } catch (error) {
      console.error(`Error in RecipeService: ${error}`);
      return { recipes: "No se encuentran recetas", status: 500 };
    }
  }

  async getLatestRecipes(userId) {
    try {
      const userTags = await this.recetasRepository.getUserTags(userId);
      const recipes = await this.recetasRepository.getLatestRecipes(userTags);
      return [recipes, 200];
    } catch (error) {
      console.error(`Error fetching latest recipes: ${error}`);
      return ["No se encuentran recetas novedosas", 404];
    }
  }
  async getIdporNombre(nombre){
    try {
      const id = await this.recetasRepository.getIdByName(nombre);
      return [id, 200];
    } catch (error) {
      console.error(`No se encontro el id, error: ${error}`)
      return ["No se pudo conseguir el id", 404]
    }
  }

  async getAllSpecialTags () {
    try {
      const tags = await this.recetasRepository.getSpecialTags();
      return [tags, 200];
    } catch (error) {
      console.error(`Error al obtener los tags especiales: ${error}`);
      return [[], 500];
    }
  };

  async delete (id) {
    try {
      const res = await this.recetasRepository.delete(id);
      return [res, 200];
    } catch (error) {
      console.error(`Error al eliminar: ${error}`);
      return [[], 500];
    }
  };

  async getRecipesByTagWithUser(tagId, userId) {
    try {
      const recipes = await this.recetasRepository.getRecipesByTagWithUser(tagId, userId);
      if (recipes.length === 0) {
        return ["No se encuentran recetas para la categoría seleccionada", 404];
      }
      return [recipes, 200];
    } catch (error) {
      console.error(`Error fetching recipes by tag and user: ${error}`);
      return ["Error interno del servidor", 500];
    }
  }

  async getFullRecipeById(recipeId) {
    try {
        const recipe = await this.recetasRepository.getFullRecipeById(recipeId);
        if (!recipe) {
            throw new Error('Receta no encontrada');
        }
        return recipe;
    } catch (error) {
        console.error(`Error en el servicio al obtener la receta completa: ${error.message}`);
        throw error;
    }
  }
  async getPasosCount(id){
    try {
      const pasos = await this.recetasRepository.pasosCount(id);
      return pasos;
    } catch (error) {
      console.error(`Error en el servicio al obtener los pasos: ${error.message}`);
        throw error;
    }
  }
  async createRecipe({ nombre, descripcion, ingredientes, pasos, tags, idcreador, imagen }) {
    try {
      // Guardar la receta en el repositorio
      const recipe = await this.recetasRepository.createRecipe({
        nombre,
        descripcion,
        ingredientes,
        pasos,
        tags,
        idcreador,
        imagen // Pasar la imagen al repositorio
      });
      return { recipe, status: 201 };
    } catch (error) {
      console.error('Error al crear receta en el servicio:', error);
      throw new Error('Error al crear receta.');
    }
  }

  async editRecipe({ id, nombre, descripcion, ingredientes, pasos, tags, idcreador, imagen }) {
    let pool;
    try {
      pool = await getConnection();
      const transaction = new sql.Transaction(pool);
      await transaction.begin();
  
      let request = new sql.Request(transaction);
  
      // Actualizar los datos principales de la receta
      await request
        .input('id', sql.Int, id)
        .input('nombre', sql.NVarChar(50), nombre)
        .input('descripcion', sql.NVarChar(100), descripcion || "")
        .input('imagen', sql.NVarChar(300), imagen || "")
        .query(`
          UPDATE Recetas 
          SET nombre = @nombre, 
              descripcion = @descripcion, 
              imagen = @imagen
          WHERE id = @id
        `);
  
      // Actualizar pasos
      const deleteStepsRequest = new sql.Request(transaction);
      await deleteStepsRequest
        .input('idReceta', sql.Int, id)
        .query(`
          DELETE FROM PasosReceta 
          WHERE idReceta = @idReceta
        `);
  
      for (const paso of pasos) {
        const stepRequest = new sql.Request(transaction);
        await stepRequest
          .input('recetaId', sql.Int, id)
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
  
      // Actualizar ingredientes
      const deleteIngredientsRequest = new sql.Request(transaction);
      await deleteIngredientsRequest
        .input('idReceta', sql.Int, id)
        .query(`
        DELETE FROM RecetaCarrito 
        Where idReceta = @idReceta
        DELETE FROM Carrito 
        Where idReceta = @idReceta
          DELETE FROM IngredientePorReceta 
          WHERE idReceta = @idReceta
        `);
  
      for (const ingrediente of ingredientes) {
        const ingredientRequest = new sql.Request(transaction);
        await ingredientRequest
          .input('recetaId', sql.Int, id)
          .input('ingredienteId', sql.Int, ingrediente.id)
          .input('cant', sql.Float, ingrediente.cantidad)
          .query(`
            INSERT INTO IngredientePorReceta 
            (idReceta, idIngrediente, cant) 
            VALUES 
            (@recetaId, @ingredienteId, @cant)
          `);
      }
  
      // Actualizar tags
      const deleteTagsRequest = new sql.Request(transaction);
      await deleteTagsRequest
        .input('idReceta', sql.Int, id)
        .query(`
          DELETE FROM TagRecetas 
          WHERE idReceta = @idReceta
        `);
  
      for (const tag of tags) {
        const tagRequest = new sql.Request(transaction);
        await tagRequest
          .input('idTag', sql.Int, tag.id)
          .input('idReceta', sql.Int, id)
          .query(`
            INSERT INTO TagRecetas (idTag, idReceta) 
            VALUES (@idTag, @idReceta)
          `);
      }
  
      await transaction.commit();
      return { message: 'Receta actualizada con éxito' };
    } catch (error) {
      console.error(`Error al editar receta: ${error.message}`);
      if (transaction) {
        await transaction.rollback();
      }
      throw error;
    } finally {
      if (pool) {
        await pool.close();
      }
    }
  }
  
  
  async rateRecipe(rating, recetaId, userId) {
    try {
      console.log("bolas nro°",userId)
      const result = await this.recetasRepository.rateReceta({ rating, recetaId, userId });
      
      return { recipe: result, status: 200 };
      
    } catch (error) {
      console.error(`Error creating rating recipe ${error}`);
      return { recipe: 'Error rateando receta', status: 400 };
    }
  }
  async updateRating(rating,recetaId,userId){
    try {
      if (rating < 1 || rating > 5) {
        throw new Error('Rating must be between 1 and 5');
      } 
      
      const result = await this.recetasRepository.updateRating({ rating, recetaId, userId });

      return { recipe: result, status: 200 };
      
    } catch (error) {
      console.error(`Error updating rating recipe ${error}`);
      return { recipe: 'Error rateando receta', status: 400 };
    }
  }
  async updateRatingReceta(recetaId){
    try {
      const result = await this.recetasRepository.updateRatingReceta(recetaId);
      return { recipe: result, status: 200 };
      
    } catch (error) {
      console.error(`Error updating the rating of the recipe ${error}`);
      return { recipe: 'Error rateando receta', status: 400 };
    }
  }
  async getRating(rid,uid){
    try {
      const result = await this.recetasRepository.getRate(rid,uid)
      return { recipe: result, status: 200};
    } catch (error) {
      console.error(`Error getting the rating ${error}`);
      return { recipe: 'Error consiguiendo el rating', status: 400 };
    }
  }
  async getComments(rid) {
    try {
      const result = await this.recetasRepository.getReviews(rid);
      return { result: result, status: 200 };  
    } catch (error) {
      console.error(`Error getting comments ${error}`);
      return { result: 'Error consiguiendo las recetas', status: 404 };
    }
  }
  
  async postCommentary(rid,uid,msg,date){
    try {
      const rating = await this.recetasRepository.ratingInCommentary(uid);
      const rate = rating[0].rating;
      const result = await this.recetasRepository.postComment(rid,uid,msg,date,rate);
      return { result: result, status: 200 };  
    } catch (error) {
      console.error(`Error getting comments ${error}`);
      return { result: 'Error consiguiendo las recetas', status: 404 };
    }
  }
  async deleteCommentary(msg,userId){
    try {
      const result = await this.recetasRepository.deleteComment(msg,userId);
      
      return {status: 204};
    } catch (error) {
      console.error(`Error deleting comment ${error}`);
      return { result: 'Error intentando borrar el comentario', status: 400 };
    }
  }
  async updateCommentary(oldmsg,userId,msg,date){
    try {
      const result = await this.recetasRepository.updateComment(oldmsg,userId,msg,date);
      return {status: 204, result: result};
    } catch (error) {
      console.error(`Error updating comment ${error}`);
      return { result: 'Error intentando borrar el comentario', status: 400 };
    }
  }
  async getCommentIdByText(commentText) {
    try {
      const result = await this.recetasRepository.findCommentByText(commentText);
      return { result: result, status: 200 };
    } catch (error) {
      console.error(`Error getting comment ID: ${error}`);
      return { result: 'Error buscando el comentario', status: 404 };
    }
  }
  
}
  