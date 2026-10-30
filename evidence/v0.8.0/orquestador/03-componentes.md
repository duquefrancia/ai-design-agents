# Componentes · Firma de transferencia con código SMS (Banco Lumen) · v0.8.0

**Fuentes:** `01-flujo.md` (casos E.. / X.., matriz de estados) · `02-historias.md` (HU-01 a HU-17) · `demo/caso-firma-operacion.md` · `demo/pantalla-firma.html` (uso actual) · **Fase:** 3
**Estado:** borrador para revisión de Design System, Tecnología y Accesibilidad. Hay decisiones bloqueadas por preguntas abiertas.
**Plataforma:** web móvil. **Criterios:** WCAG 2.2 AA. Apple HIG y Material 3 solo como referencia de convenciones.

## 0. Supuestos sobre el design system

No hay documentación del design system en el repositorio ni acceso a la librería de Figma para esta tarea (no se ha dado archivo). **No se ha buscado en Figma.** Todo lo que sigue sobre la API actual es supuesto.

| ID | Supuesto | Si es falso |
|---|---|---|
| DS1 | Existen tres componentes: **Botón** (solo variante primaria), **Campo de texto** y **Mensaje de alerta** (dato del reto). | Revisar la tabla de decisiones. |
| DS2 | El Botón no tiene estado `loading` ni protección contra doble activación. La pantalla actual solo cambia el texto a «Procesando...» y deja el botón activo. | Si existe, se reutiliza tal cual y baja a patch o nada. |
| DS3 | El Campo de texto admite etiqueta visible, texto de ayuda y mensaje de error ligados por `aria-describedby`. | Si no los admite, es un arreglo previo de accesibilidad, con impacto propio (ver 2.10). |
| DS4 | El Mensaje de alerta tiene variantes de severidad (al menos error) y no se sabe qué rol ARIA emite por defecto. | Se fija el comportamiento por defecto actual antes de añadir la propiedad `announce`. |
| DS5 | No existen en la librería: lista de datos, temporizador, panel de resultado ni diálogo. | Si existe alguno, se reutiliza y se borra su especificación de aquí. |
| DS6 | Los tokens existentes son desconocidos. Todos los nombres de token de este documento son **propuestas**, con su nivel (semántico o de componente). Ningún valor crudo es base de la especificación. | Se mapean a los tokens reales con el equipo de DS. |
| DS7 | La versión actual de la librería es desconocida. El impacto se da como tipo de cambio semver (major, minor, patch), no como número. | - |

**Acción previa obligatoria:** antes de construir nada de la sección 2 marcado como «nuevo», buscar en la librería de Figma y en código (diálogo, lista de datos, temporizador, botón secundario). Reutilizar antes que crear.

## 1. Decisiones

| Componente | Decisión | Motivo | Versión |
|---|---|---|---|
| **Botón** (Firmar, Continuar, acciones de resultado) | Variante | Se añaden `loading` con bloqueo de doble envío, variantes `secondary` y `tertiary`, e `iconOnly` para la flecha de volver. Todo con valores por defecto que no cambian el uso actual. | **minor** |
| **Campo de texto → código de un solo uso** | Variante | Un campo único con `type="otp"`: teclado numérico, `autocomplete="one-time-code"`, normalización al pegar y `readOnly` durante la firma. No se crea un componente de 6 casillas. | **minor** |
| **Mensaje de alerta** | Variante | Se reutiliza para errores X09-X12, sin conexión, reenvío fallido y ayuda de SMS. Se añaden `announce`, `actions` y `supportCode` (código técnico en segundo plano, X17). | **minor** (major si DS4 obliga a cambiar el rol por defecto) |
| **Lista de datos** (resumen antes de firmar y detalle del resultado) | Nuevo | No hay nada en el DS para pares etiqueta-valor. Se crea genérico, no «resumen de transferencia», para que sirva en otros flujos. Incluye valor copiable para la referencia. | **minor** |
| **Tiempo restante** | Nuevo | Ningún componente declarado muestra un tiempo que cambia, se recalcula con la hora del servidor y avisa solo en umbrales. Un texto suelto no cubre E09, E10 ni 2.2.1. | **minor** |
| **Resultado de operación** | Nuevo | Tres estados finales con foco en el título, frase obligatoria sobre el dinero y acciones distintas. El Mensaje de alerta es en línea y no cubre una pantalla final. | **minor** |
| **Diálogo de confirmación** (salir antes de firmar, E13) | Nuevo, condicionado a DS5 | Hace falta un modal accesible para «Si sales, la operación no se firma». Si la librería ya tiene diálogo, se reutiliza. | **minor** |
| Reenvío de código | Reutilizar (composición) | Botón `tertiary` con cuenta atrás + Mensaje de alerta. No justifica componente propio. | - (sin cambio propio) |
| Ayuda «¿No has recibido el código?» | Reutilizar (composición) | Botón `tertiary` con `aria-expanded` que muestra un Mensaje de alerta `info`. Hoy es un enlace a `#`. | - |
| Aviso sin conexión | Reutilizar | Mensaje de alerta `warning`, persistente. | - |
| Sesión caducada (X13) | Reutilizar | Mensaje de alerta + Botón primario «Iniciar sesión». El login es de otro equipo. | - |
| Teléfono enmascarado | No es componente | Regla de contenido: «terminado en 47», sin asteriscos (E06). | - |

**Publicación conjunta:** si todo sale en la misma versión de la librería, es **un minor**. Sube a **major** solo si se confirma alguno de los riesgos de la sección 9.

---

## 2. Botón (variante)

### 2.1 Propósito
Lanzar una acción. En este flujo: Continuar, Firmar, Enviar código nuevo, Comprobar estado, Ver movimiento, Nueva transferencia, Contactar, Copiar.

