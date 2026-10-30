# Evaluación heurística: firma de transferencia (Banco Lumen, ficticio)

**Entrada:** HTML (`demo/pantalla-firma.html`). Muestra el contenido, los estilos y el `onclick`. No muestra lo que pasa después de pulsar, si el contador avanza, el contenido del SMS ni la pantalla siguiente.
**Alcance:** paso «Firma de operación», en el único estado que declara el HTML. Ese estado mezcla el inicial (campo vacío) y el de error (`input.code.err` + «Error 4012»). También el cambio a «Procesando...». Fuera de alcance: pasos anteriores, resultado, reenvío del código y accesibilidad de conformidad.
**Contexto:** cliente de banca móvil* · firmar una transferencia de 250,00 € a un destinatario nuevo · introducir el código SMS y firmar · banca digital.

## 1. Líneas rojas

| # | Línea roja | Estado | Evidencia observada | Decisión afectada | Perjuicio posible | Alternativa transparente |
|---|---|---|---|---|---|---|
| U1 | Mover dinero sin resumen | **Confirmada** | La pantalla de firma no muestra importe, destinatario, IBAN ni comisiones. Solo «Referencia de la operación: 2026101583749201746» | Firmar o no la transferencia | Firmar una operación con un importe o destinatario equivocado, o manipulada, a un destinatario nuevo | Resumen fijo encima del código: «250,00 € a [nombre] · ES·· ···· [últimos 4]», con comisiones. Botón «Firmar 250,00 €» |
| U4 | Error sin salida | **Confirmada** | `<div class="error">Error 4012</div>`, sin causa ni siguiente paso | Corregir el código o pedir otro | La persona no puede firmar y no sabe por qué | Mensaje con causa y acción: «Código incorrecto. Te quedan 2 intentos» o «El código ha caducado. [Enviar otro código]» |
| U2 | Resultado incierto | Indicio fundado | `onclick="this.textContent='Procesando...'"`: solo cambia el texto. El botón sigue activo y no hay más estados | Saber si la transferencia se hizo | Repetir la firma o dar por hecha una transferencia que falló | Botón desactivado al enviar, estado de carga anunciado y pantalla de resultado: hecha, pendiente o fallida |

## 2. Nota de validación

- **Por qué sale esta nota:** he evaluado el HTML completo del paso de firma. Hay dos líneas rojas confirmadas por evidencia directa del código: U1 (sin importe ni destinatario) y U4 (error sin salida). Cada una da No apto por sí sola. Verificar el indicio U2 no cambiaría el estado, solo añadiría o quitaría un motivo.
- **Autocomprobación:** he pasado el bucle de validación entero. No he podido comprobar si el contador avanza, qué hace el enlace `href="#"`, qué hace `history.back()` con la transferencia, si el SMS incluye importe y destinatario, ni si el error aparece al cargar o solo tras un intento. H4 y H10 quedan ⚫.

## 3. Estado de aprobación

**No apto** · 🔴 1 · 🟠 2 · 🟡 4 · ⚪ 1 · líneas rojas: 2 confirmadas · 1 indicio fundado
**Motivo:** líneas rojas U1 y U4 confirmadas. Además hay un hallazgo 🔴 4 (hallazgo 1) y dos 🟠 3 (hallazgos 2 y 3).
**Válido para:** paso «Firma de operación», en el estado que declara el HTML y su `onclick` · **No cubre:** pasos anteriores, resultado, reenvío del código, contenido del SMS, el resto del flujo ni la accesibilidad.
**Recomendación:** primero, poner importe, destinatario y comisiones en la pantalla de firma. Después, reescribir el error 4012 con causa y salida.
> Este estado de aprobación es una recomendación experta. La decisión final es del equipo; la priorización se cierra con el equipo técnico, que valora viabilidad y esfuerzo.

## 4. Semáforo de las 10 heurísticas

| | H1 | H2 | H3 | H4 | H5 | H6 | H7 | H8 | H9 | H10 |
|---|---|---|---|---|---|---|---|---|---|---|
| Principal | 🟠 3 | 🟢 0 | 🟡 2 | ⚫ | 🔴 4 | ⚪ 1 | 🟡 2 | 🟡 2 | 🟠 3 | ⚫ |
| Relacionada en | #4 | #2 | #2 | — | #3 | #1 | #4 | — | — | #4 |

