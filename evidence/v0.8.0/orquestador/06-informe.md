# Informe final · Firma de transferencia (Banco Lumen) · v0.8.0

**Reto:** `demo/caso-firma-operacion.md` · **Pantalla evaluada:** `demo/pantalla-firma.html`
**Fecha:** 2026-10-23 · **Orquesta:** Head of Design

## Estado de aprobación global
**No apto** · lo determinan: **Heurísticas**, **Accesibilidad** y **Riesgo de producto** (empate).
- Heurísticas: líneas rojas U1 (se pide firmar sin resumen de importe ni destinatario) y U4 («Error 4012» sin causa, acción ni estado del dinero), ambas confirmadas.
- Accesibilidad: línea roja 2.4.7 Foco visible incumplido (`input.code{outline:none}`), más 6 hallazgos con incumplimiento A/AA confirmado (3.3.2, 3.3.1/3.3.3, 1.4.3, 1.4.11, 4.1.2, 3.1.1).
- Riesgo de producto: R1 y R2 (🟠 3 · Mayor), abiertos y sin aceptación.

| Evaluación | Cobertura | Estado de aprobación | Motivo | Evidencia necesaria | Observaciones |
|---|---|---|---|---|---|
| Heurísticas | Parcialmente evaluado | No apto | U1 y U4 confirmadas · 🔴 2 · 🟠 0 · 🟡 6 · ⚪ 1 · indicio fundado U2 (resultado incierto) | Pantalla de resultado y prueba con corte de red (U2). Doble pulsación real (#3). Duración, reenvío e intentos (#4, #6). Design system (H4 ⚫ Sin evaluar). Contenido del SMS. Efecto real de la flecha (#7). | **No cubre:** pantallas de rellenar y resultado, comportamiento real del temporizador y reenvío, SMS, design system (H4). Observaciones: tiempo poco visible (#4), campo sin `one-time-code`/`inputmode` (#5), reenvío como pregunta (#6), salida sin texto (#7), instrucción en gris (#8), referencia sin agrupar (#9). |
| Accesibilidad (WCAG) | Parcialmente evaluado | No apto | Línea roja 2.4.7 · 🔴 1 · 🟠 4 · 🟡 1 · ⚪ 1 | 3.3.4 (prototipo o especificación del paso de resumen). 2.2.1/2.2.2 (regla de duración y build con temporizador real). 4.1.3 (prueba con NVDA, VoiceOver y TalkBack). 3.3.8 (pegado/autorrelleno en iOS Safari y Android Chrome). 1.4.4, 1.4.10, 1.4.12, 2.4.11 (navegador real). 2.4.7 en botones y enlace (teclado externo). 3.2.3, 3.2.4, 3.2.6, 3.3.7 (pantallas previa y posterior). | **No cubre:** anuncios reales de lector, zoom/reflow, pantallas de rellenar y resultado. Observaciones: objetivo de volver a 44 px, `inputmode`/`one-time-code`, «**47» leído con asteriscos, `<title>` y `h1`, enlace de reenvío como `<button>`, acción visible de cancelar. |

No hay evaluaciones «No aplica». Las dos aplicaban y se confirmaron en la firma del alcance.

Aunque se aceptaran R1 y R2, el global seguiría **No apto**: las líneas rojas de heurísticas y accesibilidad tienen sus propias reglas y no se desbloquean con una aceptación de riesgo.

### Riesgos de producto (fuera de WCAG)
No son incumplimientos WCAG. Vienen del informe de accesibilidad.

| # | Riesgo | Severidad | Categoría | ¿Coincide con otra evaluación? | ¿Bloquea? | Estado | Aceptación |
|---|---|---|---|---|---|---|---|
| R1 | Firmar sin ver importe ni destinatario. SCA exige vincular el código a importe y beneficiario. | 🟠 3 · Mayor (provisional; 🔴 4 si no hay resumen en ningún paso del flujo) | Económico · Legal o normativo | Sí: mismo problema que la línea roja U1 y el hallazgo #1 de heurísticas. Se cuenta una vez. | Sí | Abierto | Ninguna. Producto la solicitó sin justificación, alcance ni condiciones; después declaró que no acepta ningún riesgo. |
| R2 | Estados inciertos: el error no dice si se ejecutó; «Procesando…» no lleva a resultado. | 🟠 3 · Mayor | Económico · Operativo | Sí: mismo problema que la línea roja U4, el hallazgo #2 y el indicio U2 de heurísticas. | Sí | Abierto | Ninguna |
| R3 | Sin protección visible contra doble envío. | 🟡 2 · Moderado (sube a 🟠 3 si el servicio no evita duplicados) | Económico | Sí: hallazgo #3 de heurísticas. | No | Abierto | — |
| R4 | Sin finalidad del código ni aviso antifraude. | 🟡 2 · Moderado | Económico (ingeniería social) | No | No | Abierto | — |

## Firmas registradas
| Punto | Quién | Qué se firmó |
|---|---|---|
| Alcance | Francia (dirección del caso) | Plan, dos evaluaciones aplicables, alcance limitado a `pantalla-firma.html` estática |
| Definir | Producto | `01-flujo.md` y `02-historias.md`, incluidos los supuestos S3 (resumen en P2 + Firmar como confirmación 3.3.4) y referencia única al pulsar Continuar |
| Evaluar | Accesibilidad y Contenido | Revisión de `04-heuristicas.md` y `05-accesibilidad.md`. El estado global queda No apto. |
| Aceptación de riesgos | — | Ninguna. No se acepta ningún riesgo. |

## Decisiones tomadas
1. **Alcance de evaluación:** solo la pantalla de firma. Rellenar y resultado entran en flujo, historias y componentes, no en evaluación.
2. **«Pendiente de confirmar» es un estado propio**, distinto de error y de éxito, para la firma enviada sin respuesta (X15, X16). Es la respuesta directa al origen de las llamadas.
3. **Resumen en la pantalla de firma + botón que nombra la acción** como confirmación explícita (3.3.4). Supuesto firmado por Producto; pendiente de validar con Accesibilidad (A1) y Compliance (vinculación SCA).
4. **Ningún valor de negocio inventado:** intentos, duración, reenvío, plazos y canal de contacto van como marcadores en historias y componentes.
5. **Componentes (`03-componentes.md`):** adaptar Botón (`loading` con bloqueo de doble envío, `secondary`/`tertiary`, `iconOnly`), Campo de texto (variante código, un solo campo, `one-time-code`) y Mensaje de alerta (`announce`, `actions`, `supportCode`) — minor. Crear Lista de datos, Tiempo restante y Resultado de operación (Realizada, No realizada, Pendiente de confirmar, Comprobando) — minor. Diálogo de salida solo si no existe. Riesgo de major: `label` obligatorio en Campo y cambio de rol ARIA por defecto en Alerta.
6. **No se acepta ningún riesgo de producto.** Todos siguen abiertos.

## Evidencias
- `01-flujo.md`: 1 happy path, 19 edge, 18 error; matriz de estados de P1, P2, P3; Mermaid; tabla de lector de pantalla.
- `02-historias.md`: 4 épicas, 17 historias; 6 críticas (HU-05, HU-11, HU-12, HU-13, HU-14, HU-15); 10 bloqueadas por preguntas abiertas; 37/37 casos cubiertos.
- `03-componentes.md`: 3 adaptados, 3 nuevos, 1 condicional; supuestos DS1–DS7 (no hay documentación del design system en el repositorio).
- `04-heuristicas.md`: informe completo, No apto.
- `05-accesibilidad.md`: informe completo, No apto. Contrastes calculados: ayuda 2,07:1, enlace 2,58:1, temporizador 2,85:1, error 4,23:1, borde del campo 1,28:1.
- Lo que nadie pudo verificar (pantalla estática): anuncios reales de lector, temporizador, caducidad, reenvío, doble envío, red, zoom y reflow. Va a riesgos abiertos, no se da por bueno.

## Revisión cruzada: cambios propuestos
Pendientes de incorporar. Nadie los ha aplicado todavía.

### `ux-heuristics-expert` sobre `02-historias.md` (20 cambios)
| # | Historia | Cambio propuesto | Severidad |
|---|---|---|---|
| 1 | Orden de implementación | «Firmar» no se activa en producción hasta que HU-03, HU-05, HU-11, HU-12 y HU-13 cumplan | 🟠 3 |
| 2 | HU-03 | Sin resumen no hay firma; el resumen sale de la operación guardada; el código solo vale para esa operación (T1, N2, Q1) | 🟠 3 |
| 3 | HU-03 | Cuenta de destino agrupada y con titular o verificación de beneficiario (Q2) | 🟠 3 |
| 4 | HU-03 | Botón con acción e importe: «Firmar y enviar [importe]» | 🟡 2 |
| 5 | HU-09 | Separar «la petición no salió» de «salió y se perdió»: en el segundo caso nunca decir «no se ha movido dinero» | 🟠 3 |
| 6 | HU-11 | Regla «ante la duda, Pendiente» como criterio, no como nota (T5) | 🟠 3 |
| 7 | HU-12 | Cambiar «Hemos recibido tu firma» por «Hemos enviado tu firma, pero no hemos recibido respuesta» | 🟡 2 |
| 8 | HU-12 | Decir qué puede haber pasado con el importe y ofrecer «Ver movimientos» (N3, T2) | 🟠 3 |
| 9 | HU-12 | Seguimiento fuera de pantalla: aviso por canal y operación localizable al volver (Q3, T2) | 🟠 3 |
| 10 | HU-13 | Bloquear nueva firma también antes del umbral y tras recargar (T1, T3) | 🟠 3 |
| 11 | HU-13 | Aviso (no bloqueo) ante una transferencia igual a una pendiente (Q4) | 🟠 3 |
| 12 | HU-15 | Salir o recargar mientras se firma: no decir «no se firma» | 🟠 3 |
| 13 | HU-14 | Sesión caducada: mensaje distinto antes y después de pulsar «Firmar» | 🟠 3 |
| 14 | HU-11 (transversal) | Todo cierre tiene salida; sin N7 la historia no pasa a «Hecha» | 🟠 3 |
| 15 | HU-11, HU-07, HU-06, HU-15 | Alinear «un estado, un mensaje» y la frase base de No realizada | 🟡 2 |
| 16 | HU-10 | «Realizada» solo afirma lo que se sabe: cargo, envío o abono (Q5) | 🟡 2 |
| 17 | HU-01, HU-08 | Reintento y reenvío reutilizan la referencia; caso de reenvío sin respuesta | 🟡 2 |
| 18 | HU-14 | Criterio verificable: la URL de retorno no lleva datos personales | 🟡 2 |
| 19 | HU-16 | En Pendiente, el lector lee «No vuelvas a firmar» antes de cualquier botón | 🟡 2 |
| 20 | HU-04 | Mensajes separados para letras y para dígitos que faltan | ⚪ 1 |

### `accessibility-auditor` sobre `03-componentes.md` (12 cambios)
| # | Componente | Cambio propuesto | Criterio | Severidad |
|---|---|---|---|---|
| 1 | Tiempo restante · Alerta · Botón | Al caducar siempre hay acción activa; `warning` ofrece la acción; documentar la excepción de 2.2.1 o permitir ampliar | 2.2.1 | 🟠 3 |
| 2 | Resultado de operación | Mantener «Comprobar estado» en `loading` durante `checking`; no robar el foco al resolver | 2.4.3 · 4.1.3 | 🟠 3 |
| 3 | Lista de datos · P2 · Diálogo | `account` permite verificar destinatario; acción visible «Modificar transferencia»; conservar datos al corregir | 3.3.4 | 🟠 3 |
| 4 | Resultado de operación | Frase del dinero ligada al `h1` (`aria-describedby`) o dentro del título | Riesgo de producto | 🟠 3 |
| 5 | Alerta (X14 frente a X15) | X14 solo con evidencia técnica de que la petición no salió; si no, Pendiente | Riesgo de producto | 🟠 3 |
| 6 | Alerta · Botón | Definir el foco cuando desaparece el control que lo tenía | 2.4.3 | 🟡 2 |
| 7 | Campo · Alerta | Una sola vía de error por caso (sin doble anuncio); foco al campo también en E05 | 3.3.1 · 4.1.3 | 🟡 2 |
| 8 | Tiempo restante · Alerta | Un solo anuncio al caducar | 4.1.3 | 🟡 2 |
| 9 | Botón · Campo · Alerta · Diálogo | Token de texto `secondary`; 4,5:1 en hover y pressed; 3:1 de foco y bordes sobre cada fondo | 1.4.3 · 1.4.11 | 🟡 2 |
| 10 | Botón (`iconOnly`, `tertiary`) | Añadir `button.min-width` | 2.5.8 | 🟡 2 |
| 11 | Lista de datos | `overflow-wrap:anywhere` en todos los valores; criterio a 320 px y 400 % | 1.4.10 | 🟡 2 |
| 12 | Botón · Campo | Guarda de doble envío en `submit` y de forma síncrona; idempotencia en servidor (T1) | Riesgo de producto | 🟡 2 |

Verificación pendiente en implementación (no cuenta como bueno): foco visible en todos los estados y fondos, foco no oculto con teclado virtual y zoom, regiones vivas presentes antes de inyectar texto, cambio de etiqueta del botón sin doble anuncio, pegado y `one-time-code`, lectura de referencia agrupada, modo oscuro y alto contraste, espaciado de texto, tamaños reales de objetivo.

## Riesgos abiertos
1. **R1** 🟠 3 (puede ser 🔴 4) y **R2** 🟠 3: bloquean. Sin aceptación.
2. **R3** y **R4** 🟡 2: no bloquean; abiertos.
3. **Idempotencia de la firma (T1) sin confirmar.** Sin ella, el bloqueo del botón no evita duplicados.
4. **Sin canal de contacto (N7)** los cierres duros (bloqueo, SMS que no llega, «sigue sin saberse») no tienen salida.
5. **Design system sin documentar.** API y tokens de `03-componentes.md` son supuestos (DS1–DS7); H4 de heurísticas queda ⚫ Sin evaluar.
6. **Supuesto S3 sin validar** (resumen + Firmar cumple 3.3.4) ni la vinculación SCA con Compliance.
7. **Todo lo dependiente de comportamiento real** queda sin verificar (lista en «Evidencias»).
8. Los 32 cambios de la revisión cruzada no están incorporados a `02-historias.md` ni a `03-componentes.md`.

## Preguntas para negocio
**Del reto**
- N1. Intentos antes de bloquear la firma. ¿Se muestran los restantes?
- N2. Duración del código; si se puede reenviar y cuántas veces; qué pasa con la operación cuando caduca.
- N3. Qué pasa con la transferencia si la conexión se corta justo después de firmar, y en cuánto tiempo se sabe.

**Del mapa de casos**
- N4. Espera entre reenvíos y máximo de reenvíos.
- N5. Duración de la sesión y qué datos se conservan al volver.
- N6. Duración del bloqueo y cómo se desbloquea.
- N7. Canal de contacto, horario y dato que debe dar el cliente.
- N8. Validaciones y límites: formato de cuenta, importe máximo, concepto, momento de comprobar saldo.
- N9. Si el SMS no llega, ¿hay otro canal o forma de cambiar el número?

**Para Tecnología**
- T1. ¿Referencia única antes de firmar y firma idempotente?
- T2. ¿Consulta de estado por referencia? ¿Pantalla de movimientos o estado?
- T3. Umbral de tiempo de espera de la firma y del SMS.
- T4. ¿Un código nuevo invalida el anterior?
- T5. Catálogo de errores: qué es «4012» y cuáles son definitivos.
- T6. ¿Caducidad con hora del servidor?
- T7. Soporte de `autocomplete="one-time-code"` y WebOTP en los navegadores objetivo.

**Nuevas en esta ronda**
- Q1. ¿El SMS incluye importe y destino?
- Q2. ¿Se muestra titular o verificación del beneficiario?
- Q3. ¿Por qué canal se avisa del estado y del resultado final fuera de la pantalla?
- Q4. Criterio de igualdad para avisar de una transferencia repetida tras Pendiente.
- Q5. ¿Qué significa «Realizada»: cargada, enviada o abonada?
- C1. Cómo se muestra la cuenta de destino. C2. Cómo se agrupa y se lee la referencia de 19 dígitos.
- A1 (Accesibilidad/Compliance). ¿Resumen + Firmar cumple 3.3.4? ¿La caducidad es excepción esencial de 2.2.1?
- A2. Lugar de la flecha de volver en el orden de foco.

## Qué necesita prueba con usuarios
Siempre con datos sintéticos y en entorno de pruebas, nunca con pagos reales.
1. **Firmar con lector de pantalla** (VoiceOver iOS, TalkBack): qué se oye en el campo, si se sabe qué, cuánto y a quién se firma, si se entiende el error y el resultado.
2. **Solo teclado externo o interruptor:** si se ve el foco en el campo y en los botones.
3. **Zoom 200 % y baja visión:** localizar campo, ayuda, temporizador y reenvío.
4. **SMS en otro dispositivo o app:** copiar y pegar; si da tiempo antes de caducar (queja del reto, sin cifras); pedir otro código.
5. **Corte de conexión tras pulsar «Firmar»:** si la persona sabe si se hizo y evita repetirla; cómo interpreta «Pendiente de confirmar».
6. **Comprensión de textos:** «¿No has recibido el código?» como reenvío; la flecha como volver o cancelar; reacción ante un error opaco (repetir o llamar).
7. **Tiempo del código:** si basta para quien teclea sin autocompletado.
