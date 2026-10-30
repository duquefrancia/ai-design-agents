# Lentes para productos regulados

Cargar cuando haya operaciones con consecuencia económica o legal difícil de revertir: dinero, contratos, salud o datos personales. Aplicar durante la inspección, sobre todo en **la tarea esencial** y en **errores y resultados**.

**Alcance.** Escrito para banca de particulares en España y la UE: transferencias, agregación de cuentas, privacidad, crédito hipotecario y autenticación. No trasladar automáticamente estas obligaciones a empresas, otros países, seguros o salud.

**Estado: borrador del 16-10-2026** a partir de fuentes públicas, sin pruebas con tecnologías de apoyo. Las preguntas, señales y evidencias para cerrar son criterios de auditoría propuestos, no hallazgos adjudicados a ninguna entidad.

## Contenido
- Severidad en producto regulado
- Lente 1 · Fraude y suplantación
- Lente 2 · Estados inciertos
- Lente 3 · Patrones oscuros
- Lente 4 · Lenguaje del sector (con glosario)
- Lente 5 · Autenticación reforzada accesible
- Normativa de referencia
- Antes de emitir el informe
- Fuentes

## Severidad en producto regulado

Se usa la escala común de la skill: **🔴 4 · Crítico · 🟠 3 · Mayor · 🟡 2 · Moderado · ⚪ 1 · Leve**. La severidad no decide el estado: un incumplimiento A/AA confirmado da No apto en cualquier nivel.

**Anclas generales** (para barreras reproducidas):

| Situación comprobada | Severidad |
|---|---|
| No se puede completar de forma autónoma una autenticación, revisión o confirmación imprescindible con los medios de acceso del alcance, sin alternativa accesible. | Crítico |
| Se puede continuar, pero sin percibir un dato o aviso decisivo, con riesgo de autorizar otra operación, repetirla o aceptar una finalidad no deseada. | Mayor |
| Hay fricción sin impedir la tarea ni comprometer una decisión esencial. | Moderado o Leve, por el método general. No subir solo porque sea banca. |

**Anclas específicas:**
- Confirmar una operación irreversible sin ver de forma accesible qué se confirma (importe, destinatario, alcance) → Crítico si el dato no existe por otra vía; Mayor si existe.
- El resultado de una operación con consecuencia no se anuncia al lector de pantalla (4.1.3) → Mayor.
- Código de un solo uso que caduca sin poder pedir otro → Mayor (2.2.1).
- Consentimiento premarcado o no modificable en el documento que se firma → riesgo de producto, Mayor mínimo, categoría Legal o normativo, marcado [legal]. Fuera de la tabla WCAG.
- Operación con consecuencia protegida solo por avisos informativos, sin bloqueo ni límite duro → riesgo de producto, Mayor mínimo. Fuera de la tabla WCAG salvo que haya además una barrera WCAG.

**Factor de consecuencia.** Si una barrera de nivel inferior aumenta **de forma demostrable** el riesgo de un cargo, un compromiso contractual o un tratamiento de datos no deseado, sube un nivel (techo: Crítico). Aplica solo el factor más alto y no cuentes dos veces un daño que ya recoge el ancla. Registra la cadena: **barrera → decisión afectada → consecuencia**.

**[legal] y anti-inflado.**
- Una cuestión solo jurídica no recibe un criterio WCAG inventado. Va como riesgo de producto [legal] pendiente de compliance, en «Riesgos de producto (fuera de WCAG)». No cambia el estado de aprobación de accesibilidad.
- Si hay una barrera técnica que impide acceder a información con obligación legal, el hallazgo va a la tabla: mínimo Mayor, con la marca [legal].
- En producto regulado, todo hallazgo AA es además riesgo normativo. Eso va **una vez, en el estado de aprobación**, como línea de cumplimiento. No sube la severidad de cada hallazgo, porque inflar diluye.

## Lente 1 · Fraude y suplantación

