# Auditoría de accesibilidad · Botón «Firmar 250,00 €»

## 1. Estado de aprobación
**Pendiente de verificación** · 🔴 4 · Crítico: 0 · 🟠 3 · Mayor: 0 · 🟡 2 · Moderado: 0 · ⚪ 1 · Leve: 0
Motivo: no hay ningún incumplimiento A/AA confirmado en el fragmento, pero falta evidencia esencial para decidir 2.4.7 Foco visible, 1.4.11 Contraste no textual en estados y 3.3.4 Prevención de errores en una firma con dinero. La aprobación queda retenida hasta resolver la Evidencia necesaria.
Sin líneas rojas confirmadas.
Lo que el fragmento muestra está bien resuelto: botón nativo, nombre accesible con el importe y contraste del texto de 8,39:1. Lo que decide la aprobación (foco, estados, revisión previa y resultado de la firma) está fuera del fragmento.
Cumplimiento: firma de una operación con dinero. Si el servicio está en el ámbito de la Ley Europea de Accesibilidad (Directiva (UE) 2019/882; en España, Ley 11/2023), cualquier incumplimiento AA que aparezca al completar la evidencia es además riesgo normativo. Ámbito y obligación concretos: por confirmar con compliance.

## 2. Entrada, alcance y trazabilidad
- Tipo de entrada: HTML (fragmento de un elemento, con estilos en línea; sin CSS externo, sin formulario ni página que lo contenga)
- Plataforma: web (si se muestra dentro de una webview de app, aplica además 44×44 pt en iOS o 48×48 dp en Android)
- Alcance: 1 componente, el botón de envío de una firma de 250,00 €. No se ha entregado el resto del paso ni del flujo.
- Trazabilidad: fecha 2026-10-22 · skill auditing-accessibility 0.8.0 · objeto evaluado: fragmento HTML `<button type="submit" style="background:#1a4d8f;color:#fff;padding:12px 20px">Firmar 250,00 €</button>` facilitado en la conversación · responsable de la revisión: pendiente de asignar

## 3. Hallazgos
Sin hallazgos confirmados con la evidencia disponible.

Aspectos revisados en el fragmento:

| Criterio WCAG | Elemento | Evidencia | Resultado |
|---|---|---|---|
| 4.1.2 Nombre, función, valor | `button[type="submit"]` | Elemento `<button>` nativo: función «botón» y nombre «Firmar 250,00 €» por su contenido de texto | 🟢 0 · Sin problemas detectados |
| 2.5.3 Etiqueta en el nombre | `button[type="submit"]` | El nombre accesible coincide con el texto visible | 🟢 0 · Sin problemas detectados |
| 2.1.1 Teclado | `button[type="submit"]` | Botón nativo: enfocable y activable con Intro y Espacio por defecto. No hay `tabindex` negativo ni `disabled` | 🟢 0 · Sin problemas detectados (en el marcado; el comportamiento real está en No verificable) |
| 1.4.3 Contraste mínimo | Texto del botón | #ffffff sobre #1a4d8f = 8,39:1, calculado con `scripts/contraste.py`. Pasa 4,5:1 sea cual sea el tamaño de letra | 🟢 0 · Sin problemas detectados (estado por defecto) |
| 2.5.8 Tamaño del objetivo (mínimo) | `button[type="submit"]` | Con los estilos declarados y la letra por defecto del navegador para botones (~13,3 px): alto ≈ 39 px, ancho > 100 px. Supera 24×24 px | 🟢 0 · Sin problemas detectados (estimado; depende de que ningún CSS externo reduzca letra o relleno) |

