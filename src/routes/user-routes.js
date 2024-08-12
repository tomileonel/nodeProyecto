// src/routes/user-routes.js

import express from 'express';
import { getUser,getUserByToken  } from '../controllers/user-controller.js';
import { authenticateToken } from '../utils/auth-middleware.js'; // Asegúrate de importar el middleware


const router = express.Router();

// Ruta para obtener un usuario por ID
router.get('/:id', getUser);
router.get('/profile', authenticateToken, getUserByToken);


export default router;
