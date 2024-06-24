import express from 'express';
import cors from 'cors';
import config from './src/configs/db-config.js';
import pkg from 'pg';
import Recetas from './src/controllers/recetas-controller.js';


const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

app.use('/api/recetas', Recetas);


app.listen(port, () => {
    console.log(`Servidor escuchando en el puerto ${port}`);
});