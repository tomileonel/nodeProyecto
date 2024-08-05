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

  async searchRecipes(userId, tipoCocina, ingredientes, maxCalorias, maxTiempo) {
    try {
      const userTags = await this.recetasRepository.getUserTags(userId);
      const recipes = await this.recetasRepository.searchRecipes(userTags, tipoCocina, ingredientes, maxCalorias, maxTiempo);
      return [recipes, 200];
    } catch (error) {
      console.error(`Error searching recipes: ${error}`);
      return ["No se encuentran recetas", 404];
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

  async getAllTags() {
    try {
      const tags = await this.recetasRepository.getAllTags();
      return [tags, 200];
    } catch (error) {
      console.error(`Error in TagService: ${error}`);
      return [{ error: 'Error al obtener las etiquetas' }, 500];
    }
  }

  async getRecipesByTag1(tagId) {
    try {
      const recipes = await this.recetasRepository.getRecipesByTag([tagId]);
      return [recipes, 200];
    } catch (error) {
      console.error(`Error fetching recipes by tag: ${error}`);
      return [{ error: 'No se encuentran recetas para el tag proporcionado' }, 404];
    }
  }


}
