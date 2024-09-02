// src/services/user-service.js
import UserRepository from '../repositories/user-repository.js';

const userRepository = new UserRepository();

class UserService {


  async getUserById(id) {
    try {
      const user = await userRepository.getUserById(id);
      if (!user) {
        throw new Error('Usuario no encontrado');
      }
      return user;
    } catch (error) {
      console.error(`Error en el servicio de usuario: ${error.message}`);
      throw error;
    }
  }
}


export default UserService;
