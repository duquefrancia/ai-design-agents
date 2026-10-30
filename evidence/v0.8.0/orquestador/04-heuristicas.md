# Evaluación heurística: pantalla de firma de transferencia (Banco Lumen, ficticio)

> Informe completo de `design-team:ux-heuristics-expert`, guardado tal cual por la Head of Design. Evaluación independiente: el agente solo leyó la pantalla y el reto.

**Entrada:** HTML estático (`demo/pantalla-firma.html`) y contexto del reto (`demo/caso-firma-operacion.md`). Se ven contenido, textos, orden, estilos y atributos. No se ve comportamiento real: temporizador, SMS, validación, respuesta del sistema ni red.
**Alcance:** pantalla "Firma de operación" en su único estado declarado (campo vacío, error "Error 4012" visible, "El código caduca en 0:45", botón "Firmar"). También el estado post-pulsación declarado en el `onclick` ("Procesando..."). Fuera de alcance: rellenar la transferencia, pantalla de resultado ("Operación realizada" o error), estados de código caducado o incorrecto, SMS y accesibilidad (se deriva).
**Contexto:** persona cliente de banca en web móvil* · quiere autorizar una transferencia con el código de un solo uso recibido por SMS · tareas: comprobar lo que firma, introducir el código, firmar, saber si se hizo, recuperarse de un fallo o de una caducidad · banca digital. (* supuesto)

## 1. Líneas rojas

| # | Línea roja | Estado | Evidencia observada | Decisión afectada | Perjuicio posible | Alternativa transparente |
|---|---|---|---|---|---|---|
| U1 | Mover dinero sin resumen | **Confirmada** | La pantalla solo tiene título, texto del móvil, referencia, campo, temporizador, error y botón "Firmar". No muestra importe, destinatario, cuenta, concepto ni comisiones. Ni siquiera dice "transferencia" (solo "operación"). | Firmar o no la transferencia | Transferencia con importe o destinatario no deseado, descubierta después de moverse el dinero | Resumen de importe, destinatario y comisiones (si las hay) sobre el campo, y botón que nombre la acción |
| U4 | Error sin salida | **Confirmada** | `<div class="error">Error 4012</div>`: código técnico, sin causa, sin siguiente paso y sin decir qué ha pasado con el dinero | Reintentar, pedir otro código, repetir la transferencia o abandonar | Repetir una transferencia ya hecha, o dar por hecha una que no lo está | Mensaje claro junto al campo con causa, acción y estado del dinero |
| U2 | Resultado incierto | **Indicio fundado** | Señal: el único estado posterior a pulsar que declara el HTML es `this.textContent='Procesando...'`, sin resultado, límite de tiempo ni protección contra doble pulsación | Esperar, repetir o salir tras firmar | No saber si la transferencia se hizo | Tres estados finales explícitos (hecha / pendiente / fallida) con la referencia |

Revisadas las otras 11 (U3, P1–P10): sin señal observable en esta pantalla. No se reportan.
- **Comisiones (P1).** Que la pantalla no las muestre es información no aportada, no un indicio de P1. Se trata dentro de U1.
- **Temporizador (P7).** No se abre indicio de urgencia falsa. Una caducidad de código es una medida de seguridad plausible y proporcionada. Solo habría que comprobar que el tiempo sea real (ver sección 7).

## 2. Nota de validación

- **Por qué sale esta nota:** se inspeccionó el HTML completo y el contexto del reto. U1 y U4 están sustentadas por el contenido literal de la pantalla, y cada una tiene además un hallazgo 🔴 4. Cambiaría si se demostrara que existe un resumen en esta misma pantalla, en un estado no entregado. Que lo haya en otra pantalla o en el SMS no lo cambiaría: U1 exige verlo justo antes de firmar. U2 solo pasaría a confirmada o descartada con la pantalla de resultado y pruebas de red.
- **Autocomprobación:** bucle de validación pasado entero. Cada ficha apunta a un elemento que existe en el HTML. No se ha convertido ninguna omisión en indicio. No pudo comprobarse nada que dependa de comportamiento real. Los ratios de contraste son estimaciones a partir de los hex del CSS y se miden en `auditing-accessibility`. H4 queda ⚫ porque no se dispone del design system.

