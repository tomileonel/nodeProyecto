// index.js

import express from 'express';
import cors from 'cors';
import Recetas from './src/controllers/recetas-controller.js';
import Favoritos from './src/controllers/favoritos-controller.js';
import { login, register } from './src/controllers/auth-controller.js'; 

import authRoutes from './src/routes/authRoutes.js';

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

app.use('/api/recetas', Recetas);
app.use('/api/favoritos', Favoritos);


app.post('/api/auth/login', login);
app.post('/api/auth/register', register);

app.use('/api/auth', authRoutes);

app.listen(port, () => {
    console.log(`Servidor escuchando en el puerto ${port}`);
});
