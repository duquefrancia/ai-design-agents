# Auditoría de accesibilidad · Firma de operación con código de un solo uso (web)

## 1. Estado de aprobación
**No apto** · 🔴 4 · Crítico: 1 · 🟠 3 · Mayor: 4 · 🟡 2 · Moderado: 2 · ⚪ 1 · Leve: 2
Motivo: nueve incumplimientos WCAG 2.2 A/AA confirmados en el código y una línea roja.
Línea roja: **foco invisible**. `input.code` lleva `outline:none` y no tiene estilo de foco alternativo.
El único campo del paso de firma no muestra el foco, no tiene etiqueta y su error («Error 4012») no dice qué pasó ni qué hacer. La instrucción, la caducidad y la vía para pedir otro código no llegan al contraste mínimo.
Cumplimiento: hallazgos A/AA en un servicio bancario para consumidores, con riesgo bajo la Ley Europea de Accesibilidad (Directiva (UE) 2019/882) y la Ley 11/2023. Detalle por confirmar con compliance.

## 2. Entrada, alcance y trazabilidad
- Tipo de entrada: HTML + CSS inline (sin JavaScript salvo dos `onclick`)
- Plataforma: web, viewport móvil
- Alcance: 1 pantalla, la de firma de operación. Se muestra en estado de error (`input.code.err` y `div.error` presentes al cargar). No se han entregado el paso previo (resumen de la operación) ni el de resultado.
- Contexto: operación con consecuencia económica (firma de una operación bancaria). Se aplican las lentes de producto regulado y los casos 1, 3 y 8 de `casos-banca.md` como guía de pruebas, no como hallazgos.
- Trazabilidad: fecha 2026-10-22 · skill auditing-accessibility 0.8.0 · objeto evaluado `demo/pantalla-firma.html` · responsable de la revisión: pendiente de asignar
- Contrastes calculados con `scripts/contraste.py` sobre los colores declarados en el CSS.

## 3. Hallazgos
| # | Criterio WCAG | Elemento | Evidencia | Severidad | Arreglo |
|---|---|---|---|---|---|
| 1 | 2.4.7 Foco visible (AA) | `input.code` | `outline:none` en la regla base y ningún estilo `:focus` ni `:focus-visible`. El borde no cambia al recibir foco. Solo queda el cursor de texto del navegador. Fallo documentado F78. Es el único campo del paso obligatorio de firma. **Línea roja.** | 🔴 4 · Crítico | Quitar `outline:none` o añadir `input.code:focus-visible{outline:2px solid <token de foco>;outline-offset:2px}` con contraste ≥3:1 sobre `#ffffff` y sobre el borde [rápido] |
| 2 | 4.1.2 Nombre, función, valor (A) · 3.3.2 Etiquetas o instrucciones (A) | `input.code` | Sin `<label>`, `aria-label` ni `aria-labelledby`. El `placeholder="······"` no da nombre útil. `p.help` no está asociado. El lector de pantalla anuncia un campo de texto sin nombre. | 🟠 3 · Mayor | `<label for="codigo">Código de firma</label>` visible y `aria-describedby` hacia `p.help` y `div.timer` [rápido] |
| 3 | 3.3.1 Identificación de errores (A) · 3.3.3 Sugerencias ante errores (AA) | `div.error` «Error 4012» | El texto no describe el error (¿código incorrecto, caducado, bloqueado?) ni dice qué hacer. No está asociado al campo: falta `aria-invalid="true"` y `aria-describedby` en `input.code`. | 🟠 3 · Mayor | Mensaje en texto que diga qué ocurrió y qué hacer (p. ej. «El código no es correcto. Revísalo o pide uno nuevo»). Asociarlo con `aria-describedby` y marcar `aria-invalid="true"`. El código interno puede ir aparte para soporte [rápido] |
| 4 | 1.4.3 Contraste mínimo (AA) | `p.help` y `div.timer` | `p.help` #b4b4b4 sobre #ffffff = 2,07:1 a 13 px. `div.timer` #999999 sobre #ffffff = 2,85:1 a 12 px. Son la instrucción del paso y el plazo de caducidad. | 🟠 3 · Mayor | Usar el token de texto secundario ≥4,5:1 (el de `div.ref`, #555555, da 7,46:1) [rápido] |
| 5 | 1.4.3 Contraste mínimo (AA) | `a.link` «¿No has recibido el código?» | #8aa4c0 sobre #ffffff = 2,58:1 a 12 px. Es la única vía visible para recuperar el código. | 🟠 3 · Mayor | Token de enlace ≥4,5:1 sobre blanco y subrayado [rápido] |
| 6 | 1.4.3 Contraste mínimo (AA) | `div.error` | #e53935 sobre #ffffff = 4,23:1 a 12 px. | 🟡 2 · Moderado | Token de error ≥4,5:1 para texto (p. ej. un rojo más oscuro del sistema) y tamaño ≥14 px [rápido] |
| 7 | 1.4.11 Contraste no textual (AA) | `input.code` en estado por defecto | Borde #e3e3e3 sobre #ffffff = 1,28:1. Sin la clase `err` el límite del campo no se distingue. (En estado de error, #e53935 da 4,23:1 y pasa.) | 🟡 2 · Moderado | Token de borde de campo ≥3:1 sobre el fondo de la tarjeta [rápido] |
| 8 | 2.4.6 Encabezados y etiquetas (AA) | `button.icon-btn` «←» | El nombre accesible es el carácter «←» («flecha izquierda»). No dice el propósito. | ⚪ 1 · Leve | `aria-label="Volver"` y carácter con `aria-hidden="true"`, o texto visible «Volver» [rápido] |
| 9 | 3.1.1 Idioma de la página (A) | `<html>` | Sin atributo `lang`. El lector puede leer el texto en español con voz de otro idioma. | ⚪ 1 · Leve | `<html lang="es">` [rápido] |

