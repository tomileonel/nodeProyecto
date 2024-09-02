// components/Timer.js
"use client";
import { useState, useEffect } from "react";
import axios from "axios";
import styles from "./styles.module.css";

const Timer = ({ id }) => {
  const [seconds, setSeconds] = useState(300); // Valor inicial predeterminado
  const [isActive, setIsActive] = useState(false);

  useEffect(() => {
    const fetchTime = async () => {
      try {
        console.log("Fetching pasos with their times...");
        console.log(id)
        // URL para obtener todos los pasos con sus tiempos en minutos
        const url = `http://localhost:3000/api/recetas/getPasosCount/${id}`;
        const response = await axios.get(url);

        // Vamos a intentar acceder directamente al array con un acceso explícito
        const pasos = response.data; // Asumiendo que response.data es un array

        // Verificación y acumulación de tiempos
        if (Array.isArray(pasos) && pasos.length > 0) {
          let counter = 0;

          for (let i = 0; i < pasos.length; i++) {
            const tiempoMin = pasos[i].duracionMin; // Acceso explícito a la propiedad
            console.log(`Paso ${i + 1}: ${tiempoMin} minutos`); // Depuración

            if (tiempoMin && !isNaN(tiempoMin)) {
              counter += tiempoMin * 60; // Convertir minutos a segundos y acumular
            } else {
              console.warn(`Paso ${i + 1} tiene un valor de duracionMin no válido:`, tiempoMin);
            }
          }

          console.log("Total seconds calculated:", counter); // Depuración
          setSeconds(counter); // Establecer el tiempo acumulado en segundos
        } else {
          console.error("La respuesta no es un array o está vacía:", response.data);
        }
      } catch (error) {
        console.error("Error fetching steps and times:", error);
      }
    };

    fetchTime(); // Llamada a la función dentro del useEffect
  }, [id]); // Dependencia en `id` para recargar si cambia

  useEffect(() => {
    let interval = null;

    if (isActive && seconds > 0) {
      interval = setInterval(() => {
        setSeconds((seconds) => seconds - 1);
      }, 1000);
    } else if (!isActive && seconds !== 0) {
      clearInterval(interval);
    }

    return () => clearInterval(interval);
  }, [isActive, seconds]);

  const resetTimer = () => {
    setIsActive(false);
    setSeconds(300); // Restablecer a un valor fijo, o modificar según lo necesites
  };

  const minutes = Math.floor(seconds / 60);
  const remainingSeconds = seconds % 60;

  return (
    <div className={styles.timerContainer}>
      <div className={styles.time}>
        {minutes} : {remainingSeconds < 10 ? `0${remainingSeconds}` : remainingSeconds}
      </div>
      <button
        className={styles.playButton}
        onClick={() => setIsActive(!isActive)}
      >
        {isActive ? "⏸️" : "▶️"}
      </button>
      <button className={styles.resetButton} onClick={resetTimer}>
        🔄️
      </button>
    </div>
  );
};

export default Timer;
