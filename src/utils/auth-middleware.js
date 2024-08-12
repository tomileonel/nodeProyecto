import jwt from 'jsonwebtoken';

export const authenticateToken = (req, res, next) => {
  const token = req.query('Authorization')?.split(' ')[1];  //cambiar por header

  if (!token) {
    return res.status(401).json({ message: 'Acceso denegado' });
  }

  try {
    const verified = jwt.verify(token, 'budin');
    req.user = verified;
    next();
  } catch (error) {
    res.status(401).json({ message: 'Token inválido' });
  }
};
