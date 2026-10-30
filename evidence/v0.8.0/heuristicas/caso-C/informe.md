# Evaluación heurística: oferta de préstamo personal de 6.000 € (Banco Lumen)

**Entrada:** descripción verbal del prototipo. Permite ver tres elementos citados de forma literal. No permite ver el resto de textos, el estado de la casilla ni qué pasa al pulsar.
**Alcance:** pantalla de oferta, estado inicial. Elementos: titular «Solo 89 €/mes», casilla del seguro y botón «Contratar». Fuera de alcance: pantallas siguientes (resumen, firma, resultado), errores y accesibilidad.
**Contexto:** cliente particular de banca* · decidir si contrata un préstamo de 6.000 € y si añade un seguro · entender el coste, elegir el seguro y contratar · banca digital.

## 1. Líneas rojas

| # | Línea roja | Estado | Evidencia observada | Decisión afectada | Perjuicio posible | Alternativa transparente |
|---|---|---|---|---|---|---|
| P2 | Extras y decisiones no autorizados | Indicio fundado | Casilla «Añadir seguro de protección de pagos (12 €/mes)». En el prototipo no se ve si viene marcada | Contratar o no un seguro de pago recurrente | Cargo de 12 €/mes no elegido de forma activa | Casilla desmarcada por defecto. Estado marcado o desmarcado visible y anunciado |
| P1 | Costes y compromisos ocultos | Indicio fundado | El dato destacado es la cuota, con el adverbio «Solo». El coste del crédito no aparece en los elementos descritos | Contratar un préstamo | Decidir solo por la cuota, sin conocer el coste total ni el plazo | TAE, TIN, plazo, número de cuotas e importe total adeudado junto a la cuota y con un peso visual comparable |

## 2. Nota de validación

- **Por qué sale esta nota:** se ha evaluado a partir de una descripción, sin observar la pantalla. Hay dos señales observables (la casilla con estado desconocido y la cuota destacada con «Solo») y una comprobación concreta pendiente para cada una. No hay ningún motivo de rechazo demostrado. Con una descripción falta evidencia esencial, así que no cabe Apto. Cambiaría a No apto si la casilla viene marcada o si el coste total y la TAE no se muestran antes de «Contratar».
- **Autocomprobación:** he pasado el bucle de validación entero. No pude comprobar el estado de la casilla, el resto de textos de la pantalla, el comportamiento de la cuota al marcar el seguro ni la pantalla posterior a «Contratar».

## 3. Estado de aprobación

**Pendiente de verificación** · 🔴 0 · 🟠 0 · 🟡 2 · ⚪ 0 · líneas rojas: 0 confirmadas · 2 indicios fundados
**Motivo:** quedan sin resolver dos indicios fundados (P2 y P1) y la entrada es una descripción. La aprobación queda retenida hasta resolver la Evidencia necesaria.
**Válido para:** pantalla de oferta, estado inicial, con los elementos descritos · **No cubre:** resumen previo, firma, resultado, errores, el resto del flujo ni la accesibilidad.
**Recomendación:** lo primero es comprobar en el prototipo o el HTML el estado por defecto de la casilla del seguro.
> Este estado de aprobación es una recomendación experta. La decisión final es del equipo; la priorización se cierra con el equipo técnico, que valora viabilidad y esfuerzo.

## 4. Semáforo de las 10 heurísticas

| | H1 | H2 | H3 | H4 | H5 | H6 | H7 | H8 | H9 | H10 |
|---|---|---|---|---|---|---|---|---|---|---|
| Principal | ⚫ | ⚫ | ⚫ | ⚫ | 🟡 2 | ⚫ | ⚫ | 🟡 2 | ⚫ | ⚫ |
| Relacionada en | #2 | #1 | — | — | #1 | #2 | — | — | — | — |

Con una descripción no hay evidencia suficiente para dar 🟢 a ninguna heurística. Los indicios P1 y P2 no colorean el semáforo.

## 5. Resumen de hallazgos

| # | Problema | Severidad | Heurística principal | Riesgo específico | Línea roja | Confianza |
|---|---|---|---|---|---|---|
| 1 | La cuota con «Solo» es el dato que domina la oferta de crédito | 🟡 2 · Moderado | H8 | Económico | Indicio fundado P1 | Media |
| 2 | No se dice si los 89 €/mes incluyen el seguro de 12 €/mes | 🟡 2 · Moderado | H5 | Económico | No aplica (relacionado con el indicio P2) | Media |

## 6. Fichas de hallazgos

