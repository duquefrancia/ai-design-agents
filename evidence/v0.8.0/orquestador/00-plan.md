# Plan · Firma de transferencia (Banco Lumen) · v0.8.0

**Reto:** `demo/caso-firma-operacion.md`
**Pantalla actual:** `demo/pantalla-firma.html` (web móvil, HTML estático)
**Entregables:** `entregables/firma-0.8.0/`
**Estado:** pendiente de firma del alcance

## Objetivo
Que firmar una transferencia con código SMS sea seguro, comprensible y accesible, también con lector de pantalla o mala conexión. Que el cliente sepa siempre si la transferencia se ha hecho.

## Fases

| # | Fase | Agente | Entregable | Firma |
|---|---|---|---|---|
| 1 | Plan y alcance | Head of Design | `00-plan.md` | Alcance (tú) |
| 2a | Mapa de casos | `workflow-mapper` | `01-flujo.md` | — |
| 2b | Historias INVEST + Gherkin | `user-story-writer` (a partir de `01-flujo.md`) | `02-historias.md` | **Producto** |
| 3 | Componentes del flujo | `design-system-specialist` | `03-componentes.md` | — |
| 4 | Evaluación en paralelo | `ux-heuristics-expert` · `accessibility-auditor` | `04-heuristicas.md` · `05-accesibilidad.md` | **Accesibilidad y Contenido** (y aceptación de riesgos 🟠 3 / 🔴 4, si los hay) |
| 5 | Revisión cruzada | `ux-heuristics-expert` revisa historias · `accessibility-auditor` revisa componentes | Cambios propuestos (se anotan en `06-informe.md`) | — |
| 6 | Informe final | Head of Design | `06-informe.md` | — |

## Evaluaciones que aplican

| Evaluación | ¿Aplica? | Alcance | Motivo |
|---|---|---|---|
| Heurísticas (Nielsen + controles banca + líneas rojas) | **Sí** | `demo/pantalla-firma.html` | Hay pantalla real. Operación con dinero. |
| Accesibilidad (WCAG 2.2 AA) | **Sí** | `demo/pantalla-firma.html` | Hay pantalla real. WCAG 2.2 AA es restricción del reto. |

No propongo ninguna evaluación como «No aplica».

## Límites del alcance (a confirmar con tu firma)
- Se evalúa **solo la pantalla de firma**. Las pantallas de «rellenar transferencia» y «Operación realizada / error» no tienen prototipo: entran en flujo, historias y componentes, pero no en las evaluaciones.
- La pantalla es **HTML estático**: no hay temporizador real, envío de SMS, validación ni estados de red. Lo que dependa de comportamiento real (lector de pantalla en dispositivo, anuncio de cambios, caducidad, reenvío) quedará como **Pendiente de verificación**, no como aprobado.
- Plataforma: web móvil. Apple HIG y Material 3 solo como referencia de convenciones, no de app nativa.

## Preguntas abiertas para negocio (del reto)
1. Cuántos intentos de código se permiten antes de bloquear la firma.
2. Cuánto dura el código y si se puede reenviar.
3. Qué pasa con la transferencia si la conexión se corta justo después de firmar.

No se inventarán respuestas: los agentes las tratarán como hipótesis o preguntas.

## Reglas de trabajo
- Me detengo en cada firma. No doy fases por aprobadas.
- Riesgos de producto 🟠 3 / 🔴 4 bloquean el global hasta que alguien con responsabilidad los acepte con datos. Yo no los acepto.
- Lo que un agente no pueda verificar va a riesgos abiertos.
