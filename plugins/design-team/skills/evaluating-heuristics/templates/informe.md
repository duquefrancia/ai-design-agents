# Plantilla del informe de evaluación heurística

Copia la estructura. Las secciones marcadas *(si aplica)* se omiten cuando no hay contenido. El ejemplo de abajo es de otra pantalla: sirve para ver el formato, no para copiar hallazgos.

```markdown
# Evaluación heurística: [pantalla o flujo]

**Entrada:** [HTML / captura / Figma / descripción] · qué permite ver y qué no
**Alcance:** [pantallas, pasos y estados evaluados] · fuera de alcance: [...]
**Contexto:** [persona usuaria · objetivo · tareas · sector] (supuestos con *)

## 1. Líneas rojas *(si aplica)*
| # | Línea roja | Estado | Evidencia observada | Decisión afectada | Perjuicio posible | Alternativa transparente |
|---|---|---|---|---|---|---|

## 2. Nota de validación
- **Por qué sale esta nota:** [qué se comprobó y con qué entrada · qué la sostiene · qué la haría cambiar]
- **Autocomprobación:** [bucle de validación pasado entero · lo que no pudo comprobarse]

## 3. Estado de aprobación
**[Apto / Apto con observaciones / Pendiente de verificación / No apto]** · [recuento: 🔴 n · 🟠 n · 🟡 n · ⚪ n] · [líneas rojas: n confirmadas · n indicios fundados]
**Motivo:** [qué hallazgo, línea roja, indicio o falta de evidencia lo determina. En Pendiente de verificación: «La aprobación queda retenida hasta resolver la Evidencia necesaria».]
**Válido para:** [...] · **No cubre:** [lo no comprobado, el resto del flujo, accesibilidad]
**Recomendación:** [qué hacer primero, en una frase]
> Este estado de aprobación es una recomendación experta. La decisión final es del equipo; la priorización se cierra con el equipo técnico, que valora viabilidad y esfuerzo.

## 4. Semáforo de las 10 heurísticas
Color = mayor severidad de los hallazgos que tienen esa heurística como **principal**. Las líneas rojas van en la sección 1 y no colorean. 🟢 solo con evidencia suficiente; sin ella, ⚫. «No aplica» solo si la heurística no corresponde al objeto, con motivo. No sirve para calcular el estado de aprobación.
| | H1 | H2 | H3 | H4 | H5 | H6 | H7 | H8 | H9 | H10 |
|---|---|---|---|---|---|---|---|---|---|---|
| Principal | [color y nivel · 🟢 0 · ⚫ · No aplica] | … |
| Relacionada en | [n.º de hallazgo o —] | … |

## 5. Resumen de hallazgos (de mayor a menor severidad)
| # | Problema | Severidad | Heurística principal | Riesgo específico | Línea roja | Confianza |
|---|---|---|---|---|---|---|

## 6. Fichas de hallazgos
### [#]. [Problema]
- **Evidencia:** ...
- **Tarea afectada:** ...
- **Consecuencia probable:** ...
- **Heurística principal:** ... · relacionadas: ...
- **Severidad:** ... [en 🟠 3 y 🔴 4: qué criterio de la rúbrica cumple]
- **Riesgo específico:** [categoría → consecuencia concreta] (una o varias)
- **Línea roja:** [confirmada / indicio fundado / no aplica]
- **Confianza:** [Alta / Media / Baja] · [justificación]
- **Corrección:** ...
- **Cómo verificarla:** ...
- **Ley de UX:** [solo si explica, orienta o fundamenta]
- **Esfuerzo:** a estimar con el equipo técnico

## 7. Evidencia necesaria *(si hay indicios fundados o falta evidencia esencial)*
| Qué falta | Cómo obtenerlo | Qué resolvería |
|---|---|---|

## 8. Lo que funciona bien
- [máximo 3, con el elemento concreto; aquí van los diseños justificados]

## 9. Hipótesis para validar con personas usuarias
- [lo que no se puede afirmar sin datos o test]

## 10. Para accesibilidad *(si aplica)*
- [comprobaciones de conformidad para auditing-accessibility; no cambian este estado de aprobación]
```

---

## Ejemplo completo

# Evaluación heurística: aumentar el límite de la tarjeta (Banco Lumen, ficticio)

**Entrada:** captura de una pantalla · se ve el contenido; no se ve qué pasa al pulsar ni la pantalla siguiente.
**Alcance:** pantalla "Límite de la tarjeta", estado inicial · fuera de alcance: confirmación, errores y pantalla de resultado.
**Contexto:** cliente de banca móvil* · subir el límite diario de su tarjeta para una compra · elegir nuevo límite y confirmar · banca digital.

## 1. Líneas rojas

| # | Línea roja | Estado | Evidencia observada | Decisión afectada | Perjuicio posible | Alternativa transparente |
|---|---|---|---|---|---|---|
| P2 | Extras no autorizados | Indicio fundado | Casilla "Activar seguro de compras (2,95 €/mes)" bajo el selector; en la captura no se distingue si está marcada | Contratar o no un seguro | Cargo mensual no autorizado | Casilla desmarcada por defecto y el seguro en un paso aparte |