**Cuándo NO usarlo:**
- Para navegar a otra página sin acción: enlace.
- Para mostrar u ocultar contenido sin acción: sí se usa, pero con `aria-expanded` (patrón de ayuda).
- Para avisar de un estado: Mensaje de alerta.

### 2.2 Reutilizar antes de crear
Se parte del Botón primario existente (DS1). No se crea «botón de firma». La firma es un Botón primario con `loading`.

### 2.3 Anatomía
1. Contenedor (obligatorio).
2. Etiqueta (obligatoria; también en `iconOnly`, como nombre accesible).
3. Indicador de carga (solo en `loading`, decorativo).
4. Icono (opcional; obligatorio en `iconOnly`).
5. Anillo de foco (siempre que tenga foco).

### 2.4 Propiedades

| Propiedad | Tipo | Valores | Por defecto | Notas |
|---|---|---|---|---|
| `variant` | enum | `primary`, `secondary`, `tertiary` | `primary` | Nuevo: `secondary` y `tertiary`. Uno solo `primary` por vista. |
| `label` | string | texto | - | Obligatorio. |
| `loading` | boolean | `true`, `false` | `false` | Nuevo. Bloquea la activación. |
| `loadingLabel` | string | texto | `label` | Nuevo. «Firmando…», «Enviando código…», «Comprobando…». |
| `disabled` | boolean | `true`, `false` | `false` | Sin cambio. Desaconsejado en este flujo (ver 2.5). |
| `unavailableReason` | string | texto | - | Nuevo. Texto visible junto al botón cuando no está disponible (p. ej., cuenta atrás de reenvío). Se liga con `aria-describedby`. |
| `iconOnly` | boolean | `true`, `false` | `false` | Nuevo. Exige `label` para el nombre accesible. |
| `icon` | ref | icono de la librería | - | Opcional. |
| `fullWidth` | boolean | `true`, `false` | `false` | Para la acción principal en móvil. |
| `type` | enum | `button`, `submit` | `button` | Firmar es `submit` del formulario de código (Enter, E07). |

### 2.5 Estados

| Estado | Cambio visual (token) | Comportamiento | Interacción |
|---|---|---|---|
| default | `button.{variant}.background`, `button.{variant}.text` | - | Activable. |
| hover | `button.{variant}.background-hover` | Solo con puntero fino. | Activable. |
| focus | `color.focus.ring`, `border.width.focus`, `space.focus.offset` | Anillo visible, contraste 3:1 con el fondo y con el botón. Solo con `:focus-visible`. | Activable. |
| active | `button.{variant}.background-pressed` | Respuesta inmediata al toque. | - |
| disabled | `button.{variant}.background-disabled`, `button.{variant}.text-disabled` | Atributo `disabled`. No se usa para Firmar con el código incompleto: Firmar valida al pulsar (E05). | Ninguna. |
| unavailable | Igual que default con `color.text.secondary` en la etiqueta | `aria-disabled="true"`, sigue en el orden de foco, el motivo se ve (`unavailableReason`). Uso: reenvío en espera (E16). | Foco sí. Activación no. |
| loading | `button.{variant}.background` sin cambio; indicador con `button.{variant}.spinner` | Primer toque → `aria-disabled="true"` y `aria-busy="true"`. El componente ignora toques, Enter y Espacio mientras dure. La etiqueta pasa a `loadingLabel`. El ancho no cambia. El foco se queda en el botón. | Ninguna activación. |
| error | No aplica al botón | El error va en el Mensaje de alerta o en el campo. | - |

**Doble envío.** La guarda del componente evita la segunda petición desde la misma vista (E02, E17). No evita la de otra pestaña (E12) ni la repetición de red. Esa garantía es del servidor (**T1**). El componente no la sustituye.

**Fin de `loading`.** Lo decide la vista, no el componente. En Firmar, `loading` no se quita al vencer el umbral (**T3**): la vista pasa a Resultado «Pendiente de confirmar» (E18, X15).

### 2.6 Tokens (propuestos)

| Token | Nivel | Uso |
|---|---|---|
| `color.action.primary.background` / `-hover` / `-pressed` / `-disabled` | semántico | Fondo primario. |
| `color.action.primary.text` | semántico | Texto sobre primario. 4,5:1. |
| `color.action.secondary.border` | semántico | Borde secundario. 3:1 con el fondo. |
| `color.action.tertiary.text` | semántico | Texto terciario. 4,5:1 con la superficie. |
| `color.focus.ring` | semántico | Anillo de foco. 3:1. |
| `border.width.focus`, `space.focus.offset` | semántico | Grosor y separación del foco. |
| `button.{variant}.background`, `.text`, `.spinner` | componente | Alias de los semánticos. |
| `button.min-height` | componente | Remite a `size.target.comfortable` (semántico). Valor a fijar por DS con referencia HIG 44 pt y M3 48 dp. Nunca por debajo del mínimo de 2.5.8. |
| `motion.duration.spinner`, `motion.reduced` | semántico | Con `prefers-reduced-motion`, el indicador no gira: se muestra estático y la etiqueta basta. |

En la pantalla actual, el enlace de ayuda y el texto de ayuda usan grises claros y la flecha mide 20 × 20 px. Son motivos para fijar estos tokens, no la evaluación (va en `04` y `05`).

### 2.7 Contenido
- Etiqueta: 1 a 3 palabras, verbo al inicio. Mínimo 1 palabra.
- Máximo orientativo: dos líneas a 320 px. Se parte en dos líneas; **nunca se trunca**. Margen para un 30-40 % más en traducción.
- `loadingLabel` dice qué pasa («Firmando…»), no «Procesando...».
- No usar «Aceptar» en la firma. La etiqueta dice lo que se hace: «Firmar» o, a validar con Contenido, «Firmar transferencia».

