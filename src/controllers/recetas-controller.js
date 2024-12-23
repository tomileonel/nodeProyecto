// src/controllers/recetas-controller.js
import { Router } from 'express';
import multer from 'multer';
import path from 'path';
import RecetasService from '../services/recetas-service.js';
import IngredientesService from '../services/ingredientes-service.js';


const router = Router();
const recetasService = new RecetasService();
const ingredientesService = new IngredientesService();

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'img/'); // Cambiamos la carpeta de destino a 'img/'
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname)); // Nombre único basado en la fecha
  }
});

const upload = multer({ storage: storage });

// Ruta para obtener recetas por etiqueta
router.get('/byTag/:userId', async (req, res) => {
  const { userId } = req.params;
  try {
    const [recipes, status] = await recetasService.getRecipesByTag(userId);
    res.status(status).json(recipes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/byUser/:userId', async (req, res) => {
  const { userId } = req.params;
  try {
    const [recipes, status] = await recetasService.getRecipesByUser(userId);
    res.status(status).json(recipes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Ruta para obtener recetas filtradas
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

// Ruta para obtener recetas más recientes
router.get('/novedades/:userId', async (req, res) => {
  const { userId } = req.params;
  try {
    const [recipes, status] = await recetasService.getLatestRecipes(userId);
    res.status(status).json(recipes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Ruta para obtener ID de receta por nombre
router.get('/getIdByName/:nombre', async (req, res) => {
  const { nombre } = req.params;
  try {
    const [id, status] = await recetasService.getIdporNombre(nombre);
    res.status(status).json(id);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Ruta para obtener todas las etiquetas especiales
router.get('/specialTags', async (req, res) => {
  try {
    const [tags, status] = await recetasService.getAllSpecialTags();
    res.status(status).json(tags);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.delete('/delete/:id', async (req, res) => {
  const {id} = req.params
  try {
    const [response,status] = await recetasService.delete(id);
    res.status(status).json(response);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Ruta para obtener recetas por etiqueta y usuario
router.get('/recipesByTag/:tagId/:userId', async (req, res) => {
  const { tagId, userId } = req.params;
  try {
    const [recipes, status] = await recetasService.getRecipesByTagWithUser(parseInt(tagId, 10), parseInt(userId, 10));
    res.status(status).json(recipes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Ruta para obtener receta completa por ID
router.get('/fullRecipe/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const recetaCompleta = await recetasService.getFullRecipeById(id);
    res.json(recetaCompleta);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Ruta para obtener cantidad de pasos de una receta por ID
router.get('/getPasosCount/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const pasos = await recetasService.getPasosCount(id);
    res.json(pasos);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Ruta para obtener todos los ingredientes
router.get('/ingredientes', async (req, res) => {
  try {
    const ingredientes = await ingredientesService.getIngredientes();
    res.json(ingredientes);
  } catch (error) {
    console.error('Error al obtener los ingredientes:', error);
    res.status(500).json({ error: 'Error al obtener los ingredientes' });
  }
});

router.post('/create', upload.single('imagen'), async (req, res) => {
  const { nombre, descripcion, ingredientes, pasos, tags, idcreador } = req.body;

  // Verifica si la imagen ha sido subida y construye la ruta de la imagen
  const imagen = req.file ? `/img/${req.file.filename}` : null;  // Ruta de la imagen

  console.log('Ruta de la imagen subida:', imagen);  // Depurar si la ruta de la imagen se genera correctamente

  // Verifica si el idcreador está presente
  if (!idcreador) {
    return res.status(400).json({ message: 'El ID del creador es obligatorio' });
  }

  try {
    const result = await recetasService.createRecipe({
      nombre,
      descripcion,
      ingredientes: JSON.parse(ingredientes),
      pasos: JSON.parse(pasos),
      tags: JSON.parse(tags),
      idcreador,
      imagen  // Pasamos la ruta de la imagen al servicio
    });

    res.status(201).json(result.recipe);
  } catch (error) {
    console.error('Error al crear receta:', error);
    res.status(500).json({ error: error.message });
  }
});

router.put('/edit/:id', upload.single('imagen'), async (req, res) => {
  const { id } = req.params; // ID de la receta a editar
  const { nombre, descripcion, ingredientes, pasos, tags, idcreador } = req.body;

  // Verifica si la imagen ha sido subida y construye la ruta
  const imagen = req.file ? `/img/${req.file.filename}` : null;

  if (!id || !idcreador) {
    return res.status(400).json({ message: 'El ID de la receta y del creador son obligatorios' });
  }

  try {
    const result = await recetasService.editRecipe({
      id,
      nombre,
      descripcion,
      ingredientes: JSON.parse(ingredientes),
      pasos: JSON.parse(pasos),
      tags: JSON.parse(tags),
      idcreador,
      imagen
    });

    res.status(200).json(result);
  } catch (error) {
    console.error('Error al editar receta:', error);
    res.status(500).json({ error: error.message });
  }
});


router.post('/rate/:rating/:idReceta/:idUsuario',  async (req,res) => {
// In the controller
const { rating, idReceta, idUsuario } = req.params;
const parsedRating = parseInt(rating, 10);

if (isNaN(parsedRating)) {
  return res.status(400).json({ error: 'Invalid rating' });
}

try {
  const result = await recetasService.rateRecipe(parsedRating, idReceta, idUsuario);
  res.status(result.status).json(result.recipe);
} catch (error) {
  res.status(400).json({ error: error.message });
}
})
router.put('/updaterating/:rating/:idReceta/:idUsuario', async (req,res) => {
  const { rating, idReceta, idUsuario } = req.params;
  const parsedRating = parseInt(rating, 10);

  if (isNaN(parsedRating)) {
  return res.status(400).json({ error: 'Invalid rating' });
  }

  try {
  const result = await recetasService.updateRating(parsedRating, idReceta, idUsuario);
  res.status(result.status).json(result.recipe);
  } catch (error) {
  res.status(400).json({ error: error.message });
  }
})
router.patch('/ratingreceta/:idReceta', async (req,res) => {
  const {idReceta} = req.params;
  try {
   const result = await recetasService.updateRatingReceta(idReceta);
   res.status(result.status).json(result.recipe) 
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
})
router.get('/getrating/:recipeId/:userId', async (req,res) => {
  const {recipeId, userId} = req.params;
  try {
    const result = await recetasService.getRating(recipeId,userId);
    res.status(result.status).json(result.recipe);
    } catch (error) {
    res.status(400).json({ error: error.message });
    }
})

router.get('/recipesByPrice', async (req, res) => {
  const { search, tiempoMax, caloriasMax, ingredientes, tags, precioMin, precioMax } = req.query;

  try {
    const params = {
      search,
      tiempoMax: tiempoMax ? parseInt(tiempoMax, 10) : null,
      caloriasMax: caloriasMax ? parseInt(caloriasMax, 10) : null,
      ingredientes: ingredientes ? ingredientes.split(',').map(Number) : [],
      tags: tags ? tags.split(',').map(Number) : [],
      precioMin: precioMin ? parseFloat(precioMin) : null,
      precioMax: precioMax ? parseFloat(precioMax) : null
    };

    const { recipes, status } = await recetasService.getFilteredRecipesByPrice(params);
    res.status(status).json(recipes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}); 
router.get('/getReviews/:recipeId', async (req,res) => {
  const {recipeId} = req.params;
    try{ 
      const result = await recetasService.getComments(recipeId)
      res.status(result.status).json(result.result);
    }catch (error) {
      res.status(404).json({ error: error.message});
    }
})
router.post('/postComment/:recipeId/:userId', async (req,res) => {
  const {recipeId,userId} = req.params;
  const {msg,date} = req.body;
  try {
    const result = await recetasService.postCommentary(recipeId,userId,msg,date)
    res.status(result.status).json(result.result)
  } catch (error) {
    res.status(400).json({error:error.message})
  }
})
router.delete('/deleteComment/:msg/:userId', async (req,res) => {
  const {msg, userId} = req.params;
 
  try {
    console.log(userId)
    const result = await recetasService.deleteCommentary(msg,userId)
    res.status(result.status).json("succesfuly deleted");
  } catch (error) {
    res.status(400).json({error:error.message})
  }
})
router.put('/updateComment/:oldmsg/:userId', async (req,res) => {
  const {oldmsg,userId} = req.params;
  const {msg} = req.body;
  const ahora = new Date().toISOString();
  const date = ahora.toLocaleString();
  try {
    const result = await recetasService.updateCommentary(oldmsg,userId,msg,date)
    res.status(result.status).json(`succesfuly updated: old commentary: ${oldmsg} new commentary ${msg}`)
  } catch (error) {
    res.status(400).json({error:error.message})
  }
})
router.get('/getCommentIdByText/:commentText', async (req, res) => {
  const { commentText } = req.params;
  try {
    const result = await recetasService.getCommentIdByText(commentText);
    res.status(result.status).json(result.result);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

export default router;
