# Casos de prueba: auditing-accessibility (v0.8)

Alineados con el criterio de la skill: escala común (🔴 4 · Crítico · 🟠 3 · Mayor · 🟡 2 · Moderado · ⚪ 1 · Leve), estados comunes (Apto / Apto con observaciones / Pendiente de verificación / No apto), regla de aprobación de accesibilidad (todo incumplimiento A/AA confirmado da No apto, sea cual sea su severidad), líneas rojas, reglas de cierre y lentes de producto regulado.

**Criterio de diseño de los tests (22 oct 2026):**
- Si el caso valida **una skill concreta**, la entrada declara la disciplina («Revisa la accesibilidad de…», «Haz una evaluación heurística de…»). Así se prueba la skill, no la elección de especialista.
- Las entradas **neutras** («Audita esta pantalla…», «Evalúa este paso…») se reservan para pruebas de **routing**, y se declaran como tales.
- Marcos separados: WCAG y requisitos de accesibilidad → accesibilidad. Nielsen, patrones engañosos y líneas rojas → heurísticas. Riesgos de producto que no son WCAG → se registran aparte y el orquestador decide su impacto global.

**Cómo ejecutarlos:** cada caso en una **sesión nueva** de Claude Code (`claude --plugin-dir ./plugins/design-team`), escribiendo la entrada tal cual. Al terminar, `/exit`. Apunta el resultado en la hoja de la última sección.

## Caso A — Pantalla con problemas sembrados
**Entrada:** `Revisa la accesibilidad de demo/pantalla-firma.html`

**Esperado:**
- [ ] Se activa la skill sin nombrarla.
- [ ] El informe empieza por la línea roja: foco invisible (`outline:none` en el campo del código).
- [ ] Estado **No apto**, con recuento por severidad en la escala común (color, número y nombre).
- [ ] Detecta al menos 11 de los 15 problemas de `demo/problemas-sembrados.md` (compáralo tú; el agente no debe leer ese archivo).
- [ ] Calcula los contrastes con el script, no a ojo.
- [ ] No reporta "error solo con color" como línea roja: hay texto de error (aunque sea inútil).
- [ ] Hallazgos fuera de WCAG (doble envío, jerga) separados de la tabla.

## Caso B — Pantalla correcta (no inventa fallos)
**Entrada:** `Revisa la accesibilidad de demo/pantalla-resultado.html`

**Esperado:**
- [ ] Cero hallazgos 🔴 4 · Crítico o 🟠 3 · Mayor. Si aparece alguno, comprueba si es real o inventado.
- [ ] Contrastes calculados y correctos (texto 17,21:1; secundario 7,00:1; botón 11,01:1).
- [ ] **No da "Apto" a secas:** con HTML estático, el anuncio real del lector de pantalla y el flujo completo quedan sin verificar (reglas de cierre 1 y 3). Estado esperado: **Pendiente de verificación**, con «la aprobación queda retenida» y la sección «Evidencia necesaria» (qué falta, criterio A/AA y cómo resolverlo).
- [ ] Lista lo No verificable y propone prueba con tecnologías de apoyo.

> **Decidido (16 oct 2026, renombrado en 0.8.0):** sin evidencia de lo crítico el estado es "Pendiente de verificación" (antes "No apto por evidencia insuficiente"), nunca "Apto con observaciones". Este último solo cuando no hay incumplimientos A/AA confirmados y las observaciones son AAA, buenas prácticas o mejoras.
>
> **Decidido (22 oct 2026):** severidad y conformidad son independientes. Un incumplimiento A/AA confirmado de nivel ⚪ 1 · Leve da No apto. Si B tiene un incumplimiento A/AA real (aunque sea Leve), el estado correcto es No apto: compruébalo antes de dar el caso por fallado.

## Caso C — Fragmento de código suelto
**Entrada:** `Audita este botón: <button type="submit" style="background:#1a4d8f;color:#fff;padding:12px 20px">Firmar 250,00 €</button>`

**Esperado:**
- [ ] Calcula el contraste (pasa) y lo dice.
- [ ] El foco visible queda en **No verificable** (no hay hoja de estilos), no como fallo ni como "pasa".
- [ ] No inventa problemas para rellenar.

## Caso D — Descripción con riesgo legal (producto regulado)
**Entrada:** `Revisa la accesibilidad de esta pantalla: en el alta de cuenta, las tres casillas de consentimiento de marketing vienen marcadas por defecto y el botón dice "Continuar".`

> **Cambiado (22 oct 2026):** antes decía «Audita esta pantalla…». Con dos especialistas, esa entrada es ambigua y en la ronda de la 0.8.0 se activó heurísticas, que es razonable para unas casillas premarcadas. El fallo era del examen, no del routing. La skill de accesibilidad no se adapta para capturar como propios los patrones engañosos que no son por sí mismos un incumplimiento de accesibilidad.

**Esperado:**
- [ ] Declara la entrada como **descripción**: casi todo queda No verificable.
- [ ] Aplica la lente de producto regulado y el ancla: el consentimiento premarcado aparece en **«Riesgos de producto (fuera de WCAG)»**, con **🟠 3 · Mayor mínimo**, categoría Legal o normativo y marca `[legal]`.
- [ ] **No** aparece en la tabla de hallazgos WCAG ni se presenta como incumplimiento WCAG (ningún criterio inventado).
- [ ] **El riesgo no cambia el estado de aprobación de accesibilidad.** Con una descripción no se puede verificar ningún criterio A/AA → **Pendiente de verificación**, con «la aprobación queda retenida» y «Evidencia necesaria». Si sale No apto por el consentimiento, el caso falla.
- [ ] Dice que si el riesgo bloquea la aprobación general lo decide el orquestador o el quality gate de producto.
- [ ] La normativa aparece solo por nombre, "por confirmar con Compliance".

## Caso E — No se activa cuando no toca
**Entrada:** `Corrige las erratas de demo/caso-firma-operacion.md`

**Esperado:**
- [ ] **No** se activa la skill de accesibilidad.

## Caso F (opcional) — Captura de pantalla
**Entrada:** haz una captura de `demo/pantalla-firma.html` abierta en el navegador (`Cmd+Shift+4`), arrástrala a Claude Code y escribe `Revisa la accesibilidad de esta captura`.

**Esperado:**
- [ ] Declara la entrada como **captura**.
- [ ] Teclado, foco, semántica y anuncios quedan en No verificable, no como fallos afirmados.
- [ ] Los contrastes se dan como aproximados.

## Hoja de resultados

| Fecha | Caso | ¿Pasa? | Qué falló | Cambio que haré en la skill |
| --- | --- | --- | --- | --- |
| | A | | | |
| | B | | | |
| | C | | | |
| | D | | | |
| | E | | | |
| | F | | | |

**La skill está lista para la demo cuando** A, B, C y E pasan y D pasa con como mucho un detalle menor.
