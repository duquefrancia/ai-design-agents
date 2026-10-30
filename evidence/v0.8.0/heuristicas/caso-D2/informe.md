# Evaluación heurística: confirmar transferencia a destinatario nuevo (Banco Lumen, ficticio)

**Entrada:** HTML estático (`demo/pantalla-confirmar-destinatario-nuevo.html`). Permite ver los textos, el orden, los controles y los estilos. No permite ver qué pasa al pulsar: los botones son `type="button"` y no tienen manejador.
**Alcance:** pantalla «Revisa tu transferencia» en un único estado: destinatario nuevo con el nombre verificado («coincide»). Fuera de alcance: los otros resultados de la verificación del nombre, Face ID, el resultado de la operación, los errores y el paso anterior.
**Contexto:** cliente de banca móvil* · enviar 3.000 € a alguien a quien no ha pagado antes · revisar los datos y confirmar o cancelar · banca digital.

## 1. Líneas rojas

Revisé las 14 y no hay ninguna confirmada ni con indicio fundado.
- **U1:** se cumple el resumen previo. Antes del botón se ven el importe, el destinatario, la comisión y el total.
- **P1:** se muestran «Sin comisión» y «Total que se cargará».
- **P5 y P6:** «Confirmar y enviar 3.000,00 €» hace lo que anuncia, y «Cancelar transferencia» se ve tanto como la acción principal.
- **U2, U3 y U4:** no se pueden evaluar porque el HTML no muestra el resultado ni los errores. Van en «Evidencia necesaria».

## 2. Nota de validación

- **Por qué sale esta nota:** evalué el HTML del estado «nombre coincide». El resumen está completo, el botón muestra la cifra, el aviso antifraude está antes de confirmar y Face ID se anuncia. El único hallazgo es 🟡 2: la cuenta de destino aparece truncada. La nota cambiaría si los estados «no coincide» o «no disponible», el resultado o el doble envío revelasen problemas. Esos estados quedan fuera de este alcance.
- **Autocomprobación:** pasé el bucle de validación entero. No pude comprobar el comportamiento de los botones, la protección contra doble envío, qué datos se conservan al volver ni si la transferencia es reversible.

## 3. Estado de aprobación

**Apto con observaciones** · 🔴 0 · 🟠 0 · 🟡 1 · ⚪ 0 · líneas rojas: 0 confirmadas · 0 indicios fundados
**Motivo:** hay un hallazgo 🟡 2 (cuenta de destino truncada) y ninguno de nivel 3 o 4. No hay líneas rojas ni indicios.
**Válido para:** esta pantalla, en estado inicial con el nombre verificado.
**No cubre:** los estados «coincide parcialmente», «no coincide» y «no disponible», la pantalla tras Face ID, el resultado, los errores, el comportamiento de «Cancelar», «Volver» y «Editar datos», y la accesibilidad.
**Recomendación:** mostrar el IBAN completo y agrupado del destinatario nuevo, y después evaluar los demás estados de la verificación del nombre.
> Este estado de aprobación es una recomendación experta. La decisión final es del equipo; la priorización se cierra con el equipo técnico, que valora viabilidad y esfuerzo.

## 4. Semáforo de las 10 heurísticas

| | H1 | H2 | H3 | H4 | H5 | H6 | H7 | H8 | H9 | H10 |
|---|---|---|---|---|---|---|---|---|---|---|
| Principal | 🟢 0 | 🟢 0 | ⚫ | 🟢 0 | 🟢 0 | 🟡 2 | No aplica | 🟢 0 | ⚫ | 🟢 0 |
| Relacionada en | — | — | — | — | #1 | — | — | — | — | — |

- **H1:** 🟢 solo para esta pantalla. El resultado tras enviar queda fuera de alcance.
- **H3:** «Volver» y «Cancelar transferencia» existen, pero no se puede ver si se pierden datos o si se pide confirmación. Por eso es ⚫.
- **H5:** 🟢 en el resumen. La protección contra doble envío no se puede evaluar.
- **H7:** No aplica. Es una pantalla de confirmación sin campos que rellenar; los atajos corresponden al paso anterior.
- **H9:** ⚫. No hay estados de error en la entrada.

## 5. Resumen de hallazgos

| # | Problema | Severidad | Heurística principal | Riesgo específico | Línea roja | Confianza |
|---|---|---|---|---|---|---|
| 1 | La cuenta de un destinatario nuevo solo se muestra truncada | 🟡 2 · Moderado | H6 | Económico | No aplica | Media |

## 6. Fichas de hallazgos

