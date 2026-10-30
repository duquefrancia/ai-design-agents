---
name: evaluating-heuristics
description: Evaluación UX experta de pantallas, prototipos y flujos con las 10 heurísticas de Nielsen como estructura principal, complementadas con controles del sector (banca, salud, comercio/SaaS), accesibilidad y líneas rojas obligatorias (usabilidad crítica y patrones engañosos o dark patterns). Leyes de UX como apoyo. Escala de severidad común 0–4 con color (base Nielsen), riesgo específico y confianza por hallazgo, semáforo de las 10 heurísticas, nota de validación y estado Apto / Apto con observaciones / Pendiente de verificación / No apto. Usar cuando se pida evaluación heurística, auditoría o revisión de usabilidad, revisión UX experta, crítica de una pantalla, detectar dark patterns o patrones engañosos, o validar una pantalla antes del handoff.
---

# Evaluación heurística

Esta skill combina el **juicio de la evaluadora** (qué es grave, qué no se acepta nunca, cuándo se aprueba) y un **método** (procedimiento, severidad, formato).

## Método de evaluación

- Las heurísticas de Nielsen son la **estructura principal** de inspección. Se complementan con los controles del sector, la accesibilidad y las líneas rojas.
- Las Leyes y principios de UX ayudan a explicar un mecanismo, orientar una comprobación o fundamentar una mejora. Nunca son prueba de un problema ni de un efecto sobre las personas usuarias.
- **Capas independientes** en cada hallazgo. La **heurística principal** explica qué falla en la interacción. La **línea roja** dice si además se cruza un límite inaceptable. La **severidad** expresa cuánto importa el problema. El **riesgo específico** indica qué puede verse afectado. El **estado de aprobación** decide si se puede aprobar. Ninguna se deduce de otra.
- Una línea roja confirmada **no se compensa** con buenas valoraciones en otros aspectos.
- Se distinguen siempre **hechos observados, hipótesis y aspectos no evaluables**.
- Los hallazgos se agrupan **por problema**: un problema es una ficha, aunque lo toquen varias heurísticas, una línea roja, una ley y accesibilidad.

## Terminología fija

- **Hallazgo**: cada problema reportado. No alternar con "fallo" o "error".
- **Heurística principal**: la heurística de Nielsen (H1–H10) que explica el mecanismo del problema observado. Una por hallazgo, cuando exista una relación pertinente. Las demás van como relacionadas.
- **Severidad**: escala común 0–4 con color, número y nombre (sección «Escala y estados comunes»), basada en Nielsen.
- **Riesgo específico**: categorías de la sección 6.
- **Confianza**: Alta, Media o Baja, con justificación.
- **Línea roja**: catálogo en [reference/lineas-rojas.md](reference/lineas-rojas.md). Estado: confirmada, indicio fundado, diseño justificado.
- **Sin evaluar** (⚫): lo que la entrada no permite comprobar.
- **Estado de aprobación**: Apto · Apto con observaciones · Pendiente de verificación · No apto. No hay otros nombres. Se escriben exactamente así. En Pendiente de verificación, el informe dice siempre que la aprobación queda retenida.

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

- [ ] 1. Declarar la entrada, el alcance y los estados evaluados
- [ ] 2. Contexto: persona usuaria, objetivo, tareas y sector
- [ ] 3. Recorrer cada tarea como lo haría esa persona
- [ ] 4. Revisar las líneas rojas
- [ ] 5. Inspeccionar las 10 heurísticas con los controles del sector y de accesibilidad
- [ ] 6. Registrar cada hallazgo con sus campos
- [ ] 7. Asignar la severidad con el contexto
- [ ] 8. Bucle de validación y estado de aprobación
- [ ] 9. Entregar con templates/informe.md

### 1. Entrada, alcance y estados

Va siempre en el informe: qué se evaluó (pantallas, pasos), qué estados (inicial, error, carga, éxito) y qué queda fuera. Nunca evalúes más allá de lo que la entrada permite ver.

