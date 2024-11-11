import bcrypt from 'bcryptjs';
import AuthRepository from '../repositories/auth-repository.js';
import { generateToken } from '../utils/token.js';
import jwt from 'jsonwebtoken';
let tk;
export default class AuthService {
  
  constructor() {
    this.authRepository = new AuthRepository();
  }
 
  async login(email, password) {
    try {
      const user = await this.authRepository.getUserByEmail(email);
      if (!user) {
        return [{ message: 'Credenciales incorrectas no user' }, 401];
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
      // Verificar si el usuario ya existe
      // Verificar si el usuario ya existe
      var existingUser = await this.authRepository.getUserByEmail(email);
      if (existingUser) {
        return [{ message: 'El correo electrónico ya está registrado' }, 400];
      }


      var existingUser = await this.authRepository.getUserByPhone(phone);
      if (existingUser) {
        return [{ message: 'El telefono ya está registrado' }, 400];
      }


      var existingUser = await this.authRepository.getUserByUsername(username);
      if (existingUser) {
        return [{ message: 'El nombre de usario ya está registrado' }, 400];
      }


      // Hashear la contraseña antes de guardarla
      const hashedPassword = await bcrypt.hash(password, 10);

      // Registrar al usuario
      const isRegisteredSuccessfully = await this.authRepository.registerUser(username, name, lastName, phone, email, hashedPassword);
      if (!isRegisteredSuccessfully) {
        return [{ message: 'Error al registrar el usuario' }, 500];
      }
      console.log("4")


      // Obtener el usuario registrado para generar el token
      const newUser = await this.authRepository.getUserByEmail(email);
      if (!newUser) {
        return [{ message: 'Error al obtener el usuario registrado' }, 500];
      }

      // Generar el token
      const token = generateToken(newUser);

      // Retornar respuesta exitosa
      return [{ message: 'Registro exitoso', token }, 201];
    } catch (error) {
      console.error(`Error en el registro: ${error.message}`, error.stack);
      return [{ message: 'Error en el servidor' }, 500];
    }
  }

  async editProfile(id,username, name, lastName, phone, email, password,description,img) {
    try {
      // Verificar si el usuario ya existe
      var existingUser = await this.authRepository.getUserByEmail(email);
      if (existingUser && existingUser.id != id) {
        return [{ message: 'El correo electrónico ya está registrado' }, 400];
      }

      var existingUser = await this.authRepository.getUserByPhone(phone);
      if (existingUser  && existingUser.telefono != phone) {
        return [{ message: 'El telefono ya está registrado' }, 400];
      }

      var existingUser = await this.authRepository.getUserByUsername(username);
      if (existingUser  && existingUser.nombreusuario != username) {
        return [{ message: 'El nombre de usario ya está registrado' }, 400];
      }


      const hashedPassword = await bcrypt.hash(password, 10);

      // Registrar al usuario
      const isRegisteredSuccessfully = await this.authRepository.editProfile(username, name, lastName, phone, email, hashedPassword,description,img);
      if (!isRegisteredSuccessfully) {
        return [{ message: 'Error al registrar el usuario' }, 500];
      }

      // Obtener el usuario registrado para generar el token
      const newUser = await this.authRepository.getUserByEmail(email);
      if (!newUser) {
        return [{ message: 'Error al obtener el usuario registrado' }, 500];
      }

      // Generar el token
      const token = generateToken(newUser);

      // Retornar respuesta exitosa
      return [{ message: 'Registro exitoso', token }, 201];
    } catch (error) {
      console.error(`Error en el registro: ${error.message}`, error.stack);
      return [{ message: 'Error en el servidor' }, 500];
    }
  }


  async getUserByToken(token) {
    try {
      const verified = jwt.verify(token, 'budin'); // Decodifica el token usando la clave secreta
      const userId = verified.id;  // Obtiene el ID del usuario del payload del token

      const user = await this.authRepository.getUserById(userId);  // Llama al repositorio para obtener el perfil del usuario
      return user;  // Devuelve el perfil del usuario
    } catch (error) {
      console.error(`Error al obtener el usuario por token: ${error.message}`);
      throw new Error('Token inválido o usuario no encontrado');
    }
  }


}