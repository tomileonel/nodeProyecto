import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class CarritoRepository {
    async getAllCarrito(userId){
        let pool;
        try{
            pool = await getConnection();
            const result = await pool.request()
            .input('uid', sql.Int, userId)
            .query(`SELECT * FROM Carrito WHERE idUsuario = @uid`)
            return result.recordset
        }finally{
            if(pool){
                await pool.close();
            }
        }
    }
    async insertRecetaCarrito(userId,recetaId){
        let pool;
        try{
            pool = await getConnection();
            const result = await pool.request()
            .input('uid', sql.Int, userId)
            .input('rid', sql.Int, recetaId)
            .query(`INSERT INTO Carrito (idReceta,idUsuario) VALUES (@rid, @uid)`)
            return result.recordset
        }finally{
            if(pool){
                await pool.close();
            }
        }
    }
}