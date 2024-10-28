import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class EventoRepository {
    async getEventos(){
        let pool;
        try{
            pool = await getConnection();
            const result = await pool.request()
            .query(`SELECT * FROM Eventos `)
            return result.recordset
        }finally{
            if(pool){
                await pool.close();
            }
        }
    }
}