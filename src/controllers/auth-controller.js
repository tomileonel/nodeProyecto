// src/controllers/auth-controller.js

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
  
