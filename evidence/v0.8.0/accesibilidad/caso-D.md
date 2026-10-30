# Evaluación heurística: consentimientos de marketing en el alta de cuenta

**Entrada:** descripción verbal · «en el alta de cuenta, las tres casillas de consentimiento de marketing vienen marcadas por defecto y el botón dice "Continuar"». No hay captura, HTML ni prototipo: no se ven los textos de las casillas, la jerarquía, el resto de la pantalla ni lo que pasa al pulsar.
**Alcance:** paso de consentimientos de marketing dentro del alta, estado inicial · fuera de alcance: resto del alta, pantalla siguiente, errores, gestión posterior de los consentimientos y accesibilidad.
**Contexto:** persona que abre una cuenta* · terminar el alta · decidir sobre tres usos de marketing y continuar · sector no indicado (posiblemente banca digital*).

## 1. Líneas rojas

| # | Línea roja | Estado | Evidencia observada | Decisión afectada | Perjuicio posible | Alternativa transparente |
|---|---|---|---|---|---|---|
| P2 | Extras y decisiones no autorizados (*Preselection*) | Confirmada, según la descripción aportada | Las tres casillas de consentimiento de marketing «vienen marcadas por defecto»; pulsar «Continuar» sin tocarlas deja los tres consentimientos activos | Aceptar o no tres usos opcionales de sus datos personales para marketing | Tratamiento de datos y comunicaciones comerciales que la persona no ha autorizado de forma activa | Las tres casillas desmarcadas por defecto; cada una con su finalidad en una frase; «Continuar» funciona igual con cero, una o tres marcadas |

La confirmación descansa en la descripción: si la pantalla real no coincide (por ejemplo, las casillas no vienen marcadas), la línea roja y el estado de aprobación se recalculan.

## 2. Nota de validación

- **Por qué sale esta nota:** se evaluó una descripción de un paso del alta. La descripción afirma el mecanismo de P2: la inacción de la persona se interpreta como consentimiento para tres usos opcionales de sus datos. Eso basta para No apto en esta disciplina, sin compensación posible. Lo haría cambiar comprobar que las casillas no vienen marcadas en la pantalla real.
- **Autocomprobación:** bucle de validación pasado entero. Con una descripción, casi todo queda sin evaluar: textos de las casillas, jerarquía visual, enlace a información de privacidad, si el alta puede terminarse sin marketing, comportamiento al pulsar y gestión posterior. No se ha usado ningún dato de uso ni métrica.

## 3. Estado de aprobación

**No apto** · 🔴 0 · 🟠 1 · 🟡 0 · ⚪ 0 · líneas rojas: 1 confirmada · 0 indicios fundados
**Motivo:** línea roja P2 confirmada según la descripción (casillas de consentimiento de marketing premarcadas) y hallazgo 1 en 🟠 3 · Mayor. Las comprobaciones de la sección 7 siguen pendientes y también deben resolverse.
**Válido para:** paso de consentimientos de marketing del alta, estado inicial, tal como se describe · **No cubre:** textos reales, resto del alta, pantalla siguiente, errores, revocación posterior y accesibilidad.
**Recomendación:** desmarcar por defecto las tres casillas antes de cualquier otro cambio.
> Este estado de aprobación es una recomendación experta. La decisión final es del equipo; la priorización se cierra con el equipo técnico, que valora viabilidad y esfuerzo.

## 4. Semáforo de las 10 heurísticas

Color = mayor severidad de los hallazgos que tienen esa heurística como **principal**. Las líneas rojas van en la sección 1 y no colorean. Con una descripción, lo no descrito queda en ⚫.

| | H1 | H2 | H3 | H4 | H5 | H6 | H7 | H8 | H9 | H10 |
|---|---|---|---|---|---|---|---|---|---|---|
| Principal | ⚫ | ⚫ | 🟠 3 | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |
| Relacionada en | #1 | — | — | — | #1 | — | — | — | — | — |

H1 y H5 aparecen como relacionadas en el hallazgo 1, pero no hay evidencia para inspeccionarlas por sí mismas: siguen en ⚫.

## 5. Resumen de hallazgos (de mayor a menor severidad)

| # | Problema | Severidad | Heurística principal | Riesgo específico | Línea roja | Confianza |
|---|---|---|---|---|---|---|
| 1 | Los tres consentimientos de marketing vienen marcados y se otorgan al pulsar «Continuar» | 🟠 3 · Mayor | H3 | Privacidad y datos personales · Legal o normativo | P2 confirmada | Media |

