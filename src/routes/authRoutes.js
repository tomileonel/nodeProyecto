// src/routes/authRoutes.js

import express from 'express';
import { login, register,getUserProfile } from '../controllers/auth-controller.js';

const router = express.Router();

router.post('/login', login);
router.post('/register', register);
router.get('/getUserProfile', getUserProfile);
export default router;