### 1. La cuota con «Solo» es el dato que domina la oferta de crédito
- **Evidencia:** arriba y en grande aparece «Solo 89 €/mes». Es el único dato económico destacado de la descripción.
- **Tarea afectada:** valorar si el préstamo le conviene antes de contratar.
- **Consecuencia probable:** la persona juzga el préstamo por la cuota, que es el dato más bajo. «Solo» minimiza el coste. No se sabe si la TAE y el coste total están en la pantalla. Eso queda en Evidencia necesaria y no sube la severidad.
- **Heurística principal:** H8 · relacionadas: H2 («Solo» es un adverbio valorativo, no información) y H5.
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:** Económico → la persona contrata sin comparar el coste total del crédito.
- **Línea roja:** indicio fundado P1.
- **Confianza:** Media · el titular está citado de forma literal, pero la conclusión depende de cómo se presenten el coste total y la TAE, que no constan.
- **Corrección:** quitar «Solo». Mostrar «89 €/mes durante [n] meses» junto a la TAE, el TIN y el importe total adeudado, con un tamaño comparable al de la cuota.
- **Cómo verificarla:** revisar el prototipo y comprobar que la TAE y el total adeudado se ven sin desplazar la pantalla y antes de «Contratar». Hacer un test de 5 segundos con la pregunta «¿Cuánto pagarás en total?».
- **Ley de UX:** Von Restorff (explica por qué el elemento aislado y grande acapara la atención; no prueba el efecto).
- **Esfuerzo:** a estimar con el equipo técnico.

### 2. No se dice si los 89 €/mes incluyen el seguro de 12 €/mes
- **Evidencia:** hay dos importes mensuales, «89 €/mes» en el titular y «12 €/mes» en la casilla. No se indica la relación entre ellos ni una cuota total con el seguro.
- **Tarea afectada:** saber cuánto pagará cada mes antes de pulsar «Contratar».
- **Consecuencia probable:** la persona cree que pagará 89 €/mes y paga 101 €/mes, o al revés. No se sabe si el titular se actualiza al marcar la casilla.
- **Heurística principal:** H5 · relacionadas: H1 (la cuota debe reflejar la elección) y H6.
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:** Económico → cuota real distinta de la que la persona cree contratar.
- **Línea roja:** no aplica por sí solo. Agrava el indicio P2 si la casilla viene marcada.
- **Confianza:** Media · los dos importes están en la descripción. Que la cuota no se actualice es una hipótesis.
- **Corrección:** mostrar la cuota resultante junto al botón. Por ejemplo: «Cuota: 89 €/mes sin seguro» y, al marcar, «101 €/mes (89 € préstamo + 12 € seguro)». Que el botón incluya la cifra, por ejemplo «Contratar préstamo de 6.000 €».
- **Cómo verificarla:** en el prototipo, marcar y desmarcar la casilla y comprobar que la cuota visible cambia y coincide con la del resumen previo a la firma.
- **Esfuerzo:** a estimar con el equipo técnico.

## 7. Evidencia necesaria

| Qué falta | Cómo obtenerlo | Qué resolvería |
|---|---|---|
| Estado por defecto de la casilla del seguro | Prototipo con los estados dibujados o el HTML (atributo `checked`) | Indicio P2: si viene marcada, se confirma (No apto); si viene desmarcada, se descarta |
| TAE, TIN, plazo, número de cuotas e importe total adeudado: si aparecen, dónde y con qué peso | Captura completa de la pantalla, incluida la parte bajo el pliegue | Indicio P1 y la severidad del hallazgo 1 |
| Si el seguro es opcional o condiciona la concesión o el tipo de interés | Regla de negocio del producto (pregunta abierta al equipo) | Si la casilla describe bien la elección |
| Qué pasa al pulsar «Contratar»: resumen previo, firma, posibilidad de cancelar y resultado | Prototipo de las pantallas siguientes | H1, H3 y H9, y las líneas rojas U1, U2 y U3 |
| Si la cuota del titular se actualiza al marcar el seguro | Prototipo interactivo | Hallazgo 2 |

## 8. Lo que funciona bien

- La casilla da el precio del seguro en su propia etiqueta («12 €/mes»), en lugar de esconderlo en otra pantalla.
- El seguro se presenta como una casilla separada del préstamo, no integrado en la cuota, lo que permite una elección independiente si viene desmarcada.

## 9. Hipótesis para validar con personas usuarias

- Las personas toman «Solo 89 €/mes» como el coste del préstamo y no buscan la TAE ni el total.
- Las personas no distinguen si la cuota incluye el seguro.

## 10. Para accesibilidad

- «No se ve si viene marcada»: si en el diseño final los estados marcado y desmarcado no se distinguen bien, puede incumplir el contraste de componentes no textuales (WCAG 1.4.11). Comprobarlo con auditing-accessibility, junto con el nombre y el estado accesibles de la casilla (4.1.2).
- Comprobar que un lector de pantalla lee la TAE y el total adeudado, no solo la cuota destacada.
