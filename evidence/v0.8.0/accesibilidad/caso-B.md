# Auditoría de accesibilidad · Transferencia realizada (pantalla de resultado, web)

## 1. Estado de aprobación
**Pendiente de verificación** · 🔴 4 · Crítico: 0 · 🟠 3 · Mayor: 0 · 🟡 2 · Moderado: 0 · ⚪ 1 · Leve: 0
Motivo: no se confirma ningún incumplimiento A/AA ni línea roja en el código. Falta evidencia esencial para decidir 4.1.3 Mensajes de estado y 2.4.3 Orden del foco: no se sabe si el resultado llega como página nueva o se inyecta en una vista ya cargada. La aprobación queda retenida hasta resolver la Evidencia necesaria.
Líneas rojas: ninguna detectada.
Resumen: la pantalla está bien construida en marcado, contraste y foco declarado. Lo que decide la aprobación es lo que oye la persona al llegar al resultado y si el justificante PDF es accesible; ninguna de las dos cosas se puede comprobar con el HTML.
Cumplimiento: producto bancario para consumidores (banco ficticio). Ley Europea de Accesibilidad (Directiva (UE) 2019/882) y Ley 11/2023 aplicables en su ámbito; alcance y obligaciones por confirmar con compliance.

## 2. Entrada, alcance y trazabilidad
- Tipo de entrada: HTML + CSS en línea, sin JavaScript.
- Plataforma: web.
- Alcance: 1 pantalla, el resultado de una transferencia. No se han entregado los pasos previos (formulario, confirmación, firma) ni el justificante PDF.
- Trazabilidad: fecha 2026-10-22 · skill auditing-accessibility 0.8.0 (copia de trabajo con cambios sin commit) · objeto evaluado `demo/pantalla-resultado.html` (SHA-256 `d9923cfca7a6…`) · responsable de la revisión: pendiente de asignar.

## 3. Hallazgos
Ningún incumplimiento A/AA confirmado dentro del alcance verificable.

Aspectos revisados en el código, sin hallazgos (🟢 0 · Sin problemas detectados, solo con la evidencia del HTML):

| Aspecto | Criterio WCAG | Evidencia |
|---|---|---|
| Contraste de texto | 1.4.3 | Cuerpo #1c1b19 / #ffffff = 17,21:1 · términos `dt` #595959 / #ffffff = 7,00:1 · texto del aviso #1c1b19 / #e7f4ec = 15,20:1 · `.btn` #ffffff / #0b3d6e = 11,01:1 · `.link` #0b3d6e / #ffffff = 11,01:1. Calculado con `scripts/contraste.py`. |
| Contraste no textual | 1.4.11 | Icono `circle` #1f6b3f / #e7f4ec = 5,74:1 · borde de `.estado` #1f6b3f / #ffffff = 6,50:1 · contorno de foco #0b3d6e / #ffffff = 11,01:1. |
| Foco visible | 2.4.7 | `.btn:focus-visible, .link:focus-visible { outline: 3px solid #0b3d6e; outline-offset: 3px }`. No hay `outline: none`. |
| Color como único portador | 1.4.1 | El éxito se comunica con texto («Transferencia realizada», «Hemos enviado 250,00 €…»), no solo con verde ni con el icono. |
| Contenido no textual | 1.1.1 | El SVG es decorativo y redundante con el texto: `aria-hidden="true"` y `focusable="false"`. Correcto. |
| Estructura | 1.3.1 · 2.4.6 | `header` y `main` como landmarks; `h1` → `h2`; resumen en `dl` con pares `dt`/`dd`. |
| Título e idioma | 2.4.2 · 3.1.1 | `<title>Transferencia realizada · Banco Lumen</title>` · `<html lang="es">`. |
| Teclado | 2.1.1 | Los dos controles son nativos (`button`, `a href`). Sin `tabindex` ni elementos `div` clicables. El orden del DOM sigue la tarea: resultado → resumen → volver → justificante. |
| Propósito de enlaces y nombre | 2.4.4 · 2.5.3 | «Descargar justificante (PDF, 40 KB)» indica acción, formato y peso. Nombre accesible = texto visible. |
| Tamaño del objetivo | 2.5.8 | `.btn` `min-height: 48px`, ancho completo · `.link` `min-height: 44px`. Supera 24×24 px. |
| Foco no oculto | 2.4.11 | No hay cabeceras fijas, banners ni capas superpuestas. |
| Datos de la operación | Lente 2 (productos regulados) | Importe, destinatario, cuenta enmascarada, concepto, fecha y referencia en texto. |

No aplican: 1.2.x (no hay audio ni vídeo), 1.4.2, 2.2.x, 2.3.1, 2.5.1, 2.5.4, 2.5.7 (no hay temporizadores, animaciones, gestos ni arrastre), 3.3.x de formularios (no hay campos).

## 4. Riesgos de producto (fuera de WCAG)
No son incumplimientos WCAG y no cambian el estado de aprobación de accesibilidad. Si bloquean la aprobación general lo decide el orquestador o el quality gate de producto.