### 2.8 Accesibilidad
- Rol `button` nativo. Nombre accesible = `label` (también en `iconOnly`: «Volver»).
- `loading`: `aria-disabled="true"` y `aria-busy="true"`, no `disabled`, para no perder el foco. El anuncio «Firmando. No cierres esta pantalla.» lo emite la vista en una región `role="status"` aparte. No se confía en que el lector lea el cambio de etiqueta.
- Teclado: Enter y Espacio activan. En `loading` y `unavailable`, no hacen nada.
- Objetivo táctil: `button.min-height` en todas las variantes, `tertiary` e `iconOnly` incluidos (hoy la flecha mide 20 px, por debajo de 24 px).
- Sin anuncio por cada segundo de cuenta atrás en `unavailableReason`.

### 2.9 Responsive
- Contenedor estrecho: `fullWidth` para la acción principal; secundarias apiladas debajo.
- Contenedor ancho: ancho del contenido, alineado según la plantilla.
- Sin barra fija inferior en P2: con teclado virtual y zoom al 400 % tapa el campo y el error (E08). Firmar va en el flujo del documento, pegado al campo.

### 2.10 Versión
**minor.** Propiedades nuevas con valores por defecto que mantienen el comportamiento actual. Riesgo: si hoy `disabled` se usa como «cargando», migrar a `loading` es cambio de uso, no de API.

---

## 3. Campo de texto · variante código de un solo uso

### 3.1 Propósito
Introducir el código de 6 dígitos del SMS para firmar.

**Cuándo NO usarlo:**
- PIN o contraseña persistente: campo de contraseña.
- Importes o números con formato: campo de texto con su variante numérica.
- No se usa con envío automático al sexto dígito (HU-03): la firma solo sale al pulsar Firmar.

### 3.2 Reutilizar antes de crear
Variante del Campo de texto existente. **No se crean 6 casillas separadas:** complican pegar, autocompletar y el lector de pantalla (6 campos, 6 etiquetas) sin aportar a la seguridad.

### 3.3 Anatomía
1. Etiqueta visible (obligatoria). Borrador: «Código del SMS (6 dígitos)».
2. Texto de ayuda (opcional). P. ej., «Te lo hemos enviado al móvil terminado en 47».
3. Contenedor e input.
4. Mensaje de error (condicional).
5. Anillo de foco.

El placeholder no sustituye a la etiqueta. Si se usa, no lleva información.

### 3.4 Propiedades

| Propiedad | Tipo | Valores | Por defecto | Notas |
|---|---|---|---|---|
| `type` | enum | `text`, …, `otp` | `text` | Nuevo valor `otp`. |
| `length` | number | entero | `6` en `otp` | Longitud esperada. **No** se traduce a `maxlength`: cortaría «123 456» al pegar. |
| `label` | string | texto | - | Obligatorio. |
| `helperText` | string | texto | - | Opcional. |
| `errorText` | string | texto | - | Activa el estado error. |
| `readOnly` | boolean | `true`, `false` | `false` | Durante la firma. |
| `disabled` | boolean | `true`, `false` | `false` | No se usa en este flujo. |
| `value` | string | dígitos | `""` | Normalizado. |
| `onComplete` | evento | - | - | Opcional. Solo para avisar a la vista; nunca para firmar. |

Atributos que emite `otp`: `inputmode="numeric"`, `autocomplete="one-time-code"`, `autocorrect="off"`, `spellcheck="false"`, `type="text"` (no `number`: quita ceros iniciales y añade flechas). WebOTP es opcional y depende de **T7**.

### 3.5 Estados

| Estado | Cambio visual (token) | Comportamiento | Interacción |
|---|---|---|---|
| default (vacío) | `field.border`, `field.background` | Etiqueta visible. | Escribir, pegar, autocompletar. |
| hover | `field.border-hover` | Solo puntero fino. | Igual. |
| focus | `color.focus.ring` + `field.border-focus` | Foco visible 3:1. Teclado numérico. | Igual. |
| filled | `field.text` con `typography.code` | Normaliza al escribir o pegar: quita espacios, guiones y todo lo que no sea dígito (E04). | Igual. |
| error | `field.border-error`, `color.feedback.error.text`, icono de error | `aria-invalid="true"`, error ligado por `aria-describedby`. Tras X09: foco al campo con el contenido seleccionado. | Corregir. El error se limpia al editar. |
| read-only (firmando) | `field.background-readonly` | `readOnly`; el valor sigue legible y enfocable. | Ninguna edición. |
| disabled | `field.background-disabled`, `field.text-disabled` | No se usa: quita el campo del orden de foco y oculta el valor. | Ninguna. |
| loading | No aplica al campo | La carga es del Botón. | - |

Comportamiento con la vista:
- Enter dentro del campo envía el formulario (= Firmar, E07).
- Validación local solo al pulsar Firmar: vacío, incompleto o con caracteres no válidos → «El código tiene 6 dígitos. Te faltan [n].» (E05). Nada se envía.
- Al volver desde la app de mensajes, el valor se conserva (E10).
- Tras reenvío correcto, la vista limpia el campo (E16).

### 3.6 Tokens (propuestos)

| Token | Nivel | Uso |
|---|---|---|
| `color.border.input` / `-hover` / `-focus` | semántico | Borde. 3:1 con el fondo (1.4.11). |
| `color.feedback.error.text`, `color.feedback.error.border` | semántico | Error. Texto 4,5:1. |
| `color.text.primary`, `color.text.secondary` | semántico | Valor y ayuda. 4,5:1. |
| `typography.label`, `typography.body.small` | semántico | Etiqueta, ayuda y error. El error no usa un cuerpo menor que la ayuda. |
| `typography.code` | semántico (nuevo) | Cifras tabulares y monoespaciadas. |
| `field.otp.letter-spacing` | componente (nuevo) | Separación de dígitos. Debe respetar 1.4.12. |
| `field.background-readonly` | componente (nuevo) | Fondo en firma. |

