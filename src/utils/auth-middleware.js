import jwt from 'jsonwebtoken';

export const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization']; // Cambia aquí para usar los headers
  const token = authHeader && authHeader.split(' ')[1]; // Extrae solo el token

  if (!token) {
    return res.status(401).json({ message: 'Acceso denegado. Token no proporcionado.' });
  }

  try {
    const verified = jwt.verify(token, 'budin'); // Verifica el token
    req.user = verified; // Asigna el usuario verificado a req.user
    next(); // Pasa al siguiente middleware/controlador
  } catch (error) {
    res.status(401).json({ message: 'Token inválido' });
  }
};
