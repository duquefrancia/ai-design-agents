# Auditoría de accesibilidad · Alta de cuenta: consentimientos de marketing

## 1. Estado de aprobación
**Pendiente de verificación** · 🔴 4 · Crítico: 0 · 🟠 3 · Mayor: 0 · 🟡 2 · Moderado: 0 · ⚪ 1 · Leve: 0
Motivo: la entrada es una descripción verbal. No permite confirmar ni descartar ningún criterio A/AA de las casillas ni del botón. La aprobación queda retenida hasta resolver la Evidencia necesaria (sección 7).
Líneas rojas: ninguna confirmada. Ninguna es verificable con esta entrada.
Lo grave de esta pantalla no es WCAG: las tres casillas premarcadas son un riesgo de producto 🟠 3 · Mayor [legal] (sección 4). Una casilla premarcada no incumple por sí sola ningún criterio WCAG, así que no se presenta como hallazgo. Ese riesgo no cambia este estado de aprobación; si bloquea la aprobación general lo decide el orquestador o el quality gate de producto.
Cumplimiento: si la base jurídica del marketing es el consentimiento, el RGPD exige acción afirmativa y las casillas premarcadas no lo acreditan. Si la cuenta es de un servicio bancario para consumidores, aplica además la EAA / Ley 11/2023. Ámbito y conclusión jurídica: por confirmar con compliance.

## 2. Entrada, alcance y trazabilidad
- Tipo de entrada: descripción (texto en la conversación). Solo permite señalar riesgos potenciales.
- Plataforma: no indicada. Se audita contra WCAG 2.2 AA; si es nativa, aplica por analogía junto con Apple HIG (44×44 pt) o Material (48×48 dp).
- Alcance: 1 pantalla, paso de consentimientos del alta de cuenta. No se conocen los pasos anterior y siguiente.
- Contexto: hay tratamiento de datos personales. Se aplica la lente 3 (patrones oscuros) y la 4 (lenguaje) de producto regulado, y el caso 4 de banca solo como guía de pruebas. No consta si el producto es bancario ni la jurisdicción.
- Trazabilidad: fecha 2026-10-22 · skill auditing-accessibility 0.8.0 · objeto evaluado: descripción «en el alta de cuenta, las tres casillas de consentimiento de marketing vienen marcadas por defecto y el botón dice "Continuar"» · responsable de la revisión: pendiente de asignar

## 3. Hallazgos
Ningún hallazgo WCAG confirmado. La descripción no aporta marcado, colores, tamaños ni comportamiento.

## 4. Riesgos de producto (fuera de WCAG)
No son incumplimientos WCAG y no cambian el estado de aprobación de accesibilidad. Si bloquean la aprobación general lo decide el orquestador o el quality gate de producto.

| # | Lente | Elemento | Evidencia | Severidad | Categoría de riesgo | Arreglo |
|---|---|---|---|---|---|---|
| 1 | 3 · Patrones oscuros | Las tres casillas de consentimiento de marketing | Vienen marcadas por defecto: quien no actúa queda registrado como si consintiera tres finalidades opcionales. Cadena: casilla premarcada → la persona no decide → tratamiento de datos no deseado. Afecta a cada alta. | 🟠 3 · Mayor [legal] | Legal o normativo | Casillas desmarcadas por defecto; cada finalidad se elige por separado y continuar sin marcar ninguna no bloquea el alta [rápido]. Compliance valida finalidades y base jurídica, y que lo registrado coincide con lo elegido [estructural]. |
| 2 | 4 · Lenguaje del sector | Botón «Continuar» | El botón no dice que al pulsarlo se registran los consentimientos marcados. Junto con el riesgo 1, avanzar equivale a aceptar sin saberlo. | 🟡 2 · Moderado | Privacidad y datos personales | Que el texto junto al botón o la confirmación posterior diga qué preferencias quedan guardadas y dónde cambiarlas; con casillas desmarcadas por defecto, «Continuar» deja de ser ambiguo [rápido]. |