## 4. Riesgos de producto (fuera de WCAG)
No son incumplimientos WCAG y no cambian el estado de aprobación de accesibilidad. Si bloquean la aprobación general lo decide el orquestador o el quality gate de producto.

| # | Lente | Elemento | Evidencia | Severidad | Categoría de riesgo | Arreglo |
|---|---|---|---|---|---|---|
| R1 | 1 · Fraude y suplantación / 5 · Autenticación reforzada | Pantalla de firma completa | Se firma sin ver importe, destinatario ni tipo de operación. Solo aparece «Referencia de la operación: 2026101583749201746». Cadena: barrera → no se puede revisar qué se autoriza → riesgo de autorizar una operación distinta. [legal] El vínculo con importe y beneficiario en la autenticación de pagos remotos (PSD2 / Reglamento Delegado (UE) 2018/389) está por confirmar con compliance para esta operación. | 🟠 3 · Mayor | Económico · Legal o normativo | Mostrar en texto, antes del campo, importe, destinatario, cuenta de destino y tipo de operación. Nombre de acción inequívoco («Firmar transferencia de X €») o resumen accesible junto al botón [medio] |
| R2 | 2 · Estados inciertos | `button.btn` | `onclick` solo cambia el texto a «Procesando...». El botón sigue activo: se puede pulsar otra vez. No hay evidencia de protección frente a reintentos en el servicio. | 🟡 2 · Moderado | Económico · Operativo o continuidad del servicio | Pedir a desarrollo evidencia de idempotencia en el servicio. Además, `aria-disabled` durante el envío y estado de procesamiento anunciado [medio] |
| R3 | 1 · Fraude y suplantación | `p.help` | El texto no dice para qué sirve el código ni avisa de no compartirlo con nadie que lo pida por teléfono o mensaje. | 🟡 2 · Moderado | Económico | Añadir finalidad y aviso: «Este código sirve para firmar esta operación. No lo compartas con nadie» [rápido] |

