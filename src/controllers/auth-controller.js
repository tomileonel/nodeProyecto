import { Router } from 'express';
import AuthService from '../services/auth-service.js';

const router = Router();
const authService = new AuthService();

router.post('/login', async (req, res) => {
  const { email, password } = req.body;
  try {
    const [response, status] = await authService.login(email, password);
    res.status(status).json(response);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/register', async (req, res) => {
    const { username, name, lastName, phone, email, password } = req.body;
  
    if (!username || !name || !lastName || !phone || !email || !password) {
      return res.status(400).json({ message: 'Todos los campos son obligatorios' });
    }
  
    try {
      const [response, status] = await authService.register(username, name, lastName, phone, email, password);
      res.status(status).json(response);
    } catch (error) {
      console.error('Error en el registro:', error.message);
      res.status(500).json({ message: 'Error en el servidor', error: error.message });
    }
  });
  
export default router;
