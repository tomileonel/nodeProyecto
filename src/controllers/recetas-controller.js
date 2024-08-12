import { Router } from 'express';
import RecetasService from '../services/recetas-service.js';

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

router.get('/recipes', async (req, res) => {
  const { search, tiempoMax, caloriasMax, ingredientes, tags } = req.query;

  try {
    const params = {
      search,
      tiempoMax: tiempoMax ? parseInt(tiempoMax, 10) : null,
      caloriasMax: caloriasMax ? parseInt(caloriasMax, 10) : null,
      ingredientes: ingredientes ? ingredientes.split(',').map(Number) : [],
      tags: tags ? tags.split(',').map(Number) : []
    };

    const { recipes, status } = await recetasService.getFilteredRecipes(params);
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
router.get('/getIdByName/:nombre', async (req,res) => {
  const { nombre } = req.params;
  try {
    const [id, status] = await recetasService.getIdporNombre(nombre);
    res.status(status).json(id);
  } catch (error) {
    res.status(500).json({error: error.message});
  }
})

router.get('/specialTags', async (req, res) => {
  try {
    const [tags, status] = await recetasService.getAllSpecialTags();
    res.status(status).json(tags);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/recipesByTag/:tagId/:userId', async (req, res) => {
  const { tagId, userId } = req.params;
  try {
    const [recipes, status] = await recetasService.getRecipesByTagWithUser(parseInt(tagId, 10), parseInt(userId, 10));
    res.status(status).json(recipes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