**Criterio:** lo que no se puede percibir o revisar a tiempo no sirve como comprobación. Audita la advertencia y la posibilidad real de detenerse, no la presencia de un icono de seguridad.

**Preguntas**
- ¿Se pueden consultar importe, moneda, destinatario, cuenta de destino, concepto, comisiones y fecha de ejecución **antes** de autorizar? ¿Están en texto accesible, con orden de lectura comprensible, también con zoom?
- ¿La verificación del beneficiario diferencia **coincidente, casi coincidente, no coincidente y no se pudo verificar** con texto y semántica, sin depender del color? Son los resultados que describe el Banco de España [R1]; la implementación de cada banco hay que comprobarla.
- ¿Se explica qué dato revisar y cómo corregir o detener el envío? ¿Se evita presentar la coincidencia de titularidad como garantía de que la solicitud es legítima?
- ¿Los avisos antifraude aparecen antes del compromiso, se alcanzan con teclado y lector de pantalla y permiten volver al resumen? ¿Las solicitudes de dinero se distinguen de cobros o ingresos?
- ¿Una llamada o notificación se puede verificar entrando por iniciativa propia en la app, sin el enlace o número del interlocutor? ¿Queda una vía de comprobación si no llega la notificación?
- ¿Cada código o confirmación dice su finalidad (acceso, alta de dispositivo, recuperación, pago)? ¿Se distingue introducirlo en un flujo auténtico de dárselo a quien lo pide por teléfono?

**Señales de alarma:** avisos solo visuales; resumen en imagen sin equivalente; coincidencia representada solo por color; mensaje que confunde ausencia de comprobación con seguridad; urgencia que empuja a confirmar sin revisar.

**Criterios WCAG candidatos:** 1.4.1 · 2.1.1 · 2.4.3 · 3.3.4 · 4.1.3 cuando corresponda. [W0]

**Evidencia para cerrar:** grabación o registro de la revisión accesible previa, texto exacto del aviso, resultado de la comprobación y efecto real de cancelar o corregir en un entorno autorizado. La verificación regulatoria del beneficiario necesita además validación funcional y de compliance.

## Lente 2 · Estados inciertos

**Criterio:** «¿se hizo o no se hizo?» es prioritario cuando puede inducir a repetir una operación. La interfaz distingue lo confirmado por el servicio de lo que aún no sabe.

**Preguntas**
- Tras confirmar, ¿se comunica el procesamiento y se puede consultar después el resultado? En web, ¿hay `role="status"` u otro mecanismo adecuado para un mensaje dinámico sin cambio de foco? No exijas región viva a todo resultado: una página nueva o un diálogo gestionan el contexto de otra forma. [W3]
- Si se corta la conexión tras enviar, ¿se puede consultar la operación sin volver a ordenarla? ¿Se evita leer un tiempo de espera agotado como rechazo confirmado?
- ¿Se controla la doble activación (teclado, ratón, táctil) y se informa del procesamiento? Pide a desarrollo evidencia de protección frente a reintentos en el servicio: desactivar el botón no prueba que no haya duplicados.
- ¿El resultado incluye referencia si existe, importe, destinatario, fecha y siguiente paso en texto accesible? ¿Un justificante de orden se distingue de una confirmación de abono al destinatario?
- En agregación de cuentas, ¿se identifica la entidad origen y la última actualización? ¿Se diferencia una cuenta sin conexión de una sin saldo? ¿Solicitar una transferencia a otro banco se distingue de confirmarla?
- ¿Cada estado pendiente tiene responsable, siguiente paso y regla de resolución? En transferencias inmediatas, contrasta con compliance la información y el tratamiento del saldo ante falta de confirmación; «pendiente» no puede ser una espera indefinida. [N3]

**Señales de alarma:** animación sin nombre accesible; notificación que desaparece; «error» sin saber si se envió; botón para repetir antes de consultar; saldo agregado presentado como actualizado sin evidencia.

**Modelo de estados propuesto** (para la prueba; no son etiquetas de ninguna entidad):

