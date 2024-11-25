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
    try {
    pool = await getConnection();

    // Validar valores
    if (numero.toString().length > 19) {
        throw new Error('El número de la tarjeta excede el límite permitido.');
    }
    if (cvv < 0 || cvv > 9999) {
        throw new Error('El CVV debe estar entre 0 y 9999.');
    }

    const result = await pool.request()
        .input('id', sql.Int, userId)
        .input('numero', sql.BigInt, numero) // Asegúrate de que la columna en la tabla sea BIGINT
        .input('titular', sql.NVarChar(50), titular)
        .input('vencimiento', sql.Date, fechavencimiento)
        .input('cvv', sql.Int, cvv) // Asegúrate de que la columna en la tabla sea INT
        .query(`
            INSERT INTO Tarjeta (numero, titular, fechavencimiento, cvv, idTitular)
            OUTPUT INSERTED.id
            VALUES (@numero, @titular, @vencimiento, @cvv, @id);
        `);

    return result.recordset;
    } finally {
    if (pool) {
        await pool.close();
    }
    }
    }async userTarjeta(userId){
        let pool;
        try{
            pool = await getConnection();
            const result = await pool.request()
            .input('uid', sql.Int, userId.userId )
            .query(`SELECT * FROM Tarjeta WHERE idUsuario = @uid`)
            return result.recordset
        }finally{
            if(pool){
                await pool.close();
            }
        }
    }
    
}