### 3.7 Contenido
- Etiqueta: mínimo «Código del SMS»; máximo una línea a 320 px con texto grande, si no cabe se parte.
- Ayuda: una frase.
- Error: una o dos frases. Dice qué pasa y qué hacer. Nunca un código técnico.
- Valor: exactamente `length` dígitos. A 320 px y con zoom, los 6 dígitos caben sin scroll horizontal.

### 3.8 Accesibilidad
- `<label for>` ligado. Ayuda y error en `aria-describedby`.
- Error tras pulsar Firmar: el texto se anuncia con `role="alert"` (lo emite el Mensaje de alerta o la región de error de la vista, una sola vez).
- Teclado: Tab entra y sale; Enter envía. Orden de la vista: campo, Firmar, reenviar, volver (E07).
- Objetivo táctil: altura de control ≥ `size.target.comfortable`.
- No se anuncia cada dígito de forma especial: el lector lee el valor como texto.

### 3.9 Responsive
- Ancho del contenedor a 320 px.
- Con teclado virtual abierto, la vista hace visible el campo y su error al enfocar; Firmar queda justo debajo (E08).
- Con texto grande, la etiqueta crece y se parte; el input crece en alto.

### 3.10 Versión
**minor.** Nuevo valor de `type`. Si el Campo de texto actual no ata etiqueta, ayuda y error (DS3 falso), arreglarlo es **patch** si no cambia la API y **major** si `label` pasa a ser obligatorio.

---

## 4. Mensaje de alerta (variante)

### 4.1 Propósito
Comunicar en línea un error, un aviso o una confirmación que el usuario debe leer, con su acción.

**Cuándo NO usarlo:**
- Estado final de la operación: Resultado de operación.
- Error de un solo campo que cabe junto a él: `errorText` del campo. Excepción: errores de firma con consecuencia (caducado, intentos), que llevan Mensaje de alerta y acción.
- Avisos que se cierran solos (toast): no en flujos con dinero.

### 4.2 Reutilizar antes de crear
Se reutiliza el existente. Cubre: X07, X08, X09-X12, X14, ayuda de SMS (X06), «Código enviado» (E16), sesión caducada (X13), sin conexión.

### 4.3 Anatomía
1. Contenedor con severidad.
2. Icono de severidad (obligatorio; el color no es la única pista).
3. Título (opcional).
4. Cuerpo (obligatorio).
5. Acciones (opcional, Botones `secondary` o `tertiary`).
6. Código para soporte (opcional, texto secundario).

### 4.4 Propiedades

| Propiedad | Tipo | Valores | Por defecto | Notas |
|---|---|---|---|---|
| `severity` | enum | `info`, `success`, `warning`, `error` | `info` | Supuesto DS4: confirmar las existentes. |
| `title` | string | texto | - | Opcional. |
| `body` | string | texto | - | Obligatorio. |
| `announce` | enum | `none`, `polite`, `assertive` | **el comportamiento actual** | Nuevo. `polite` → `role="status"`; `assertive` → `role="alert"`. |
| `actions` | slot | 0-2 Botones | - | Nuevo. |
| `supportCode` | string | texto | - | Nuevo. «Código para soporte: 4012». Nunca solo (X17). |
| `persistent` | boolean | `true`, `false` | `true` | Sin botón de cerrar en este flujo. |

### 4.5 Estados

| Estado | Cambio visual (token) | Comportamiento | Interacción |
|---|---|---|---|
| default | `color.feedback.{severity}.background`, `.border`, `.icon`, `color.text.primary` | Se muestra al ocurrir el evento, no al cargar la pantalla (hoy carga con «Error 4012»). | Leer, acciones. |
| hover / active | En las acciones (Botón) | - | - |
| focus | En las acciones (Botón) | El contenedor no recibe foco salvo que la vista lo mande (errores sin campo, X11). | - |
| disabled | No aplica | - | - |
| loading | Acción en `loading` (p. ej., «Enviar código nuevo») | El mensaje no cambia hasta la respuesta. | - |
| error | Es `severity="error"` | - | - |

Mapa de uso en P2 (textos: borradores de `01-flujo.md`):

| Caso | `severity` | `announce` | Acción |
|---|---|---|---|
| X09 código incorrecto | error | assertive | - (foco al campo) |
| X10 código antiguo | error | assertive | - |
| X12 caducado | error | assertive | «Enviar código nuevo» o «Empezar de nuevo» (**N2**) |
| X11 intentos agotados | Pasa a Resultado «No realizada» | - | - |
| X14 sin conexión al firmar / aviso sin conexión | warning | polite | - |
| E16 código enviado | success | polite | - |
| X07 reenvío fallido | error | assertive | «Reintentar» |
| X08 límite de reenvíos | warning | polite | «[Siguiente paso — N7]» |
| X06 ayuda SMS | info | none (se abre por acción del usuario) | Reenviar, contactar (**N7**), otro canal (**N9**) |
| X13 sesión caducada | warning | assertive | «Iniciar sesión» |

### 4.6 Tokens (propuestos)

| Token | Nivel | Uso |
|---|---|---|
| `color.feedback.{info,success,warning,error}.background` | semántico | Fondo. |
| `color.feedback.{…}.border`, `.icon` | semántico | Borde e icono. 3:1. |
| `color.text.primary` | semántico | Cuerpo. 4,5:1 sobre el fondo de feedback. |
| `color.text.secondary` | semántico | `supportCode`. 4,5:1. |
| `alert.space.inset`, `alert.radius` | componente | Alias de `space.inset.m`, `radius.container`. |

### 4.7 Contenido
- Cuerpo: una o dos frases. Qué pasó, si se movió dinero cuando aplique, qué hacer.
- Título: máximo una línea a 320 px; si no cabe, se parte. Nunca se trunca.
- Sin códigos técnicos en título ni cuerpo. El código va en `supportCode`.
- Margen del 30-40 % en traducción: el contenedor crece en alto.

