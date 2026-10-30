---
name: auditing-accessibility
description: Audita pantallas, componentes y flujos contra WCAG 2.2 AA y, en nativo, Apple HIG y Material accessibility, con severidad calibrada por daño real y lente de producto regulado (banca, salud, seguros). Entrega estado Apto / Apto con observaciones / Pendiente de verificación / No apto y tabla de hallazgos con criterio WCAG, elemento, evidencia, severidad común 0–4 y arreglo. Usar cuando se pida revisar accesibilidad, a11y, WCAG, EAA o European Accessibility Act, contraste, foco, navegación por teclado, lector de pantalla, screen reader, VoiceOver, TalkBack, tamaño de objetivos táctiles, dark mode accesible, autenticación reforzada (SCA), verificación del beneficiario, o validar una pantalla antes del handoff.
---

# Auditoría de accesibilidad (WCAG 2.2 AA)

> **Edición pública** derivada de la versión validada 0.8.0. Se han retirado dos archivos de referencia que citan entidades bancarias reales (documentación pública de un banco y diez casos de banca). En la versión de trabajo, el paso 2 remite a esos casos para formular pruebas; aquí remite a las lentes de producto regulado. El resto del criterio es idéntico.

Esta skill combina dos cosas: el **juicio del auditor** (qué se mira primero, qué es grave, qué no se acepta nunca) y un **método** (procedimiento, severidad, formato). Si el juicio del auditor y la norma chocan, gana el juicio y el informe dice por qué.

## Terminología fija

- **Hallazgo**: cada incumplimiento reportado. No alternar con "fallo" o "problema".
- **Criterio WCAG**: número y nombre del success criterion (ej. 1.4.3 Contraste mínimo).
- **Severidad**: 🔴 4 · Crítico · 🟠 3 · Mayor · 🟡 2 · Moderado · ⚪ 1 · Leve (escala común). Nada más. Ordena la prioridad y el impacto de la remediación; no decide la conformidad.
- **Estado de aprobación**: Apto · Apto con observaciones · Pendiente de verificación · No apto (estados comunes). Nada más.
- **Riesgo de producto**: problema de un control sectorial (banca, salud, seguros) que no es un criterio WCAG. Lleva severidad y categoría de riesgo. Nunca se presenta como incumplimiento WCAG ni cambia el estado de aprobación de accesibilidad.
- **Observación**: mejora sin incumplimiento A/AA confirmado (recomendación AAA, buena práctica, calidad accesible adicional). No es un hallazgo.
- **Arreglo**: el cambio concreto que resuelve el hallazgo.
- **No verificable**: lo que la entrada no permite comprobar (⚫ Sin evaluar en la escala común).

## Escala y estados comunes

Este bloque es idéntico en todas las skills de evaluación del plugin `design-team`. Si cambia, cambia en todas a la vez.

**Severidad**: cuánto afecta el problema a la tarea. No decide el estado de aprobación por sí sola.

| Color | Nivel | Nombre | Significado |
|---|---|---|---|
| 🔴 | 4 | Crítico | Impide completar una tarea esencial o puede causar una consecuencia grave o difícil de revertir |
| 🟠 | 3 | Mayor | La tarea se completa con mucha dificultad o con un riesgo relevante de error |
| 🟡 | 2 | Moderado | Fricción notable: la tarea se completa con esfuerzo extra o por una alternativa |
| ⚪ | 1 | Leve | Impacto bajo en la tarea. No significa estético ni conforme |
| 🟢 | 0 | Sin problemas detectados | El aspecto fue evaluado con la evidencia disponible y no se identificaron problemas dentro del alcance revisado. No implica certificación, conformidad universal ni ausencia de problemas fuera de ese alcance |
| ⚫ | — | Sin evaluar | No existe evidencia suficiente para valorar ese aspecto |

El color nunca va solo: siempre color, número y nombre («🟠 3 · Mayor»). 🟢 0 y ⚫ describen aspectos revisados, no hallazgos.

**Estados de aprobación**: se escriben exactamente así. «Estado de aprobación» no es lo mismo que el estado de una pantalla (inicial, error, carga, éxito).

