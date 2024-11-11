// src/routes/authRoutes.js
import multer from 'multer';
import path from 'path';
import express from 'express';
import { login, register,getUserProfile, editProfile } from '../controllers/auth-controller.js';

const router = express.Router();

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, 'img/'); // Cambiamos la carpeta de destino a 'img/'
    },
    filename: function (req, file, cb) {
      cb(null, Date.now() + path.extname(file.originalname)); // Nombre único basado en la fecha
    }
  });
  
  const upload = multer({ storage: storage });
router.post('/login', login);
router.post('/register', register);
router.post('/editProfile', upload.single('imagen'),editProfile)
router.get('/getUserProfile', getUserProfile);
export default router;
