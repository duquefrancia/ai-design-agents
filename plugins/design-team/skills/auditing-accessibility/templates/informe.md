# Plantilla de informe

Copia la estructura. Las secciones 4, 7 y 8 y la línea de cumplimiento solo si aplican.

```markdown
# Auditoría de accesibilidad · [pantalla o flujo]

## 1. Estado de aprobación
**[Apto | Apto con observaciones | Pendiente de verificación | No apto]** · 🔴 4 · Crítico: n · 🟠 3 · Mayor: n · 🟡 2 · Moderado: n · ⚪ 1 · Leve: n
[Motivo: qué incumplimiento A/AA, línea roja o falta de evidencia lo determina. En Pendiente de verificación: «La aprobación queda retenida hasta resolver la Evidencia necesaria».]
[Líneas rojas, si las hay, con nombre propio.]
[Resumen en máximo 3 líneas.]
[Cumplimiento: normativa aplicable por nombre — solo producto regulado.]

## 2. Entrada, alcance y trazabilidad
- Tipo de entrada: [HTML | captura | Figma | descripción | mixta]
- Plataforma: [web | iOS | Android]
- Alcance: [pantallas auditadas; muestreo si lo hay]
- Trazabilidad: fecha [AAAA-MM-DD] · skill auditing-accessibility [versión del plugin] · objeto evaluado [archivo, URL, build o versión de Figma] · responsable de la revisión [persona o «pendiente de asignar»]

## 3. Hallazgos
| # | Criterio WCAG | Elemento | Evidencia | Severidad | Arreglo |
|---|---|---|---|---|---|
[Severidad con color, número y nombre: «🟠 3 · Mayor». Todo incumplimiento A/AA confirmado da No apto, sea cual sea su severidad.]
No aplica: [criterios] — [motivo: p. ej. no hay vídeo ni audio]

## 4. Riesgos de producto (fuera de WCAG)
No son incumplimientos WCAG y no cambian el estado de aprobación de accesibilidad. Si bloquean la aprobación general lo decide el orquestador o el quality gate de producto.
| # | Lente | Elemento | Evidencia | Severidad | Categoría de riesgo | Arreglo |
|---|---|---|---|---|---|---|

## 5. No verificable
- [Qué] — [por qué la entrada no lo permite] — [qué haría falta]

## 6. Prueba con personas usuarias de tecnologías de apoyo
- [Tarea] con [lector de pantalla / teclado / zoom / switch]: [qué observar]

## 7. Evidencia necesaria
Si el estado de aprobación es Pendiente de verificación, o si es No apto y además falta evidencia de otros criterios.
| Qué falta exactamente | Criterio A/AA que permite decidir | Cómo resolverlo (conseguirla o implementarla) |
|---|---|---|

## 8. Observaciones
Mejoras sin incumplimiento A/AA confirmado: recomendaciones AAA, buenas prácticas, calidad accesible adicional. No cambian el estado de aprobación.
- [Observación] — [elemento] — [mejora]
```

---

# Ejemplo

```markdown
# Auditoría de accesibilidad · Confirmar transferencia (app web)

## 1. Estado de aprobación
**No apto** · 🔴 4 · Crítico: 1 · 🟠 3 · Mayor: 2 · 🟡 2 · Moderado: 1 · ⚪ 1 · Leve: 0
Motivo: cuatro incumplimientos AA confirmados y una línea roja.
Línea roja: foco invisible. `button.confirm:focus { outline: none }` sin estilo alternativo.
La transferencia no se puede confirmar con teclado con seguridad y su resultado no se anuncia.
Cumplimiento: hallazgos AA con riesgo bajo European Accessibility Act y Ley 11/2023 (detalle por confirmar con compliance).

## 2. Entrada, alcance y trazabilidad
- Tipo de entrada: HTML + CSS
- Plataforma: web
- Alcance: 1 pantalla (paso 3 de 3 del flujo de transferencia)
- Trazabilidad: fecha 2026-10-22 · skill auditing-accessibility 0.8.0 · objeto evaluado `transferencia-paso-3.html` · responsable de la revisión: pendiente de asignar

## 3. Hallazgos
| # | Criterio WCAG | Elemento | Evidencia | Severidad | Arreglo |
|---|---|---|---|---|---|
| 1 | 2.4.7 Foco visible | `button.confirm` | `outline: none` en `:focus`, sin alternativa | 🔴 4 · Crítico | Añadir `:focus-visible` con contorno ≥3:1 sobre el fondo [rápido] |
| 2 | 4.1.3 Mensajes de estado | `div.result` | Texto "Transferencia realizada" inyectado sin `role="status"` | 🟠 3 · Mayor | Añadir `role="status"` al contenedor antes de inyectar el texto [rápido] |
| 3 | 1.4.3 Contraste mínimo | `p.amount-detail` | #8a8a8a sobre #ffffff = 3,45:1 | 🟠 3 · Mayor | Usar token de texto secundario ≥4,5:1, p. ej. #6b6b6b [rápido] |
| 4 | 2.4.3 Orden del foco | `a.help` | Recibe foco después del pie de página | 🟡 2 · Moderado | Reordenar en el DOM tras el resumen [medio] |

## 5. No verificable
- Anuncio real en NVDA/VoiceOver — requiere prueba en vivo.
- Caducidad del código de un solo uso — el paso 2 no se ha entregado.

## 6. Prueba con personas usuarias de tecnologías de apoyo
- Confirmar una transferencia solo con teclado: ¿se ve dónde está el foco en cada paso?
- Con lector de pantalla: ¿oye importe y destinatario antes de confirmar, y el resultado después?
```
