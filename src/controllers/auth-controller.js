import AuthService from '../services/auth-service.js';
import { authenticateToken } from '../utils/auth-middleware.js';

const authService = new AuthService();

export const login = async (req, res) => {
  const { email, password } = req.body;

  const [response, statusCode] = await authService.login(email, password);
  res.status(statusCode).json(response);
};

export const register = async (req, res) => {
  const { username, name, lastName, phone, email, password } = req.body;

  if (!username || !name || !lastName || !phone || !email || !password) {
    return res.status(400).json({ message: 'Todos los campos son obligatorios' });
  }

  const [response, statusCode] = await authService.register(username, name, lastName, phone, email, password);
  res.status(statusCode).json(response);
};

export const getUserProfile = async (req, res) => {
  const token = req.headers['authorization']?.split(' ')[1]; // Obtiene el token del encabezado Authorization

  if (!token) {
    return res.status(401).json({ message: 'Token no proporcionado' });
  }

  try {
    const userProfile = await authService.getUserByToken(token); // Usa la función getUserByToken para obtener el perfil
    if (!userProfile) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }
    res.json(userProfile); // Devuelve el perfil del usuario
  } catch (error) {
    res.status(401).json({ message: error.message });
  }
};

// export const getUserByToken = async (token) => {
//   try {
//     const verified = jwt.verify(token, 'budin'); // Decodifica el token usando la clave secreta
//     const userId = verified.id;  // Obtiene el ID del usuario del payload del token

//     const user = await authService.getUserByToken(userId);  // Obtiene el perfil del usuario usando el ID
//     return user;
//   } catch (error) {
//     console.error(`Error al obtener el usuario por token: ${error.message}`);
//     throw new Error('Token inválido o usuario no encontrado');
//   }
// }


