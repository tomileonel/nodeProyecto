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

export default router;