| Estado | Qué exigir en la prueba |
|---|---|
| Enviando | Se transmite la orden; no afirmar que ya se ejecutó. |
| Pendiente | Qué se espera, quién debe actuar y cómo consultar la evolución. |
| Ejecutada | Qué hito se confirma (orden ejecutada, cargo, abono) sin tratarlos como equivalentes. |
| Rechazada | Rechazo confirmado, siguiente paso y tratamiento del saldo que conste. |
| Resultado no confirmado | La incertidumbre, una vía de consulta y ningún incentivo a reenviar hasta resolverla. |

**Criterios WCAG candidatos:** 4.1.3 · 2.4.3 si hay cambio de contexto · 3.3.1 cuando corresponda. Reserva `role="alert"` para lo importante y urgente; no para todo error. [W0] [W3]

**Evidencia para cerrar:** correlación entre registro del servicio, estado visible y anuncio accesible en éxito, rechazo e interrupción. Reentrada, consulta y reintento probados en preproducción. Nunca pagos reales para probar duplicados.

## Lente 3 · Patrones oscuros

**Criterio:** la persona puede elegir, entender la consecuencia y mantener su elección. Distingue una mala práctica de diseño de una infracción jurídica demostrada.

**Preguntas**
- ¿Los consentimientos opcionales parten de una elección real, sin selección por defecto? ¿Una preferencia previa válida se muestra como tal, sin aparentar un consentimiento nuevo?
- ¿Se separan contrato, tratamiento necesario para prestarlo, finalidades opcionales y permisos del dispositivo? No todo tratamiento bancario se basa en consentimiento: la base jurídica la determina compliance. [N4]
- ¿Se puede rechazar cada finalidad independiente sin bloquear la tarea cuando no es necesaria? ¿Nombre, estado y agrupación de cada control son accesibles?
- ¿Retirar el consentimiento es tan fácil como darlo? Evalúa por separado cancelar una operación, cerrar un producto y ejercer el desistimiento: no son el mismo derecho ni siguen el mismo proceso. [N4] [N5] [N7]
- ¿Las ofertas distinguen beneficio, coste, permanencia y condiciones de acceso? ¿La información desfavorable se percibe antes de decidir? Un contador o fecha límite hay que contrastarlo con una restricción real; su presencia no prueba manipulación.
- ¿Rechazar, volver atrás o retirar una selección mantiene lo elegido? En agregación, ¿se explica la diferencia entre desconectar una cuenta externa, retirar un permiso y cerrar esa cuenta?

**Señales de alarma:** aceptación global ambigua; opciones activadas sin acción; rechazo escondido; reactivación silenciosa de preferencias; mensajes de culpa; coste de productos combinados omitido al destacar una rebaja.

**Criterios WCAG candidatos:** 3.3.2 · 4.1.2, solo si hay barrera técnica. Un consentimiento inválido no recibe un criterio WCAG solo por serlo. [W0]

**Evidencia para cerrar:** coincidencia entre elección, versión documental y tratamiento aplicado, más prueba accesible de retirada. Validación de compliance sobre finalidades y bases jurídicas. Evidencia minimizada y anonimizada; ningún dato real de clientes en los archivos de referencia.

## Lente 4 · Lenguaje del sector

**Criterio:** la persona entiende qué va a hacer, cuánto le cuesta y qué cambia después. Un término preciso puede quedarse, pero necesita explicación en contexto cuando determina una decisión.

**Preguntas**
- ¿Se explican en el punto de uso TIN, TAE, bonificación, fecha valor, disposición, saldo disponible o adeudo, sin salir del flujo?
- ¿Se distingue dinero propio de crédito disponible, y previsión de movimiento registrado? ¿Moneda y sentido del movimiento se entienden sin color?
- ¿El error dice qué ocurrió, qué dato revisar y qué acción hay? ¿Evita culpar a la persona de un fallo de conexión o de otro banco?
- ¿Las condiciones importantes tienen explicación comprensible junto al documento completo? En hipotecas, el resumen no sustituye la información precontractual exigible ni contradice la oferta personalizada. [N7]
- ¿Una cuota reducida aparece junto a los requisitos para mantenerla y sus costes? ¿Se distinguen simulación, solicitud, aprobación, oferta y contrato firmado?
- ¿Las personas participantes en la prueba pueden explicar con sus palabras qué pagarán, cuándo y en qué condiciones, también con tecnologías de apoyo? Una puntuación automática de legibilidad no sustituye esta prueba.

