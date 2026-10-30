# Cobertura WCAG 2.2 AA

Pasada de cobertura después de "Qué miro primero". No es un orden de prioridad.

Incluye los **55 criterios de nivel A y AA** de WCAG 2.2 (4.1.1 se retiró en 2.2). Todo incumplimiento A/AA confirmado da No apto, así que ninguno se salta: si no aplica (ej. no hay vídeo), dilo; si no se puede comprobar, va a No verificable.

## Perceptible
- 1.1.1 Contenido no textual: imágenes informativas con alternativa; decorativas con `alt=""` (correcto, no es hallazgo).
- 1.2.1 Solo audio y solo vídeo (grabado) · 1.2.2 Subtítulos (grabado) · 1.2.3 Audiodescripción o alternativa (grabado) · 1.2.4 Subtítulos (en directo) · 1.2.5 Audiodescripción (grabado): vídeos de producto, onboarding, webinars.
- 1.3.1 Información y relaciones: encabezados, listas, tablas y labels expresados en el código, no solo visualmente.
- 1.3.2 Secuencia significativa · 1.3.3 Características sensoriales (instrucciones que no dependen solo de forma, posición o sonido: «pulsa el botón verde de la derecha») · 1.3.4 Orientación · 1.3.5 Propósito de los campos (`autocomplete`).
- 1.4.1 Uso del color: nunca único portador de información.
- 1.4.2 Control del audio: audio automático de más de 3 s se puede pausar o silenciar.
- 1.4.3 Contraste mínimo · 1.4.11 Contraste no textual (bordes de campos, iconos, foco, estados).
- 1.4.5 Imágenes de texto: texto como texto, no como imagen (salvo logotipos).
- 1.4.4 Redimensionar texto 200 % · 1.4.10 Reflow a 320 px · 1.4.12 Espaciado de texto · 1.4.13 Contenido al pasar el ratón o con foco.

## Operable
- 2.1.1 Teclado · 2.1.2 Sin trampas de teclado · 2.1.4 Atajos de una sola tecla (se pueden desactivar o reasignar).
- 2.2.1 Tiempo ajustable · 2.2.2 Pausar, detener, ocultar.
- 2.3.1 Tres destellos o por debajo del umbral.
- 2.4.1 Saltar bloques · 2.4.2 Título de página · 2.4.3 Orden del foco · 2.4.4 Propósito de los enlaces (en contexto) · 2.4.5 Múltiples vías · 2.4.6 Encabezados y etiquetas · 2.4.7 Foco visible.
- **2.4.11 Foco no oculto (mínimo)** — nuevo en 2.2: cabeceras fijas, banners de cookies o chats que tapan el foco.
- **2.5.7 Movimientos de arrastre** — nuevo en 2.2: alternativa de un solo puntero.
- **2.5.8 Tamaño del objetivo (mínimo)** — nuevo en 2.2: 24×24 px o espaciado equivalente.
- 2.5.1 Gestos del puntero (alternativa de un solo punto a gestos multipunto o de trayectoria) · 2.5.2 Cancelación del puntero (la acción se dispara al soltar o se puede anular).
- 2.5.3 Etiqueta en el nombre: el nombre accesible contiene el texto visible.
- 2.5.4 Activación por movimiento (agitar o inclinar tiene alternativa y se puede desactivar).

## Comprensible
- 3.1.1 Idioma de la página · 3.1.2 Idioma de las partes.
- 3.2.1 / 3.2.2 Sin cambios de contexto inesperados al recibir foco o al introducir datos.
- 3.2.3 Navegación coherente · 3.2.4 Identificación coherente (mismos componentes, mismos nombres en todo el flujo).
- **3.2.6 Ayuda consistente** — nuevo en 2.2: chat, teléfono o ayuda en la misma posición relativa en todas las páginas del flujo.
- 3.3.1 Identificación de errores · 3.3.2 Etiquetas o instrucciones · 3.3.3 Sugerencias ante errores · 3.3.4 Prevención de errores (legales, financieros, datos).
- **3.3.7 Entrada redundante** — nuevo en 2.2: no pedir otra vez lo ya introducido en el mismo proceso.
- **3.3.8 Autenticación accesible (mínimo)** — nuevo en 2.2: sin pruebas cognitivas; permitir pegar y gestores de contraseñas. Clave en verificación en dos pasos.

## Robusto
- 4.1.2 Nombre, función, valor: controles personalizados con role, nombre y estado.
- 4.1.3 Mensajes de estado: resultados, errores y avisos anunciados sin mover el foco.

## Atajos si hay código

Orientan la búsqueda; no sustituyen la revisión.

- `<img>` sin `alt`.
- `tabindex` con valor positivo.
- `<div>` o `<span>` con `onclick` sin `role` ni manejo de teclado.
- `outline: none` sin estilo de foco alternativo.
- `<input>` sin `<label>`, `aria-label` ni `aria-labelledby`.
- Clases de error que solo cambian el color.
- Mensajes de resultado sin `role="status"` / `aria-live`.

## Exenciones de 1.4.3 (no son hallazgos)

Logotipos y texto de marca, controles deshabilitados, texto puramente decorativo.

## Nativo

- iOS (HIG): Dynamic Type, etiquetas de VoiceOver, objetivos de 44×44 pt, Reduce Motion.
- Android (Material): TalkBack, `contentDescription`, objetivos de 48×48 dp, escalado de fuente.