H4 queda ⚫: comprobar la consistencia exige ver el resto del flujo. H10 queda ⚫: el enlace de ayuda existe, pero su destino (`href="#"`) no se puede evaluar. Las líneas rojas no colorean el panel.

## 5. Resumen de hallazgos

| # | Problema | Severidad | Heurística principal | Riesgo específico | Línea roja | Confianza |
|---|---|---|---|---|---|---|
| 1 | Se firma sin ver importe, destinatario ni comisiones | 🔴 4 · Crítico | H5 | Económico · Legal o normativo | U1 confirmada | Alta |
| 2 | «Error 4012» sin causa ni salida | 🟠 3 · Mayor | H9 | Operativo · Accesibilidad o inclusión | U4 confirmada | Alta |
| 3 | Tras «Firmar» solo cambia el texto: sin bloqueo ni resultado | 🟠 3 · Mayor | H1 | Económico | U2 indicio fundado | Media |
| 4 | El código caduca sin una vía clara para pedir otro | 🟡 2 · Moderado | H3 | Operativo · Accesibilidad o inclusión | No aplica | Media |
| 5 | El campo del código no admite autocompletar ni abre teclado numérico | 🟡 2 · Moderado | H7 | Operativo | No aplica | Alta |
| 6 | No hay «Cancelar»: la única salida es una flecha de 20 × 20 px | 🟡 2 · Moderado | H3 | Operativo · Accesibilidad o inclusión | No aplica | Media |
| 7 | Las instrucciones, el contador y la ayuda tienen muy poco contraste | 🟡 2 · Moderado | H8 | Accesibilidad o inclusión | No aplica | Alta |
| 8 | Referencia de 19 dígitos sin agrupar | ⚪ 1 · Leve | H6 | Sin riesgo específico identificado | No aplica | Alta |

## 6. Fichas de hallazgos

### 1. Se firma sin ver importe, destinatario ni comisiones
- **Evidencia:** la caja `.box` solo contiene el título, la instrucción del SMS, la referencia, el campo, el contador, el error y «Firmar». No aparecen «250,00 €», el destinatario, la cuenta ni las comisiones.
- **Tarea afectada:** confirmar que se autoriza la transferencia correcta antes de firmar.
- **Consecuencia probable:** la persona firma sin poder comprobar qué autoriza. Con un destinatario nuevo, un error o una manipulación del destinatario no se detecta en el último punto de control. Una transferencia ejecutada es difícil de revertir.
- **Heurística principal:** H5 · relacionadas: H6 (hay que recordar los datos del paso anterior).
- **Severidad:** 🔴 4 · Crítico. Cumple «consecuencia grave o difícil de revertir»: autorizar dinero a un destinatario sin verlo.
- **Riesgo específico:** Económico → envío a un destinatario o por un importe no deseados. Legal o normativo → posible implicación con el requisito de vinculación dinámica de la autenticación reforzada en pagos (PSD2 / RTS). Hay que informar a quien paga del importe y del beneficiario. No está verificado: falta saber si el SMS los incluye.
- **Línea roja:** U1 confirmada.
- **Confianza:** Alta · el HTML es la pantalla completa y los datos no están. Aunque un paso anterior los mostrara, no están a la vista al firmar.
- **Corrección:** bloque de resumen encima del código, con importe, nombre del destinatario, IBAN parcial, comisión («0,00 €» o la cifra real) y la etiqueta «Destinatario nuevo». Botón «Firmar 250,00 €».
- **Cómo verificarla:** revisar el prototipo con 5 personas. Tarea: «Antes de firmar, ¿a quién envías y cuánto?». Todas deben responder sin volver atrás.
- **Ley de UX:** no aplica.
- **Esfuerzo:** a estimar con el equipo técnico.

