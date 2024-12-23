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
        const result = await this.carritoRepository.insertCarrito(userId,recetaId);
        return [result,201]
    } catch (error) {
        console.error(`No se pudo insertar en el carrito, error: ${error}`)
        return ["No se pudo insertar en el carrito", 409]
    }
}
async RecetaCarrito(recetaId,userId){
    try {
        const result = await this.carritoRepository.RecetaCarrito(userId,recetaId);
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
}async guardarTarjeta(userId,numero,titular,fechavencimiento,cvv){
    try {
        const result = await this.carritoRepository.guardarTarjeta(userId,numero,titular,fechavencimiento,cvv)
        return[`guardado efectivamente, ${result}`, 200]
    } catch (error) {
        console.error(`No se pudo guardar la tarjeta, error: ${error}`)
        return ["No se pudo guardar la tarjeta", 400]
    }
}async userTarjeta(userId){
    try {
        console.log(userId)
        const result = await this.carritoRepository.userTarjeta(userId)
        console.log(result)
        return[`${result}`, 200]
    } catch (error) {
        console.error(`No se pudo conseguir la tarjeta, error: ${error}`)
        return ["No se pudo conseguir la tarjeta", 400]
    }
}async pagarPedido(userId,recetaId,idTarjeta,fechapedido,fechaentrega,precio){
    try {
        const result = await this.carritoRepository.pagarPedido(userId,recetaId,idTarjeta,fechapedido,fechaentrega,precio)
        return[`${result}`, 200]
    } catch (error) {
        console.error(`No se pudo conseguir la tarjeta, error: ${error}`)
        return ["No se pudo conseguir la tarjeta", 400]
    }
}


  
}
  