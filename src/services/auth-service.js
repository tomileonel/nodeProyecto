import bcrypt from 'bcryptjs';
import AuthRepository from '../repositories/auth-repository.js';
import { generateToken } from '../utils/token.js';
let tk;
export default class AuthService {
  
  constructor() {
    this.authRepository = new AuthRepository();
  }
 
  async login(email, password) {
    try {
      const user = await this.authRepository.getUserByEmail(email);
      if (!user) {
        return [{ message: 'Credenciales incorrectas' }, 401];
      }

      const isPasswordValid = await bcrypt.compare(password, user.contrasena);
      if (!isPasswordValid) {
        return [{ message: 'Credenciales incorrectas' }, 401];
      }

      const token = generateToken(user);
      return [{ message: 'Inicio de sesión exitoso', token }, 200];
    } catch (error) {
      console.error(`Error en la autenticación: ${error.message}`, error.stack);
      return [{ message: 'Error en el servidor' }, 500];
    }
  }

  async register(username, name, lastName, phone, email, password) {
    try {
      const existingUser = await this.authRepository.getUserByEmail(email);
      if (existingUser) {
        return [{ message: 'El correo electrónico ya está registrado' }, 400];
      }

      // const hashedPassword = await bcrypt.hash(password, 10);

      const isRegisteredSuccessfully = await this.authRepository.registerUser(username, name, lastName, phone, email, password);
      if (isRegisteredSuccessfully) {
        const newUser = await this.authRepository.getUserByEmail(email);
        const token = generateToken(newUser);
        tk = token;
        return [{ message: 'Registro exitoso', token }, 201];
      } else {
        return [{ message: 'Error al registrar el usuario' }, 500];
      }
    } catch (error) {
      console.error(`Error en el registro: ${error.message}`, error.stack);
      return [{ message: 'Error en el servidor' }, 500];
    }
  }
}
