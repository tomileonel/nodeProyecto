import jwt from 'jsonwebtoken';

const secretKey = process.env.JWT_SECRET || 'tu_secreto';

export const generateToken = (user) => {
  return jwt.sign({ userId: user.id, email: user.mail }, secretKey, { expiresIn: '1h' });
};

export const verifyToken = (token) => {
  try {
    return jwt.verify(token, secretKey);
  } catch (error) {
    return null;
  }
};
