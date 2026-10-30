# Evaluación heurística: pantalla de resultado de transferencia (Banco Lumen, ficticio)

**Entrada:** HTML (`demo/pantalla-resultado.html`). Se ven los textos, el orden, los controles y los atributos. No se ve qué hace «Volver al inicio» (no tiene `onclick` ni `href`), qué contiene el PDF ni si los datos son reales.
**Alcance:** pantalla «Transferencia realizada», estado de éxito. Queda fuera: los pasos anteriores (formulario, resumen, firma) y los estados de carga, error y operación pendiente.
**Contexto:** cliente de banca digital* · comprobar que la transferencia del alquiler se ha hecho y guardar un justificante* · leer el resultado, revisar los datos, descargar el justificante y salir · banca digital.

## 1. Líneas rojas

No hay ninguna confirmada ni ningún indicio fundado. Revisé las 14:
- **U2 (resultado incierto):** no aplica. El resultado es claro: el `h1` dice «Transferencia realizada», hay un mensaje con `role="status"` y un icono de éxito.
- **U1, U3 y U4:** no aplican. En esta pantalla no se confirma dinero, no hay acciones irreversibles y no hay error.
- **De P1 a P10:** sin señales. No hay ofertas, casillas, urgencia ni publicidad. «El dinero llegará hoy» es una afirmación cuya veracidad no se puede comprobar desde el HTML. No hay ninguna señal de que sea falsa, así que no cuenta como indicio. Va en «No cubre».

## 2. Nota de validación

- **Por qué sale esta nota:** evalué el HTML completo del estado de éxito. La pantalla dice qué pasó, a quién, cuánto, cuándo llega y con qué referencia (🟢 en H1 para el resultado y en H6). Solo hay dos hallazgos ⚪ 1 y ninguna línea roja. La nota cambiaría si «llegará hoy» no fuera cierto para algún tipo de transferencia u hora de corte (posible P10, integridad de la información), o si el botón no lleva a donde dice.
- **Autocomprobación:** pasé el bucle de validación entero. No pude comprobar el comportamiento del botón, el contenido del PDF, la veracidad del plazo de llegada ni los estados de error y de operación pendiente.

## 3. Estado de aprobación

**Apto** · 🔴 0 · 🟠 0 · 🟡 0 · ⚪ 2 · líneas rojas: 0 confirmadas · 0 indicios fundados
**Motivo:** solo hay hallazgos leves. No hay líneas rojas ni falta evidencia esencial dentro del alcance declarado.
**Válido para:** la pantalla «Transferencia realizada», estado de éxito, según su HTML.
**No cubre:**
- La veracidad de «El dinero llegará hoy» según el tipo de transferencia, la hora de corte y los festivos.
- El destino de «Volver al inicio».
- El contenido del justificante.
- Los estados de pendiente, error y rechazo.
- El resto del flujo.
- La accesibilidad.

**Recomendación:** añadir al resumen la cuenta de origen y el total cargado, y confirmar con negocio cuándo se puede afirmar «llegará hoy».
> Este estado de aprobación es una recomendación experta. La decisión final es del equipo; la priorización se cierra con el equipo técnico, que valora viabilidad y esfuerzo.

## 4. Semáforo de las 10 heurísticas

| | H1 | H2 | H3 | H4 | H5 | H6 | H7 | H8 | H9 | H10 |
|---|---|---|---|---|---|---|---|---|---|---|
| Principal | ⚪ 1 | ⚪ 1 | 🟢 0 | 🟢 0 | ⚫ | 🟢 0 | 🟢 0 | 🟢 0 | ⚫ | 🟢 0 |
| Relacionada en | #2 | — | — | — | — | #1 | — | — | — | — |

Por qué hay dos celdas sin evaluar:
- **H5:** en esta pantalla no se toma ninguna decisión. Prevenir errores, como un envío duplicado al volver atrás, depende de un comportamiento que no está en el HTML.
- **H9:** la entrada no incluye ningún estado de error.

## 5. Resumen de hallazgos

| # | Problema | Severidad | Heurística principal | Riesgo específico | Línea roja | Confianza |
|---|---|---|---|---|---|---|
| 1 | El resumen no dice desde qué cuenta salió el dinero ni el total cargado | ⚪ 1 · Leve | H1 | Económico | No aplica | Media |
| 2 | «Fecha» no aclara si es la fecha de la orden o la de llegada | ⚪ 1 · Leve | H2 | Económico | No aplica | Media |

## 6. Fichas de hallazgos

