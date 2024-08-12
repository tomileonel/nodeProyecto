// src/routes/user-routes.js

import express from 'express';
import { getUser } from '../controllers/user-controller.js';

const router = express.Router();

// Ruta para obtener un usuario por ID
router.get('/:id', getUser);

export default router;
