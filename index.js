import express from 'express';
import cors from 'cors';
import path from 'path';
import { fileURLToPath } from 'url';  // Importa la utilidad para obtener la ruta actual
import Recetas from './src/controllers/recetas-controller.js';
import Favoritos from './src/controllers/favoritos-controller.js';
import Tags from './src/controllers/tags-controller.js';
import authRoutes from './src/routes/authRoutes.js';
import userRoutes from './src/routes/user-routes.js';
import ingredientesRoutes from './src/controllers/ingredientes-controller.js';
import Eventos from './src/controllers/evento-controller.js'
import Carrito from './src/controllers/carrito-controller.js'

// Obtener __dirname en módulos ESM
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

// Sirve las imágenes subidas desde la carpeta 'uploads'
app.use('/img', express.static(path.join(__dirname, 'img')));


// Servir las imágenes desde la carpeta 'img'


// Rutas de la aplicación
app.use('/api/recetas', Recetas);
app.use('/api/favoritos', Favoritos);
app.use('/api/auth', authRoutes);
app.use('/api/user', userRoutes);
app.use('/api/ingredientes', ingredientesRoutes); 
app.use('/api/tags', Tags);
app.use('/api/eventos', Eventos)
app.use('/api/carrito', Carrito)


app.listen(port, () => {
  console.log(`Servidor escuchando en el puerto ${port}`);
});
