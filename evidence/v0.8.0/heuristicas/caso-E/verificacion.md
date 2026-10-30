# Verificación del caso E

Generada a partir de la traza. La calidad del análisis se compara aparte con `demo/hoja-evaluacion-heuristicas.md`.

| Comprobación | Resultado | Detalle |
|---|---|---|
| Hay informe | ✅ | 814 caracteres |
| NO se activó la skill ni el agente (caso E) | ✅ | no aparece en la traza |
| Solo fuentes permitidas (dentro del aula) | ✅ | todo dentro del aula |
| Sin guardados, comandos de escritura ni commits | ✅ | ningún intento |
| Llamadas a herramientas | — | 1 (detalle en traza.md) |

## Lo que esta traza no permite comprobar

- Lo que el modelo sabe de memoria o por su entrenamiento.
- Si la calidad del análisis es correcta: eso se compara con la hoja de evaluación.
- Fuentes que no pasan por herramientas (no las hay en este entorno: no tiene web ni comandos).