### 4.8 Accesibilidad
- La región viva (`role="status"` o `role="alert"`) debe existir en el DOM **antes** de inyectar el texto; si no, algunos lectores no lo anuncian. Pendiente de verificar en dispositivo.
- Un solo anuncio por evento. No se combina `role="alert"` del mensaje con otro anuncio del campo.
- El icono es decorativo si el título o el cuerpo nombran la severidad; si no, lleva texto oculto («Error:»).
- Acciones: objetivo táctil de Botón.

### 4.9 Responsive
Ancho del contenedor. Acciones apiladas en contenedor estrecho, en línea en ancho.

### 4.10 Versión
**minor** si `announce` mantiene por defecto el rol actual. **major** si para cumplir hay que cambiar el rol por defecto (p. ej., quitar `role="alert"` a todos los avisos): rompe anuncios en otras pantallas.

---

## 5. Lista de datos (nuevo)

### 5.1 Propósito
Mostrar pares etiqueta-valor de solo lectura. Aquí: resumen antes de firmar (HU-03, 3.3.4) y detalle del resultado (HU-10, E19).

**Cuándo NO usarlo:**
- Datos editables: campos de formulario.
- Datos tabulares con varias columnas: tabla.
- Listas de movimientos: componente de lista (fuera de alcance).

### 5.2 Reutilizar antes de crear
No hay equivalente declarado (DS5). Se crea genérico, no ligado a transferencias, para que lo use cualquier confirmación del banco.

### 5.3 Anatomía
1. Contenedor (`<dl>`).
2. Título del grupo (opcional, encabezado).
3. Fila: etiqueta (`<dt>`).
4. Fila: valor (`<dd>`).
5. Acción de fila (opcional): Botón `tertiary` «Copiar».

### 5.4 Propiedades

| Propiedad | Tipo | Valores | Por defecto | Notas |
|---|---|---|---|---|
| `title` | string | texto | - | Opcional. P. ej., «Vas a firmar». |
| `headingLevel` | number | 2-4 | `2` | Según la vista. |
| `items[]` | lista | `{label, value, format, copyable}` | - | Obligatorio, 1 o más. |
| `items[].format` | enum | `text`, `amount`, `account`, `reference`, `date` | `text` | Formato de presentación. |
| `items[].copyable` | boolean | `true`, `false` | `false` | Añade «Copiar». |
| `layout` | enum | `stacked`, `inline` | `stacked` | `inline` solo si el contenedor lo permite. |
| `emphasis` | enum | `none`, `amount` | `none` | Resalta el importe. |

Formatos:
- `amount`: formato local es-ES con moneda. Lo da el servidor o la librería de formato; el componente no calcula.
- `account`: cómo se muestra la cuenta de destino (completa, enmascarada, con titular) es **pregunta abierta**. No se decide aquí.
- `reference`: se muestra agrupada para leerla (E19); «Copiar» copia los dígitos sin espacios. El tamaño de grupo es decisión de Contenido.

### 5.5 Estados

| Estado | Cambio visual (token) | Comportamiento | Interacción |
|---|---|---|---|
| default | `color.text.secondary` etiqueta, `color.text.primary` valor | Solo lectura. Texto seleccionable. | Leer, seleccionar, copiar. |
| hover / focus / active | En «Copiar» (Botón) | - | - |
| copiado | Etiqueta del botón pasa a «Copiada» durante un tiempo de feedback | Anuncio `role="status"`: «Referencia copiada». | - |
| error al copiar | Mensaje en línea | «No se ha podido copiar. Selecciona el texto.» El valor sigue seleccionable. | Seleccionar a mano. |
| loading | `skeleton` con `color.surface.placeholder` | Solo si el dato llega tarde. En P2 el resumen no se muestra a medias: sin datos completos, no hay Firmar. | Ninguna. |
| disabled | No aplica | - | - |

### 5.6 Tokens (propuestos)

| Token | Nivel | Uso |
|---|---|---|
| `color.text.primary`, `color.text.secondary` | semántico | Valor y etiqueta. 4,5:1. |
| `typography.body`, `typography.label`, `typography.code` | semántico | `typography.code` para referencia y cuenta. |
| `typography.amount.emphasis` | semántico (nuevo) | Importe resaltado. |
| `color.border.subtle` | semántico | Separador entre filas (decorativo, sin requisito de contraste). |
| `datalist.space.row` | componente (nuevo) | Separación entre filas. |

### 5.7 Contenido
- Etiqueta: 1-3 palabras («Destino», «Importe», «Concepto», «Referencia»).
- Valor: sin truncar. Nombres de titular largos y concepto se parten en líneas (`overflow-wrap: anywhere` solo en `reference` y `account`). Longitud máxima del concepto: **N8**.
- Valor vacío: no se muestra la fila; un «—» no informa en un resumen de firma.

### 5.8 Accesibilidad
- `<dl>`, `<dt>`, `<dd>`. El lector anuncia los pares.
- Orden de lectura en P2: resumen antes que el campo (HU-03).
- «Copiar» con nombre accesible completo: «Copiar referencia».
- Lectura de la referencia agrupada: comprobar en VoiceOver y TalkBack cómo suena (puede leerse como números grandes). **Sin verificar.**

### 5.9 Responsive
- `stacked`: etiqueta encima del valor. Por defecto en móvil y a 320 px.
- `inline`: etiqueta a la izquierda, valor a la derecha, solo con contenedor ancho. Con zoom o texto grande vuelve a `stacked` (consulta de contenedor).

### 5.10 Versión
**minor.** Componente nuevo, no afecta a nadie.

---

## 6. Tiempo restante (nuevo)

### 6.1 Propósito
Mostrar cuánto queda para que caduque el código y avisar cuando queda poco, sin interrumpir (E09, E10, HU-07).

**Cuándo NO usarlo:**
- Duraciones que no caducan nada: texto.
- Cuenta atrás del botón de reenvío: `unavailableReason` del Botón.
- Sesión: es otro tiempo, con otro aviso (**N5**).

