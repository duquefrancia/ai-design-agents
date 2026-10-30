# Auditoría de accesibilidad · Firma de una transferencia (web móvil, Banco Lumen)

> Informe completo de `design-team:accessibility-auditor`, guardado tal cual por la Head of Design. Auditoría independiente: el agente solo leyó la pantalla, el reto y los materiales de su skill.

## 1. Estado de aprobación
**No apto** · 🔴 4 · Crítico: 1 · 🟠 3 · Mayor: 4 · 🟡 2 · Moderado: 1 · ⚪ 1 · Leve: 1

**Qué lo determina:**
- Una línea roja: foco invisible en el campo del código (`input.code { outline:none }`, sin estilo alternativo).
- Siete incumplimientos A/AA confirmados sobre el HTML y el CSS entregados (la línea roja es el primero de ellos): 2.4.7, 3.3.2, 3.3.1, 3.3.3, 1.4.3, 1.4.11, 4.1.2 y 3.1.1.

**Línea roja:** foco eliminado. Quien navega con teclado externo, control por interruptor o VoiceOver/TalkBack con teclado no ve dónde está en el único campo de la tarea.

**Resumen:**
- La persona usuaria no puede identificar el campo del código (sin etiqueta, sin foco visible, borde casi invisible).
- Si falla, no entiende el error ("Error 4012") ni sabe si la transferencia se hizo.
- Los textos que explican el código, el tiempo y la recuperación no llegan a 4,5:1.
- Además, 3.3.4 (confirmación antes de mover dinero), 2.2.1 y 4.1.3 quedan pendientes de evidencia (sección 7). Ese pendiente no suaviza el No apto.

**Cumplimiento:** producto bancario para consumidores. Los incumplimientos AA tienen riesgo bajo la Ley Europea de Accesibilidad (Directiva (UE) 2019/882) y la Ley 11/2023 (identificación, firma y pago están en su ámbito). El detalle jurídico se confirma con Compliance. Esto no es una declaración de conformidad.

## 2. Entrada, alcance y trazabilidad
- Tipo de entrada: HTML + CSS estático (sin JavaScript más allá de dos `onclick` en línea). Permite verificar marcado, estilos, semántica, nombres accesibles y foco declarado. No permite verificar comportamiento real con tecnologías de apoyo, temporizador, red ni zoom.
- Plataforma: web móvil. Objetivo mínimo aplicable: 24×24 px (2.5.8).
- Alcance firmado: solo `demo/pantalla-firma.html` (paso de firma con código de un solo uso). Consecuencia económica: sí (mueve dinero), así que se aplican las lentes de producto regulado.
- Fuera de alcance: pantallas de rellenar la transferencia y de resultado (sin prototipo). Lo que depende de ellas se indica como tal (3.3.4, 4.1.3, 3.3.7, 3.2.x).
- Contexto leído: `demo/caso-firma-operacion.md`.
- Trazabilidad: fecha 2026-10-23 · skill auditing-accessibility (versión del plugin: no consultada en esta ejecución; indicarla al guardar) · objeto evaluado `demo/pantalla-firma.html` · responsable de la revisión: pendiente de asignar.
- Método de contraste: `scripts/contraste.py` de la skill, sobre los colores del CSS. Fondo del `.box` `#ffffff`.

