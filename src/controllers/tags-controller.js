// src/controllers/recetas-controller.js
import { Router } from 'express';
import TagsService from '../services/tags-service.js';


const router = Router();
const tagsService = new TagsService();

router.get('/', async (req, res) => {
    const { searchTerm } = req.query; // Extrae el searchTerm de los parámetros
    try {
      console.log('searchTerm:', searchTerm);
      const ingredientes = await tagsService.buscarIngredientes(searchTerm); // Usa el servicio aquí
      console.log('Ingredientes:', ingredientes);
      res.json(ingredientes);
    } catch (error) {
      console.error('Error al obtener los ingredientes:', error);
      res.status(500).json({ message: 'Error al obtener los ingredientes', error });
    }
  });


export default router;
