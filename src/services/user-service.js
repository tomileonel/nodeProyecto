// src/services/user-service.js
import UserRepository from '../repositories/user-repository.js';

const userRepository = new UserRepository();

class UserService {
  async getUserById(id) {
    try {
      const user = await userRepository.getUserById(parseInt(id, 10)); //
      return user;
    } catch (error) {
      console.error(`Error al obtener el usuario: ${error}`);
      throw error;
    }
  }
}

export default UserService;