## 3. Hallazgos
| # | Criterio WCAG | Elemento | Evidencia | Severidad | Arreglo |
|---|---|---|---|---|---|
| 1 | 2.4.7 Foco visible (AA). **Línea roja** | `input.code` | CSS `input.code{…outline:none}`. No hay regla `:focus` ni `:focus-visible`, y el borde no cambia con el foco. El campo del código es el único paso obligatorio de la tarea. | 🔴 4 · Crítico | Quitar `outline:none` y añadir `input.code:focus-visible{outline:3px solid #0b3d6e;outline-offset:2px}` (11,01:1 sobre blanco). Dejar el contorno también en el estado de error. [rápido] |
| 2 | 3.3.2 Etiquetas o instrucciones (A) · 1.3.1 Información y relaciones (A) · 4.1.2 Nombre, función, valor (A) | `input.code` | Sin `<label>`, `aria-label` ni `aria-labelledby`. Solo `placeholder="······"`, que no es nombre accesible fiable y desaparece al escribir. `p.help`, `.timer` y `.error` no están asociados al campo. Etiquetas ausentes en el flujo principal. | 🟠 3 · Mayor | `<label for="codigo">Código de firma (6 dígitos)</label>` con `id="codigo"`. Añadir `aria-describedby="ayuda timer error"` apuntando a esos tres textos. [rápido] |
| 3 | 3.3.1 Identificación de errores (A) · 3.3.3 Sugerencias ante errores (AA) | `div.error` ("Error 4012") | El texto es un código sin descripción: no dice qué ocurrió, qué revisar ni qué hacer. Tampoco dice si la transferencia se ejecutó. Sin `aria-invalid` en el campo ni vínculo programático con él. El campo se marca en rojo (`input.code.err`), pero el error también se enuncia en texto, por lo que no confirmo línea roja de color. El contexto del caso dice que los clientes no saben si la operación se hizo tras un error. Cadena: mensaje opaco → decisión (reintentar firma o repetir la transferencia) → cargo duplicado o llamada a soporte. | 🟠 3 · Mayor | Mensaje en lenguaje llano por causa conocida. Por ejemplo: «El código no es correcto. Revisa los 6 dígitos del SMS o pide uno nuevo. Tu transferencia todavía no se ha realizado.» La causa y el estado reales los define negocio. Añadir `aria-invalid="true"` y `aria-describedby`. Mantener el código técnico como referencia secundaria. [medio] |
| 4 | 1.4.3 Contraste mínimo (AA) | Cuatro textos secundarios: `p.help`, `a.link`, `div.timer` y `div.error` | `p.help` `#b4b4b4`/`#fff`, 13 px: **2,07:1**. `a.link` `#8aa4c0`/`#fff`, 12 px: **2,58:1** (único camino si no llega el código). `div.timer` `#999999`/`#fff`, 12 px: **2,85:1**. `div.error` `#e53935`/`#fff`, 12 px: **4,23:1**. Ninguno es texto grande ni exento. | 🟠 3 · Mayor | Usar tokens de texto ≥4,5:1. `p.help` y `.timer` a `#595959` (7,00:1) o `#6b6b6b` (5,33:1). `a.link` a `#0b3d6e` (11,01:1) y subrayado. `div.error` a `#c62828` (5,62:1). Subir los 12 px a ≥14 px, aunque no es obligatorio. [rápido] |
| 5 | 1.4.11 Contraste no textual (AA) | `input.code` (estado sin error) | Regla base `border:1px solid #e3e3e3` sobre `#fff`: **1,28:1**. Fondo del campo blanco sobre `.box` blanco, así que no hay otro límite visible. El estado renderizado (`.err`, borde `#e53935`, 4,23:1) sí cumple, pero el estado sin error es el primero que se ve en cada uso. Escalado: frecuencia (cada firma). | 🟠 3 · Mayor | Borde `#767676` o más oscuro (≥3:1; `#767676` da 4,54:1) en el estado base. Conservar el rojo, ya conforme, en error. [rápido] |
| 6 | 4.1.2 Nombre, función, valor (A) · 1.1.1 Contenido no textual (A) | `button.icon-btn` (`onclick="history.back()"`) | El contenido es solo el carácter `&#8592;` (←). Sin `aria-label`. El nombre accesible es el glifo ("flecha hacia la izquierda"), sin indicar la acción. Es la única salida visible del paso de firma. | 🟡 2 · Moderado | `aria-label="Volver"` y el glifo con `aria-hidden="true"`. Ver Observaciones sobre el tamaño. [rápido] |
| 7 | 3.1.1 Idioma de la página (A) | `<html>` | Falta `lang`. Un lector de pantalla puede leer en la voz equivocada el texto en español y el código de 6 dígitos. | ⚪ 1 · Leve | `<html lang="es">`. [rápido] |

Resumen de remediación: 5 de los 7 hallazgos son [rápido], uno [medio] (el 3) y ninguno [estructural].

**No aplica:**
- 1.2.1–1.2.5: no hay audio ni vídeo.
- 1.4.2 y 2.3.1: no hay audio automático ni destellos.
- 1.4.5: no hay imágenes de texto.
- 2.5.1, 2.5.2, 2.5.4 y 2.5.7: no hay gestos, arrastre ni movimiento. Solo hay controles de activación simple.
- 2.1.4: no hay atajos de una tecla.
- 1.4.13: no hay contenido al pasar el ratón o con foco.
- 3.1.2: no hay partes en otro idioma.
- 2.4.5: es un paso de un proceso, que es una excepción del criterio.

