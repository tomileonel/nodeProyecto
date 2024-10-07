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
  async createRecipe({ nombre, descripcion, ingredientes, pasos, tags, idcreador }) {
    try {
      const result = await this.recetasRepository.createRecipe({ nombre, descripcion, ingredientes, pasos, tags, idcreador });
      return { recipe: result, status: 201 };
    } catch (error) {
      console.error(`Error creating recipe: ${error}`);
      return { recipe: 'Error al crear la receta', status: 500 };
    }
  }
  
  async rateRecipe(rating, recetaId, userId) {
    try {
      if (rating < 1 || rating > 5) {
        throw new Error('Rating must be between 1 and 5');
      }
  
      const result = await this.recetasRepository.rateReceta({ rating, recetaId, userId });
      return { recipe: result, status: 200 };
    } catch (error) {
      console.error(`Error rating recipe ${error}`);
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
      console.error(`Error rating recipe ${error}`);
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
      const result = await this.recetasRepository.postComment(rid,uid,msg,date);
      return { result: result, status: 200 };  
    } catch (error) {
      console.error(`Error getting comments ${error}`);
      return { result: 'Error consiguiendo las recetas', status: 404 };
    }
  }
  async getLikes(cId,uId){
    try {
      const result = await this.recetasRepository.getLikes(cId,uId);
      return { result: result, status: 200 };  
    } catch (error) {
      console.error(`Error getting comments ${error}`);
      return { result: 'Error consiguiendo las recetas', status: 404 };
    }
  }
  async likeComment(cId, uId, like) {
    if (!cId || !uId) {
        throw new Error('Invalid comment ID or user ID');
    }
    try {
        const result = await this.recetasRepository.postLike(cId, uId, like);
        return { result: result, status: 200 };  
    } catch (error) {
        console.error(`Error liking comment: ${error}`);
        return { result: 'Error liking comment', status: 404 };
    }
}

  async deleteLike(cId,uId){
    try {
      const result = await this.recetasRepository.deleteLike(cId,uId);
      return { result: result, status: 200 };  
    } catch (error) {
      console.error(`Error getting comments ${error}`);
      return { result: 'Error consiguiendo las recetas', status: 404 };
    }
  }
  async countLikes(cId,like){
    try {
      const result = await this.recetasRepository.countLikes(cId,like);
      return { result: result, status: 200 };  
    } catch (error) {
      console.error(`Error getting comments ${error}`);
      return { result: 'Error consiguiendo las recetas', status: 404 };
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
  