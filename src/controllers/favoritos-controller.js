import { Router } from 'express';
import FavoritosService from '../services/favoritos-service.js';

const router = Router();
const favoritosService = new FavoritosService();

router.get('/getFavourites/:userId/:recipeId', async (req,res) =>{
    const { userId, recipeId } = req.params;
    try {
        const [bookmark,status] = await favoritosService.getBookmarked(userId,recipeId);
        res.status(status).json(bookmark);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
})
router.get('/favoritesFromUser/:userId', async (req,res) =>{
    const { userId } = req.params;
    try{
        const [bookmark,status] = await favoritosService.GetFavoritesFromUser(userId)
        res.status(status).json(bookmark);
    } catch (error){
        res.status(500).json({error:error.message});
    }
})
router.post('/Insertar/:userId/:recipeId', async (req,res) => {
    const { userId, recipeId } = req.params;
    try{
        const [bookmark,status] = await favoritosService.BookmarkRecipe(userId,recipeId);
        res.status(status).json("Creado efectivamente 👍");
    }catch(error){
        res.status(500).json({error:error.message});
    }
})
router.delete('/Borrar/:userId/:recipeId', async (req,res) => {
    const { userId, recipeId } = req.params;
    try{
        const [bookmark,status] = await favoritosService.DeleteBookmark(userId,recipeId);
        res.status(status).json("Borrado efectivamente 👍");
    }catch(error){
        res.status(500).json({error:error.message});
    }
})


export default router;