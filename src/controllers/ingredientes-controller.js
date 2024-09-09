// src/controllers/ingredientes-controller.js
import express from 'express';
import { getIngredientes } from '../services/ingredientes-service.js';

const router = express.Router();

// Obtener todos los ingredientes
router.get('/', async (req, res) => {
  try {
    const searchTerm = req.query.search || '';
    const ingredientes = await getIngredientes(searchTerm);
    res.json(ingredientes);
  } catch (error) {
    res.status(500).json({ message: 'Error al obtener los ingredientes', error });
  }
});


router.post('/add-to-recipe', async (req, res) => {
  const { idreceta, idingrediente, cantidad, detalleCant } = req.body;
  try {
    await ingredientesService.addIngredientToRecipe(idreceta, idingrediente, cantidad, detalleCant);
    res.status(200).json({ message: 'Ingrediente agregado a la receta con éxito' });
  } catch (error) {
    res.status(500).json({ message: 'Error al agregar ingrediente a la receta', error });
  }
});
export default router;
