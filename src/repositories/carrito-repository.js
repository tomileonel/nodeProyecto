import sql from 'mssql';
import getConnection from '../configs/db-config.js';
import { response } from 'express';

export default class CarritoRepository {
    async getAllCarrito(userId){
        let pool;
        try{
            pool = await getConnection();
            const result = await pool.request()
            .input('uid', sql.Int, userId.userId )
            .query(`SELECT r.nombre, r.rating, r.imagen, r.tiempoMins, r.calorias, r.precio, c.idUsuario, c.id, r.id AS idReceta FROM Carrito c
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
    }async guardarTarjeta(userId,numero,titular,fechavencimiento,cvv){
        let pool;
        try{
            pool = await getConnection()
            const result = await pool.request()
            .input('id', sql.Int, userId)
            .input('numero', sql.BigInt, numero)
            .input('titular', sql.NVarChar(50), titular)
            .input('vencimiento', sql.Date, fechavencimiento)
            .input('cvv', sql.Int, cvv)
            .query(`INSERT INTO Tarjeta (numero, titular, fechavencimiento, cvv, idTitular)
VALUES (@numero, @titular, @vencimiento, @cvv, @id)
RETURNING id; `)
            return result.recordset
        }finally{
            if(pool){
                await pool.close();
            }
        }
    }async guardarMetodo(userId,tarjeta,efectivo){
        let pool;
        try{
            pool = await getConnection()
            const result = await pool.request()
            .input('uid', sql.Int, userId)
            .input('tid', sql.Int, tarjeta)
            .input('eid', sql.Bit, efectivo)
            .query(`INSERT INTO FormaPago (efectivo,idTarjeta,idUsuario) VALUES (@eid,@tid,@uid) RETURNING id;`)
            return result.recordset
        }finally{
            if(pool){
                await pool.close();
            }
        }
    }
    
}