## 4. Riesgos de producto (fuera de WCAG)
No son incumplimientos WCAG y no cambian el estado de aprobación de accesibilidad. Si bloquean la aprobación general lo decide el orquestador o el quality gate de producto.

| # | Lente | Elemento | Evidencia | Severidad | Categoría de riesgo | Arreglo |
|---|---|---|---|---|---|---|
| R1 | 1 · Fraude y suplantación [legal] | Cuerpo de `.box` | La pantalla de firma solo muestra una referencia (`2026101583749201746`). No muestra importe, destinatario, cuenta de destino, concepto ni fecha. El flujo documentado (rellenar, "Continuar", SMS, firmar) no menciona un paso de resumen. Es la autorización final, y la autenticación reforzada (SCA) en pagos remotos exige vincular el código con importe y beneficiario. Severidad provisional según el ancla «confirmar sin ver qué se confirma»: Mayor si el dato existe por otra vía, Crítico si no existe. | 🟠 3 · Mayor (provisional) | Económico · Legal o normativo | Mostrar en texto, encima del campo del código, el importe, el destinatario (nombre y cuenta enmascarada) y la fecha. Nombrar el botón «Firmar transferencia». Confirmar con Compliance el requisito de vinculación dinámica. [medio] |
| R2 | 2 · Estados inciertos | `div.error` y `button.btn` | El error no dice si la operación se ejecutó (ver hallazgo 3). El botón cambia a «Procesando…» y el código no tiene salida a un resultado, un error de red ni una consulta posterior. | 🟠 3 · Mayor | Económico · Operativo o continuidad del servicio | Definir el contrato de estados: enviando, pendiente, ejecutada, rechazada y resultado no confirmado. En este último, ofrecer una vía de consulta y no incentivar el reenvío hasta resolverlo. [estructural] |
| R3 | 2 · Estados inciertos | `button.btn` (`onclick="this.textContent='Procesando...'"`) | El botón no se deshabilita ni se bloquea tras el primer clic, y no se ve protección frente a doble activación. La protección real vive en el servicio y no es verificable aquí. | 🟡 2 · Moderado (sube a Mayor si el servicio no impide duplicados) | Económico | Deshabilitar el botón con `aria-disabled`, mantener el foco en él y pedir a desarrollo evidencia de idempotencia en el servicio. [medio] |
| R4 | 1 · Fraude y suplantación | `p.help` | El texto no dice la finalidad del código (firma de qué operación) ni avisa de no compartirlo con nadie, ni siquiera con quien llame en nombre del banco. | 🟡 2 · Moderado | Económico (fraude por ingeniería social) | Texto breve: «Código para firmar tu transferencia. Lumen nunca te lo pedirá por teléfono.» Redacción por validar con Seguridad. [rápido] |

## 5. No verificable
- Lectura real con VoiceOver, TalkBack y NVDA: el HTML no permite confirmar nombres, orden de lectura ni anuncios. Hace falta prueba en dispositivo.
- Temporizador: «El código caduca en 0:45» es texto fijo, sin script. No se sabe si cuenta atrás, cuánto dura el código en total ni qué pasa al caducar (2.2.1, 2.2.2).
- Anuncio de «Procesando…», del error y del resultado: no hay `role` ni región viva en el HTML, pero el criterio 4.1.3 se decide en un entorno con tecnologías de apoyo.
- Pegado y autorrelleno del SMS: el HTML no bloquea el pegado (sin `onpaste`; ver sección 6). Falta probarlo en iOS Safari y Android Chrome (3.3.8).
- Zoom 200 %, reflow a 320 px y espaciado de texto (1.4.4, 1.4.10, 1.4.12): solo se ha revisado el CSS. `.top` tiene `height:56px` fijo con `overflow` visible. El resto usa `max-width` y `width:100%`, sin anchos fijos, pero hace falta prueba real.
- Foco no oculto bajo la cabecera pegajosa (2.4.11): `.top{position:sticky}` de 56 px y sin `scroll-padding-top`. Con zoom o pantalla pequeña podría tapar el elemento enfocado. Solo se confirma en navegador.
- Color real del `placeholder` (`······`): lo fija el navegador, no el CSS. Se ignora su contraste porque no transmite información.
- Aro de foco por defecto de `button.btn`, `button.icon-btn` y `a.link`: el CSS no lo elimina, pero su aspecto sobre `#0b3d6e` depende del navegador y debe comprobarse.
- Páginas de rellenar y de resultado: sin prototipo. Quedan sin evaluar 3.2.3 Navegación coherente, 3.2.4 Identificación coherente, 3.2.6 Ayuda consistente, 3.3.7 Entrada redundante y 4.1.3 del resultado final.
- Medidas de los objetivos (2.5.8): calculadas desde el CSS, no medidas en pantalla.