| Entrada | Se puede evaluar | Queda Sin evaluar |
|---|---|---|
| HTML / código | Contenido, textos, orden, controles, estados declarados (`onclick`, atributos) | Lo que pasa después: siguiente pantalla, tiempos reales, respuesta del sistema |
| Captura | Lo visible: textos, jerarquía, opciones, datos mostrados | Estados, comportamiento, lo que hay fuera de la captura |
| Figma / prototipo | Lo visible y los estados dibujados | Lo no prototipado |
| Descripción | Riesgos e indicios a partir de lo descrito | Casi todo: lo descrito no está observado |

Con una **descripción** falta evidencia esencial: nunca hay Apto ni Apto con observaciones.

### 2. Contexto

Una línea: quién usa la pantalla, qué quiere conseguir, qué tareas tiene la pantalla y en qué sector. Lo deducido se marca con `*` como supuesto. Prueba sin causar daño: datos sintéticos, nunca operaciones reales.

### 3. Recorrido

Recorre cada tarea paso a paso como esa persona. Anota dónde dudaría, dónde se equivocaría y dónde no sabría qué ha pasado. La tarea manda: lo que impide terminarla va primero.

### 4. Líneas rojas

Lee [reference/lineas-rojas.md](reference/lineas-rojas.md) y comprueba las 14. Cada posible caso tiene uno de tres estados:

- **Confirmada**: la evidencia sustenta el mecanismo. Encabeza el informe.
- **Indicio fundado**: hay una **señal observable** que apunta al mecanismo (algo que está en la entrada: una casilla de estado desconocido, una cuota destacada con «Solo», un botón ambiguo) y una **comprobación concreta pendiente**. Di qué comprobar y cómo. No afirmes hechos ni intenciones no demostrados.

Distingue tres cosas que no son lo mismo:

| Situación | Qué es | Dónde va |
|---|---|---|
| La entrada no menciona o no muestra algo (no dice las comisiones, no precisa el orden de los pasos) | **Información no aportada**. Una omisión de la entrada no es una señal | «Evidencia necesaria». Si es esencial para decidir, el estado de aprobación es Pendiente de verificación. Nunca se convierte por sí sola en indicio de línea roja |
| Algo observado apunta al mecanismo, pero falta comprobarlo | **Indicio fundado** | Tabla de líneas rojas y «Evidencia necesaria» |
| La evidencia sustenta el mecanismo | **Incumplimiento confirmado** | Tabla de líneas rojas; estado de aprobación No apto |

Una sospecha genérica sobre algo no revisado no es un indicio fundado: no se reporta.
- **Diseño justificado**: la medida responde a una necesidad real, está explicada y es proporcionada. Se dice en «Lo que funciona bien».

No clasifiques como engaño por defecto una autenticación reforzada, una comprobación de permisos, una alerta clínica fundada, una renovación aceptada antes o una confirmación antes de borrar datos. Examina finalidad, veracidad y proporcionalidad.

### 5. Inspección

Recorre las 10 heurísticas en orden con [reference/heuristicas.md](reference/heuristicas.md): control general, control del sector y controles de accesibilidad que afectan a la tarea.

**Semáforo de las 10 heurísticas.** Es un panel de lectura rápida; no calcula nada.

1. Cada hallazgo de usabilidad identifica **una única heurística principal** cuando exista una relación pertinente con el problema observado. Se elige por el **mecanismo concreto** del problema, no por la línea roja.
2. Las **líneas rojas son un eje independiente**. Un hallazgo puede tener a la vez una heurística principal y una línea roja (confirmada, indicio fundado o diseño justificado). La línea roja no sustituye a la heurística principal ni propaga una heurística predeterminada: los cruces como U1 → H1/H5 orientan la inspección, no deciden.
3. Cada heurística toma **la mayor severidad suficientemente sustentada de los hallazgos que la tienen como heurística principal**.
4. Las heurísticas **relacionadas** se registran como contexto secundario en la ficha y en la fila «Relacionada en», **sin cambiar el color**. Las líneas rojas se representan aparte (sección 1 del informe) y afectan al estado de aprobación según sus propias reglas.
5. Cada celda dice una de tres cosas distintas:
   - **color y nivel**: tiene hallazgos como principal;
   - **🟢 0 · Sin problemas detectados**: se inspeccionó con evidencia suficiente y no hay hallazgos que la tengan como principal. La ausencia de heurística principal no es cumplimiento: sin evidencia suficiente para evaluarla, es ⚫, nunca 🟢;
   - **⚫ Sin evaluar**: la entrada no permite inspeccionarla.
   - **No aplica**: la heurística no corresponde al objeto evaluado. Con motivo en la nota bajo el semáforo. Nunca en lugar de ⚫.
