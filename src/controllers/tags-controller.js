// src/controllers/recetas-controller.js
import { Router } from 'express';
import TagsService from '../services/tags-service.js';


const router = Router();
const tagsService = new TagsService();

router.get('/', async (req, res) => {
    const { nombre } = req.query; // Extrae el parámetro 'nombre' de la consulta
    try {
      console.log('nombre:', nombre);
      const tags = await tagsService.buscarTags(nombre); // Usa el servicio aquí
      console.log('Tags:', tags);
      res.json(tags);
    } catch (error) {
      console.error('Error al obtener los tags:', error);
      res.status(500).json({ message: 'Error al obtener los tags', error });
    }
  });
  
  router.get('/:id', async (req, res) => {
    try {
      const { id } = req.params; // Extrae el parámetro 'nombre' de la consulta
      const tags = await tagsService.buscarTagsId(id); // Usa el servicio aquí
      console.log('Tags:', tags);
      res.json(tags);
    } catch (error) {
      console.error('Error al obtener los tags:', error);
      res.status(500).json({ message: 'Error al obtener los tags', error });
    }
  });
  

export default router;
