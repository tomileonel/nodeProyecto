import express from 'express';
import IngredientesService from '../services/ingredientes-service.js';
import db from '../configs/db-config.js';
import sql from 'mssql';

const router = express.Router();
const ingredientesService = new IngredientesService();

// Obtener todos los ingredientes
router.get('/', async (req, res) => {
  const searchTerm = req.query.search || ''; // Uso correcto de req.query
  try {
    console.log('searchTerm:', searchTerm);
    const ingredientes = await ingredientesService.getFilteredIngredientes(searchTerm); // Llamada a la función con el término de búsqueda
    console.log('Ingredientes:', ingredientes);
    res.json(ingredientes);
  } catch (error) {
    console.error('Error al obtener los ingredientes:', error);
    res.status(500).json({ message: 'Error al obtener los ingredientes', error });
  }
});

// Agregar ingrediente a receta
router.post('/add-to-recipe', async (req, res) => {
  console.log('Solicitud recibida para agregar ingrediente a la receta'); // Log de inicio de la función
  console.log('Cuerpo de la solicitud:', req.body); // Log del cuerpo de la solicitud

  const { idreceta, idingrediente, cant } = req.body; // Asegúrate de que estás extrayendo 'cant' correctamente
  try {
    console.log('ID Creador recibido:', req.user ? req.user.id : 'No autenticado'); // Si estás usando autenticación
    console.log('cant recibida:', cant); // Verifica que la cant recibida sea correcta

    await ingredientesService.addIngredientToRecipe(idreceta, idingrediente, cant);
    res.status(200).json({ message: 'Ingrediente agregado a la receta con éxito' });
  } catch (error) {
    console.error('Error al agregar ingrediente a la receta:', error);
    res.status(500).json({ message: 'Error al agregar ingrediente a la receta', error });
  }
});

router.post('/calcular-nutricion', async (req, res) => {
  const { ingredientId, quantity } = req.body;

  if (!ingredientId || !quantity) {
    return res.status(400).json({ error: 'Faltan datos' });
  }

  try {
    // Consulta a la base de datos para obtener los datos del ingrediente
    const result = await db.query(
      'SELECT nombre, calorias, carbohidratos, proteinas, grasas FROM Ingredientes WHERE id = @ingredientId',
      { replacements: { ingredientId }, type: db.QueryTypes.SELECT }
    );

    if (result.length === 0) {
      return res.status(404).json({ error: 'Ingrediente no encontrado' });
    }

    const ingredient = result[0];

    // Realiza los cálculos basados en la cantidad ingresada
    const factor = quantity / 100;
    const calorias = (ingredient.calorias * factor).toFixed(2);
    const carbohidratos = (ingredient.carbohidratos * factor).toFixed(2);
    const proteina = (ingredient.proteinas * factor).toFixed(2);
    const grasas = (ingredient.grasas * factor).toFixed(2);

    // Devolver los datos calculados
    res.json({
      id: ingredientId,
      nombre: ingredient.nombre,
      quantity,
      calorias,
      carbohidratos,
      proteina,
      grasas
    });
  } catch (error) {
    console.error('Error al calcular la información nutricional:', error);
    res.status(500).json({ error: 'Error al calcular la información nutricional' });
  }
});

router.post('/ingredientePorReceta', async (req, res) => {
  const { idreceta, idingrediente, cant } = req.body;
  console.log('Datos recibidos:', { idreceta, idingrediente, cant }); // Para depuración

  try {
    // Aquí va tu lógica para insertar en la base de datos
    const result = await db.query(/* tu consulta aquí */);
    res.status(200).json(result);
  } catch (error) {
    console.error('Error al insertar ingrediente:', error);
    res.status(500).json({ error: 'Error al insertar ingrediente' });
  }
});


export default router;