6. El estado de aprobación se calcula con todos los hallazgos y las reglas de la sección 8, **nunca contando colores del panel**.

**Accesibilidad.** Cuando un problema de usabilidad afecta también a la inclusión, se marca con el riesgo «Accesibilidad o inclusión» dentro de su ficha. La comprobación de conformidad (ratios de contraste, foco, etiquetas, lector de pantalla) se deriva a `auditing-accessibility` en la sección «Para accesibilidad». Este estado de aprobación no aprueba ni suspende accesibilidad.

**Leyes de UX.** Usa la skill `applying-ux-laws` cuando una ley explique el mecanismo de un hallazgo, oriente qué comprobar o fundamente la corrección (ej. Miller en un número largo sin agrupar). No exijas una ley por hallazgo ni evalúes todas las leyes en todas las pantallas. Una ley no demuestra que el problema exista ni que afecte a las personas usuarias: eso lo demuestra la evidencia.

### 6. Ficha de cada hallazgo

| Campo | Qué escribir |
|---|---|
| Problema | Una frase. Un problema, una ficha |
| Evidencia | Lo observado: texto literal, selector o elemento exacto |
| Tarea afectada | Qué intenta hacer la persona cuando lo encuentra |
| Consecuencia probable | Qué le puede pasar. Si no hay datos, se dice como probable, no como hecho |
| Heurística principal | Una heurística H1–H10, por el mecanismo del problema. Relacionadas: el resto, sin duplicar el hallazgo |
| Severidad | 🔴 4 · 🟠 3 · 🟡 2 · ⚪ 1 (sección 7). En 🟠 3 y 🔴 4, una línea de justificación con la rúbrica. Si hay línea roja confirmada y la severidad es 1 o 2, justificación explícita |
| Riesgo específico | Una o varias categorías, cada una con su consecuencia concreta |
| Línea roja | Confirmada / indicio fundado / no aplica |
| Confianza | Alta / Media / Baja + justificación breve |
| Corrección | Cambio concreto y comprobable, no genérico |
| Cómo verificarla | La prueba que demuestra que la corrección funciona |
| Ley de UX | Solo si explica, orienta o fundamenta |
| Esfuerzo | «A estimar con el equipo técnico» |

**Confianza**, referida a la conclusión concreta, no a la observación:
- **Alta**: la evidencia sustenta suficientemente la conclusión concreta dentro del alcance evaluado.
- **Media**: la evidencia es parcial y la conclusión depende de supuestos o comprobaciones identificados.
- **Baja**: el sustento es limitado; la conclusión requiere validación y se presenta como hipótesis.

No equipares "observado" con Alta ni "inferido" con Media. Observar un estado de pantalla no demuestra su origen ni sus consecuencias.

**Riesgo específico** (selección múltiple):
- Económico
- Privacidad y datos personales
- Clínico o seguridad del paciente
- Operativo o continuidad del servicio
- Accesibilidad o inclusión
- Legal o normativo
- *Estados alternativos (no se combinan con las categorías):* Sin riesgo específico identificado · No evaluable con la evidencia disponible

Reglas:
- Varias categorías solo cuando hay consecuencias distintas sustentadas. Cada categoría va con su consecuencia concreta.
- La etiqueta por sí sola no determina la severidad ni el estado de aprobación.
- «Legal o normativo»: identifica el requisito potencialmente afectado y distingue una posible implicación de un incumplimiento verificado.
- «Sin riesgo específico identificado» no garantiza ausencia de riesgo. «No evaluable» no se convierte en «Sin riesgo».
- Si hay riesgos identificados y quedan aspectos pendientes, conserva las categorías conocidas y describe la limitación.