## 5. No verificable
- Anuncio real con NVDA, JAWS, VoiceOver y TalkBack — la entrada es código; requiere prueba en vivo.
- Si el error y «Procesando...» se inyectan dinámicamente y cómo se anuncian (4.1.3) — en el HTML entregado el error ya está presente al cargar y no hay lógica de envío.
- Caducidad del código (2.2.1) — «El código caduca en 0:45» es texto estático; no hay temporizador ni comportamiento al caducar.
- Qué hace «¿No has recibido el código?» — `href="#"` sin destino.
- Resumen previo de la operación (3.3.4) — el paso anterior no se ha entregado.
- Resultado de la firma (éxito, rechazo, resultado no confirmado) — no hay pantalla de resultado.
- Canal y mecanismo del código (3.3.8) — no consta si el SMS llega al mismo dispositivo ni si hay alternativa a transcribirlo. El código no bloquea el pegado.
- Zoom 200 %, reflow a 320 px y espaciado de texto (1.4.4, 1.4.10, 1.4.12) — requieren renderizado. Riesgo a comprobar: `.top` tiene `height:56px` fija.
- Foco tapado por la cabecera `position:sticky` (2.4.11) — requiere renderizado con desplazamiento.
- Contraste del anillo de foco por defecto en `button.btn`, `button.icon-btn` y `a.link` — depende del navegador.
- Modo oscuro y colores forzados — no hay estilos declarados; requiere prueba en los sistemas objetivo.

## 6. Prueba con personas usuarias de tecnologías de apoyo
- Firmar solo con teclado: ¿se ve en todo momento dónde está el foco, sobre todo en el campo del código?
- Con lector de pantalla: ¿oye qué operación firma (importe, destinatario) antes de introducir el código? ¿Sabe qué escribir en el campo?
- Con lector de pantalla e introduciendo un código erróneo: ¿oye qué falló y qué hacer?
- Con lector de pantalla o magnificador: ¿se entera del plazo de caducidad a tiempo? ¿Puede pedir otro código sin perder la operación?
- Con zoom 200 % y en 320 px: ¿siguen visibles instrucción, campo, error y botón?
- Tras pulsar «Firmar»: ¿oye que se está procesando y después el resultado? ¿Evita volver a pulsar?

## 7. Evidencia necesaria
| Qué falta exactamente | Criterio A/AA que permite decidir | Cómo resolverlo (conseguirla o implementarla) |
|---|---|---|
| Paso previo con el resumen de la operación y si la firma es reversible | 3.3.4 Prevención de errores (AA) | Entregar el paso anterior y el resultado; o implementar revisión y confirmación accesible antes de la firma |
| Comportamiento al caducar el código: aviso, ampliación o petición de otro código sin perder la operación, y excepción de seguridad documentada si se alega | 2.2.1 Tiempo ajustable (A) | Implementar el temporizador y el reenvío y probarlos en preproducción; documentar la excepción con Seguridad |
| Canal del código y mecanismos de asistencia (pegado, `autocomplete="one-time-code"`, alternativa si el código llega a otro dispositivo) | 3.3.8 Autenticación accesible (mínimo) (AA) | Describir las variantes de firma y probarlas sin ayuda de terceros |
| Anuncio de «Procesando...», del error y del resultado sin mover el foco | 4.1.3 Mensajes de estado (AA) | Implementar `role="status"` (o el patrón adecuado) y grabar la prueba con lector de pantalla |
| Renderizado con zoom, reflow, espaciado de texto y cabecera fija | 1.4.4 · 1.4.10 · 1.4.12 · 2.4.11 (AA) | Prueba en navegador a 200 % y 320 px, con bookmarklet de espaciado y tabulación con desplazamiento |

## 8. Observaciones
- Tamaño de `button.icon-btn`: 20×20 px. Cumple 2.5.8 por la excepción de espaciado (no hay otros objetivos a menos de 24 px), pero queda muy por debajo de 44×44 (2.5.5, AAA, y HIG). Ampliar el área táctil a 44×44.
- `input.code`: añadir `inputmode="numeric"` y `autocomplete="one-time-code"` para facilitar teclado numérico y autorrelleno.
- Referencia de 19 dígitos: el lector puede leerla como una cifra enorme. Agruparla visualmente o con un texto alternativo legible.
- «**47»: el lector lee los asteriscos. Escribir «móvil terminado en 47».
- Título de la página «Firma»: hacerlo más descriptivo, p. ej. «Firma de operación · Banco Lumen».
- Estructura: no hay `h1` ni landmark de cabecera. Usar `<header>` y un `h1` para el título del paso.