### 6.2 Reutilizar antes de crear
Ningún componente declarado lo cubre. Un texto fijo («caduca en 0:45», como hoy) no se recalcula ni avisa.

### 6.3 Anatomía
1. Contenedor.
2. Icono de reloj (opcional, decorativo).
3. Texto visible: «El código caduca en m:ss».
4. Región viva oculta para los avisos de umbral.

Sin barra de progreso: no aporta y añade movimiento.

### 6.4 Propiedades

| Propiedad | Tipo | Valores | Por defecto | Notas |
|---|---|---|---|---|
| `expiresAt` | fecha-hora | ISO del servidor | - | Obligatorio. La cuenta atrás se calcula contra la hora del servidor (**T6**). |
| `serverOffset` | number | ms | `0` | Diferencia reloj local - servidor. |
| `warnAt` | lista de number | segundos | **`<pendiente N2>`** | Umbrales de aviso. Sin valor hasta que N2 responda. |
| `state` | enum | `running`, `warning`, `expired`, `paused` | calculado | `paused` solo durante la firma. |
| `onExpire` | evento | - | - | La vista muestra la alerta X12 y la acción de código nuevo. |

### 6.5 Estados

| Estado | Cambio visual (token) | Comportamiento | Interacción |
|---|---|---|---|
| default (`running`) | `color.text.secondary` | Actualiza el texto cada segundo. Sin anuncio. | Ninguna. |
| `warning` | `color.feedback.warning.text` + icono | Al cruzar un umbral de `warnAt`: un anuncio `role="status"` («Te quedan [n] segundos»). Uno por umbral. | Ninguna. |
| `expired` | `color.feedback.error.text` + icono | Texto: «El código caducó a las [hh:mm]». Llama a `onExpire`. Anuncio `role="status"`. | La vista ofrece el código nuevo. |
| `paused` (firmando) | Sin cambio | No pasa a `expired` mientras hay una firma en curso; el servidor decide. | - |
| hover / focus / active / disabled | No aplica (no interactivo) | - | - |
| loading | Texto «Calculando…» | Hasta conocer `expiresAt` (recarga, E11). | - |
| error | Sin hora del servidor | Muestra la hora de caducidad sin cuenta atrás. A decidir con Tecnología (**T6**). | - |

Al volver a la pestaña (`visibilitychange`), recalcula. No reanuda desde el valor congelado (E10).

### 6.6 Tokens (propuestos)

| Token | Nivel | Uso |
|---|---|---|
| `color.text.secondary` | semántico | Estado normal. 4,5:1 (hoy el temporizador usa un gris claro de 12 px). |
| `color.feedback.warning.text`, `color.feedback.error.text` | semántico | Aviso y caducado. 4,5:1. |
| `typography.body.small` + `font.feature.tabular` | semántico | Cifras tabulares para que el texto no baile. |
| `timer.icon.color` | componente (nuevo) | Alias de feedback según estado. |

### 6.7 Contenido
- Formato visible: m:ss. El anuncio usa palabras («45 segundos», «1 minuto»).
- Una línea a 320 px; con texto grande, dos.
- El cambio de estado nunca depende solo del color: el texto y el icono cambian.

### 6.8 Accesibilidad
- El texto visible no es región viva: no se anuncia cada segundo.
- Avisos solo en umbrales, por la región `role="status"` oculta y ya presente en el DOM.
- **2.2.1:** la caducidad por seguridad puede ser excepción, pero la vía para obtener más tiempo (código nuevo en un toque) debe existir. A validar con Accesibilidad (hipótesis de E09).
- No se coloca `role="timer"` con `aria-live` activo.
- Comprobar en VoiceOver y TalkBack que el umbral se oye una vez. **Sin verificar.**

### 6.9 Responsive
Va pegado al campo de código, visible con el teclado abierto (E08). Sin cambios por breakpoint.

### 6.10 Versión
**minor.** Componente nuevo.

---

## 7. Resultado de operación (nuevo)

### 7.1 Propósito
Decir sin ambigüedad cómo ha terminado la operación y qué hacer: **Realizada**, **No realizada** o **Pendiente de confirmar** (HU-10, HU-11, HU-12).

**Cuándo NO usarlo:**
- Errores recuperables dentro de P2 (X09, X10, X12): Mensaje de alerta.
- Confirmaciones sin dinero ni datos sensibles: Mensaje de alerta `success`.

### 7.2 Reutilizar antes de crear
El Mensaje de alerta es en línea, no gestiona foco de página ni acciones finales. Se crea como **componente de vista** que compone Lista de datos, Mensaje de alerta y Botón. Es genérico para operaciones firmadas, no solo transferencias.

### 7.3 Anatomía
1. Icono de estado (obligatorio, con forma distinta por estado).
2. Título `h1` (obligatorio, recibe el foco).
3. Frase sobre el dinero (obligatoria): «Hemos enviado…», «No se ha movido dinero», «Aún no sabemos si se ha hecho. No vuelvas a firmar».
4. Motivo (opcional; solo `failed` y si **T5** lo permite).
5. Lista de datos: importe, destino, fecha, referencia copiable.
6. Hora de la última comprobación (solo `pending` y sin conexión).
7. Acciones: una primaria y hasta dos secundarias.
8. Código para soporte (opcional).

### 7.4 Propiedades

| Propiedad | Tipo | Valores | Por defecto | Notas |
|---|---|---|---|---|
| `status` | enum | `done`, `failed`, `pending`, `checking` | - | Obligatorio. Nombres en código; en Figma: Realizada, No realizada, Pendiente de confirmar, Comprobando. |
| `title` | string | texto | según `status` | Mensaje base de `01-flujo.md`; copy final de Contenido. |
| `moneyStatement` | string | texto | según `status` | Obligatorio. El componente no se renderiza sin él. |
| `reason` | string | texto | - | Solo `failed`. **T5.** |
| `details` | Lista de datos | - | - | Referencia siempre presente. |
| `lastCheckedAt` | fecha-hora | - | - | `pending` y sin conexión. |
| `actions` | slot | Botones | según `status` | Ver tabla. |
| `supportCode` | string | texto | - | Segundo plano. |