### 1. La cuenta de un destinatario nuevo solo se muestra truncada
- **Evidencia:** `<dt>Cuenta de destino</dt><dd>Terminada en 9012</dd>`, junto a la etiqueta «Destinatario nuevo».
- **Tarea afectada:** comprobar, antes de enviar 3.000 €, que la cuenta es la que le han dado.
- **Consecuencia probable:** si hay un error en los dígitos centrales, la persona no puede detectarlo aquí. Tiene que fiarse de lo que escribió en el paso anterior o volver atrás para mirarlo.
- **Heurística principal:** H6 (el dato del paso anterior no se repite completo al confirmar) · relacionada: H5.
- **Severidad:** 🟡 2 · Moderado. La verificación del nombre («El nombre coincide con el titular») reduce el riesgo de que la cuenta sea equivocada. Por eso no sube a 3.
- **Riesgo específico:** Económico → transferencia de 3.000 € a una cuenta que no es la prevista.
- **Línea roja:** no aplica. U1 se cumple: el destinatario sí está identificado.
- **Confianza:** Media. El truncado se observa. La mitigación depende de cómo funcione la verificación del nombre, y eso no se ve en el HTML.
- **Corrección:** en destinatarios nuevos, mostrar el IBAN completo agrupado de 4 en 4 (`ES12 3456 7890 1234 5678 9012`) y, si se conoce, el nombre del banco de destino. El truncado puede quedarse para destinatarios ya guardados.
- **Cómo verificarla:** test con datos sintéticos en el que se introduce un IBAN con un dígito central cambiado. Contar cuántas personas detectan el error en esta pantalla, comparando la versión truncada con la completa.
- **Ley de UX:** Miller (fundamenta el agrupado de 4 en 4 para cotejar el número).
- **Esfuerzo:** a estimar con el equipo técnico.

## 7. Evidencia necesaria

No bloquea esta aprobación, que se limita al estado evaluado. Sí hace falta para aprobar el flujo.

| Qué falta | Cómo obtenerlo | Qué resolvería |
|---|---|---|
| Los estados «coincide parcialmente», «no coincide» y «no disponible» de la verificación del nombre | HTML o prototipo de cada estado | H1, H5 y H9 en el caso de más riesgo del destinatario nuevo |
| Qué pasa tras Face ID: éxito, pendiente, fallo, Face ID rechazado | Pantallas de resultado y de error | U2, U4, H1 y H9 |
| Protección contra doble envío del botón principal | Prototipo funcional o especificación | H5 |
| Si «Cancelar transferencia» pide confirmación y si «Volver» o «Editar datos» conservan lo rellenado | Prototipo funcional | H3 y U3 |
| Si la transferencia es inmediata e irrevocable («Llegada: Hoy») | Regla de negocio del banco (pregunta abierta) | Si hay que avisar de que no se puede anular una vez enviada |
| En qué plataformas se muestra el texto «Face ID» | Especificación de plataformas | H4: en Android el término no corresponde |

## 8. Lo que funciona bien

- El resumen completo (importe, destinatario, cuenta de origen, concepto, comisión, total y llegada) y el botón «Confirmar y enviar 3.000,00 €» repiten la cifra en el momento de decidir.
- El aviso antifraude («Si alguien te ha pedido esta transferencia por teléfono o mensaje, no la confirmes») está justo antes de confirmar, en lenguaje claro.
- Pedir Face ID es un diseño justificado: es autenticación reforzada, se anuncia antes de pulsar y es proporcionada para 3.000 € a un destinatario nuevo.

## 9. Hipótesis para validar con personas usuarias

- El bloque verde con la marca de verificación puede leerse como «destinatario seguro», cuando solo confirma que el nombre coincide con la cuenta. En un fraude donde el estafador cobra en una cuenta a su nombre, ese mensaje podría restar fuerza al aviso antifraude. Hay que validarlo con un test de comprensión: «¿Qué te garantiza este mensaje?».
- No sabemos si las personas relacionan «El nombre coincide…» con «Pedro Gil». El mensaje aparece antes del resumen y no junto al campo «Destinatario».

## 10. Para accesibilidad

Estas comprobaciones son para `auditing-accessibility` y no cambian este estado de aprobación:
- **Foco de «Volver» posiblemente invisible:** `header a:focus-visible` usa `outline: 3px solid #0b3d6e` sobre una cabecera con fondo `#0b3d6e`. El contorno sería del mismo color que el fondo. Hay que comprobarlo con WCAG 2.4.7 y 2.4.13.
- **Orden de lectura:** el lector de pantalla anuncia «El nombre coincide…» antes de leer el nombre del destinatario.
- **Etiqueta «Destinatario nuevo»:** es un `<span>` sin relación semántica con el resumen. Hay que comprobar cómo la anuncian VoiceOver y TalkBack.
