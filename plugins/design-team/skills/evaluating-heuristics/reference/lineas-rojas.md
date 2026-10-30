# Líneas rojas: lo que no se acepta nunca

Una línea roja confirmada da **No apto** y encabeza el informe, sea cual sea la severidad UX. No se compensa con buenas valoraciones en otros aspectos, no se rebaja a observación ni se negocia con "es la marca" o "mejora la conversión".

No diseñes, recomiendes ni optimices mecanismos que engañen, coaccionen o reduzcan injustificadamente la capacidad de decidir. Una mejora de conversión, retención o ingresos no justifica estas prácticas.

Son 14: cuatro de usabilidad crítica (U) y diez de patrones engañosos e integridad de la información (P).

Las líneas rojas son un **eje independiente**: no sustituyen a la heurística principal del hallazgo, no fijan su severidad y no colorean el semáforo. La columna «Heurísticas» de abajo orienta la inspección; la heurística principal de cada hallazgo se elige por el mecanismo concreto del problema.

## U · Usabilidad crítica

| # | Línea roja | Heurísticas | Ejemplo en banca |
|---|---|---|---|
| U1 | **Mover dinero sin resumen.** Confirmar sin ver justo antes importe, destinatario y comisiones | H1, H5 | Un botón "Firmar" sin importe ni destinatario en la pantalla |
| U2 | **Resultado incierto.** Tras la operación no queda claro si se hizo o no | H1, H9 | Tras pulsar, solo "Procesando..." y ninguna confirmación |
| U3 | **Irreversible sin salida.** Acción irreversible sin confirmar, cancelar ni deshacer | H3, H5 | Borrar un beneficiario guardado con un toque y sin aviso |
| U4 | **Error sin salida.** Un error en un paso obligatorio que no dice qué pasó ni qué hacer | H9 | "Error 4012" en la firma, sin causa ni siguiente paso |

## P · Patrones engañosos y por sector