## 6. Criterios verificados sin problema (dentro del alcance HTML/CSS)
- **1.4.3 en el resto del texto:** `.ref` `#555`/`#fff` 7,46:1; cuerpo `#222`/`#fff` 15,91:1; cabecera y botón, blanco sobre `#0b3d6e`, 11,01:1.
- **1.4.4 (parcial):** el `viewport` no bloquea el zoom y el tamaño de letra es relativo al navegador.
- **1.3.4 Orientación:** el CSS no la bloquea.
- **2.1.1 y 2.1.2 (marcado):** todos los controles son nativos (`button`, `input`, `a href`) y no hay trampas en el código. La prueba real con teclado está en la sección 7.
- **2.4.3 Orden del foco (marcado):** orden del DOM = orden visual y lógico (volver, código, Firmar, enlace). No hay `tabindex`.
- **2.4.1 Saltar bloques:** `<main>` cumple por landmark en una página de este tamaño.
- **2.5.3 Etiqueta en el nombre:** «Firmar» coincide con el nombre accesible.
- **3.2.1 y 3.2.2:** no hay cambios de contexto al recibir foco ni al introducir datos.
- **3.3.8 Autenticación accesible (mínimo), por el marcado:** el código se puede pegar (no hay manejador `paste`) y es un campo único. Falta confirmar el comportamiento real (ver sección 5).
- **2.5.8 Tamaño del objetivo, aproximado:** `button.icon-btn` mide 20×20 px, por debajo de 24, pero cumple por la excepción de espaciado: no hay otro objetivo en un círculo de 24 px centrado en él. `a.link` ocupa todo el ancho y unos 14 px de alto, y queda a 14 px del botón Firmar, por lo que cumple por espaciado. `button.btn` mide unos 51 px de alto. Hay que medirlo en pantalla.
- **1.4.11 en el estado de error:** el borde rojo `#e53935` (4,23:1) cumple. El incumplimiento está en el estado base (hallazgo 5).
- **Sin comprobar por ausencia de elementos:** 1.1.1 (salvo el hallazgo 6) y 1.4.5, porque no hay imágenes.

## 7. Evidencia necesaria
El estado ya es No apto. Esta evidencia falta además para los criterios que siguen sin decidir.

| Qué falta exactamente | Criterio A/AA que permite decidir | Cómo resolverlo |
|---|---|---|
| Pantalla de rellenar o resumen de la transferencia (o la especificación del paso previo) y confirmación de si existe revisión de importe, destinatario y fecha antes de pedir el código, y de qué hace cancelar | 3.3.4 Prevención de errores (legales, financieros, datos) (AA) | Obtener el prototipo o la especificación. Con lector de pantalla y teclado, comprobar que se lee el resumen, que se puede corregir y que cancelar funciona. Si no hay ninguna de las tres opciones del criterio (reversible, comprobada o confirmada) en todo el flujo, queda confirmado un incumplimiento AA y R1 sube a Crítico. |
| Duración total del código, comportamiento del temporizador, qué ocurre al caducar y si "¿No has recibido el código?" genera uno nuevo | 2.2.1 Tiempo ajustable (A) · 2.2.2 Pausar, detener, ocultar (A) | Pedir la regla de negocio (hoy es pregunta abierta). Probar la build real con datos sintéticos y justificar con Seguridad si aplica la excepción esencial. |
| Anuncio real de «Procesando…», del error y del resultado | 4.1.3 Mensajes de estado (AA) | Prueba con NVDA, VoiceOver iOS y TalkBack sobre una build con estados reales (éxito, rechazo, desconexión), contrastando el anuncio con el registro del servicio. Nunca con pagos reales. |
| Pegado y autorrelleno del SMS en dispositivos reales | 3.3.8 Autenticación accesible (mínimo) (AA) | Probar en iOS Safari y Android Chrome. Comprobar que el código llega entero. |
| Zoom 200 %, reflow a 320 px, espaciado de texto y foco bajo la cabecera sticky | 1.4.4, 1.4.10, 1.4.12, 2.4.11 (AA) | Pruebas en navegador móvil real con capturas por estado. |
| Aspecto del aro de foco en `button.btn`, `button.icon-btn` y `a.link` | 2.4.7 Foco visible (AA) | Tabular con teclado externo en Safari y Chrome móvil. |
| Páginas previa y posterior del flujo | 3.2.3, 3.2.4, 3.2.6, 3.3.7 (A/AA) | Entregar los prototipos, o indicar qué ayuda se ofrece en cada página. |

