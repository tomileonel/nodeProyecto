import TagsRepository from '../repositories/tags-repository.js';

export default class TagsService {
  constructor() {
    this.TagsRepository = new TagsRepository();
  }

  async buscarIngredientes(nombre) {
    try {
      const ingredientes = await  this.TagsRepository.getIngredientes(nombre);
      return ingredientes;
    } catch (error) {
      console.error('Error en el servicio de ingredientes:', error);
      throw error; // Lanza el error para manejarlo en el controlador
    }
  }
}
  