## 3. Estado de aprobación

**No apto** · 🔴 2 · 🟠 0 · 🟡 6 · ⚪ 1 · líneas rojas: 2 confirmadas · 1 indicio fundado
**Motivo:** lo determinan dos líneas rojas confirmadas (U1 y U4) y dos hallazgos 🔴 4 sustentados (#1 y #2). La pantalla pide firmar sin mostrar qué se firma, y el error no dice qué ha pasado ni qué hacer. Esto no se compensa con nada del resto de la pantalla. El indicio U2 y las comprobaciones pendientes se listan en la sección 7, pero no cambian el estado.
**Válido para:** `pantalla-firma.html`, estado único declarado y el estado "Procesando..." del `onclick` · **No cubre:** pantallas de relleno y de resultado, estados de código caducado o incorrecto, comportamiento real del temporizador y del reenvío, contenido del SMS, uso del design system y accesibilidad.
**Recomendación:** añadir primero el resumen de la transferencia (importe, destinatario, comisiones) a esta pantalla y sustituir "Error 4012" por un mensaje con causa, acción y estado del dinero.
> Este estado de aprobación es una recomendación experta. La decisión final es del equipo; la priorización se cierra con el equipo técnico, que valora viabilidad y esfuerzo.

## 4. Semáforo de las 10 heurísticas

Color = mayor severidad de los hallazgos que tienen esa heurística como principal. Las líneas rojas van en la sección 1 y no colorean.

| | H1 | H2 | H3 | H4 | H5 | H6 | H7 | H8 | H9 | H10 |
|---|---|---|---|---|---|---|---|---|---|---|
| Principal | 🟡 2 · Moderado | 🟢 0 | 🟡 2 · Moderado | ⚫ Sin evaluar | 🔴 4 · Crítico | ⚪ 1 · Leve | 🟡 2 · Moderado | 🟡 2 · Moderado | 🔴 4 · Crítico | 🟢 0 |
| Relacionada en | #2, #5, #7 | #2, #6, #7 | #4 | — | #3 | #1, #5 | — | — | #3, #4, #6 | #2, #6 |

- **H2 🟢 0:** los textos de la pantalla ("Introduce el código…", "Firmar") se entienden. La jerga del "Error 4012" está en #2, con H9 como principal.
- **H10 🟢 0:** hay ayuda mínima sobre dónde llegó el código. No es principal de ningún hallazgo. No se ha evaluado si debería haber un aviso antifraude, porque la entrada no lo muestra ni lo excluye.
- **H4 ⚫:** no se dispone del design system (botón primario, campo, mensaje de alerta) para comparar. El HTML usa colores hexadecimales directos, no tokens.

## 5. Resumen de hallazgos (de mayor a menor severidad)

| # | Problema | Severidad | Heurística principal | Riesgo específico | Línea roja | Confianza |
|---|---|---|---|---|---|---|
| 1 | Se pide firmar sin resumen de la transferencia | 🔴 4 · Crítico | H5 | Económico · Legal o normativo | U1 confirmada | Alta |
| 2 | "Error 4012" sin causa, acción ni estado del dinero | 🔴 4 · Crítico | H9 | Económico · Operativo · Accesibilidad o inclusión | U4 confirmada | Alta |
| 3 | Tras pulsar "Firmar" solo cambia el texto a "Procesando..." | 🟡 2 · Moderado | H1 | Económico · Operativo | U2 indicio fundado | Media |
| 4 | Tiempo de caducidad poco visible y sin estado de caducado | 🟡 2 · Moderado | H1 | Operativo · Accesibilidad o inclusión | No aplica | Media |
| 5 | El campo no ayuda a introducir el código con rapidez | 🟡 2 · Moderado | H7 | Operativo · Accesibilidad o inclusión | No aplica | Media |
| 6 | "¿No has recibido el código?" no es una acción clara de reenvío | 🟡 2 · Moderado | H3 | Operativo · Accesibilidad o inclusión | No aplica | Media |
| 7 | Única salida: flecha sin texto, y no se dice qué pasa con la operación | 🟡 2 · Moderado | H3 | Económico · Accesibilidad o inclusión | No aplica | Media |
| 8 | La instrucción principal está en gris muy claro | 🟡 2 · Moderado | H8 | Accesibilidad o inclusión | No aplica | Media |
| 9 | Referencia de 19 dígitos sin agrupar | ⚪ 1 · Leve | H6 | Operativo | No aplica | Media |

**Efecto combinado (#1 + #2 + #3).** En la misma tarea, la persona no sabe qué firma, recibe un error que no explica y, si pulsa, no ve un resultado. Eso reproduce el problema que el caso describe: clientes que no saben si la transferencia se ha hecho. Los dos 🔴 4 ya bloquean el estado de aprobación, así que no se reajusta ninguna severidad.

## 6. Fichas de hallazgos

### 1. Se pide firmar sin resumen de la transferencia
- **Evidencia:** la pantalla contiene `<h2>Firma de operación</h2>`, el texto "…móvil terminado en **47", "Referencia de la operación: 2026101583749201746", el campo, el temporizador, el error y `<button class="btn">Firmar</button>`. No hay importe, destinatario, cuenta de destino, concepto ni comisiones. La palabra "transferencia" no aparece.
- **Tarea afectada:** autorizar la transferencia introduciendo el código.
- **Consecuencia probable:** la persona firma sin poder contrastar justo antes lo que ha rellenado. Un importe o destinatario equivocado se descubre después de mover el dinero.
- **Heurística principal:** H5 · relacionadas: H6, H1.
- **Severidad:** 🔴 4 · Crítico. Cumple el criterio "puede provocar una consecuencia grave o difícilmente reversible": una transferencia confirmada con importe o destinatario no deseados.
- **Riesgo específico:**
  - Económico → dinero enviado a un destinatario o por un importe no deseado.
  - Legal o normativo → posible implicación sobre la confirmación explícita antes de mover dinero (WCAG 3.3.4, restricción del caso). Cumplimiento debería verificar además si el código ha de vincularse al importe y al beneficiario. Es una implicación a verificar, no una conclusión jurídica.
- **Línea roja:** U1 confirmada.
- **Confianza:** Alta · el HTML completo de la pantalla no contiene ese contenido. Queda sin ver si el SMS incluye importe y destinatario; en cualquier caso no sustituye al resumen en pantalla.
- **Corrección:**
  - Bloque de resumen encima del campo con importe, destinatario (nombre e IBAN agrupado), concepto, cuenta de origen y comisiones. Si no hay comisiones, decirlo solo si es cierto.
  - Botón con la acción concreta: "Firmar transferencia de [importe]".
  - Mantener el código y la referencia como elementos secundarios. No quitar la autenticación.
- **Cómo verificarla:** en el prototipo, a 360×640 px sin desplazar, importe y destinatario se ven antes del campo. En un test con datos sintéticos, la persona dice a quién y cuánto va a pagar antes de pulsar. Con lector de pantalla, el resumen se lee antes del campo.
- **Ley de UX:** Tesler (explica): el sistema ya tiene esos datos y no debería dejar que la persona los recuerde del paso anterior.
- **Esfuerzo:** a estimar con el equipo técnico.

### 2. "Error 4012" sin causa, acción ni estado del dinero
- **Evidencia:** `<div class="error">Error 4012</div>` en 12 px y `#e53935`, bajo el temporizador. El campo tiene la clase `err` (borde rojo) y está vacío. El texto no dice qué ha fallado, qué hacer ni si se ha movido dinero. El caso indica que los clientes llaman al soporte porque no saben si la transferencia se hizo tras un error.
- **Tarea afectada:** recuperarse de un fallo de firma y decidir el siguiente paso.
- **Consecuencia probable:** la persona no sabe si reintentar, pedir otro código, repetir la transferencia o abandonar. Puede duplicar una operación ya hecha o dar por no hecha una que sí lo está (hipótesis; depende del estado real del backend).
- **Heurística principal:** H9 · relacionadas: H1, H2, H5, H10.
- **Severidad:** 🔴 4 · Crítico. Cumple el criterio "impide completar una tarea esencial" (no hay salida desde el error) y "puede causar una consecuencia grave o difícil de revertir" (operación duplicada).
- **Riesgo específico:**
  - Económico → repetir o abandonar sin saber el estado del dinero (hipótesis).
  - Operativo → llamadas al soporte, que el caso documenta como problema.
  - Accesibilidad o inclusión → el error se señala solo con color rojo y borde, en 12 px, sin vínculo evidente con el campo.
- **Línea roja:** U4 confirmada.
- **Confianza:** Alta · el texto literal carece de causa y acción. Qué ocurre con el dinero depende del sistema y no es evaluable aquí.
- **Corrección:**
  - Mensaje en lenguaje claro junto al campo con tres cosas: qué ha pasado, qué puede hacer la persona y qué ha pasado con el dinero. Esto último solo si es cierto, p. ej. "No se ha realizado ningún cargo".
  - Las causas reales (código incorrecto, caducado, intentos agotados) las define negocio; son preguntas abiertas del caso.
  - Dejar el código técnico como referencia secundaria para soporte.
- **Cómo verificarla:** para cada error posible, el mensaje responde "¿qué ha pasado?", "¿qué hago?" y "¿se ha movido mi dinero?". En un test con datos sintéticos, la persona contesta las tres sin ayuda.
- **Ley de UX:** no se aplica.
- **Esfuerzo:** a estimar con el equipo técnico.

### 3. Tras pulsar "Firmar" solo cambia el texto a "Procesando..."
- **Evidencia:** `onclick="this.textContent='Procesando...'"`. El botón no se deshabilita, no hay indicador ni región `aria-live`, no hay opción de cancelar ni resultado en la pantalla.
- **Tarea afectada:** enviar la firma y saber cómo ha terminado.
- **Consecuencia probable:** la persona no distingue "en curso" de "colgado" y puede pulsar otra vez o salir. Que eso duplique algo depende de si el sistema lo protege (hipótesis).
- **Heurística principal:** H1 · relacionadas: H5, H9.
- **Severidad:** 🟡 2 · Moderado. Se mide solo por lo observado: un estado transitorio sin garantías. Si el indicio U2 se confirma, se reevalúa.
- **Riesgo específico:**
  - Económico → posible doble envío si no hay protección (a comprobar).
  - Operativo → llamadas al soporte por resultado incierto.
- **Línea roja:** U2 indicio fundado. Señal: el único estado posterior a pulsar es "Procesando..." sin resultado. Comprobación: pantalla de resultado y prueba con la conexión cortada justo tras firmar (pregunta abierta del caso).
- **Confianza:** Media · el estado declarado se ve, pero es un marcador del prototipo y no se observa el comportamiento real.
- **Corrección:**
  - Botón deshabilitado y `aria-busy` mientras procesa.
  - Texto como "Estamos procesando tu transferencia. No repitas la operación".
  - Estado final siempre explícito (hecha / pendiente / fallida) con la referencia.
  - Qué mostrar si se corta la conexión lo define negocio.
- **Cómo verificarla:** en el entorno de pruebas, con red lenta o cortada y datos sintéticos, dos pulsaciones crean una sola operación y siempre se llega a un estado final legible.
- **Ley de UX:** Doherty (orienta): esperas sin feedback.
- **Esfuerzo:** a estimar con el equipo técnico.

### 4. Tiempo de caducidad poco visible y sin estado de caducado
- **Evidencia:** `<div class="timer">El código caduca en 0:45</div>` con `font-size:12px; color:#999` (≈2,8:1 sobre blanco, estimado). Es texto estático (sin script) y sin `aria-live`. No hay estado "caducado".
- **Tarea afectada:** teclear el código antes de que caduque.
- **Consecuencia probable:** la persona no percibe el tiempo que le queda, o llega a 0:00 sin saber qué hacer. El caso recoge que algunos clientes dicen que el código caduca antes de poder escribirlo; no hay cifras.
- **Heurística principal:** H1 · relacionadas: H3, H9.
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:**
  - Operativo → códigos caducados, reintentos y llamadas al soporte.
  - Accesibilidad o inclusión → límite de tiempo sin aviso ni ampliación (WCAG 2.2.1, a derivar).
- **Línea roja:** no aplica.
- **Confianza:** Media · estilo y texto se ven, pero la duración total y el comportamiento real no.
- **Corrección:**
  - Tiempo con mayor tamaño y contraste.
  - Aviso accesible en umbrales, no cada segundo.
  - Estado "El código ha caducado" con acción visible de pedir otro.
  - La duración la fija seguridad y negocio (pregunta abierta). No se propone acortar ni alargar sin datos.
- **Cómo verificarla:** en un prototipo con contador real, a 0:00 aparece el estado y se puede pedir un código nuevo sin perder la transferencia. Con lector de pantalla se anuncia el aviso.
- **Ley de UX:** no se aplica.
- **Esfuerzo:** a estimar con el equipo técnico.

### 5. El campo no ayuda a introducir el código con rapidez
- **Evidencia:** `<input class="code" type="text" maxlength="6" placeholder="······">`. No tiene `inputmode`, `autocomplete="one-time-code"` ni etiqueta asociada. El placeholder de puntos no indica "6 dígitos", y `outline:none` quita el foco nativo.
- **Tarea afectada:** teclear o pegar el código del SMS mientras corre el tiempo.
- **Consecuencia probable:** se abre el teclado alfabético y no se ofrece el código recibido por SMS, así que se tarda más con el contador en marcha (hipótesis ligada al problema reportado). `maxlength` corta en silencio lo que se pegue de más.
- **Heurística principal:** H7 · relacionadas: H6, H1.
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:**
  - Operativo → códigos caducados y reintentos.
  - Accesibilidad o inclusión → entrada más costosa y sin etiqueta (a derivar).
- **Línea roja:** no aplica.
- **Confianza:** Media · los atributos se ven, pero el efecto depende de dispositivo y navegador.
- **Corrección:**
  - `inputmode="numeric"` y `autocomplete="one-time-code"`.
  - Etiqueta visible "Código de 6 dígitos".
  - Mantener la posibilidad de pegar.
- **Cómo verificarla:** en iOS Safari y Android Chrome (entorno de pruebas), se abre teclado numérico y se ofrece el código del SMS sobre el teclado.
- **Ley de UX:** Jakob (orienta): las apps de banca suelen autocompletar el código.
- **Esfuerzo:** a estimar con el equipo técnico.

### 6. "¿No has recibido el código?" no es una acción clara de reenvío
- **Evidencia:** `<a class="link" href="#">¿No has recibido el código?</a>` en 12 px, `#8aa4c0` (≈2,6:1, estimado), sin relleno vertical (objetivo táctil de unos 14 px de alto) y con destino `#`.
- **Tarea afectada:** conseguir otro código si no llega o ha caducado.
- **Consecuencia probable:** el texto es una pregunta, no una acción. No dice qué pasará (reenviar, abrir ayuda, invalidar el código anterior) y no cubre el caso "caducado". Es difícil de pulsar con precisión.
- **Heurística principal:** H3 · relacionadas: H10, H2, H9.
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:**
  - Operativo → la persona no puede recuperarse sin llamar al soporte.
  - Accesibilidad o inclusión → objetivo táctil pequeño y bajo contraste (a derivar).
- **Línea roja:** no aplica.
- **Confianza:** Media · la etiqueta y el estilo se ven, pero qué hace realmente el enlace no.
- **Corrección:**
  - Acción explícita "Enviar un código nuevo", junto al temporizador, con objetivo de al menos 44 px de alto.
  - Confirmación tras pulsar: "Código enviado al móvil terminado en 47".
  - Si el código anterior deja de valer, decirlo solo si es la regla.
  - Las reglas de reenvío son una pregunta abierta del caso.
- **Cómo verificarla:** medir el objetivo táctil. Tras pulsar aparece la confirmación y el temporizador se reinicia.
- **Ley de UX:** Fitts (orienta): tamaño de objetivo táctil.
- **Esfuerzo:** a estimar con el equipo técnico.

### 7. Única salida: flecha sin texto, y no se dice qué pasa con la operación
- **Evidencia:** `<button class="icon-btn" onclick="history.back()">&#8592;</button>`, con 20×20 px, solo flecha, sin texto ni nombre accesible. No hay una acción "Cancelar".
- **Tarea afectada:** salir de la firma sin perder la transferencia rellenada, o cancelarla.
- **Consecuencia probable:** la persona no sabe si volver cancela la operación, la deja pendiente o conserva los datos. Lo que ocurre depende del sistema (hipótesis).
- **Heurística principal:** H3 · relacionadas: H2, H1.
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:**
  - Económico → no saber si queda una operación pendiente que pueda firmarse más tarde (a comprobar).
  - Accesibilidad o inclusión → icono sin nombre accesible y objetivo de 20 px (a derivar).
- **Línea roja:** no aplica.
- **Confianza:** Media · el control se ve, pero su efecto real no.
- **Corrección:**
  - Acción visible "Cancelar operación", secundaria para no competir con "Firmar", con texto de lo que ocurre.
  - Flecha con nombre accesible y objetivo de al menos 44 px.
  - Comprobar que `history.back()` no deja la operación en un estado ambiguo.
- **Cómo verificarla:** tras pulsar, el estado de la transferencia es el anunciado (cancelada o conservada). Con lector de pantalla se anuncia "Volver".
- **Ley de UX:** Fitts (orienta).
- **Esfuerzo:** a estimar con el equipo técnico.

### 8. La instrucción principal está en gris muy claro
- **Evidencia:** `.help{color:#b4b4b4;font-size:13px}` contiene "Introduce el código que te hemos enviado al móvil terminado en **47" (≈2,1:1 sobre blanco, estimado). El dato secundario `.ref` usa `#555`, más oscuro.
- **Tarea afectada:** entender qué hacer y a qué móvil llegó el código.
- **Consecuencia probable:** la instrucción es el texto más débil de la pantalla. Se lee mal con poca luz (hipótesis).
- **Heurística principal:** H8 · relacionadas: ninguna.
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:** Accesibilidad o inclusión → texto esencial con bajo contraste (WCAG 1.4.3, a derivar).
- **Línea roja:** no aplica.
- **Confianza:** Media · el color se ve, pero el ratio es estimado y el efecto en lectura no está medido.
- **Corrección:** usar el token de texto con contraste suficiente para la instrucción y reservar el gris para lo accesorio. La instrucción debe pesar más que la referencia.
- **Cómo verificarla:** medir con herramienta de contraste (mínimo 4,5:1) y revisar la jerarquía en el prototipo.
- **Ley de UX:** no se aplica.
- **Esfuerzo:** a estimar con el equipo técnico.

### 9. Referencia de 19 dígitos sin agrupar
- **Evidencia:** "Referencia de la operación: 2026101583749201746", 19 dígitos seguidos, 13 px.
- **Tarea afectada:** reconocer la operación o dictarla al soporte.
- **Consecuencia probable:** errores al leerla o dictarla. Se tolera, porque no bloquea la firma.
- **Heurística principal:** H6.
- **Severidad:** ⚪ 1 · Leve.
- **Riesgo específico:** Operativo → errores al dictar la referencia al soporte.
- **Línea roja:** no aplica.
- **Confianza:** Media · el formato se ve, pero no se mide cuánto afecta.
- **Corrección:** mostrarla agrupada (p. ej. en bloques de 4) o con botón "Copiar", sin cambiar el valor almacenado.
- **Cómo verificarla:** una persona la dicta a otra y se compara con el original.
- **Ley de UX:** Miller (orienta): números largos sin agrupar.
- **Esfuerzo:** a estimar con el equipo técnico.

## 7. Evidencia necesaria

| Qué falta | Cómo obtenerlo | Qué resolvería |
|---|---|---|
| Pantalla de resultado y mensaje tras error o corte de conexión | Prototipo o captura de "Operación realizada", del error y del caso "conexión cortada justo después de firmar" | Indicio U2; H1, H9; qué ocurre con la transferencia |
| Comportamiento real de "Firmar" | Prueba en entorno de pruebas con datos sintéticos y doble pulsación | Si hay doble envío (#3) |
| Duración real del código, reenvío e intentos permitidos | Respuesta de negocio (preguntas abiertas del caso) y prueba del contador | #4, #6; que el contador refleje la caducidad real |
| Si el error se muestra tras un intento fallido o desde la carga | Estado de la pantalla en la primera carga | Si "Error 4012" precede a la acción |
| Contenido del SMS | Texto del SMS | Qué datos ve la persona al recibir el código (no sustituye a #1) |
| Efecto real de la flecha de volver | Prueba del flujo completo | #7 |
| Design system (botón, campo, mensaje de alerta) | Biblioteca o tokens | H4: consistencia y uso de componentes |
| Pantalla de rellenar transferencia | Prototipo | Si el resumen puede reutilizarse en la firma (#1) |

## 8. Lo que funciona bien

- "Terminado en **47" confirma a qué móvil llegó el código sin exponer el número completo.
- El campo del código es grande (22 px) y con espaciado entre dígitos, y `maxlength="6"` coincide con los 6 dígitos del flujo.
- El botón "Firmar" ocupa todo el ancho, con texto blanco sobre `#0b3d6e`, y es la acción primaria claramente reconocible.

## 9. Hipótesis para validar con personas usuarias

- Si el tiempo total del código es suficiente para quien teclea sin autocompletado.
- Si la gente entiende "¿No has recibido el código?" como "reenviar".
- Si interpreta la flecha como "cancelar" o como "volver".
- Si, ante "Error 4012", la gente repite la transferencia o llama al soporte.

## 10. Para accesibilidad

Derivar a `auditing-accessibility`. Estas comprobaciones no cambian este estado de aprobación.
- **Contraste, por medir:** `#b4b4b4` (ayuda), `#999` (temporizador), `#8aa4c0` (enlace), `#e53935` a 12 px (error) y `#e3e3e3` (borde del campo).
- **Campo:** sin `<label>` asociado, solo placeholder. `outline:none` sin foco alternativo visible.
- **Error:** sin `role="alert"` ni vínculo con el campo (`aria-describedby`). Estado indicado solo por color.
- **Temporizador y "Procesando...":** sin región `aria-live`.
- **Controles:** el botón de volver no tiene nombre accesible y mide 20×20 px (objetivo táctil mínimo). El enlace de reenvío es muy bajo.
- **Documento:** `<html>` sin atributo `lang`. Comprobar cómo lee el lector "**47".

Archivos relevantes (solo lectura): `demo/pantalla-firma.html` y `demo/caso-firma-operacion.md`.