### 7. Severidad

Usa la escala de «Escala y estados comunes». Equivalencia con Nielsen: catastrophe → 🔴 4 · Crítico · major → 🟠 3 · Mayor · minor → 🟡 2 · Moderado · cosmetic → ⚪ 1 · Leve · no problem → 🟢 0 · Sin problemas detectados.

⚪ 1 · Leve incluye lo que Nielsen llama cosmético, pero no se limita a lo estético: es cualquier problema de impacto bajo en la tarea.

**Cómo se asigna.** La severidad se decide por **impacto, frecuencia, persistencia, reversibilidad y riesgo sobre la tarea**. Para distinguir los dos niveles altos:
- **🟠 3 · Mayor**: impacto significativo, riesgo relevante o corrección necesaria antes de aprobar el flujo.
- **🔴 4 · Crítico**: impide una tarea esencial, puede provocar una consecuencia grave o difícilmente reversible, o introduce un riesgo inaceptable inmediato.

Cada 🟠 3 y 🔴 4 lleva en su ficha una línea que diga qué criterio de la rúbrica cumple.

**Línea roja y severidad.** Una línea roja confirmada no fija la severidad: ya bloquea el estado de aprobación por sí misma. La severidad sigue midiendo el impacto UX real. Si una línea roja confirmada recibe 🟡 2 o ⚪ 1, la ficha lo justifica de forma explícita.

**La criticidad del flujo clasifica antes del estado de aprobación.** Pregunta qué decisión o acción queda comprometida. Si puede llevar a confirmar un importe o destinatario equivocado, a una operación no deseada, a exponer datos o a una decisión clínica errónea, revisa la severidad por ese impacto concreto. Estar en una operación financiera, clínica o de datos **no** convierte un hallazgo menor en grave por sí solo.

**Efecto combinado.** Si varios hallazgos producen juntos un efecto significativo en la misma tarea, documéntalo y reevalúa la gravedad. No sumes severidades por cantidad.

### 8. Bucle de validación y estado de aprobación

Revisa el borrador con esta lista → corrige → vuelve a revisar → solo entonces entrega.

- [ ] Cada ficha tiene todos los campos y señala un elemento que existe en la entrada.
- [ ] Hechos, hipótesis y no evaluables están separados; nada se afirma más allá de la entrada.
- [ ] La confianza se refiere a la conclusión y lleva justificación.
- [ ] Severidad, riesgo y línea roja se han decidido por separado.
- [ ] Cada indicio de línea roja tiene una señal observable y una comprobación concreta; si no, se ha quitado.
- [ ] Ninguna omisión de la entrada se ha convertido en indicio: lo no aportado está en «Evidencia necesaria».
- [ ] Cada consecuencia probable se apoya en lo observado; si depende de algo no aportado (¿hay comisión?, ¿tiene varias cuentas?), esa parte va como hipótesis o en «Evidencia necesaria», no sube la severidad.
- [ ] Cada hallazgo tiene su heurística principal elegida por el mecanismo; la línea roja va aparte.
- [ ] Semáforo: color solo por heurística principal; relacionadas en su fila; líneas rojas sin propagar.
- [ ] Cada 🟠 3 y 🔴 4 dice qué criterio de la rúbrica cumple; cada línea roja confirmada con 🟡 2 o ⚪ 1 lo justifica.
- [ ] Ninguna ley de UX se usa como prueba.
- [ ] No hay problemas duplicados por marco ni hallazgos de relleno.
- [ ] Ningún 🟢 sin comprobar; lo demás es ⚫.
- [ ] Cada «No aplica» lleva motivo y no oculta falta de evidencia.
- [ ] No hay datos de uso, métricas ni citas inventados.
- [ ] Cada corrección **preserva la autonomía** de la persona, **la información necesaria** para decidir y **las medidas de protección justificadas** (no quita una confirmación, un aviso o una autenticación para ganar fluidez).
- [ ] Cada corrección dice cómo verificarla.
- [ ] El estado de aprobación sigue la precedencia de abajo y declara su alcance.