## 8. Prueba con personas usuarias de tecnologías de apoyo
- **Firmar una transferencia con lector de pantalla (VoiceOver iOS y TalkBack), datos sintéticos.** Qué observar:
  - Qué oye al llegar al campo (hoy no tiene etiqueta).
  - Si puede saber qué firma, cuánto y a quién antes de introducir el código.
  - Si entiende qué dice el error y si sabe si la operación se hizo.
  - Qué anuncia al pulsar «Firmar» y si el resultado se percibe sin buscarlo.
- **Misma tarea solo con teclado externo o control por interruptor.** Qué observar: ¿ve dónde está el foco en el campo del código? Hoy no es visible.
- **Con zoom del 200 % y con baja visión.** Qué observar: ¿encuentra el campo, lee las ayudas y el temporizador, y localiza «¿No has recibido el código?»?
- **Con el SMS en otro dispositivo o app.** Qué observar: ¿puede copiar y pegar el código? ¿Le da tiempo antes de que caduque (queja ya recogida en el caso, sin cifras)? ¿Puede pedir otro y qué pasa con lo escrito?
- **Fallo de conexión justo tras pulsar «Firmar».** Qué observar: ¿sabe si la transferencia se hizo o no y evita repetirla? Probar en entorno autorizado.

## Observaciones
Mejoras sin incumplimiento A/AA confirmado. No cambian el estado de aprobación.
- `button.icon-btn`: mide 20×20 px. Cumple 2.5.8 por espaciado, pero conviene subir a 44×44 px (recomendación AAA 2.5.5 y HIG en iOS).
- `input.code`: añadir `inputmode="numeric"` y `autocomplete="one-time-code"` para teclado numérico y autorrelleno de SMS en iOS y Android. Es ayuda web, no obligación WCAG aislada.
- `p.help`: «terminado en **47». El lector puede leer los asteriscos como «asterisco asterisco». Escribir «terminado en 47».
- `div.ref`: la referencia de 19 dígitos sin separar se lee como un número enorme. Agrupar los dígitos y ofrecer «Copiar referencia».
- `<title>Firma</title>`: poco descriptivo. Mejor «Firma de operación · Banco Lumen».
- `h2` sin `h1` y cabecera como `div`: usar `<h1>`, `<header>` y marcar «Banco Lumen» como texto de cabecera.
- `a.link` con `href="#"`: si la acción es reenviar el código, usar `<button>` y el texto «Reenviar código». Hoy es una pregunta, no una acción.
- `button.btn` «Firmar»: nombrar la operación (ver R1) y añadir una acción visible de cancelar. Hoy solo existe la flecha de volver con `history.back()`, que abandona el paso sin aviso.
- El estado renderizado combina error, campo vacío y temporizador a la vez. Confirmar con negocio qué estados reales existen (primera carga, error, caducado, bloqueado) antes de decidir cuál se audita.

## Preguntas abiertas para negocio (sin inventar datos)
- Intentos permitidos antes de bloquear la firma.
- Duración total del código y si se puede reenviar.
- Qué pasa con la transferencia si se corta la conexión justo tras firmar.
- Qué significa el código 4012 y qué acción puede hacer la persona.

Archivos leídos para esta auditoría (de solo lectura): `demo/pantalla-firma.html` y `demo/caso-firma-operacion.md`. De la skill, solo sus referencias y su plantilla.
