import TagsRepository from '../repositories/tags-repository.js';

export default class TagsService {
  constructor() {
    this.TagsRepository = new TagsRepository();
  }

  async buscarTags(nombre) {
    try {
      const tags = await  this.TagsRepository.getTags(nombre);
      return tags;
    } catch (error) {
      console.error('Error en el servicio de tags:', error);
      throw error; // Lanza el error para manejarlo en el controlador
    }
  }

  async buscarTagsId(id) {
    try {
      const tags = await  this.TagsRepository.getTagsId(id);
      return tags;
    } catch (error) {
      console.error('Error en el servicio de tags:', error);
      throw error; // Lanza el error para manejarlo en el controlador
    }
  }
}
  