| # | Lente | Elemento | Evidencia | Severidad | Categoría de riesgo | Arreglo |
|---|---|---|---|---|---|---|
| 1 | Lente 2 · Estados inciertos | `p` dentro de `.estado`: «El dinero llegará hoy.» | La pantalla promete el abono en el día. No consta qué tipo de transferencia es (inmediata u ordinaria) ni qué hito confirma el servicio. Si el abono no está garantizado, la persona puede tomar decisiones sobre un dato no confirmado. Regla de negocio no verificable: pregunta abierta. | ⚪ 1 · Leve | Operativo o continuidad del servicio | Confirmar con negocio qué hito se conoce al mostrar la pantalla. Mostrar solo lo confirmado (p. ej. «Orden enviada. Llegará hoy si…» o la fecha prevista que dé el servicio) [rápido] |

## 5. No verificable
- Anuncio real del resultado con lector de pantalla — el HTML no dice si la pantalla es una carga de página nueva o contenido inyectado. `role="status"` en un contenedor que ya está en el DOM al cargar no suele anunciarse; en una página nueva lo gestionan título y `h1`, en una vista inyectada no está garantizado — hace falta saber el mecanismo y probar con VoiceOver y NVDA.
- Posición del foco al llegar al resultado — depende de la navegación previa, no entregada — hace falta el flujo completo.
- Accesibilidad del justificante PDF (`justificante-2026-1016.pdf`) — no se ha entregado — hace falta el archivo.
- Destino y comportamiento de «Volver al inicio» — `button type="button"` sin manejador en el HTML — hace falta el código del comportamiento.
- Zoom 200 % (1.4.4), reflow a 320 px (1.4.10) y espaciado de texto (1.4.12) — no se ha renderizado. En el código no hay indicios de rotura: sin anchos fijos, `max-width: 420px`, texto que ajusta y `min-height` en vez de `height` — hace falta prueba en navegador.
- Ayuda consistente (3.2.6) y navegación e identificación coherentes (3.2.3, 3.2.4) — exigen comparar con las demás pantallas del flujo, no entregadas.
- Lectura de la referencia `2026 1016 8374 9201` por el lector de pantalla — depende del motor de voz.
- Protección frente a reenvío o duplicado de la orden — es del servicio, no de esta pantalla.

## 6. Prueba con personas usuarias de tecnologías de apoyo
- Completar una transferencia de prueba con VoiceOver (iOS Safari) y NVDA (Firefox o Chrome): ¿oye «Transferencia realizada» e importe y destinatario sin buscar? ¿Dónde queda el foco?
- Solo con teclado, desde el último paso de firma hasta esta pantalla: ¿el foco llega al inicio del resultado o se queda en el cuerpo de la página?
- Con zoom 200 % y a 320 px de ancho: ¿el resumen `dl` sigue siendo legible en pares término–valor?
- Abrir el justificante con lector de pantalla: ¿lee importe, destinatario, fecha y referencia en orden?
- Personas mayores o con poca soltura digital: ¿entienden si el dinero ya está en la cuenta de destino o solo se ha enviado?

## 7. Evidencia necesaria
| Qué falta exactamente | Criterio A/AA que permite decidir | Cómo resolverlo (conseguirla o implementarla) |
|---|---|---|
| Cómo se llega a esta pantalla: carga de página nueva o vista inyectada en una SPA | 4.1.3 Mensajes de estado · 2.4.3 Orden del foco | Conseguir el código de navegación del paso de firma. Si es SPA: mover el foco al `h1` (`tabindex="-1"`) o insertar el texto dentro de un `role="status"` que ya exista vacío antes de la inyección. |
| Grabación o registro de lo que anuncian VoiceOver y NVDA al llegar al resultado | 4.1.3 Mensajes de estado | Prueba en preproducción con datos sintéticos; registrar versión, fecha, navegador, tecnología de apoyo, pasos y resultado. |
| Justificante PDF | 1.3.1 Información y relaciones · 1.3.2 Secuencia significativa · 1.1.1 Contenido no textual | Entregar el PDF generado; comprobar etiquetado, orden de lectura y que los datos no estén en imagen. |
| Render a 320 px, zoom 200 % y espaciado de texto | 1.4.10 Reflow · 1.4.4 Redimensionar texto · 1.4.12 Espaciado de texto | Prueba en navegador con las tres condiciones; capturas como evidencia. |
| Pantallas anteriores del flujo | 3.2.3 · 3.2.4 · 3.2.6 | Entregarlas para auditar el flujo completo (regla de cierre 3). |

## 8. Observaciones
- «Volver al inicio» es navegación pero está marcado como `button` — `.btn` — si lleva a otra página, usar `<a href>` con el mismo estilo; el lector de pantalla anuncia «enlace» y se puede abrir en otra pestaña.
- `role="status"` sobre contenido presente al cargar no aporta y puede dar la falsa sensación de que el anuncio está resuelto — `div.estado` — decidir el mecanismo según la Evidencia necesaria y documentarlo.
- La referencia puede leerse como cifras («dos mil veintiséis…») y no dígito a dígito — `dd.ref` — valorar etiqueta accesible con los dígitos separados si las personas tienen que dictarla al soporte; comprobar antes con lectores reales.
- No hay acceso directo al detalle de la operación en movimientos — pantalla completa — valorar un enlace «Ver en movimientos» para consultar el resultado después sin depender del PDF.