## 5. No verificable
- Foco visible (2.4.7) — el estilo en línea no elimina el `outline`, pero el CSS global puede hacerlo (`outline: none`, resets). Hace falta la hoja de estilos aplicada o la página en vivo.
- Foco no oculto (2.4.11) — depende de la página: cabeceras fijas, banners o barras inferiores que tapen el botón al enfocarlo. Hace falta la página completa.
- Contraste de estados (1.4.3 y 1.4.11) — no hay estilos declarados para `:hover`, `:focus-visible`, `:active` ni estado de envío o desactivado. Hacen falta sus colores o tokens.
- Contraste del botón con el fondo de la página (1.4.11) — no se conoce el fondo. Como el texto identifica el control, no es un requisito para el botón; sí lo es para el indicador de foco.
- Prevención de errores en la firma (3.3.4) — el botón no permite saber si antes hay revisión y confirmación de importe, destinatario y concepto, si la operación se puede revertir o si se pueden corregir los datos. Hace falta el paso completo.
- Anuncio del resultado tras firmar (4.1.3) y gestión del foco tras el envío (2.4.3) — no se ha entregado el estado posterior.
- Lectura del importe — «250,00 €» se lee bien solo si la página declara `lang="es"` (3.1.1). Hace falta el elemento `<html>` y la prueba con lector de pantalla.
- Protección frente a doble activación y estado de procesamiento — riesgo de repetir la firma. El fragmento no muestra si el botón comunica «Enviando» ni si el servicio evita duplicados. Hace falta el comportamiento real y evidencia del servicio.
- Que el botón esté dentro de un `<form>` — un `type="submit"` fuera de un formulario no envía nada. Hace falta el marcado del paso.

## 6. Prueba con personas usuarias de tecnologías de apoyo
- Firmar solo con teclado: ¿se ve el foco en el botón en todo momento y no lo tapa ningún elemento fijo?
- Con lector de pantalla (VoiceOver, NVDA): ¿oye importe, destinatario y concepto antes de llegar al botón? ¿El botón se anuncia como «Firmar 250 euros, botón»? ¿Oye el resultado después de firmar sin tener que buscarlo?
- Con zoom al 200 % y ancho de 320 px: ¿el texto del botón cabe entero, sin cortar el importe?
- Doble pulsación rápida (teclado, ratón, táctil) en preproducción con datos sintéticos: ¿se crea una sola operación y se informa de que se está procesando?

## 7. Evidencia necesaria
| Qué falta exactamente | Criterio A/AA que permite decidir | Cómo resolverlo (conseguirla o implementarla) |
|---|---|---|
| Estilo de foco efectivo del botón con todo el CSS aplicado | 2.4.7 Foco visible · 1.4.11 Contraste no textual | Entregar la hoja de estilos o la URL de preproducción. Si no hay indicador, implementar `:focus-visible` con contorno ≥3:1 frente al botón y al fondo |
| Página completa del paso de firma | 2.4.11 Foco no oculto (mínimo) | Entregar la página en vivo o el HTML completo con cabeceras y elementos fijos |
| Colores de `:hover`, `:focus-visible`, `:active` y estado de envío | 1.4.3 Contraste mínimo · 1.4.11 Contraste no textual | Entregar los tokens de estado del componente y calcular cada par con el script |
| Resumen previo a la firma y vía de corrección o cancelación | 3.3.4 Prevención de errores (legales, financieros, datos) | Entregar el paso completo. Si no existe, implementar revisión con importe, destinatario y concepto en texto, y opción de volver a corregir antes de firmar |
| Estado de resultado tras pulsar el botón | 4.1.3 Mensajes de estado · 2.4.3 Orden del foco | Entregar el estado de éxito, rechazo y resultado no confirmado. En web, mensaje con `role="status"` o página nueva con foco en el resultado |
| Atributo `lang` de la página | 3.1.1 Idioma de la página | Comprobar `<html lang="es">` o el idioma que corresponda |

## 8. Observaciones
- Colores fijos en línea (`#1a4d8f`, `#fff`, `padding: 12px 20px`) — `button[type="submit"]` — sustituirlos por los tokens semánticos o de componente del botón primario del design system. Así los estados, el modo oscuro y el foco heredan valores ya validados.
- Importe en el nombre del botón — `button[type="submit"]` — buena práctica: repite lo que se firma en el punto de decisión. Mantenerlo y comprobar que el importe del botón sale del mismo dato que el resumen y la operación firmada.
