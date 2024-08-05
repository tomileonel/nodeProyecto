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
}
