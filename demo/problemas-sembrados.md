# Problemas sembrados en pantalla-firma.html

Esta es tu hoja de respuestas para comprobar a los agentes. **No se la pases a ellos**: compara su informe con esta lista. En la demo es una buena forma de mostrar que validas lo que hace la IA.

| # | Problema | Dónde | Lo debería detectar | Criterio |
| --- | --- | --- | --- | --- |
| 1 | El botón dice solo "Firmar": no se ve importe, destinatario ni concepto antes de mover dinero | Botón y pantalla | Heurísticas y accesibilidad | H1, H5 · WCAG 3.3.4 |
| 2 | El campo del código no tiene etiqueta; solo un placeholder de puntos | Campo del código | Accesibilidad | WCAG 3.3.2, 4.1.2, 1.3.1 |
| 3 | El campo no tiene `autocomplete="one-time-code"` ni `inputmode="numeric"` | Campo del código | Accesibilidad | WCAG 1.3.5 · H7 |
| 4 | Texto de ayuda #b4b4b4 sobre blanco: 2,07:1. El temporizador #999: 2,85:1 | Texto de ayuda y temporizador | Accesibilidad | WCAG 1.4.3 |
| 5 | Error genérico "Error 4012" sin causa ni solución, y no asociado al campo | Mensaje de error | Ambos | H9 · WCAG 3.3.1, 3.3.3 |
| 6 | El error se indica con color rojo y texto de 12 px #e53935 (4,23:1, no llega a 4,5:1); el borde normal del campo #e3e3e3 tiene 1,28:1; el estado de error no se anuncia | Campo y error | Accesibilidad | WCAG 1.4.1, 1.4.3, 1.4.11, 4.1.3 |
| 7 | El código caduca en 45 s sin opción de ampliar ni de reenviar visible | Temporizador | Ambos | WCAG 2.2.1 · H3 |
| 8 | El temporizador no se anuncia a lectores de pantalla | Temporizador | Accesibilidad | WCAG 4.1.3 |
| 9 | Botón de volver con solo una flecha: sin nombre accesible y de 20×20 px | Cabecera | Accesibilidad | WCAG 4.1.2, 2.5.8 |
| 10 | Tras pulsar "Firmar" solo cambia el texto a "Procesando..."; sin estado anunciado ni protección contra doble pulsación | Botón | Ambos | H1 · WCAG 4.1.3 · edge case de duplicado |
| 11 | Referencia de 19 dígitos sin agrupar, difícil de leer o dictar al soporte | Referencia | Heurísticas | Ley de Miller · H6 |
| 12 | Enlace "¿No has recibido el código?" #8aa4c0 sobre blanco: 2,58:1, a 12 px | Enlace | Accesibilidad | WCAG 1.4.3 |
| 13 | El campo tiene `outline:none`: sin foco visible | Campo del código | Accesibilidad | WCAG 2.4.7 |
| 14 | Falta `lang="es"` en el documento y el título es genérico ("Firma") | Documento | Accesibilidad | WCAG 3.1.1, 2.4.2 |
| 15 | El texto de ayuda usa asteriscos "**47" que un lector de pantalla lee de forma confusa | Texto de ayuda | Accesibilidad / contenido | H2 |

Contrastes calculados con `plugins/design-team/skills/auditing-accessibility/scripts/contraste.py`.

**Cómo puntuar:** un buen resultado detecta al menos 11 de 15, sin inventar problemas que no estén en la pantalla.
