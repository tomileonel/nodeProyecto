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
        let pool;
        try{
            pool = await getConnection()
            const result = await pool.request()
            .input('userId', sql.Int, userId)
            .input('recipeId', sql.Int, recipeId)
            .query(`INSERT INTO Favoritos (idUsuario, idReceta) VALUES (@userId, @recipeId)`)
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
    }

}