### 2. «Error 4012» sin causa ni salida
- **Evidencia:** `<div class="error">Error 4012</div>` y borde rojo en `input.code.err`. No hay texto de causa ni acción, y el mensaje no está ligado al campo.
- **Tarea afectada:** recuperarse de un código fallido y firmar.
- **Consecuencia probable:** la persona no sabe si el código es incorrecto, ha caducado o está bloqueado. Puede reintentar a ciegas y agotar intentos (hipótesis: no se conoce la política de intentos) o abandonar la transferencia.
- **Heurística principal:** H9 · relacionadas: H2 (código interno), H3 (no ofrece una salida).
- **Severidad:** 🟠 3 · Mayor. Cumple «riesgo relevante y corrección necesaria antes de aprobar»: bloquea la recuperación en un paso obligatorio. No llega a 🔴 4 porque el campo sigue editable y no se demuestra que la tarea quede impedida.
- **Riesgo específico:** Operativo → la operación queda sin firmar y la persona tiene que llamar al banco. Accesibilidad o inclusión → el error se marca con borde rojo y texto de 12 px, sin asociación programática.
- **Línea roja:** U4 confirmada.
- **Confianza:** Alta · el texto literal no da causa ni siguiente paso. Media sobre si el error aparece ya al cargar, porque el HTML lo declara junto al campo vacío.
- **Corrección:** un mensaje por causa, en lenguaje claro y junto al campo. Por ejemplo, «El código no es correcto. Te quedan 2 intentos» o «El código ha caducado» con botón «Enviar otro código». Si hace falta el código interno, va aparte para soporte. Mostrar el error solo tras un intento.
- **Cómo verificarla:** recorrer cada código de error del servicio y comprobar que todos tienen causa y acción. Test: «¿Qué harías ahora?» con cada mensaje.
- **Ley de UX:** no aplica.
- **Esfuerzo:** a estimar con el equipo técnico.

### 3. Tras «Firmar» solo cambia el texto: sin bloqueo ni resultado
- **Evidencia:** `onclick="this.textContent='Procesando...'"`. El botón no se desactiva y no hay estado de carga anunciado ni de resultado.
- **Tarea afectada:** saber si la transferencia se ha hecho.
- **Consecuencia probable:** se puede pulsar de nuevo, con riesgo de una segunda firma (hipótesis: no se sabe si el servidor lo evita). Si la respuesta tarda o falla, la persona no sabe si el dinero ha salido.
- **Heurística principal:** H1 · relacionadas: H5 (doble envío).
- **Severidad:** 🟠 3 · Mayor. Cumple «riesgo relevante de error» en una operación con dinero.
- **Riesgo específico:** Económico → transferencia duplicada, o repetida por creer que falló.
- **Línea roja:** U2 indicio fundado. Comprobación: ver qué pasa tras la respuesta del servidor (éxito, fallo, tiempo de espera).
- **Confianza:** Media · el `onclick` se ve, pero puede que la navegación real esté en otro código.
- **Corrección:** al pulsar, desactivar el botón y anunciar «Firmando…» (`aria-live`). Después, una pantalla de resultado con estado (hecha, pendiente o fallida), importe, destinatario y referencia. Si falla, decir qué ha pasado con el dinero.
- **Cómo verificarla:** pruebas con doble toque, red lenta y error del servidor. En cada caso debe salir un único resultado claro.
- **Ley de UX:** Doherty (orienta la comprobación: una respuesta que tarda sin señal invita a repetir).
- **Esfuerzo:** a estimar con el equipo técnico.

### 4. El código caduca sin una vía clara para pedir otro
- **Evidencia:** «El código caduca en 0:45» (texto estático en el HTML, `#999`, 12 px). La única salida es «¿No has recibido el código?» con `href="#"`. Ningún control dice «Enviar otro código».
- **Tarea afectada:** firmar antes de que caduque el código, o pedir otro.
- **Consecuencia probable:** si caduca, la persona no sabe que puede pedir otro. El enlace habla de «no recibido», no de «caducado».
- **Heurística principal:** H3 · relacionadas: H1 (no se sabe si el contador avanza), H10 (destino del enlace desconocido).
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:** Operativo → tener que repetir la transferencia. Accesibilidad o inclusión → límite de tiempo sin aviso ni ampliación para quien lee o escribe despacio.
- **Línea roja:** no aplica. El contador responde a la caducidad real del código SMS (hipótesis). No hay señal de urgencia falsa.
- **Confianza:** Media · no se ve si el contador avanza ni qué hace el enlace.
- **Corrección:** al caducar, cambiar el texto a «El código ha caducado» con un botón «Enviar otro código». Renombrar el enlace como «Enviar otro código» y mantenerlo siempre visible.
- **Cómo verificarla:** dejar que caduque el código en el prototipo y comprobar que la persona pide otro sin salir de la pantalla.
- **Esfuerzo:** a estimar con el equipo técnico.

