import express from 'express';
import cors from 'cors';
import Recetas from './src/controllers/recetas-controller.js';
import Auth from './src/controllers/auth-controller.js'; 

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

app.use('/api/recetas', Recetas);
app.use('/api/auth', Auth); 

app.listen(port, () => {
    console.log(`Servidor escuchando en el puerto ${port}`);
});
