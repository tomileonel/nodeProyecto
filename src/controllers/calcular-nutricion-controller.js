import express from 'express';
import { obtenerIngredientePorId } from './ingredientes-controller.js'; // Ajusta según tu estructura

const router = express.Router();

router.post('/', async (req, res) => {
  const { ingredientId, quantity } = req.body;

  try {
    const ingredient = await obtenerIngredientePorId(ingredientId); // Obtén el ingrediente de la base de datos
    if (!ingredient) {
      return res.status(404).json({ error: 'Ingrediente no encontrado.' });
    }

    // Calcula los valores nutricionales
    const totalCalories = (ingredient.calorias / 100) * quantity;

    res.json({
      ...ingredient,
      quantity,
      calorias: totalCalories
    });
  } catch (error) {
    console.error('Error al calcular la nutrición:', error);
    res.status(500).json({ error: 'Error en el servidor.' });
  }
});

export default router;