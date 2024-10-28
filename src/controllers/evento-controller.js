import { Router } from "express";
import EventoService from "../services/evento-service.js";

const router = Router();
const eventoService = new EventoService();

router.get('/', async (req,res) =>{
    try {
        const [data,status] = await eventoService.getEventos();
        res.status(status).json(data)
    } catch (error) {
        res.status(404).json({error: error.message});
    }
})


export default router;