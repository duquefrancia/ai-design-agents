# Verificación del caso D1

Generada a partir de la traza. La calidad del análisis se compara aparte con `demo/hoja-evaluacion-heuristicas.md`.

| Comprobación | Resultado | Detalle |
|---|---|---|
| Hay informe | ✅ | 9050 caracteres |
| Se activó la skill o el agente | ✅ | Skill evaluating-heuristics |
| Solo fuentes permitidas (dentro del aula) | ✅ | todo dentro del aula |
| Sin guardados, comandos de escritura ni commits | ✅ | ningún intento |
| Llamadas a herramientas | — | 3 (detalle en traza.md) |

## Lo que esta traza no permite comprobar

- Lo que el modelo sabe de memoria o por su entrenamiento.
- Si la calidad del análisis es correcta: eso se compara con la hoja de evaluación.
- Fuentes que no pasan por herramientas (no las hay en este entorno: no tiene web ni comandos).
