import AuthService from '../services/auth-service.js';
import { authenticateToken } from '../utils/auth-middleware.js';
import multer from 'multer';
import path from 'path';
const authService = new AuthService();

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'img/'); // Cambiamos la carpeta de destino a 'img/'
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname)); // Nombre único basado en la fecha
  }
});

const upload = multer({ storage: storage });

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

export const editProfile = async (req, res) => {
  console.log("llegaste")
  const img = req.file ? `/img/${req.file.filename}` : null;  // Ruta de la imagen

  const { id,username, name, lastName, phone, email, password, description,tags} = req.body;


  const [response, statusCode] = await authService.editProfile(id,username, name, lastName, phone, email, password, description,img,tags);
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

