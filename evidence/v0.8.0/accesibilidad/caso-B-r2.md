# Auditoría de accesibilidad · Resultado de transferencia (web)

## 1. Estado de aprobación
**Pendiente de verificación** · 🔴 4 · Crítico: 0 · 🟠 3 · Mayor: 0 · 🟡 2 · Moderado: 0 · ⚪ 1 · Leve: 0
Motivo: no hay ningún incumplimiento A/AA confirmado en el código entregado, pero falta evidencia esencial para decidir 4.1.3 y 2.4.3 (cómo se llega a la pantalla y qué anuncia realmente el lector de pantalla) y para el justificante PDF enlazado (1.3.1, 1.3.2). La aprobación queda retenida hasta resolver la Evidencia necesaria.
Líneas rojas: ninguna detectada en el código.
La pantalla está bien construida: título, encabezados, lista de definición, contraste ≥ 7:1, foco visible y reflow correcto a 320 px. Lo que falta es probar el resultado en el flujo real, no la pantalla aislada.
Cumplimiento: servicio bancario a consumidores, dentro del posible ámbito de la European Accessibility Act y la Ley 11/2023 (alcance y obligaciones por confirmar con compliance).

## 2. Entrada, alcance y trazabilidad
- Tipo de entrada: HTML + CSS en línea. Render propio en Chrome sin interfaz a 320 px y 640 px de ancho para comprobar reflow.
- Plataforma: web
- Alcance: 1 pantalla, resultado de una transferencia realizada. No se han entregado los pasos previos del flujo, el estado de error ni el justificante PDF.
- Trazabilidad: fecha 2026-10-23 · skill auditing-accessibility 0.8.0 · objeto evaluado `demo/pantalla-resultado.html` · responsable de la revisión: pendiente de asignar

## 3. Hallazgos
Sin hallazgos confirmados dentro del alcance verificable.

Aspectos revisados con el código y el render (🟢 0 · Sin problemas detectados, dentro de lo que permite la entrada):

| Criterio WCAG | Elemento | Evidencia |
|---|---|---|
| 1.1.1 Contenido no textual | `svg` del estado | `aria-hidden="true"`; el texto contiguo transmite el resultado. Decorativo correcto. |
| 1.3.1 Información y relaciones | `h1`, `h2`, `dl` / `dt` / `dd`, `header`, `main` | Estructura en el marcado; cada dato del resumen asociado a su etiqueta. |
| 1.4.1 Uso del color | `.estado` | Éxito comunicado con texto («Transferencia realizada», «Hemos enviado…») e icono, no solo con verde. |
| 1.4.3 Contraste mínimo | Texto | `#1c1b19`/`#ffffff` 17,21:1 · `#1c1b19`/`#e7f4ec` 15,20:1 · `dt` `#595959`/`#ffffff` 7,00:1 · cabecera y botón `#ffffff`/`#0b3d6e` 11,01:1 · enlace `#0b3d6e`/`#ffffff` 11,01:1. Calculado con `scripts/contraste.py`. |
| 1.4.11 Contraste no textual | Botón, borde del estado, icono, contorno de foco | Botón `#0b3d6e`/`#ffffff` 11,01:1 · borde e icono `#1f6b3f`/`#e7f4ec` 5,74:1 · contorno de foco `#0b3d6e` sobre `#ffffff` 11,01:1. |
| 1.4.10 Reflow | Página completa | Render a 320 px: sin scroll horizontal; importe, cuenta, fecha y referencia hacen salto de línea sin cortarse. |
| 2.4.2 Título de página | `<title>` | «Transferencia realizada · Banco Lumen». |
| 2.4.4 Propósito de los enlaces | `a.link` | «Descargar justificante (PDF, 40 KB)»: acción, formato y tamaño. |
| 2.4.7 Foco visible | `.btn`, `.link` | `:focus-visible` con contorno de 3 px y separación de 3 px. No se elimina el foco por defecto. |
| 2.5.3 Etiqueta en el nombre | Botón y enlace | Nombre accesible = texto visible. |
| 2.5.8 Tamaño del objetivo | `.btn`, `.link` | Botón ≥ 48 px de alto y ancho completo; enlace 44 px de alto. |
| 3.1.1 Idioma de la página | `<html lang="es">` | Declarado. |

No aplica:
- 1.2.1–1.2.5 — no hay audio ni vídeo.
- 1.3.5 Propósito de los campos, 3.3.1, 3.3.2, 3.3.3, 3.3.7, 3.3.8 — la pantalla no tiene campos ni autenticación.
- 3.3.4 Prevención de errores — la operación ya se ejecutó; corresponde al paso de confirmación, no entregado.
- 2.2.1, 2.2.2, 2.3.1, 1.4.2, 1.4.13, 2.1.4, 2.5.1, 2.5.2, 2.5.4, 2.5.7 — no hay límites de tiempo, movimiento, audio, contenido emergente, atajos, gestos, arrastre ni activación por movimiento.
- 2.4.5 Múltiples vías — excepción de WCAG: la página es el resultado de un proceso.
- 2.4.1 Saltar bloques — la cabecera no contiene elementos interactivos; `header` y `main` actúan como landmarks.

