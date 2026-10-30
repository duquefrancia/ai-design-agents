# Evaluación heurística: confirmación de transferencia a destinatario nuevo

**Entrada:** descripción en texto. Permite valorar el contenido descrito y detectar riesgos. No permite ver la jerarquía visual, el orden real de los pasos, el resto de controles ni lo que ocurre al confirmar.
**Alcance:** paso de revisión y autenticación antes de enviar 3.000 € · fuera de alcance: pasos anteriores (alta del destinatario, introducción del importe), resultado, errores y accesibilidad.
**Contexto:** cliente de banca móvil en iOS* · enviar 3.000 € a alguien a quien nunca ha pagado · revisar los datos, autenticarse y confirmar o cancelar · banca digital.

## 1. Líneas rojas

No hay líneas rojas confirmadas ni indicios fundados.

- **U1 (mover dinero sin resumen):** el resumen muestra el importe y el destinatario. Las comisiones no aparecen en el texto descrito. Puede ser que no haya o que estén en otro sitio: es información no aportada, no un indicio. Va a «Evidencia necesaria».
- **U2, U3 y U4:** ⚫ Sin evaluar. La descripción no incluye el resultado ni los errores.
- **P1–P10:** no hay ninguna señal observable.

## 2. Nota de validación

- **Por qué sale esta nota:** solo se ha evaluado una descripción. No hay ningún hallazgo 🟠 3 o 🔴 4 sustentado ni ninguna línea roja. Faltan cosas esenciales: las comisiones, el orden entre Face ID y el resumen, y qué hace «Cancelar». Con una descripción no puede salir Apto. Si se aportan prototipos y se confirma que no hay comisiones ocultas, pasaría a Apto con observaciones. Pasaría a No apto si en las comisiones o el plazo aparece un coste no mostrado.
- **Autocomprobación:** he revisado todo el bucle de validación. No he podido comprobar el aspecto visual, el comportamiento, los errores, el resultado ni la accesibilidad.

## 3. Estado de aprobación

**Pendiente de verificación** · 🔴 0 · 🟠 0 · 🟡 2 · ⚪ 1 · líneas rojas: 0 confirmadas · 0 indicios fundados
**Motivo:** falta evidencia esencial (comisiones, orden de los pasos, efecto de «Cancelar»). La aprobación queda retenida hasta resolver la Evidencia necesaria.
**Válido para:** el paso de revisión descrito, estado inicial · **No cubre:** pasos anteriores, resultado, errores, plazo de ejecución ni accesibilidad.
**Recomendación:** que el aviso hable del fraude típico con destinatarios nuevos y que el resumen diga que el destinatario es nuevo.
> Este estado de aprobación es una recomendación experta. La decisión final es del equipo; la priorización se cierra con el equipo técnico, que valora viabilidad y esfuerzo.

## 4. Semáforo de las 10 heurísticas

| | H1 | H2 | H3 | H4 | H5 | H6 | H7 | H8 | H9 | H10 |
|---|---|---|---|---|---|---|---|---|---|---|
| Principal | ⚫ | ⚫ | 🟡 2 | ⚪ 1 | 🟡 2 | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |
| Relacionada en | #1 | — | — | — | #3 | — | — | — | — | — |

Algunas heurísticas no tienen hallazgos, pero una descripción no basta para darlas en 🟢. Por eso quedan en ⚫.

## 5. Resumen de hallazgos

| # | Problema | Severidad | Heurística principal | Riesgo específico | Línea roja | Confianza |
|---|---|---|---|---|---|---|
| 1 | El aviso no protege frente al fraude más probable con destinatarios nuevos | 🟡 2 · Moderado | H5 | Económico | No aplica | Media |
| 2 | Si hay un dato erróneo, no hay forma de corregirlo sin cancelar | 🟡 2 · Moderado | H3 | Económico | No aplica | Baja |
| 3 | «Confirmar» no dice qué acción ejecuta | ⚪ 1 · Leve | H4 | Sin riesgo específico identificado | No aplica | Media |

## 6. Fichas de hallazgos