### 5. El campo del código no admite autocompletar ni abre teclado numérico
- **Evidencia:** `<input class="code err" type="text" maxlength="6" placeholder="······">`, sin `inputmode="numeric"` ni `autocomplete="one-time-code"`.
- **Tarea afectada:** introducir el código del SMS.
- **Consecuencia probable:** hay que cambiar de app, memorizar seis cifras y teclearlas en un teclado alfabético. Efecto combinado con el hallazgo 4: más probabilidad de que el código caduque o se escriba mal.
- **Heurística principal:** H7.
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:** Operativo → código caducado o erróneo y nueva solicitud.
- **Línea roja:** no aplica.
- **Confianza:** Alta · los atributos faltan en el código. Lo que no se ha medido es cuánto tarda la persona.
- **Corrección:** añadir `inputmode="numeric"` y `autocomplete="one-time-code"`. En nativo, usar `textContentType = .oneTimeCode` (iOS) y la API de recuperación de SMS (Android).
- **Cómo verificarla:** en iOS y Android, recibir el SMS y comprobar que el teclado sugiere el código y que el teclado es numérico.
- **Ley de UX:** Miller (fundamenta la corrección: evitar retener seis cifras entre apps).
- **Esfuerzo:** a estimar con el equipo técnico.

### 6. No hay «Cancelar»: la única salida es una flecha de 20 × 20 px
- **Evidencia:** `<button class="icon-btn" onclick="history.back()">&#8592;</button>` con `width:20px;height:20px`, sin texto ni nombre accesible. No hay botón «Cancelar».
- **Tarea afectada:** abandonar la firma o corregir un dato.
- **Consecuencia probable:** la persona no sabe si al volver se cancela la transferencia, se pierde lo rellenado o queda pendiente. El objetivo táctil es pequeño.
- **Heurística principal:** H3.
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:** Operativo → transferencia rellenada que se pierde, o duda sobre si quedó pendiente. Accesibilidad o inclusión → objetivo de 20 × 20 px, por debajo de 44 pt (HIG) y 48 dp (Material).
- **Línea roja:** no aplica.
- **Confianza:** Media · se ve el control, no el efecto de `history.back()` sobre la operación.
- **Corrección:** añadir «Cancelar transferencia» como acción secundaria. Llevar la flecha a 44 × 44 con nombre accesible «Volver». Volver a la transferencia sin perder los datos.
- **Cómo verificarla:** pulsar Volver y Cancelar en el prototipo y comprobar que no queda ninguna firma pendiente y que los datos se conservan al volver.
- **Ley de UX:** Fitts (fundamenta el tamaño del objetivo).
- **Esfuerzo:** a estimar con el equipo técnico.

### 7. Las instrucciones, el contador y la ayuda tienen muy poco contraste
- **Evidencia:** `.help` `#b4b4b4` sobre blanco (≈ 2,1:1, 13 px), el texto que dice adónde llega el código. `.timer` `#999` (≈ 2,8:1, 12 px). `.link` `#8aa4c0` (≈ 2,6:1, 12 px). Son valores calculados a mano: confirmarlos.
- **Tarea afectada:** saber dónde está el código, cuánto tiempo queda y cómo pedir ayuda.
- **Consecuencia probable:** con poca visión o al sol, la persona no lee la instrucción ni el tiempo restante.
- **Heurística principal:** H8.
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:** Accesibilidad o inclusión → texto esencial ilegible para parte de las personas usuarias.
- **Línea roja:** no aplica.
- **Confianza:** Alta · los colores se ven en el CSS y los tres quedan muy por debajo de 4,5:1.
- **Corrección:** usar tokens semánticos de texto secundario y de enlace que cumplan 4,5:1, con 14 px como mínimo.
- **Cómo verificarla:** medir el contraste con una herramienta y revisarlo en un dispositivo real con mucho brillo.
- **Esfuerzo:** a estimar con el equipo técnico.

