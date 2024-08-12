import jwt from 'jsonwebtoken';

export const authenticateToken = (req, res, next) => {
  const token = req.header('Authorization')?.split(' ')[1]; 

  if (!token) {
    return res.status(401).json({ message: 'Acceso denegado' });
  }

  try {
    const verified = jwt.verify(token, 'tu_secreto');
    req.user = verified;
    next();
  } catch (error) {
    res.status(401).json({ message: 'Token inválido' });
  }
};
