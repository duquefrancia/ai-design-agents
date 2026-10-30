# Método: el criterio que llevan dentro los agentes

Las reglas en detalle que hay detrás del [README](../README.es.md). Las skills están escritas en español. · [English version](METHOD.md)

## 1. Una escala de severidad común

Cada nivel significa lo mismo en todas las disciplinas.

| Nivel | Significado |
|---|---|
| 🔴 4 · Crítico | Impide una tarea esencial o puede causar una consecuencia grave o difícil de revertir |
| 🟠 3 · Mayor | La tarea se completa con mucha dificultad o con un riesgo relevante de error |
| 🟡 2 · Moderado | Fricción notable: la tarea se completa con esfuerzo extra o por una alternativa |
| ⚪ 1 · Leve | Impacto bajo en la tarea (no significa «estético» ni «conforme») |
| 🟢 0 · Sin problemas detectados | Evaluado con la evidencia disponible, sin problemas dentro del alcance. No es una certificación |
| ⚫ Sin evaluar | No hay evidencia suficiente para valorarlo |

## 2. Cuatro estados de aprobación comunes y reglas de aprobación separadas

**Apto · Apto con observaciones · Pendiente de verificación · No apto.**

La severidad y el estado de aprobación son dimensiones distintas:

- **Heurísticas:** un 🟡 2 aislado da *Apto con observaciones*. Una línea roja confirmada da *No apto*.
- **Accesibilidad:** cualquier incumplimiento WCAG 2.2 A/AA confirmado da *No apto*, aunque sea ⚪ 1. La conformidad no se gradúa; la severidad solo ordena la prioridad de la remediación.

## 3. Cobertura

Cada evaluación declara qué cubrió de verdad: **Evaluado · Parcialmente evaluado · Sin evaluar · No aplica**. «No aplica» nunca se supone: lo confirma una persona en la firma del alcance. Hasta entonces queda *Sin evaluar*.

## 4. Reglas de evidencia

- **Lo que falta no es sospechoso.** Lo que el enunciado no aporta va a *Evidencia necesaria*, nunca a un hallazgo.
- **Un supuesto nunca confirma un hallazgo.** Sin evidencia observada, una línea roja llega como mucho a *indicio fundado*.
- **Calculado, no estimado.** Los contrastes salen de un script sobre los colores declarados.
- **Trazabilidad.** Cada informe indica fecha, versión de la skill, objeto evaluado y responsable.
- **Independencia.** Cada auditoría empieza de cero; nunca se leen informes anteriores.

## 5. Líneas rojas

Problemas que bloquean la aprobación por sí solos, aunque el resto de la pantalla esté bien. Heurísticas tiene 14 (usabilidad crítica y patrones engañosos: mover dinero sin resumen, error sin salida, resultado incierto, costes ocultos, consentimiento forzado…). Accesibilidad trata como líneas rojas los fallos que bloquean un paso esencial, como el foco invisible en el único campo de un paso de firma.

## 6. El riesgo de producto no es WCAG

Los riesgos de banca que no son criterios WCAG (exposición al fraude, estados inciertos, consentimientos premarcados…) se registran aparte, con severidad y categoría de riesgo (económico, legal u operativo). Nunca aparecen como incumplimientos WCAG ni cambian el estado de aprobación de accesibilidad.

## 7. Cómo agrega el orquestador

- **Gana el más restrictivo:** No apto > Pendiente de verificación > Apto con observaciones > Apto.
- **Sin medias ni compensaciones** entre disciplinas.
- Dice **qué evaluación determina** el resultado global y conserva los pendientes y las observaciones de las demás.
- **Un mismo problema visto desde varios marcos se cuenta una vez**, conservando el gate más estricto.

## 8. Aceptación de riesgos

- Un riesgo de producto 🟠 3 bloquea por defecto. Solo se acepta con responsable, justificación, alcance y condiciones.
- Un 🔴 4 no se libera con una firma ordinaria de Producto.
- **Aceptar un riesgo no es resolverlo**, y nunca desbloquea una línea roja de heurísticas ni de accesibilidad.
- El orquestador **nunca firma en nombre de una persona**.

## 9. Permisos

*Evaluar, guardar y hacer commit son tres permisos distintos.* Un agente al que se le pide evaluar no escribe archivos ni toca git si no se le pide.

## 10. Cómo diseñé las pruebas

- **Hojas de respuestas escritas antes de probar:** una pantalla con 15 problemas sembrados ([`demo/problemas-sembrados.md`](../demo/problemas-sembrados.md)), una pantalla correcta, casos límite y un caso en el que el agente **no** debe activarse.
- **Una sesión nueva por caso.**
- **Un aula aislada** para heurísticas ([`evals/`](../evals)): sin informes previos, sin hojas de respuestas, sin git y con traza de cada archivo leído y cada acción intentada.
- **Los tests de una skill declaran la disciplina**; los enunciados neutros se reservan para probar el routing.
- **Cuando una prueba falla, reviso primero el examen.** Dos exámenes eran ambiguos (caso D de accesibilidad y caso A de heurísticas); se corrigieron y se repitieron en lugar de forzar la skill para que pasara.
- **Prueba punta a punta** del orquestador con 10 criterios de aceptación definidos de antemano. Aceptada con una incidencia contenida (ver el README).