### 8. Referencia de 19 dígitos sin agrupar
- **Evidencia:** «Referencia de la operación: 2026101583749201746».
- **Tarea afectada:** dictar o anotar la referencia si hay que llamar a soporte.
- **Consecuencia probable:** errores al leerla o dictarla. Ocupa un espacio destacado que no aporta a la firma.
- **Heurística principal:** H6.
- **Severidad:** ⚪ 1 · Leve.
- **Riesgo específico:** Sin riesgo específico identificado.
- **Línea roja:** no aplica.
- **Confianza:** Alta · el número se ve sin agrupar.
- **Corrección:** agruparla («2026 1015 8374 9201 746») y moverla debajo del resumen o a la pantalla de resultado.
- **Cómo verificarla:** pedir a 3 personas que la dicten y contar los errores.
- **Ley de UX:** Miller (orienta la agrupación).
- **Esfuerzo:** a estimar con el equipo técnico.

## 7. Evidencia necesaria

| Qué falta | Cómo obtenerlo | Qué resolvería |
|---|---|---|
| Qué pasa tras pulsar «Firmar» (éxito, fallo, tiempo de espera, doble toque) | Prototipo o código de la llamada y de la pantalla siguiente | El indicio U2 y la severidad del hallazgo 3 |
| Contenido del SMS (¿incluye importe y destinatario?) | Plantilla del SMS | La posible implicación normativa del hallazgo 1. No cambia la línea roja U1 |
| Si «Error 4012» aparece al cargar o solo tras un intento, y la política de intentos | Estados de la pantalla y especificación del servicio | El alcance del hallazgo 2 |
| Si el contador avanza y qué hace «¿No has recibido el código?» | Prototipo navegable | Los hallazgos 4 y el estado de H10 |
| Efecto de `history.back()` sobre la transferencia | Prototipo o especificación | El hallazgo 6 |
| Comisión de la transferencia y aviso de destinatario nuevo en pasos anteriores | Pantallas previas del flujo | Qué mostrar en el resumen de firma |

## 8. Lo que funciona bien

- Pedir un código SMS antes de mover dinero a un destinatario nuevo es diseño justificado: autenticación reforzada, explicada y proporcionada.
- «al móvil terminado en **47» dice dónde buscar el código sin exponer el número completo.
- El tiempo de validez del código está a la vista, aunque necesita más contraste (hallazgo 7) y una salida al caducar (hallazgo 4).

## 9. Hipótesis para validar con personas usuarias

- Si quienes firman recuerdan el importe y el destinatario del paso anterior sin verlos en la firma.
- Si «¿No has recibido el código?» se entiende también como la vía para pedir otro cuando caduca.
- Si 45 segundos bastan para cambiar de app, leer el SMS y teclear el código, en especial con baja experiencia digital.

## 10. Para accesibilidad

Comprobaciones para `auditing-accessibility`. No cambian este estado de aprobación.
- Ratios de contraste de `.help`, `.timer`, `.link` y del borde del campo `#e3e3e3` (texto 1.4.3 y no textual 1.4.11).
- `outline:none` en `input.code`: posible pérdida de foco visible (2.4.7).
- El campo no tiene `<label>`, solo `placeholder` (1.3.1, 3.3.2).
- El error no está ligado al campo (`aria-invalid`, `aria-describedby`) y se marca sobre todo con color (1.4.1, 3.3.1).
- El contador y «Procesando...» no se anuncian (`aria-live`, 4.1.3). Límite de tiempo sin ampliación (2.2.1).
- El botón de volver no tiene nombre accesible y su objetivo es de 20 × 20 px (4.1.2, 2.5.8).
- Falta `lang` en `<html>` (3.1.1) y el título «Firma» es genérico (2.4.2).
- Cómo lee un lector de pantalla «**47».

No he leído las hojas de respuestas de `demo/` ni informes anteriores, y no he guardado ningún archivo.
