import sql from 'mssql';
import getConnection from '../configs/db-config.js';

export default class FavoritosRepository {
    async GetFavoritos(userId, recipeId){
        let pool;
        try {
            pool = await getConnection()
            const result = await pool.request()
            .input('userId', sql.Int, userId)
            .input('recipeId', sql.Int, recipeId)
            .query(`SELECT * FROM Favoritos WHERE idUsuario = @userId AND idReceta = @recipeId`);
            return result;
        } finally{
            if(pool){
                await pool.close();
            }
        }
    }
    async PonerBookmark(userId,recipeId){ 
        const fechaUTC = new Date();
        fechaUTC.setHours(fechaUTC.getHours() - 3); // Ajuste a UTC-3
        const fecha = fechaUTC.toISOString().slice(0, 19).replace('T', ' ');
        let pool;
        try{
            pool = await getConnection()
            console.log(fecha)
            const result = await pool.request()
            .input('userId', sql.Int, userId)
            .input('recipeId', sql.Int, recipeId)
            .input('fecha', sql.DateTime, fecha)
            .query(`INSERT INTO Favoritos (idUsuario, idReceta, fechaAgregado) VALUES (@userId, @recipeId, @fecha)`)
            return result;
        }finally{
            if(pool	){
                await pool.close();
            }
        }
    }
    async SacarBookmark(userId,recipeId){
        let pool;
        try{
            pool = await getConnection()
            const result = await pool.request()
            .input('userId', sql.Int, userId)
            .input('recipeId', sql.Int, recipeId)
            .query(`DELETE FROM Favoritos WHERE idUsuario = @userId AND idReceta = @recipeId`)
            return result;
        }finally{
            if(pool	){
                await pool.close();
            }
        }
    }async FavoritosDeUsuario(userId){
        let pool;
        try {
            pool = await getConnection();
            
            if (!pool) {
                throw new Error('No se pudo obtener la conexión a la base de datos.');
            }
    
            // Crea la solicitud
            const request = pool.request();
    
            // Verifica si request es válido
            if (!request) {
                throw new Error('No se pudo crear la solicitud a la base de datos.');
            }
    
            // Configura los parámetros y ejecuta la consulta
            const result = await request
                .input('id', sql.Int, userId)
                .query(`
                    SELECT r.nombre, r.rating, r.tiempoMins, r.calorias, r.carboidratos, r.proteina, r.grasas, r.precio,r.imagen, f.idUsuario, f.fechaAgregado 
                    FROM Favoritos f
                    JOIN Recetas r ON r.id = f.idReceta 
                    WHERE f.idUsuario = @id
                `);
    
            return result;
        } catch (error) {
            console.error('Error al obtener los favoritos del usuario:', error.message);
            throw error;
        } finally {
            if (pool) {
                // Cierra la conexión si fue abierta
                await pool.close();
            }
        }
    }
    

}