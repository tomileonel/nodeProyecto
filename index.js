// index.js
import express from 'express';
import cors from 'cors';
import Recetas from './src/controllers/recetas-controller.js';
import Favoritos from './src/controllers/favoritos-controller.js';
import Tags from './src/controllers/tags-controller.js';
import authRoutes from './src/routes/authRoutes.js';
import userRoutes from './src/routes/user-routes.js';
import ingredientesRoutes from './src/controllers/ingredientes-controller.js';

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

app.use('/api/recetas', Recetas);
app.use('/api/favoritos', Favoritos);
app.use('/api/auth', authRoutes);
app.use('/api/user', userRoutes);
app.use('/api/ingredientes', ingredientesRoutes);
app.use('/api/tags', Tags);

app.listen(port, () => {
  console.log(`Servidor escuchando en el puerto ${port}`);
});
