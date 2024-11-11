import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class CarritoRepository {
    async getAllCarrito(userId){
        let pool;
        try{
            pool = await getConnection();
            const result = await pool.request()
            .input('uid', sql.Int, userId.userId )
            .query(`SELECT r.nombre, r.rating, r.imagen, r.tiempoMins, r.calorias, r.precio, c.idUsuario, c.id FROM Carrito c
            JOIN Recetas r on r.id = c.idReceta WHERE c.idUsuario = @uid`)
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
    async deleteRecetaCarrito(id){
        let pool;
        try{
            pool = await getConnection()
            const result = await pool.request()
            .input('id', sql.Int, id)
            .query(`DELETE FROM Carrito WHERE id = @id`)
            return result.recordset
        }finally{
            if(pool){
                await pool.close();
            }
        }
    }
}