Acciones por estado (salidas de `01-flujo.md`):

| `status` | Primaria | Secundarias | Prohibido |
|---|---|---|---|
| `done` | Ver movimiento (**T2**) | Nueva transferencia | Firmar |
| `failed` | Corregir y empezar de nuevo | Contactar (**N7**) | Firmar la misma operación |
| `pending` | Comprobar estado (**T2**) | Ver movimientos, Contactar con la referencia (**N7**) | **Firmar** (X16) |
| `checking` | - | Contactar (**N7**) | Firmar |

La regla «nunca Firmar» la aplica la vista y la valida la revisión de DS. El componente no acepta una acción con `type="submit"` de firma en ningún estado.

### 7.5 Estados

| Estado | Cambio visual (token) | Comportamiento | Interacción |
|---|---|---|---|
| default (`done`) | `result.icon.done` sobre `color.feedback.success.*` | Foco en el título al montar. | Acciones. |
| `failed` | `result.icon.failed`, `color.feedback.error.*` | Igual. | Acciones. |
| `pending` | `result.icon.pending`, `color.feedback.warning.*` | Igual. Consulta automática limitada (límite **sin definir**, N3/T2). | Comprobar estado. |
| loading (`checking`) | Indicador decorativo | `role="status"`: «Comprobando el estado de tu transferencia…». Sin botón de firmar. | Esperar o contactar. |
| sin conexión | `Mensaje de alerta warning` encima | Muestra el último estado conocido con `lastCheckedAt`. `done` no cambia nunca a otro estado. | Comprobar estado al volver la red. |
| hover / focus / active | En acciones y «Copiar» (Botón) | - | - |
| disabled | No aplica | - | - |
| error | No es un estado del componente | Un error desconocido es `pending`, no `failed` (HU-11). | - |

Atrás o recarga (E14): la vista vuelve a mostrar el mismo resultado. El componente no guarda estado; lo pide por referencia (**T2**).

### 7.6 Tokens (propuestos)

| Token | Nivel | Uso |
|---|---|---|
| `color.feedback.{success,error,warning}.icon`, `.background` | semántico | Icono y fondo del estado. Icono 3:1. |
| `color.text.primary` | semántico | Título y frase del dinero. 4,5:1. |
| `typography.heading.page` | semántico | Título. |
| `result.icon.size` | componente (nuevo) | Tamaño del icono. |
| `result.space.stack` | componente (nuevo) | Separación entre bloques. |

### 7.7 Contenido
- Título: corto, el estado en palabras. Mínimo 2 palabras. Se parte en líneas; no se trunca.
- Frase del dinero: una frase. Siempre dice si se movió dinero o que no se sabe.
- `pending` nunca dice «error» ni «éxito», ni promete que se ejecutará o cancelará (**N3**).
- Plazo para saber el resultado en `pending`: **`<pendiente N3>`**.
- Traducciones: el título puede pasar a 3 líneas a 320 px; las acciones se apilan.

### 7.8 Accesibilidad
- Foco programático en el `h1` (`tabindex="-1"`) al montar y al cambiar de `checking` a un estado final. Se anuncia el estado (E19).
- El estado no depende solo del color: icono con forma distinta + texto.
- Iconos decorativos (`aria-hidden`), el título nombra el estado.
- Referencia en bloque aparte, copiable (Lista de datos).
- Orden: título, frase del dinero, motivo, detalle, acciones.
- Anuncio real **sin verificar** en dispositivo.

### 7.9 Responsive
- Contenedor estrecho: todo apilado, primaria a ancho completo.
- Contenedor ancho: Lista de datos en `inline` si cabe.
- Reflow a 320 px sin scroll horizontal; la referencia se parte por grupos.

### 7.10 Versión
**minor.** Componente nuevo.

---

## 8. Diálogo de confirmación (nuevo, condicionado)

**Condición:** solo si la librería no tiene diálogo (DS5). Si lo tiene, se reutiliza y esta sección se reduce al contenido de E13.

### 8.1 Propósito
Pedir confirmación antes de una acción que hace perder progreso. Aquí: salir de P2 sin firmar (E13).

**Cuándo NO usarlo:**
- Para confirmar la firma: la confirmación es el resumen + Firmar (HU-03). Un diálogo extra añade un paso sin aportar.
- Para informar: Mensaje de alerta.

### 8.2 Reutilizar antes de crear
Buscar primero en la librería y en código. Base técnica propuesta: elemento `<dialog>` nativo con `showModal()`.

### 8.3 Anatomía
1. Fondo (scrim).
2. Contenedor.
3. Título (obligatorio).
4. Cuerpo (obligatorio).
5. Acción de permanecer (Botón `primary`).
6. Acción de salir (Botón `secondary`).

### 8.4 Propiedades

| Propiedad | Tipo | Valores | Por defecto | Notas |
|---|---|---|---|---|
| `open` | boolean | `true`, `false` | `false` | - |
| `title` | string | texto | - | «¿Salir sin firmar?» (borrador). |
| `body` | string | texto | - | «Si sales, la operación no se firma. Tus datos se conservan.» |
| `confirmLabel` | string | texto | - | «Salir». |
| `cancelLabel` | string | texto | - | «Seguir con la firma». |
| `defaultAction` | enum | `cancel`, `confirm` | `cancel` | La opción segura recibe el foco. |

### 8.5 Estados

| Estado | Cambio visual (token) | Comportamiento | Interacción |
|---|---|---|---|
| default (abierto) | `color.surface.overlay`, `color.scrim` | Foco en la acción segura. Fondo inerte. | Botones, Escape. |
| hover / focus / active | En los Botones | Foco atrapado dentro. | - |
| loading | Botón «Salir» en `loading` si salir requiere llamada | - | - |
| disabled / error | No aplica | - | - |
| cerrado | - | El foco vuelve al control que lo abrió (la flecha). | - |

