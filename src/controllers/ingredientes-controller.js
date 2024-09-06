// src/controllers/ingredientes-controller.js
import express from 'express';
import IngredientesService from '../services/ingredientes-service.js';

const router = express.Router();
const ingredientesService = new IngredientesService();

router.get('/', async (req, res) => {
  try {
    const ingredientes = await ingredientesService.getAllIngredientes();
    res.status(200).json(ingredientes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
