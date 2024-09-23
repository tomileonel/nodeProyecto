import jwt from 'jsonwebtoken';

const SECRET_KEY = 'budin'; 

export const generateToken = (user) => {
  return jwt.sign({ id: user.id, email: user.mail }, SECRET_KEY, { expiresIn: '3h' });
};

export const verifyToken = (token) => {
  try {
    return jwt.verify(token, SECRET_KEY);
  } catch (error) {
    throw new Error('Token inválido');
  }
};