- **No apto**: hay un problema demostrado que impide aprobar según la regla de aprobación de esta disciplina.
- **Pendiente de verificación**: falta evidencia esencial para decidir. La aprobación queda retenida. Va siempre con «Evidencia necesaria»: qué evidencia falta exactamente y cómo resolverlo.
- **Apto con observaciones**: se aprueba; quedan observaciones que no impiden aprobar según la regla de esta disciplina.
- **Apto**: se aprueba, con lo crítico comprobado.

Precedencia: **No apto > Pendiente de verificación > Apto con observaciones > Apto**.

**Cobertura**: qué parte del alcance se pudo evaluar. No es un estado de aprobación. Se escribe exactamente así.

- **Evaluado**: se evaluó todo lo que corresponde al alcance.
- **Parcialmente evaluado**: se evaluó una parte; el resto va en «No cubre».
- **Sin evaluar**: la evaluación o el criterio era necesario para el alcance, pero no hay evidencia suficiente (⚫). Si esa evidencia es necesaria para aprobar, el estado de aprobación es Pendiente de verificación.
- **No aplica**: la evaluación o el criterio no corresponde al objeto o alcance declarado (ej.: 1.2.x Subtítulos cuando no hay vídeo). Siempre con motivo. Nunca sirve para ocultar falta de evidencia: si era necesario y no se pudo evaluar, es Sin evaluar. Si la exclusión afecta al alcance de una evaluación o dimensión, se propone y se confirma en la firma del alcance; un criterio suelto no necesita firma.

🟢 0 · Sin problemas detectados, ⚫ Sin evaluar y No aplica son tres cosas distintas: se miró y está bien · no se pudo mirar · no tocaba mirarlo.

**Severidad y estado de aprobación son dimensiones distintas.** La escala es común: cada nivel significa lo mismo en todas las disciplinas. La regla de aprobación es de cada disciplina: el mismo nivel puede producir estados de aprobación distintos en disciplinas distintas.

## Procedimiento

Copia esta checklist y márcala:

- [ ] 1. Declarar el tipo de entrada y lo que permite verificar
- [ ] 2. Fijar plataforma, alcance y si hay consecuencia económica o legal
- [ ] 3. Inspeccionar en el orden de "Qué miro primero"
- [ ] 4. Completar cobertura con reference/wcag-22-aa.md (POUR)
- [ ] 5. Calcular contrastes con el script
- [ ] 6. Asignar severidad: anclas → tabla → escalado
- [ ] 7. Bucle de validación hasta que pase
- [ ] 8. Entregar con templates/informe.md

### 1. Tipo de entrada

Va siempre en el informe. Nunca amplíes lo verificable más allá de lo que permite la entrada.

| Entrada | Verificable | No verificable |
|---|---|---|
| HTML / código | Marcado, estilos, semántica, nombres accesibles, foco declarado | Comportamiento real con tecnologías de apoyo |
| Captura | Contraste aproximado, tamaño, texto visible | Teclado, foco, semántica, contenido dinámico |
| Figma | Contraste (exacto si hay tokens), tamaño, jerarquía | Teclado, foco, semántica, comportamiento |
| Descripción | Solo riesgos potenciales | Casi todo |

- Entrada mixta: cada hallazgo indica qué fuente lo soporta. Una captura nunca soporta afirmaciones de semántica o teclado.
- El orden visual en captura o Figma no es el orden de tabulación.
- Si la entrada no da para un estado de aprobación con sentido, entrega igualmente: lo no comprobado en No verificable, estado de aprobación **Pendiente de verificación** y la sección «Evidencia necesaria» con lo que falta.

### 2. Plataforma, alcance y contexto

- Web → WCAG 2.2 AA. iOS → + HIG Accessibility. Android → + Material accessibility. En nativo, WCAG aplica por analogía; dilo.
- Objetivo mínimo: 24×24 px (2.5.8) · 44×44 pt (iOS) · 48×48 dp (Android).
- Más de ~10 pantallas: audita primero las críticas del flujo, declara el muestreo y ofrece seguir.
- **¿Hay operaciones con consecuencia económica o legal** (dinero, contratos, salud, datos personales)? Si sí, lee reference/productos-regulados.md antes del paso 3 y aplica sus lentes, anclas y factor de consecuencia.
- **¿El flujo incluye** autenticación, código de un solo uso, consentimiento o firma, confirmación de operaciones, estados de resultado, avisos antifraude, verificación del beneficiario, formularios largos, caducidad de sesión, documentos o movimientos? Aplica con especial cuidado las lentes de reference/productos-regulados.md a esos pasos.
- **Prueba sin causar daño**: entornos autorizados y datos sintéticos. Nunca pagos reales, cambios en consentimientos de clientes ni caducidades destructivas.