## 6. Fichas de hallazgos

### 1. Los tres consentimientos de marketing vienen marcados y se otorgan al pulsar «Continuar»
- **Evidencia:** según la descripción, las tres casillas de consentimiento de marketing están marcadas en el estado inicial y el botón del paso dice «Continuar».
- **Tarea afectada:** terminar el alta de cuenta.
- **Consecuencia probable:** quien quiere terminar el alta pulsa «Continuar» sin revisar las casillas y queda dado de alta en tres usos de marketing que no ha elegido. «Continuar» no anuncia que pulsarlo registra tres consentimientos, así que la persona puede no saber que los ha dado.
- **Heurística principal:** H3 (control y libertad: el sistema decide por la persona y le obliga a actuar para no consentir) · relacionadas: H5 (no previene la aceptación accidental), H1 (el botón no informa de lo que se registra).
- **Severidad:** 🟠 3 · Mayor · criterio de la rúbrica: riesgo relevante sobre datos personales y corrección necesaria antes de aprobar el flujo. No llega a 🔴 4 porque no impide terminar el alta y el consentimiento es revocable*, aunque las comunicaciones o cesiones hechas mientras tanto no se deshacen.
- **Riesgo específico:**
  - Privacidad y datos personales → uso de los datos para marketing sin una decisión activa de la persona.
  - Legal o normativo → posible implicación en la normativa de protección de datos, que exige consentimiento mediante acción afirmativa para finalidades opcionales. Es una posible implicación, no un incumplimiento verificado: requiere revisión jurídica.
- **Línea roja:** P2 confirmada, según la descripción aportada.
- **Confianza:** Media · la descripción afirma el mecanismo sin ambigüedad, pero no se ha observado la pantalla: textos, finalidades y comportamiento real no se han comprobado.
- **Corrección:**
  1. Las tres casillas desmarcadas en el estado inicial.
  2. Cada casilla con su finalidad concreta en una frase (qué datos, para qué, por qué canal) y enlace a la información de privacidad.
  3. «Continuar» habilitado con cualquier combinación, incluida ninguna casilla marcada, sin avisos que insistan en aceptar.
- **Cómo verificarla:** cargar el paso en el prototipo o en código y comprobar que las tres casillas aparecen desmarcadas; pulsar «Continuar» sin marcar ninguna y comprobar en el registro de consentimientos que no queda ninguno activo; repetir marcando solo una y comprobar que solo esa queda registrada.
- **Ley de UX:** no se usa.
- **Esfuerzo:** a estimar con el equipo técnico.

## 7. Evidencia necesaria

No cambia el estado de aprobación (ya es No apto), pero hace falta para cerrar la evaluación.

| Qué falta | Cómo obtenerlo | Qué resolvería |
|---|---|---|
| Captura o HTML del paso en su estado inicial | Pedir la pantalla real del alta | Confirma la línea roja P2 sobre la pantalla, no solo sobre la descripción, y permite evaluar H1, H2, H4, H8 |
| Texto literal de cada casilla y si hay información de privacidad enlazada | Captura o copy del paso | Si cada finalidad está explicada y separada |
| Si el alta puede terminarse con las tres casillas desmarcadas | Probar el paso desmarcando todo, con datos sintéticos | Descarta o abre P3 (consentimiento forzado) |
| Cómo se revocan después los consentimientos | Recorrer ajustes de privacidad o perfil del producto | Descarta o abre P4 (revocación obstruida) |
| Sector y plataforma del producto | Preguntar al equipo | Aplica controles del sector y de Apple HIG / Material 3 |

## 8. Lo que funciona bien

- Los consentimientos están separados en tres casillas en lugar de uno global. Si cada una corresponde a una finalidad distinta, permite decidir por finalidad. Pendiente de confirmar con los textos.

## 9. Hipótesis para validar con personas usuarias

- Al terminar el alta, ¿saben las personas que han aceptado comunicaciones de marketing? Se puede comprobar con un test de recuerdo tras completar el alta con la versión actual y la corregida.

## 10. Para accesibilidad

- Verificar con auditing-accessibility que cada casilla tiene nombre accesible con su finalidad, que el lector de pantalla anuncia su estado (marcada / no marcada) y que el objetivo táctil cumple el tamaño mínimo. No cambia este estado de aprobación.