| # | Patrón y línea roja | Banca digital | Salud y cuidado del paciente | Comercio y SaaS para pymes |
|---|---|---|---|---|
| P1 | **Costes y compromisos ocultos.** Nunca ocultar el coste total, la recurrencia, la permanencia o condiciones decisivas antes de aceptar. Incluye *Hidden Costs* y *Forced Continuity*. | Destacar una cuota reducida ocultando comisiones y coste total del crédito. | Presentar seguimiento de pago recurrente como una consulta única. | Anunciar precio mensual ocultando pago anual, cargos por usuario o renovación. |
| P2 | **Extras y decisiones no autorizados.** Nunca interpretar la inacción como autorización para añadir costes o activar cesiones opcionales de datos. Incluye *Preselection* y *Sneak into Basket*. | Añadir un seguro al préstamo mediante una casilla premarcada. | Activar por defecto la cesión de datos a socios comerciales. | Incorporar garantías, servicios o licencias adicionales sin autorización informada. |
| P3 | **Consentimiento forzado o desviado.** Nunca condicionar una función necesaria a finalidades secundarias innecesarias, ni aprovechar un permiso para otra acción no informada. Incluye *Forced Action*, *Privacy Zuckering* y *Friend Spam*. | Exigir aceptar marketing para consultar el saldo. | Condicionar el acceso a resultados a compartir datos con anunciantes. | Importar contactos al CRM y enviarles invitaciones sin confirmación. |
| P4 | **Salida y revocación obstruidas.** Nunca añadir barreras injustificadas para cancelar, reducir un plan, retirar permisos o recuperar datos cuya entrega corresponde. Incluye *Roach Motel* y *Obstruction*. | Ocultar la baja de un servicio entre ofertas y trámites comerciales. | Hacer difícil retirar permisos opcionales de acceso a información clínica. | Exigir llamadas innecesarias para cancelar o bloquear una exportación contratada para impedir la salida. |
| P5 | **Acciones o textos engañosos.** Nunca hacer que un control ejecute una acción material distinta de la anunciada, ni usar ambigüedad para obtener aceptación. Incluye *Bait and Switch* y *Trick Questions*. | Un botón «Simular» termina contratando un producto. | «Ver resultados» acepta también un servicio comercial. | «Invitar colaborador» genera una licencia de pago sin avisarlo. |
| P6 | **Alternativas ocultas o visualmente anuladas.** Nunca volver imperceptible o impracticable rechazar, comparar o elegir una alternativa relevante. Incluye *Misdirection* e *Interface Interference*. | Ocultar la opción de pago total mientras se destaca financiar. | Esconder «Continuar sin compartir datos opcionales». | Mostrar «Aceptar todo» claramente y hacer casi ilegible «Rechazar». |
| P7 | **Urgencia, escasez o prueba social falsas.** Nunca inventar plazos, disponibilidad, actividad, reseñas o respaldo profesional para precipitar una decisión. | Una oferta de crédito «caduca» con un contador que siempre se reinicia. | Afirmar «Última cita disponible» sin respaldo en la agenda real. | Inventar compradores activos, existencias limitadas o testimonios de clientes. |
| P8 | **Culpa, miedo infundado e insistencia coercitiva.** Nunca avergonzar, alarmar sin fundamento o agotar al usuario para doblegar su rechazo. Incluye *Confirmshaming* y *Nagging*. | «Si rechazas este seguro, no proteges a tu familia». | «No me importa mi salud» como opción para rechazar una mejora de pago. | Interrumpir repetidamente el trabajo con la misma oferta ya rechazada. |
| P9 | **Publicidad y conflictos de interés encubiertos.** Nunca presentar promociones o recomendaciones condicionadas comercialmente como información independiente. Incluye *Disguised Ads*. | Ordenar créditos por comisión recibida y presentarlos como «los mejores para ti». | Mostrar un producto patrocinado como recomendación clínica neutral. | Presentar una integración pagada como recomendación independiente del sistema. |
| P10 | **Integridad de dashboards.** Nunca presentar datos, estados o conclusiones críticas de forma que oculten limitaciones relevantes o creen una certeza falsa. | Presentar dinero proyectado como saldo disponible o una estimación de rentabilidad como resultado garantizado. | Mostrar un dato ausente como «normal», un resultado antiguo como actual o una recomendación automatizada como validada por un profesional cuando no lo está. | Presentar facturación como beneficio, ocultar costes que cambian la interpretación o simular procesos completados para impulsar una compra. |

P10 amplía el catálogo a la integridad de la información. Un error de datos o de visualización puede exigir corrección urgente sin que haya evidencia suficiente para clasificarlo como dark pattern.

## Cómo documentar cada caso

**Pantalla o flujo → evidencia observada → decisión afectada → perjuicio posible → línea roja → alternativa transparente.**

Tres resultados:

- **Línea roja confirmada:** hay evidencia del mecanismo descrito. Rechaza esa solución y propone una corrección. → No apto.
- **Indicio fundado:** hay una señal observable que apunta al mecanismo y una comprobación concreta pendiente. Que la entrada no mencione algo (comisiones, orden de los pasos) es **información no aportada**, no una señal: va a «Evidencia necesaria» y no abre un indicio por sí sola. Explica qué comprobar y cómo; no afirmes hechos ni intenciones no demostrados. → Pendiente de verificación (la aprobación queda retenida), con «Evidencia necesaria», salvo que ya haya un motivo de No apto. Una sospecha genérica sobre algo no revisado no es un indicio fundado.
- **Diseño justificado:** la medida responde a una necesidad real, está explicada y es proporcionada. → Se dice en «Lo que funciona bien»; no es hallazgo.

Cuando se verifica un indicio: si se descarta o resulta diseño justificado, el estado de aprobación se recalcula con los hallazgos que queden; si se confirma, No apto por línea roja confirmada.

No clasifiques automáticamente como engaño una autenticación bancaria, una comprobación de permisos de un cuidador, una alerta clínica fundada, una renovación previamente aceptada o una confirmación antes de borrar datos. Examina su finalidad, veracidad y proporcionalidad.

Evalúa la gravedad del perjuicio por separado de la solidez de la evidencia. Estas líneas rojas son reglas internas de diseño; cualquier conclusión jurídica requiere su propia verificación.
