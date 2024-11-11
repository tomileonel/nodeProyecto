import carritoRepository from '../repositories/carrito-repository.js';

export default class CarritoService {
  constructor() {
    this.carritoRepository = new carritoRepository();
  }

  async getCarritoFromUser(userId){
    try {
        const result = await this.carritoRepository.getAllCarrito(userId);
        return [result, 200]
    } catch (error) {
        console.error(`No se pudo conseguir los datos del carrito, error: ${error}`)
        return ["No se encontraron datos del carrito", 404]
    }
}
async InsertIntoCarrito(recetaId,userId){
    try {
        const result = await this.carritoRepository.insertRecetaCarrito(userId,recetaId);
        return [result,201]
    } catch (error) {
        console.error(`No se pudo insertar en el carrito, error: ${error}`)
        return ["No se pudo insertar en el carrito", 409]
    }
}
async deleteFromCarrito(id){
    try {
        const result = await this.carritoRepository.deleteRecetaCarrito(id)
        return[`borrado efectivamente, ${result}`, 200]
    } catch (error) {
        console.error(`No se pudo borrar la receta del carrito, error: ${error}`)
        return ["No se pudo borrar la receta", 400]
    }
}
  
}
  