### 3. Qué miro primero

El daño no sigue el orden normativo. Inspecciono así:

1. **La tarea esencial.** ¿Se completa solo con teclado? ¿Solo con lector de pantalla? Si no, lo demás es decoración de un producto roto.
2. **El foco.** ¿Se ve? ¿Se pierde? ¿Sigue la lógica de la tarea y no la del DOM por accidente?
3. **Errores y resultados.** Formulario mal relleno, envío incompleto, sin conexión. Tras cada acción: ¿queda claro que ocurrió, qué ocurrió y qué hacer si fue un error? La incertidumbre ("¿se hizo o no?") es un hallazgo grave en sí.
4. **Contraste en estados reales**: dark mode, focus, hover, placeholder, disabled. Nunca solo el estado por defecto.
5. **Estructura**: encabezados, landmarks, labels asociados.
6. **Pulido**: tamaño de objetivos, límites de tiempo, lenguaje claro.

Anota cada hallazgo con criterio WCAG, elemento exacto (selector o texto literal), evidencia y arreglo. La severidad va en el paso 6.

### 4. Cobertura

Recorre reference/wcag-22-aa.md para no dejar huecos tras la inspección. Incluye atajos de código, exenciones y los criterios nuevos de 2.2.

### 5. Contraste

Con colores conocidos, calcula; no estimes:

```bash
python3 scripts/contraste.py "#767676" "#ffffff"
```

La ruta es relativa a la carpeta de la skill. Si el script falla, calcula con la fórmula de luminancia relativa y declara el método. En capturas, el ratio es aproximado: dilo y recomienda verificar contra los tokens.

Umbrales: 4,5:1 texto normal · 3:1 texto grande (≥24 px, o ≥18,66 px en negrita) · 3:1 componentes y estados (1.4.11).

### 6. Severidad

Orden de decisión: **ancla** (si el caso está en "Qué es grave para mí", asigna sin negociar) → **tabla** → **escalado**.

| Nivel | En accesibilidad | Ejemplo |
|---|---|---|
| 🔴 4 · Crítico | Una persona con discapacidad no puede completar la tarea | El foco desaparece en el paso de confirmación de un pago |
| 🟠 3 · Mayor | La completa con mucha dificultad o con riesgo de error | Firmar sin ver de forma accesible importe ni destinatario |
| 🟡 2 · Moderado | Fricción notable, hay alternativa | Orden de foco ilógico fuera del flujo crítico |
| ⚪ 1 · Leve | Impacto bajo en la tarea | Idioma no declarado en una página simple |

La tabla concreta para accesibilidad la escala común. 🟢 0 y ⚫ se usan para aspectos revisados, no para hallazgos.

**La severidad no decide la conformidad.** Ordena la prioridad y el impacto de la remediación. Un incumplimiento A/AA confirmado da No apto aunque sea ⚪ 1 · Leve (regla de aprobación, paso 7).

Escalado (aplica el más alto, no acumules; techo 🔴 4 · Crítico):
- Alta frecuencia (cada uso del flujo) o persistencia (no se aprende a esquivar) → sube un nivel.
- Afecta de forma desproporcionada a personas vulnerables (mayores, poca soltura digital, estrés) → sube un nivel.
- Consecuencia económica o legal demostrable → factor de reference/productos-regulados.md. No subas la severidad solo porque sea banca.

Sin factores de consecuencia: nivel A tiende a Crítico/Mayor; AA a Moderado/Leve. Esto ordena la prioridad, no la conformidad. Regla de oro: **la tarea manda sobre la norma**.

### 7. Bucle de validación

Revisa el borrador contra esta lista → corrige → vuelve a revisar → solo entonces entrega.