### 1. El aviso no protege frente al fraude más probable con destinatarios nuevos
- **Evidencia:** «Si no reconoces esta operación, cancela.» El resumen no dice que Pedro Gil es un destinatario nuevo. Solo muestra «cuenta terminada en 9012» y no dice si el nombre coincide con el titular de la cuenta.
- **Tarea afectada:** decidir si se envían 3.000 € a alguien a quien nunca se ha pagado.
- **Consecuencia probable:** el aviso sirve si otra persona ha iniciado la operación. Pero si a la persona usuaria la han engañado para que la haga ella misma, sí la «reconoce», y el aviso no la frena. Tampoco puede comprobar la cuenta completa ni ve una señal de que el destinatario es nuevo. Esto es una hipótesis: no tengo datos de fraude de esta app.
- **Heurística principal:** H5 · relacionadas: H1 (no se muestra que el destinatario es nuevo).
- **Severidad:** 🟡 2 · Moderado. La transferencia se puede hacer y el resumen tiene datos clave. Subiría a 🟠 3 si los pasos anteriores tampoco avisan del destinatario nuevo ni comprueban el nombre del titular.
- **Riesgo específico:** Económico → transferencia de 3.000 € a un estafador, difícil de recuperar. Legal o normativo → posible implicación con la verificación del beneficiario que exige el Reglamento (UE) 2024/886 para transferencias SEPA. No está verificado si la app la hace en otro paso.
- **Línea roja:** no aplica.
- **Confianza:** Media · el texto citado es literal. El efecto depende de los pasos anteriores, que no se han aportado.
- **Corrección:** añadir la etiqueta «Destinatario nuevo». Mostrar el resultado de la comprobación del titular (coincide / coincide parcialmente / no coincide). Cambiar el aviso por uno concreto, por ejemplo: «Tu banco nunca te pedirá que hagas una transferencia. Si alguien te está guiando por teléfono o mensaje, cancela.» Mantener Face ID.
- **Cómo verificarla:** test con un escenario de suplantación por teléfono: medir cuántas personas cancelan con el aviso actual y con el nuevo. Revisión legal del flujo de verificación del beneficiario.
- **Esfuerzo:** a estimar con el equipo técnico.

### 2. Si hay un dato erróneo, no hay forma de corregirlo sin cancelar
- **Evidencia:** solo se describen los botones «Cancelar» y «Confirmar». No hay «Editar» ni «Volver».
- **Tarea afectada:** corregir el importe o el destinatario al ver un error en el resumen.
- **Consecuencia probable:** hay que empezar de cero. Si cuesta repetir los pasos, aumenta la tentación de confirmar sin cambiar nada. Es una hipótesis: puede que haya una navegación hacia atrás que no se ha descrito.
- **Heurística principal:** H3.
- **Severidad:** 🟡 2 · Moderado.
- **Riesgo específico:** Económico → confirmar un importe o un destinatario incorrectos para no repetir el proceso.
- **Línea roja:** no aplica. Se puede cancelar, así que no se cumple U3.
- **Confianza:** Baja · depende de controles que no se han descrito.
- **Corrección:** añadir «Editar» junto al importe y al destinatario. Al volver, los datos tienen que seguir rellenos.
- **Cómo verificarla:** recorrido en el prototipo: cambiar el importe desde el resumen sin volver a escribir el destinatario.
- **Esfuerzo:** a estimar con el equipo técnico.

### 3. «Confirmar» no dice qué acción ejecuta
- **Evidencia:** botón «Confirmar».
- **Tarea afectada:** la acción final de envío.
- **Consecuencia probable:** es más fácil confirmar por inercia. El importe ya está en el texto, así que el impacto es bajo.
- **Heurística principal:** H4 · relacionadas: H5.
- **Severidad:** ⚪ 1 · Leve.
- **Riesgo específico:** Sin riesgo específico identificado.
- **Línea roja:** no aplica.
- **Confianza:** Media · el texto es literal. Apple HIG recomienda que los botones de las alertas usen un verbo específico.
- **Corrección:** «Enviar 3.000,00 €».
- **Cómo verificarla:** revisar los textos del prototipo frente a la guía de alertas de Apple HIG.
- **Esfuerzo:** a estimar con el equipo técnico.

## 7. Evidencia necesaria

| Qué falta | Cómo obtenerlo | Qué resolvería |
|---|---|---|
| Comisiones y plazo de la transferencia (inmediata o estándar) | Prototipo o especificación del resumen | U1: se descarta o se abre un hallazgo |
| Orden entre Face ID y el resumen: ¿Face ID autoriza después de revisar? | Prototipo navegable | Si la autenticación va ligada a los datos revisados |
| Qué hace «Cancelar» y si hay navegación hacia atrás | Prototipo | Confirmar o descartar el hallazgo 2 |
| Si los pasos anteriores avisan del destinatario nuevo y comprueban el titular | Capturas del alta del destinatario | La severidad del hallazgo 1 |
| Pantallas de resultado y de error | Capturas o prototipo | U2, U4, H1 y H9 |

## 8. Lo que funciona bien

- Face ID antes de enviar 3.000 € a un destinatario nuevo es un diseño justificado: autenticación reforzada, proporcionada al importe y al riesgo.
- «Revisa: 3.000,00 € a Pedro Gil» pone el importe con decimales y el nombre justo antes de la decisión.
- Hay una salida clara («Cancelar») en una acción difícil de revertir.

## 9. Hipótesis para validar con personas usuarias

- Si quienes reciben una llamada fraudulenta interpretan «Si no reconoces esta operación» como algo que no va con ellas.
- Si los 4 últimos dígitos bastan para darse cuenta de que la cuenta es otra.

## 10. Para accesibilidad

Estos puntos van a `auditing-accessibility`:
- Alternativa al Face ID (código del dispositivo) para quien no puede usarlo.
- Cómo lee VoiceOver «3.000,00 €» y «9012»: tiene que ser dígito a dígito, no «nueve mil doce».
- El resumen y el aviso tienen que funcionar con texto grande (Dynamic Type).
