import UserService from '../services/user-service.js';

const userService = new UserService();

export const getUser = async (req, res) => {
  const { id } = req.params;

  try {
    const user = await userService.getUserById(id);
    if (!user) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }
    res.status(200).json(user);
  } catch (error) {
    console.error(`Error en la consulta de usuario por ID: ${error}`);
    res.status(500).json({ message: 'Error en el servidor' });
  }
};