### 1. El resumen no dice desde qué cuenta salió el dinero ni el total cargado
- **Evidencia:** el `<dl>` muestra Importe, Destinatario, Cuenta de destino, Concepto, Fecha y Referencia. No hay cuenta de origen ni comisión o total cargado.
- **Tarea afectada:** comprobar que la operación quedó como se esperaba.
- **Consecuencia probable:** si la persona tiene varias cuentas o la transferencia tiene comisión, tiene que ir a movimientos para saber qué cuenta se ha cargado y por cuánto. Esto es una hipótesis: no sé si tiene varias cuentas ni si hay comisión.
- **Heurística principal:** H1 · relacionada: H6.
- **Severidad:** ⚪ 1 · Leve. La tarea se completa. No subo la severidad por datos que la entrada no aporta.
- **Riesgo específico:** Económico → no detectar que se cargó una cuenta no prevista o un coste.
- **Línea roja:** no aplica. Es la pantalla posterior a la operación. Si el coste se mostró antes de firmar no se puede evaluar aquí.
- **Confianza:** Media · la ausencia se ve, pero el impacto depende de supuestos.
- **Corrección:** añadir «Cuenta de origen: terminada en XXXX» y «Comisión: 0,00 €» (o su importe) con «Total cargado».
- **Cómo verificarla:** revisar el HTML y probar con una cuenta sintética con comisión y otra sin comisión.
- **Esfuerzo:** a estimar con el equipo técnico.

### 2. «Fecha» no aclara si es la fecha de la orden o la de llegada
- **Evidencia:** `<dt>Fecha</dt><dd>16 de octubre de 2026</dd>` junto a «El dinero llegará hoy».
- **Tarea afectada:** acreditar ante quien recibe el pago (por ejemplo, el arrendador*) cuándo se pagó.
- **Consecuencia probable:** si las fechas de orden y de llegada no coinciden, la persona puede dar la fecha equivocada como prueba de pago. Es una hipótesis.
- **Heurística principal:** H2.
- **Severidad:** ⚪ 1 · Leve.
- **Riesgo específico:** Económico → posible discrepancia en un pago con fecha límite.
- **Línea roja:** no aplica.
- **Confianza:** Media · la etiqueta es ambigua, pero no sé si las dos fechas pueden ser distintas.
- **Corrección:** «Fecha de la orden» y, si difiere, «Fecha de llegada prevista».
- **Cómo verificarla:** hacer un test rápido con 5 personas y preguntar «¿Qué día recibe Laura el dinero?».
- **Esfuerzo:** a estimar con el equipo técnico.

## 7. Evidencia necesaria

No hay indicios fundados ni falta evidencia esencial para el alcance. Estas comprobaciones amplían el alcance:

| Qué falta | Cómo obtenerlo | Qué resolvería |
|---|---|---|
| Regla de negocio de «El dinero llegará hoy» (tipo de transferencia, hora de corte, festivos) | Pregunta abierta a negocio o a producto | Si el plazo es veraz o necesita condiciones (posible P10) |
| Destino de «Volver al inicio» y estados de pendiente o error | Prototipo o código de la navegación y de los demás estados | H5, H9 y U2 en otros resultados |

## 8. Lo que funciona bien

- El resultado se entiende a la primera: «Hemos enviado 250,00 € a Laura Martín. El dinero llegará hoy.», con `role="status"` y el icono con `aria-hidden`.
- La referencia va agrupada en bloques (`2026 1016 8374 9201`) y la cuenta de destino aparece enmascarada («Terminada en 4821»).
- El enlace del justificante dice el formato y el tamaño: «Descargar justificante (PDF, 40 KB)».

## 9. Hipótesis para validar con personas usuarias

- Si quien paga el alquiler busca el justificante antes de salir, o si «Volver al inicio» como acción principal hace que lo pierda.
- Si alguien que copia la referencia espera que se pegue con espacios o sin ellos.

## 10. Para accesibilidad

Estas comprobaciones son para `auditing-accessibility` y no cambian este estado de aprobación:
- Si `role="status"` en un contenido que ya existe al cargar la página se anuncia con VoiceOver y TalkBack. Si no se anuncia, conviene llevar el foco al `h1`.
- Si el contorno de foco del botón (`#0b3d6e` sobre un botón `#0b3d6e`, con desplazamiento de 3 px) se distingue bien.
- Si la cuadrícula `dl` se lee y se amplía bien al 200 % y a 320 px.

No he guardado esta evaluación en ningún archivo.