Severidad del riesgo 1: ancla «consentimiento premarcado → Mayor mínimo [legal]». No se sube a Crítico por el factor de consecuencia porque el ancla ya recoge ese daño.

Preguntas abiertas para producto y compliance (no se dan por supuestas):
- ¿Cuáles son las tres finalidades y su base jurídica?
- ¿Se puede retirar cada consentimiento tan fácil como se dio, y dónde?
- ¿Qué se registra si la persona desmarca y vuelve atrás?

## 5. No verificable
- Nombre accesible, función y estado (marcada / no marcada) de cada casilla — la descripción no aporta marcado — hace falta HTML o build nativa.
- Etiqueta visible de cada casilla y su asociación al control — no se conoce el texto — hace falta captura y código.
- Agrupación de las tres casillas con un título común — sin marcado — hace falta HTML (`fieldset`/`legend` o `role="group"` con nombre).
- Uso solo con teclado y foco visible en casillas, enlaces a la política y botón — sin comportamiento — hace falta prototipo navegable o build.
- Contraste del borde y la marca de la casilla en todos los estados, también dark mode — sin colores — hacen falta tokens.
- Tamaño de objetivo de casillas y botón — sin medidas — hace falta Figma o build.
- Nombre accesible del botón y coincidencia con «Continuar» — sin marcado — hace falta código.
- Errores del formulario de alta y su anuncio — no descritos — hace falta el flujo completo.
- Si al alta le aplica 3.3.4 (compromiso legal o datos controlados por la persona) y si hay revisión o corrección posterior — sin el flujo — hace falta el paso siguiente y la confirmación.

## 6. Prueba con personas usuarias de tecnologías de apoyo
- Completar el alta con lector de pantalla (VoiceOver, TalkBack o NVDA): ¿oye que hay tres consentimientos, qué autoriza cada uno y que vienen marcados antes de llegar a «Continuar»?
- Desmarcar las tres casillas solo con teclado: ¿se ve el foco en cada una y el cambio de estado se anuncia?
- Tras «Continuar»: ¿la persona sabe qué preferencias quedaron guardadas y dónde cambiarlas?
- Con zoom al 200 % y a 320 px de ancho: ¿las casillas siguen junto a su texto y antes del botón?
- Usar datos sintéticos en un entorno autorizado. Nunca cambiar consentimientos de clientes reales.

## 7. Evidencia necesaria
| Qué falta exactamente | Criterio A/AA que permite decidir | Cómo resolverlo (conseguirla o implementarla) |
|---|---|---|
| Marcado de las tres casillas: `input type="checkbox"` o equivalente nativo, `label` asociado, estado | 1.3.1 Información y relaciones · 4.1.2 Nombre, función, valor | Entregar HTML o build; comprobar con el árbol de accesibilidad |
| Texto visible de cada casilla y de su título de grupo | 3.3.2 Etiquetas o instrucciones · 2.4.6 Encabezados y etiquetas | Captura o Figma con el copy definitivo |
| Recorrido con teclado y estilo de foco | 2.1.1 Teclado · 2.4.3 Orden del foco · 2.4.7 Foco visible · 2.4.11 Foco no oculto (mínimo) | Prototipo navegable o build; grabación del recorrido |
| Colores de casilla (borde, marca, fondo) en reposo, foco, marcada y dark mode | 1.4.11 Contraste no textual · 1.4.3 Contraste mínimo | Tokens; calcular con `scripts/contraste.py` |
| Tamaño del área pulsable de casillas y botón | 2.5.8 Tamaño del objetivo (mínimo) | Medidas en Figma o build |
| Nombre accesible del botón | 2.5.3 Etiqueta en el nombre | Código del botón |
| Flujo posterior: revisión o corrección de lo elegido | 3.3.4 Prevención de errores (si compliance confirma que aplica) | Entregar paso siguiente y confirmación del alta |