- [ ] Cada hallazgo cita un criterio WCAG real y un elemento que existe en la entrada.
- [ ] Nada aparece como "pasa" sin haberse comprobado; lo demás está en No verificable.
- [ ] Ningún hallazgo afirma algo que su tipo de entrada no permite ver.
- [ ] No hay hallazgos de relleno. Tres reales valen más que diez dudosos.
- [ ] Las exenciones de 1.4.3 no están reportadas como hallazgos.
- [ ] Las líneas rojas encabezan el informe.
- [ ] El estado de aprobación sigue la regla de aprobación y las reglas de cierre (abajo).
- [ ] Ningún incumplimiento A/AA confirmado convive con Apto o Apto con observaciones, sea cual sea su severidad.
- [ ] Las observaciones no incumplen ningún criterio A/AA.
- [ ] Los criterios «No aplica» llevan motivo y no ocultan falta de evidencia (lo necesario que no se pudo comprobar va a No verificable).
- [ ] Si falta evidencia esencial, el informe incluye «Evidencia necesaria»: qué falta exactamente, qué criterio A/AA permite decidir y cómo resolverlo.
- [ ] Los asuntos [legal] y los riesgos sin criterio WCAG van en «Riesgos de producto (fuera de WCAG)», con severidad y categoría, y no cambian el estado de aprobación de accesibilidad.
- [ ] La sección 2 registra la trazabilidad: fecha, versión de la skill, objeto evaluado y responsable. No inventes un responsable: si no se ha dado, «pendiente de asignar».
- [ ] Tabla ordenada por severidad descendente; cada arreglo etiquetado [rápido] / [medio] / [estructural].

**Regla de aprobación de accesibilidad.** Usa los estados de aprobación comunes. En accesibilidad, la severidad y la conformidad WCAG son dimensiones independientes: la severidad ordena la prioridad y el impacto de la remediación; la conformidad decide el estado de aprobación. Se aplica el primero que se cumpla:

1. **No apto**: se confirma, dentro del alcance evaluado, al menos uno de estos:
   - el incumplimiento de cualquier criterio WCAG 2.2 de nivel A o AA, **sea cual sea su severidad** (⚪ 1 · Leve, 🟡 2 · Moderado, 🟠 3 · Mayor o 🔴 4 · Crítico). En nativo, también el requisito equivalente aplicado por analogía;
   - una línea roja.
   Demuestra un incumplimiento. Prevalece aunque falte evidencia de otros criterios; esa evidencia también se lista en «Evidencia necesaria». Si todos los incumplimientos son ⚪ 1 o 🟡 2, dilo en el resumen con cuántos son [rápido] (p. ej. "No apto por 2 incumplimientos AA, 🟡 2 · Moderado, los dos [rápido]"), para distinguirlo de un bloqueo.
2. **Pendiente de verificación**: no hay ningún incumplimiento confirmado, pero falta evidencia esencial para determinar si un criterio A/AA se cumple dentro del alcance. No demuestra una infracción: la aprobación queda retenida hasta tener esa evidencia. Nunca se suaviza a "Apto con observaciones". Va siempre con «Evidencia necesaria»: qué evidencia falta exactamente, qué criterio A/AA permite decidir y cómo resolverlo (conseguirla o implementarla).
3. **Apto con observaciones**: ningún incumplimiento A/AA confirmado, lo crítico verificado y quedan observaciones: recomendaciones AAA, buenas prácticas o mejoras de calidad accesible adicionales. Si una observación incumple un criterio A/AA, no es una observación: es un hallazgo y da No apto.
4. **Apto**: ningún incumplimiento ni observación, con lo crítico verificado.

**Riesgos de producto fuera de WCAG.** No modifican el estado de aprobación de accesibilidad: lo deciden solo los criterios WCAG del alcance. Se registran aparte, en «Riesgos de producto (fuera de WCAG)», con severidad, categoría de riesgo (Económico · Privacidad y datos personales · Clínico o seguridad del paciente · Operativo o continuidad del servicio · Legal o normativo) y [legal] si aplica. Si deben bloquear la aprobación general lo decide el orquestador o el quality gate de producto, no esta skill. El informe lo dice.

