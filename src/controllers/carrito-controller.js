import { Router } from "express";
import CarritoService from '../services/carrito-service.js';


const router = Router();
const carritoService = new CarritoService();

router.get('/getInfoCarrito/:userId', async (req,res) =>{
    const userId = req.params;
    try {
        const [data,status] = await carritoService.getCarritoFromUser(userId);
        res.status(status).json(data)
    } catch (error) {
        res.status(404).json({error: error.message});
    }
})
router.post('/insertCarrito/:userId/:recipeId', async (req,res) => {
    const {userId,recipeId} = req.params;
    try {
        const [data,status] = await carritoService.InsertIntoCarrito(recipeId,userId);
        res.status(status).json(data)
    } catch (error) {
        res.status(409).json({error:error.message})
    }
})

export default router;