// src/controllers/recetas-controller.js
import { Router } from 'express';
import TagsService from '../services/tags-service.js';


const router = Router();
const tagsService = new TagsService();

router.get('/', async (req, res) => {
    const { nombre } = req.query; // Extrae el parámetro 'nombre' de la consulta
    try {
      console.log('nombre:', nombre);
      const ingredientes = await tagsService.buscarIngredientes(nombre); // Usa el servicio aquí
      console.log('Ingredientes:', ingredientes);
      res.json(ingredientes);
    } catch (error) {
      console.error('Error al obtener los ingredientes:', error);
      res.status(500).json({ message: 'Error al obtener los ingredientes', error });
    }
  });
  

export default router;
