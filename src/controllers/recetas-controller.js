import { Router } from 'express';
import RecetasService from '../services/recetas-service';

const router = Router();
const recetasService = new RecetasService();

router.get('/byTag/:userId', async (req, res) => {
  const { userId } = req.params;
  try {
    const [recipes, status] = await recetasService.getRecipesByTag(userId);
    res.status(status).json(recipes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/search', async (req, res) => {
  const { userId, tipoCocina, ingredientes, maxCalorias, maxTiempo } = req.query;
  try {
    const [recipes, status] = await recetasService.searchRecipes(userId, tipoCocina, ingredientes, maxCalorias, maxTiempo);
    res.status(status).json(recipes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/novedades/:userId', async (req, res) => {
  const { userId } = req.params;
  try {
    const [recipes, status] = await recetasService.getLatestRecipes(userId);
    res.status(status).json(recipes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