**Señales de alarma:** siglas sin desarrollar; «operación realizada» para hitos distintos; cuota destacada sin condiciones; botón «Aceptar» sin objeto; resumen que omite costes; código de error sin acción posible.

**Glosario de traducción** (propuestas editoriales, no definiciones jurídicas; adaptar al producto y conservar el término técnico cuando haga falta):

| Término | Cómo decirlo claro |
|---|---|
| Fecha valor | Fecha con la que se calculan los intereses de ese movimiento; no es la fecha de la operación. [N2] |
| Adeudo domiciliado | Recibo que se cobra en tu cuenta mediante una domiciliación. [R2] |
| Saldo disponible de una tarjeta de crédito | Parte del límite de crédito que aún puedes usar; no es dinero ahorrado. |
| TIN | Porcentaje de interés del préstamo, sin sus comisiones ni otros gastos. |
| TAE | Porcentaje anual con intereses y los gastos que correspondan, bajo unos supuestos, para comparar ofertas. |
| Bonificación | Rebaja del interés mientras cumplas ciertas condiciones; revisa también lo que cuestan. |
| Capital pendiente | Parte del dinero prestado que falta devolver. |
| Disposición | Uso de dinero del crédito; di si es retirada de efectivo, compra o transferencia. |
| FEIN | Documento con las condiciones personalizadas de tu oferta de hipoteca. [N7] |
| Agregador | Servicio que reúne información de tus cuentas en otros bancos; di qué más operaciones permite. |
| Orden de transferencia | Instrucción para enviar dinero; di si está pendiente o ya se ejecutó. [N2] |
| Beneficiario casi coincidente | El nombre se parece pero no coincide; revisa el nombre que devuelve la comprobación. [R1] |
| Beneficiario no verificable | No se pudo comprobar que nombre y cuenta coincidan; no significa que coincidan. [R1] |
| Retirar el consentimiento | Dejar de permitir los tratamientos basados en esa autorización; no es cerrar el producto. [N4] |

**Criterios WCAG candidatos:** 3.3.1 · 3.3.2 · 3.3.3. **3.1.5 Nivel de lectura es AAA**, no obligación AA. La exigencia de información comprensible en banca de consumidores bajo la EAA / Ley 11/2023 tiene otra base jurídica; no las confundas. [W0] [W8] [N1]

**Evidencia para cerrar:** pruebas de comprensión con tareas y preguntas concretas; coherencia entre mensajes y condiciones efectivas; revisión de compliance del contenido precontractual. Una mejora editorial no acredita la conformidad del documento entero.

## Lente 5 · Autenticación reforzada accesible

**Marco:** la autenticación reforzada (SCA) se exige en los supuestos previstos y admite excepciones reguladas. No significa siempre dos pantallas, dos dispositivos o un SMS. Cuando procede, exige dos o más factores independientes de categorías distintas: conocimiento, posesión e inherencia; en pagos electrónicos remotos, vinculados a importe y beneficiario. Confirma el caso con seguridad y compliance. [N2] [N2b]

La accesibilidad de identificación, firma y pago se evalúa junto a la seguridad, no después. Aplica 3.3.8 y 2.2.1 con sus condiciones y excepciones; «por seguridad» no justifica cualquier barrera. [N1] [W1] [W4]

