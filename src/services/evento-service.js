import EventoRepository from "../repositories/evento-repository.js";

export default class EventoService {
    constructor(){
        this.eventoRepository = new EventoRepository();
    }
    async getEventos(){
        try {
            const result = await this.eventoRepository.getEventos();
            return [result, 200]
        } catch (error) {
            console.error(`No se pudo conseguir los eventos, error: ${error}`)
            return ["No se encontraron eventos", 404]
        }
    }
}