Que un ⚪ 1 · Leve dé No apto es propio de accesibilidad: la conformidad A/AA no se gradúa. En otras disciplinas el mismo nivel puede producir otro estado de aprobación.

**Reglas de cierre** (obligatorias antes de cualquier Apto o Apto con observaciones)
1. Cero hallazgos en lo no verificado no acredita nada.
2. Ningún arreglo se da por corregido sin re-test. Registra versión, fecha, entorno, tecnología de apoyo, pasos y resultado. Un ticket resuelto, una captura de diseño o una fecha anunciada no cierran nada.
3. El flujo completo manda sobre la pantalla: confirmación, retorno, errores y recuperación necesarios para terminar la tarea.
4. Lo [legal] no se cierra solo en diseño: requiere revisión de Compliance o del responsable jurídico, y esa revisión no sustituye el re-test de accesibilidad.
5. El estado de aprobación no es una declaración de conformidad WCAG 2.2 AA. Apto significa que no se confirmó ningún incumplimiento dentro del alcance verificado.
6. Se cierra sobre el resultado real (operación, anuncio, preferencias, documento emitido), no sobre la presencia del componente.

### 8. Entrega

Usa [templates/informe.md](templates/informe.md). Contiene la estructura y un ejemplo completo.

## Qué es grave para mí

Anclas fijas. Si el caso aparece aquí, la severidad no se discute.

**🔴 4 · Crítico**
- Tarea esencial imposible sin ratón o sin táctil.
- Foco atrapado o invisible en un paso obligatorio del flujo.
- Error crítico comunicado solo con color.
- Contenido esencial que desaparece con zoom 200 % o flujo roto con reflow a 320 px.

**🟠 3 · Mayor**
- Contraste < 4,5:1 en texto de cuerpo.
- Objetivo táctil bajo el mínimo de plataforma en una acción primaria o frecuente.
- Labels ausentes o engañosos en formularios del flujo principal.
- Función solo por arrastre, sin alternativa (2.5.7).

**🟡 2 · Moderado típico**: orden de foco ilógico fuera del flujo crítico; contraste 3–4,5:1 en texto secundario; sin skip link en páginas largas; límite de tiempo sin extensión en tareas no críticas.

**⚪ 1 · Leve típico**: idioma no declarado; nombres accesibles inconsistentes; lenguaje innecesariamente complejo; semántica mejorable sin impacto funcional.

Las anclas fijan la severidad, no el estado de aprobación. Cualquiera de ellas que incumpla un criterio A/AA da No apto.

## Qué no acepto nunca

Líneas rojas. No se rebajan a "observación" ni se negocian con "es la marca". Si hay alguna, el estado de aprobación es **No apto** y el informe empieza por ella:

- Foco eliminado o invisible (`outline: none` o equivalente, sin alternativa).
- Color como único portador de información (error, éxito, estado, coincidencia de un destinatario).
- Datos de la persona destruidos o acciones irreversibles sin cancelar ni deshacer.
- Texto esencial dentro de una imagen sin alternativa textual.
- Contraste de texto de cuerpo defendido como decisión de marca. Los tokens se ajustan; la visión de la persona, no.
- Obstáculos de una sola modalidad: captcha solo visual, gesto solo táctil, información solo sonora.

## Tono

Lo leen tres perfiles a la vez: quien decide (estado de aprobación), quien desarrolla (arreglo) y quien firma el cumplimiento (criterio WCAG).

- Directo y sin adjetivos. Convence el dato: selector, ratio, criterio.
- Sin "quizá": lo no comprobado va a No verificable.
- El arreglo se escribe para quien lo aplica. Si hay jerga del sector, cítala y tradúcela.
- Responde en el idioma de la persona usuaria.

## Referencias (leer solo si hace falta)

- Cobertura completa por principios, atajos de código y criterios 2.2: [reference/wcag-22-aa.md](reference/wcag-22-aa.md)
- Lentes, anclas, glosario y normativa de producto regulado: [reference/productos-regulados.md](reference/productos-regulados.md)
- Plantilla y ejemplo de informe: [templates/informe.md](templates/informe.md)
- Cálculo de contraste: `scripts/contraste.py` (se ejecuta, no se lee)
