import AuthRepository from '../repositories/auth-repository.js';

export default class AuthService {
  constructor() {
    this.authRepository = new AuthRepository();
  }

  async login(email, password) {
    try {
      const isAuthenticated = await this.authRepository.authenticateUser(email, password);
      if (isAuthenticated) {
        return [ { message: 'Inicio de sesión exitoso' }, 200 ];
      } else {
        return [ { message: 'Credenciales incorrectas' }, 401 ];
      }
    } catch (error) {
      console.error(`Error en la autenticación: ${error}`);
      return [ { message: 'Error en el servidor' }, 500 ];
    }
  }

  async register(username, name, lastName, phone, email, password) {
    try {
      // Verificar si el usuario ya está registrado
      const existingUser = await this.authRepository.getUserByEmail(email);
      if (existingUser) {
        return [{ message: 'El correo electrónico ya está registrado' }, 400];
      }

      // Registrar el nuevo usuario
      const isRegisteredSuccessfully = await this.authRepository.registerUser(username, name, lastName, phone, email, password);
      if (isRegisteredSuccessfully) {
        return [{ message: 'Registro exitoso' }, 201];
      } else {
        return [{ message: 'Error al registrar el usuario' }, 500];
      }
    } catch (error) {
      console.error(`Error en el registro: ${error.message}`);
      return [{ message: 'Error en el servidor' }, 500];
    }
  }
}