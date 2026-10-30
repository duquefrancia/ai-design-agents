# Changelog · Registro de cambios

Public summary of the `design-team` plugin versions. · Resumen público de las versiones del plugin `design-team`.

## [0.8.0] — 2026-10-23 · Validated · Validada

**EN** · One shared language, separate criteria.
- Shared severity scale and shared approval states for accessibility and heuristics; each discipline keeps its own approval rule.
- Accessibility: any confirmed WCAG A/AA failure means *Not approved*, whatever its severity. Full coverage of the 55 WCAG 2.2 A/AA criteria. Product risks outside WCAG recorded separately. Report traceability (date, version, object, reviewer).
- Shared coverage: Evaluated · Partially evaluated · Not evaluated · Not applicable.
- Orchestrator: global result by most restrictive state, no averaging; risk acceptance rules for 🟠 3 and 🔴 4; "Not applicable" confirmed at scope sign-off.
- Validation: accessibility 5/5, heuristics 6/6 in an isolated classroom, coverage regression, and end-to-end orchestrator test accepted with one contained incident.

**ES** · Un mismo idioma, criterios separados.
- Escala de severidad y estados de aprobación comunes en accesibilidad y heurísticas; cada disciplina conserva su regla de aprobación.
- Accesibilidad: todo incumplimiento WCAG A/AA confirmado da *No apto*, sea cual sea su severidad. Cobertura de los 55 criterios A/AA de WCAG 2.2. Riesgos de producto fuera de WCAG registrados aparte. Trazabilidad del informe (fecha, versión, objeto y responsable).
- Cobertura común: Evaluado · Parcialmente evaluado · Sin evaluar · No aplica.
- Orquestador: resultado global por el estado más restrictivo, sin medias; reglas de aceptación de riesgo para 🟠 3 y 🔴 4; «No aplica» confirmado en la firma del alcance.
- Validación: accesibilidad 5/5, heurísticas 6/6 en aula aislada, regresión de cobertura y prueba punta a punta del orquestador aceptada con una incidencia contenida.

## [0.6.0 – 0.7.0] — 2026-10-21 · Heuristics agent · Agente de heurísticas

**EN** · Nielsen as the main structure, 14 red lines, independent decision layers (heuristic, red line, severity, risk, confidence, approval), isolated classroom with traces after detecting unrequested saves and commits.

**ES** · Nielsen como estructura principal, 14 líneas rojas, capas de decisión independientes (heurística, línea roja, severidad, riesgo, confianza y aprobación) y aula aislada con traza tras detectar guardados y commits no pedidos.

## [0.2.0 – 0.5.0] — 2026-10-18 · Accessibility agent · Agente de accesibilidad

**EN** · My criteria inside the skill (severity anchors, red lines, verdicts), regulated-product lenses, fixed report template, answer keys and test cases; "insufficient evidence" separated from "approved with observations"; every audit independent.

**ES** · Mi criterio dentro de la skill (anclas de severidad, líneas rojas y veredictos), lentes de producto regulado, plantilla de informe fija, hojas de respuestas y casos de prueba; «evidencia insuficiente» separada de «apto con observaciones»; cada auditoría, independiente.