Limitación: la flecha del navegador no permite un diálogo propio fiable (`beforeunload` solo da el aviso genérico del navegador). Cómo tratar el atrás del navegador es decisión de Tecnología. Qué pasa con el código al salir: **N2**.

### 8.6 Tokens (propuestos)
`color.surface.overlay` (semántico), `color.scrim` (semántico), `dialog.radius`, `dialog.space.inset`, `dialog.max-width` (componente), `elevation.overlay` (semántico).

### 8.7 Contenido
Título: una línea, pregunta. Cuerpo: una o dos frases. Botones: verbo; nunca «Sí» / «No».

### 8.8 Accesibilidad
`role="dialog"` (nativo) con `aria-modal="true"`, `aria-labelledby` al título y `aria-describedby` al cuerpo. Escape = acción segura. Tab y Mayús+Tab dentro. Objetivos de Botón.

### 8.9 Responsive
Estrecho: ancho casi completo, botones apilados, la acción segura primero. Ancho: centrado con `dialog.max-width`. Con zoom al 400 %, el contenido hace scroll dentro del diálogo.

### 8.10 Versión
**minor.** Componente nuevo.

---

## 9. Riesgos de versión

| Riesgo | Sube a | Cómo evitarlo |
|---|---|---|
| El Campo de texto no ata etiqueta y hay que hacer `label` obligatorio (DS3). | major | Mantener `label` opcional con aviso en desarrollo y migrar antes de exigirlo. |
| El Mensaje de alerta emite `role="alert"` por defecto y hay que cambiarlo (DS4). | major | Mantener el por defecto actual y fijar `announce` en cada uso nuevo. |
| Cambiar el aspecto por defecto del Botón primario para cumplir contraste o foco. | patch si es corrección de accesibilidad sin cambio de API; anunciar en el changelog. | - |

## 10. Composición en P2 (orden de foco y lectura)

1. Título «Firma de la operación» (foco al llegar).
2. Lista de datos: destino, importe, concepto, referencia.
3. Texto: «Te hemos enviado un código al móvil terminado en 47».
4. Campo código de un solo uso.
5. Tiempo restante.
6. Mensaje de alerta (si hay).
7. Botón primario Firmar (`loading`).
8. Botón `tertiary` Reenviar (con `unavailableReason` en la espera, **N4**).
9. Botón `tertiary` «¿No has recibido el código?» (`aria-expanded`) → Mensaje de alerta `info`.
10. Volver (Botón `iconOnly` en la cabecera) → Diálogo de confirmación.

Nota: el orden de foco de `01-flujo.md` es campo, Firmar, reenviar, volver. La flecha está en la cabecera, antes en el DOM. Decidir con Accesibilidad si se mantiene en la cabecera (convención) o se acepta que el orden de Tab empiece por ella.

## Preguntas abiertas

| ID | Pregunta | Afecta a |
|---|---|---|
| DS1-DS7 | Confirmar con el equipo de DS la API, tokens y versión actuales. Acceso a la librería de Figma para buscar antes de crear. | Todo |
| N1 | Intentos y si se muestran. | Mensaje de alerta X09; paso a Resultado `failed` (X11). |
| N2 | Duración del código, umbrales de aviso, si hay reenvío y qué pasa al salir o caducar. | Tiempo restante (`warnAt`), acción de X12, Diálogo (E13). |
| N3 | Qué pasa tras un corte después de firmar y en cuánto se sabe. | Resultado `pending`: texto, plazo, límite de consulta automática. |
| N4 | Espera y máximo de reenvíos. | Botón `unavailableReason`, alerta X08. |
| N5 | Duración de la sesión. | Si hace falta un aviso de sesión aparte del Tiempo restante. |
| N7 | Canal de contacto. | Acciones «Contactar» en Resultado y alertas. Sin N7, X08, X11 y `pending` sin resolver no tienen salida. |
| N8 | Longitud del concepto. | Lista de datos: contenido máximo. |
| N9 | Otro canal si el SMS no llega. | Ayuda de SMS. |
| T1 | Idempotencia de la firma. | El `loading` del Botón no basta sin ella. |
| T2 | Consulta por referencia y pantalla de movimientos. | Resultado: «Comprobar estado», «Ver movimiento», recarga. |
| T3 | Umbral de espera de la firma. | Cuándo la vista pasa de `loading` a Resultado `pending`. |
| T5 | Catálogo de errores y motivos mostrables. | `reason` y `supportCode`; qué va a `failed` y qué a `pending`. |
| T6 | Hora del servidor para la caducidad. | Tiempo restante: `expiresAt`, `serverOffset`, estado de error. |
| T7 | Soporte de `one-time-code` y WebOTP. | Campo código de un solo uso. |
| C1 | Cómo se muestra la cuenta de destino (completa, enmascarada, con titular). Pregunta nueva. | Lista de datos `format="account"`. |
| C2 | Tamaño de grupo de la referencia de 19 dígitos y cómo la lee el lector. Pregunta nueva. | Lista de datos `format="reference"`. |
| A1 | Si el resumen en P2 + Firmar cumple 3.3.4 (S3) y si la caducidad es excepción de 2.2.1. | Lista de datos en P2, Tiempo restante. |
| A2 | Posición de la flecha de volver en el orden de foco. | Composición P2. |

## Límites

- No se ha consultado la librería de Figma ni el código del design system: no había acceso indicado.
- Ningún token tiene valor. Son nombres propuestos con su nivel.
- Los textos son borradores de `01-flujo.md`, no copy aprobado.
- Anuncios de lector de pantalla sin verificar en dispositivo.
- Este documento no evalúa la pantalla actual. Eso va en `04` y `05`.