**Regla de aprobación de heurísticas.** Usa los estados de aprobación comunes. Precedencia: se aplica el primero que se cumpla.

1. **No apto**: algún hallazgo 🟠 3 o 🔴 4 suficientemente sustentado, o una línea roja confirmada. Requiere corregir un problema demostrado. Prevalece aunque queden comprobaciones pendientes; esas también se listan.
2. **Pendiente de verificación**: no hay motivo de rechazo suficientemente demostrado, pero existe un indicio fundado de línea roja o falta evidencia esencial para decidir dentro del alcance. Requiere completar la verificación; la aprobación queda retenida hasta entonces. Lleva siempre «Evidencia necesaria»: qué falta, cómo obtenerlo y qué resolvería. La severidad de los hallazgos y el estado del indicio no cambian por este estado de aprobación.
3. **Apto con observaciones**: sin líneas rojas confirmadas ni indicios fundados pendientes, con evidencia suficiente y al menos un hallazgo 🟡 2 (ninguno por encima).
4. **Apto**: sin líneas rojas confirmadas ni indicios pendientes, con evidencia suficiente y solo hallazgos ⚪ 1 o ninguno. Los leves se listan, pero no cambian el estado de aprobación.

Qué pasa después de verificar un indicio: si se descarta o resulta diseño justificado, el estado de aprobación se recalcula con los hallazgos que queden (por ejemplo, Apto con observaciones si solo hay 🟡 2). Si se confirma, No apto por línea roja confirmada.

El umbral desde el nivel 3 es la regla de aprobación de esta disciplina, no una regla universal de Nielsen. Un 🟡 2 aislado da Apto con observaciones cuando no hay niveles 3/4, líneas rojas confirmadas ni evidencia esencial pendiente. Otras disciplinas aplican su propia regla al mismo nivel (en accesibilidad, un incumplimiento A/AA da No apto en cualquier nivel).

**Alcance del estado de aprobación.** Escribe «Válido para:» (pantallas, pasos y estados evaluados) y «No cubre:» (lo no comprobado, el resto del flujo y la accesibilidad). La aprobación heurística no se extiende a accesibilidad ni a partes del flujo no comprobadas.

**Nota de validación** (antes del estado de aprobación, siempre):
- *Por qué sale esta nota*: qué se comprobó y con qué entrada; qué hallazgo, línea roja, indicio o luz verde la sostiene; qué la haría cambiar.
- *Autocomprobación*: confirma que se ha pasado el bucle de validación entero y qué no pudo comprobarse.

**Recomendación y decisión.** Tras el estado de aprobación, una frase de recomendación (qué hacer primero) y siempre: «Este estado de aprobación es una recomendación experta. La decisión final es del equipo; la priorización se cierra con el equipo técnico, que valora viabilidad y esfuerzo.»

Las líneas rojas son reglas internas de diseño: cualquier conclusión jurídica necesita su propia verificación.

### 9. Entrega

Usa [templates/informe.md](templates/informe.md). Contiene la estructura y un ejemplo completo.

## Reglas

- No inventes problemas para parecer exhaustiva. Tres hallazgos reales valen más que diez dudosos.
- No inventes datos de uso, métricas ni citas de usuarios.
- No diseñes, recomiendes ni optimices mecanismos de las líneas rojas, aunque mejoren conversión, retención o ingresos.
- Cada evaluación es independiente: no copies de informes anteriores.

## Tono

Directo y sin adjetivos. Convence la evidencia: texto literal, elemento, consecuencia. Lo leen quien decide (estado de aprobación), quien diseña o desarrolla (corrección y verificación) y quien prioriza (severidad y riesgo). Responde en el idioma de la persona usuaria.

## Referencias (leer solo si hace falta)

- Heurísticas con controles generales, por sector y de accesibilidad: [reference/heuristicas.md](reference/heuristicas.md)
- Catálogo de las 14 líneas rojas: [reference/lineas-rojas.md](reference/lineas-rojas.md)
- Plantilla y ejemplo de informe: [templates/informe.md](templates/informe.md)