**Preguntas**
- ¿Qué variante se prueba: acceso, firma en dispositivo, SMS, compra con tarjeta, alta de dispositivo o recuperación? ¿Constan app, sistema operativo, navegador y fecha?
- Con código de un solo uso, ¿se puede pegar entero y usar el autorrelleno cuando exista? Con campos fragmentados, ¿aceptan el código completo sin memorizarlo? `autocomplete="one-time-code"` es una ayuda web, no una garantía ni una obligación WCAG aislada. [W1] [H1]
- ¿Hay un mecanismo de autenticación que no dependa de superar una prueba cognitiva sin asistencia o alternativa admitida? 3.3.8 no obliga a ofrecer a la vez pegado y autorrelleno. [W1]
- ¿Se distinguen caducidad del código, inactividad de la sesión y tiempo total del proceso? ¿Hay una acción comprensible para pedir otro código o recuperar el proceso? ¿El aviso de caducidad se percibe sin anuncios cada segundo?
- ¿Hay alternativa para quien no puede usar la biometría, el gesto o el dispositivo habitual? ¿Se encuentra y completa sin ayuda de un tercero? Verifica también alta, sustitución y recuperación del dispositivo.
- Al pasar de web a app, de notificación a firma y de vuelta al comercio, ¿se mantienen el contexto, la revisión de importe y destinatario y el resultado? ¿Cancelar o dejar caducar hace lo que dice, sin mensajes contradictorios?
- Si una espera se considera esencial por seguridad, ¿se documenta qué excepción aplica y por qué? Algunos tokens con tiempo limitado pueden quedar exentos de 2.2.1; eso no se extiende a toda la sesión. [W4]

**Señales de alarma:** pegado bloqueado sin alternativa; biometría como única vía efectiva; código que caduca antes de encontrar el campo; avisos temporales solo visuales; vuelta del comercio sin resultado; recuperación que exige la misma capacidad que falta.

**Criterios WCAG candidatos:** 3.3.8 · 2.2.1 · 3.3.2 · 2.4.3 · 3.3.4 cuando corresponda. En nativo, documenta la evaluación funcional y los mecanismos de la plataforma; no exijas atributos HTML. [W0] [W1] [W4]

**Dos límites:** 3.3.4 admite reversibilidad, comprobación con corrección, o revisión y confirmación; no exige las tres. Continuar sin perder datos tras reautenticarse es **2.2.5, nivel AAA**: puede ser requisito de producto, no obligación AA. [W2] [W6]

**Evidencia para cerrar:** pruebas reproducibles de acceso, autorización, error, caducidad y recuperación; alternativa realmente utilizable; nueva validación del resumen y del resultado. Nunca claves, códigos ni datos biométricos en la evidencia.

## Normativa de referencia

**Solo nombre y obligación relevante.** Artículos, plazos, ámbito, excepciones y conclusión jurídica: **por confirmar con compliance** para el servicio y contrato concretos. Esto no es validación legal ni certificación.

| Norma | Obligación relevante para el diseño |
|---|---|
| Ley Europea de Accesibilidad (EAA), Directiva (UE) 2019/882; en España, Ley 11/2023 | Accesibilidad de servicios bancarios para consumidores dentro de su ámbito, incluidas identificación, firma, seguridad y pago. Información comprensible, con el límite de complejidad lingüística de la norma. No se reduce a pasar una lista WCAG. [N1] |
| PSD2; Real Decreto-ley 19/2018; Reglamento Delegado (UE) 2018/389 | SCA en los supuestos exigibles, con las condiciones de sus excepciones. Protección de credenciales y, en pagos remotos cuando corresponda, vínculo con importe y beneficiario. [N2] [N2b] |
| Reglamento (UE) 2024/886, transferencias inmediatas | Verificación del beneficiario antes de autorizar las transferencias cubiertas (ordinarias e inmediatas) e información del resultado. Obligaciones de información y saldo en las inmediatas. La ausencia de respuesta no es coincidencia. [N3] [R1] |
| Reglamento General de Protección de Datos (RGPD) | Transparencia y base jurídica adecuada. Si la base es el consentimiento: libre, específico, informado e inequívoco, por acción afirmativa; las casillas premarcadas no lo acreditan. Retirar tan fácil como dar. [N4] |
| Orden EHA/2899/2011; Circular 5/2012 del Banco de España; Ley 5/2019 en crédito inmobiliario | Información precontractual y contractual clara sobre condiciones, costes y consecuencias, incluida la personalizada en hipotecas; un resumen comercial no la sustituye. [N5] [N6] [N7] |