## 2. Nota de validación

- **Por qué sale esta nota:** se evaluó una captura del estado inicial. El cambio de límite se entiende y el botón dice el nuevo límite (🟢 en H1 y H5). No hay motivo de rechazo demostrado, pero no se puede saber si el seguro viene marcado. Si se confirma desmarcado, pasaría a Apto con observaciones; si viene marcado, a No apto.
- **Autocomprobación:** bucle de validación pasado entero. Sin evaluar: H3, H7 y H9, porque la captura no muestra comportamiento ni errores.

## 3. Estado de aprobación

**Pendiente de verificación** · 🔴 0 · 🟠 0 · 🟡 1 · ⚪ 1 · líneas rojas: 0 confirmadas · 1 indicio fundado
**Motivo:** indicio fundado de P2 (casilla del seguro) sin resolver. La aprobación queda retenida hasta resolver la Evidencia necesaria.
**Válido para:** pantalla "Límite de la tarjeta", estado inicial · **No cubre:** confirmación, errores, resultado y accesibilidad.
**Recomendación:** comprobar el estado por defecto de la casilla del seguro antes de cualquier otra cosa.
> Este estado de aprobación es una recomendación experta. La decisión final es del equipo; la priorización se cierra con el equipo técnico, que valora viabilidad y esfuerzo.

## 4. Semáforo de las 10 heurísticas

| | H1 | H2 | H3 | H4 | H5 | H6 | H7 | H8 | H9 | H10 |
|---|---|---|---|---|---|---|---|---|---|---|
| Principal | 🟢 0 | 🟡 2 | ⚫ | 🟢 0 | 🟢 0 | 🟢 0 | ⚫ | ⚪ 1 | ⚫ | 🟢 0 |
| Relacionada en | — | — | — | — | — | — | — | — | — | #1 |

H10 está en 🟢 porque no es principal de ningún hallazgo; aparece como relacionada en el hallazgo 1. El indicio P2 no colorea ninguna heurística.

## 5. Resumen de hallazgos

| # | Problema | Severidad | Heurística principal | Riesgo específico | Línea roja | Confianza |
|---|---|---|---|---|---|---|
| 1 | Siglas del límite sin explicar | 🟡 2 · Moderado | H2 | Económico | No aplica | Media |
| 2 | Banner de puntos compite con la tarea | ⚪ 1 · Leve | H8 | Sin riesgo específico identificado | No aplica | Alta |

## 6. Fichas de hallazgos

### 1. Siglas del límite sin explicar
- **Evidencia:** texto "Límite operativo ATM/TPV".
- **Tarea afectada:** decidir qué límite subir para una compra en tienda.
- **Consecuencia probable:** la persona sube un límite que no cubre su compra y la tarjeta es rechazada en caja.
- **Heurística principal:** H2 · relacionadas: H10.
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:** Económico → compra rechazada o límite subido más de lo necesario.
- **Línea roja:** no aplica.
- **Confianza:** Media · las siglas se ven, pero no sabemos cuántas personas las entienden.
- **Corrección:** "Límite para cajeros y compras en tienda".
- **Cómo verificarla:** test de 5 preguntas a personas usuarias: "¿Este límite cubre una compra en tienda?".
- **Ley de UX:** Jakob (orienta la comprobación: ¿qué término usan otras apps de banca?).
- **Esfuerzo:** a estimar con el equipo técnico.

### 2. Banner de puntos compite con la tarea
- **Evidencia:** banner "Gana puntos" encima del selector de límite.
- **Tarea afectada:** elegir el nuevo límite.
- **Consecuencia probable:** distracción leve; la tarea se completa.
- **Heurística principal:** H8.
- **Severidad:** ⚪ 1 · Leve.
- **Riesgo específico:** Sin riesgo específico identificado.
- **Línea roja:** no aplica.
- **Confianza:** Alta · el banner se ve y no bloquea ningún control.
- **Corrección:** mover el banner después de la confirmación.
- **Cómo verificarla:** revisión visual del nuevo orden en el prototipo.
- **Esfuerzo:** a estimar con el equipo técnico.

## 7. Evidencia necesaria

| Qué falta | Cómo obtenerlo | Qué resolvería |
|---|---|---|
| Estado por defecto de la casilla del seguro | Prototipo o HTML de la pantalla en su estado inicial | El indicio P2: confirmado (No apto) o descartado |
| Qué pasa al confirmar y si hay error | Captura o prototipo de la pantalla siguiente y del error | H1, H3 y H9 en el resultado |

## 8. Lo que funciona bien

- El botón dice "Subir límite a 1.500 €": la acción y la cifra están a la vista al confirmar.
- La petición de Face ID antes de confirmar es diseño justificado: autenticación reforzada, explicada y proporcionada.

## 9. Hipótesis para validar con personas usuarias

- Si quienes usan poco la banca móvil entienden que el límite vuelve a su valor anterior al día siguiente.

## 10. Para accesibilidad

- El texto gris claro del pie parece de bajo contraste: verificar con auditing-accessibility.
