import RecetasRepository from '../repositories/recetas-repository';

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
}