**Referencia técnica, no ley:** WCAG 2.2 AA es el objetivo de la skill. Un atributo ARIA, un sello o una declaración pública no acreditan la conformidad del recorrido completo. [W0]

## Antes de emitir el informe

Además de las reglas de cierre de la skill:
- [ ] Jurisdicción y tipo de cliente confirmados.
- [ ] Producto, canal y contrato identificados.
- [ ] Versión de las fuentes guardada (las páginas cambian).
- [ ] Cuestiones [legal] enviadas a compliance y separadas de la tabla WCAG.
- [ ] Ningún caso documental usado como sustituto de una prueba propia.

## Fuentes

Consulta: 16-10-2026. Las fechas son las que indica cada fuente. Conserva copia controlada del contenido relevante al abrir una auditoría.

**Regulación y supervisión**
- [R1] Banco de España, verificación del beneficiario (07-10-2025): resultados posibles y alcance. https://clientebancario.bde.es/pcb/es/blog/nuevo-servicio-gratuito-de-verificacion-del-beneficiario-a-partir-del-9-de-octubre-de-2025-.html
- [R2] Banco de España, adeudos domiciliados: base del término del glosario, no de plazos. https://clientebancario.bde.es/pcb/es/menu-horizontal/productosservici/serviciospago/Adeudos_domiciliados.html
- [N1] Ley 11/2023, texto consolidado. https://www.boe.es/buscar/act.php?id=BOE-A-2023-11022
- [N2] Real Decreto-ley 19/2018, texto consolidado. https://www.boe.es/buscar/act.php?id=BOE-A-2018-16036
- [N2b] Reglamento Delegado (UE) 2018/389, consolidación del 25-07-2023; revalidar modificaciones. https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX%3A02018R0389-20230725
- [N3] Reglamento (UE) 2024/886. https://www.boe.es/buscar/doc.php?id=DOUE-L-2024-80392
- [N4] Reglamento (UE) 2016/679 (RGPD). https://www.boe.es/buscar/doc.php?id=DOUE-L-2016-80807
- [N5] Orden EHA/2899/2011, texto consolidado. https://www.boe.es/buscar/act.php?id=BOE-A-2011-17015
- [N6] Circular 5/2012 del Banco de España, texto consolidado. https://www.boe.es/buscar/act.php?id=BOE-A-2012-9058
- [N7] Ley 5/2019, texto consolidado. https://www.boe.es/buscar/act.php?id=BOE-A-2019-3814

**Técnicas**
- [W0] WCAG 2.2. https://www.w3.org/TR/WCAG22/
- [W1] Understanding 3.3.8 Autenticación accesible (mínimo). https://www.w3.org/WAI/WCAG22/Understanding/accessible-authentication-minimum.html
- [W2] Understanding 3.3.4 Prevención de errores. https://www.w3.org/WAI/WCAG22/Understanding/error-prevention-legal-financial-data.html
- [W3] Understanding 4.1.3 Mensajes de estado. https://www.w3.org/WAI/WCAG22/Understanding/status-messages.html
- [W4] Understanding 2.2.1 Tiempo ajustable. https://www.w3.org/WAI/WCAG22/Understanding/timing-adjustable.html
- [W6] Understanding 2.2.5 Reautenticación (AAA). https://www.w3.org/WAI/WCAG22/Understanding/re-authenticating.html
- [W8] Understanding 3.1.5 Nivel de lectura (AAA). https://www.w3.org/WAI/WCAG22/Understanding/reading-level.html
- [H1] WHATWG HTML, autocompletado `one-time-code`. https://html.spec.whatwg.org/dev/form-control-infrastructure.html#autofill