## 4. Riesgos de producto (fuera de WCAG)
No son incumplimientos WCAG y no cambian el estado de aprobación de accesibilidad. Si bloquean la aprobación general lo decide el orquestador o el quality gate de producto.

| # | Lente | Elemento | Evidencia | Severidad | Categoría de riesgo | Arreglo |
|---|---|---|---|---|---|---|
| 1 | Estados inciertos | `.estado p` | «Hemos enviado 250,00 € […]. El dinero llegará hoy.» afirma un plazo de abono. No hay evidencia de la regla de negocio que lo respalda (tipo de transferencia, hora de corte, entidad destino). Si el abono no llega hoy, la persona puede creer que falló y repetir la operación. | 🟡 2 · Moderado (hipótesis: depende de la regla real) | Económico | Confirmar con negocio qué hito garantiza el servicio. Si no se garantiza el abono hoy, mostrar el hito confirmado («Orden enviada») y el plazo previsto con su condición. [medio] |

## 5. No verificable
- Anuncio real del resultado con NVDA, JAWS o VoiceOver — el HTML no permite comprobar el comportamiento de las tecnologías de apoyo — prueba en vivo.
- Si `role="status"` sobre contenido presente al cargar se anuncia — muchos lectores solo anuncian cambios posteriores a la creación de la región; en una carga de página completa el título y el `h1` cubren el contexto, en una vista inyectada no — saber cómo se llega a la pantalla.
- Posición del foco al llegar a la pantalla (2.4.3, 2.4.11) — depende de la navegación del flujo, no entregada.
- Accesibilidad del justificante PDF (1.3.1, 1.3.2, 1.1.1) — `justificante-2026-1016.pdf` no está en `demo/` — un justificante emitido real.
- Destino y comportamiento de «Volver al inicio» — `type="button"` sin manejador en el archivo; no se puede comprobar qué hace ni si conserva el contexto — el flujo implementado.
- 1.4.4 Redimensionar texto y 1.4.12 Espaciado de texto — revisados en código (sin alturas fijas; `.link` usa `line-height:44px` con `min-height`, no `height`), sin prueba con zoom de texto ni bookmarklet de espaciado.
- Modo de alto contraste o colores forzados — no probado.
- 3.2.3 Navegación coherente, 3.2.4 Identificación coherente, 3.2.6 Ayuda consistente — requieren el resto de pantallas del flujo.

## 6. Prueba con personas usuarias de tecnologías de apoyo
- Completar una transferencia de prueba con lector de pantalla (NVDA + Firefox, VoiceOver + Safari iOS): ¿oye «Transferencia realizada», importe y destinatario sin buscarlos? ¿Sabe si debe hacer algo más?
- Solo con teclado: al llegar a la pantalla, ¿dónde está el foco? ¿Alcanza «Volver al inicio» y «Descargar justificante» en ese orden y ve el contorno?
- Con lector de pantalla: ¿cómo lee la referencia «2026 1016 8374 9201»? ¿Se puede dictar o copiar a soporte sin errores?
- Abrir el justificante descargado con lector de pantalla: ¿se leen importe, destinatario, fecha y referencia en orden?
- Con zoom del navegador al 200 % y 400 %: ¿se lee todo sin scroll horizontal?

## 7. Evidencia necesaria
| Qué falta exactamente | Criterio A/AA que permite decidir | Cómo resolverlo (conseguirla o implementarla) |
|---|---|---|
| Cómo se llega a la pantalla tras confirmar (carga de página completa o vista inyectada) y dónde queda el foco | 4.1.3 Mensajes de estado · 2.4.3 Orden del foco | Entregar el paso de confirmación y la navegación. Si es vista inyectada: que el contenedor `role="status"` exista antes de insertar el texto, o mover el foco al `h1` con `tabindex="-1"`. |
| Grabación o registro del anuncio real con al menos un lector de pantalla de escritorio y uno móvil | 4.1.3 Mensajes de estado | Prueba en preproducción con datos sintéticos; registrar versión, navegador, tecnología de apoyo, pasos y resultado. |
| Un justificante PDF emitido por el sistema (no plantilla vacía) | 1.3.1 Información y relaciones · 1.3.2 Secuencia significativa · 1.1.1 Contenido no textual | Generar uno en preproducción y revisarlo con PAC o similar y con lector de pantalla. |

## 8. Observaciones
- Colores en hex directo (`#0b3d6e`, `#595959`, `#1f6b3f`…) en lugar de tokens semánticos — estilos de la página — los ratios se calcularon sobre estos valores; vuelve a calcularlos sobre los tokens cuando se migren.
- Referencia de operación — `dd.ref` — valorar un botón «Copiar referencia» con confirmación accesible (`role="status"`), útil para quien no puede leerla y dictarla con facilidad.
- Mensajes de estado — `.estado` — si la pantalla es siempre una carga completa, `role="status"` es inocuo pero no aporta; el contexto lo dan el `<title>` y el `h1`. Mantenerlo solo si hay inyección dinámica.
