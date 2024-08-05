import FavoritosRepository from '../repositories/favoritos-repository.js';

export default class FavoritosService {
  constructor() {
    this.favoritosRepository = new FavoritosRepository();
  }

  async getBookmarked(userId, recipeId){
    try {
        const bookmarked = await this.favoritosRepository.GetFavoritos(userId,recipeId);
        return [bookmarked,200]
    } catch (error) {
        console.error(`error founding bookmarked: ${error}`);
        return ["No se encontraron los favoritos", 404];
    }
  }async BookmarkRecipe(userId,recipeId){
    try {
        const bookmark = await this.favoritosRepository.PonerBookmark(userId,recipeId);
        return [bookmark, 201]
    } catch (error) {
        console.error(`error adding bookmark: ${error}`)
        return ["No se pudo agregar a favoritos", 404];
    }
  }
  async DeleteBookmark(userId,recipeId){
    try {
        const bookmark = await this.favoritosRepository.SacarBookmark(userId,recipeId);
        return [bookmark, 204]
    } catch (error) {
        console.error(`error adding bookmark: ${error}`)
        return ["No se pudo sacar de favoritos", 404];
    }
  }
}