# Historias de usuario · Firma de transferencia con código SMS (Banco Lumen) · v0.8.0

**Fuente:** `entregables/firma-0.8.0/01-flujo.md` (mapa de casos) · **Reto:** `demo/caso-firma-operacion.md` · **Plan:** `entregables/firma-0.8.0/00-plan.md` · **Fase:** 2b
**Estado:** borrador para firma de Producto. Hay historias bloqueadas por preguntas abiertas.
**Plataforma:** web móvil. **Criterios transversales:** WCAG 2.2 AA y confirmación explícita antes de mover dinero (3.3.4).

## Cómo leer este documento

- **Rol principal:** «cliente de Banco Lumen que firma una transferencia desde el móvil». Otros roles se nombran donde aplican.
- **Casos:** cada historia indica los IDs del mapa (E.. / X..) que cubre.
- **Marcadores `<... — pendiente Nn/Tn>`:** valor que no se conoce. No es una regla. Sin respuesta, el criterio es **provisional** y no se puede dar por cerrado.
- **Textos entre comillas:** son borradores del mapa, no copy aprobado. Contenido los valida.
- **Supuestos heredados del mapa:** S3 (resumen en P2 como confirmación explícita) y S4 (operación pendiente con referencia única creada al pulsar Continuar). Ambos están por validar con Accesibilidad y Tecnología. Las historias HU-03, HU-05, HU-12, HU-13, HU-14 y HU-15 dependen de ellos.
- **Pantallas:** P1 formulario, P2 firma, P3 resultado. P1 y P3 no tienen prototipo.
- **Estados finales:** Realizada, No realizada, Pendiente de confirmar. Un estado, un mensaje, venga de la ruta que venga.

## Estructura

| Épica | Historias |
|---|---|
| A. Preparar la firma | HU-01, HU-02, HU-03 |
| B. Firmar con el código | HU-04, HU-05, HU-06, HU-07, HU-08, HU-09 |
| C. Saber con certeza qué pasó | HU-10, HU-11, HU-12, HU-13, HU-14, HU-15 |
| D. Accesibilidad transversal | HU-16, HU-17 |

Orden de la lista: primero lo que desbloquea el valor principal (firmar una vez y saber el resultado), después lo que protege el dinero, después la fricción.

---

# Épica A. Preparar la firma

## HU-01 · Pedir el código sin duplicar la operación

**Como** cliente de Banco Lumen que prepara una transferencia desde el móvil, **quiero** pedir el código SMS con un solo toque y saber qué va a pasar, **para** no crear operaciones ni SMS repetidos y no sorprenderme.

**Casos:** E02 (alta), E03 (baja), X04 (media), X05 (alta). **Prioridad:** Alta. **Estado:** criterio provisional (T1, T3).

```gherkin
Escenario: Happy path. Se pide el código
  Dado que el cliente ha rellenado cuenta de destino, importe y concepto válidos en P1
  Cuando pulsa "Continuar"
  Entonces se crea una operación pendiente de firma con referencia única
  Y se envía un SMS de 6 dígitos
  Y se abre P2 con el foco en el título

Escenario: Aviso previo sobre el SMS (E03)
  Dado que el cliente está en P1
  Entonces, antes del botón "Continuar", se lee "Te enviaremos un SMS con un código de 6 dígitos"
  Y el cliente habitual no tiene pasos adicionales

Escenario: Doble toque en Continuar (E02)
  Dado que el cliente ha pulsado "Continuar"
  Cuando vuelve a pulsarlo antes de que cambie la pantalla
  Entonces el botón ya está bloqueado y muestra "Enviando código…"
  Y se crea una sola operación y se envía un solo SMS
  Y el cliente llega a P2 una sola vez

Escenario: Sin conexión al pedir el código (X04)
  Dado que el dispositivo no tiene conexión
  Cuando el cliente pulsa "Continuar"
  Entonces se muestra "Sin conexión. No se ha enviado nada ni se ha movido dinero."
  Y los datos del formulario se conservan

Escenario: Sin respuesta al pedir el SMS (X05)
  Dado que la petición del SMS no recibe respuesta pasado <umbral de espera — pendiente T3>
  Cuando se agota la espera
  Entonces se muestra "No sabemos si te hemos enviado el código. No se ha movido dinero. Mira tus SMS o pide uno nuevo."
  Y el cliente puede reintentar, volver o contactar
```

**Dependencias:** ninguna (arranca el flujo). **Notas:** E02 y el SMS único exigen que la creación de la operación sea idempotente (T1). Pedir el SMS no mueve dinero (S5). Preguntas: T1, T3.

## HU-02 · Corregir los errores del formulario antes de pedir el código

**Como** cliente de Banco Lumen que rellena una transferencia, **quiero** que me diga qué campo falla y cómo corregirlo sin perder lo escrito, **para** llegar a la firma con datos válidos y sin gastar un SMS.

**Casos:** E01 (media), X01 (media), X02 (alta), X03 (media). **Prioridad:** Alta. **Estado:** **BLOQUEADA** por N8 (reglas de validación y límites) y N7 (canal de contacto).

```gherkin
Escenario: Campo mal formado o vacío (X01)
  Dado que el cliente deja vacío el importe o escribe una cuenta mal formada
  Cuando pulsa "Continuar"
  Entonces aparece un error junto a cada campo afectado y un resumen al inicio del formulario
  Y el foco va al primer error
  Y cada mensaje dice qué pasa y cómo corregirlo
  Y los datos escritos se conservan

Escenario: Formato o longitud no admitidos (E01)
  Dado que el cliente escribe un concepto de más de <longitud máxima — pendiente N8> o un importe con formato no admitido
  Cuando pulsa "Continuar"
  Entonces se avisa en línea con el límite real
  Y el sistema no recorta nada en silencio

Escenario: Importe por encima de saldo o límite (X02)
  Dado que el importe supera <saldo disponible o límite de operación — pendiente N8>
  Cuando el cliente pulsa "Continuar"
  Entonces se muestra "El importe supera [tu saldo disponible / el límite de la operación]. No se ha enviado nada."
  Y no se envía ningún SMS
  Y el cliente puede cambiar el importe o cancelar

Escenario: Cuenta bloqueada o sin permiso (X03)
  Dado que la cuenta del cliente no puede transferir
  Cuando abre el formulario o pulsa "Continuar"
  Entonces se muestra qué pasa y cómo contactar, vía <canal de contacto — pendiente N7>
  Y no hay formulario editable
```

**Dependencias:** HU-01. **Notas:** no se inventan formatos, límites ni momento de comprobar el saldo (N8). X03 no tiene salida real sin N7.

## HU-03 · Revisar y confirmar lo que firmo antes de mover dinero

**Como** cliente de Banco Lumen que firma una transferencia, **quiero** ver destino, importe, concepto y referencia justo encima del campo del código, **para** confirmar conscientemente que esa operación es la que quiero.

**Casos:** happy path pasos 3 y 5; criterio 3.3.4 del reto (confirmación antes de mover dinero). **Prioridad:** Alta. **Estado:** criterio provisional (S3 por validar con Accesibilidad).

```gherkin
Escenario: Resumen visible antes de firmar
  Dado que el cliente llega a P2
  Entonces ve cuenta de destino, importe, concepto y referencia encima del campo de código
  Y ve el teléfono enmascarado terminado en 47

Escenario: El botón es la confirmación explícita
  Dado que el resumen está visible
  Cuando el cliente pulsa "Firmar"
  Entonces la acción solo se ejecuta tras ese toque explícito
  Y nada se envía al introducir el sexto dígito ni al autocompletar el código

Escenario: Resumen con zoom y lector de pantalla
  Dado que el cliente usa ampliación o lector de pantalla
  Entonces el resumen se puede leer entero antes de llegar al campo de código
  Y el orden de lectura es resumen, campo, "Firmar"
```

**Dependencias:** HU-01. **Notas:** la pantalla actual no muestra el resumen. Es un cambio respecto al flujo actual. Si Accesibilidad no valida S3, hay que decidir otra forma de cumplir 3.3.4 (por ejemplo, un paso de confirmación previo). Pregunta abierta, no suposición.

---

# Épica B. Firmar con el código

## HU-04 · Introducir el código y firmar

**Como** cliente de Banco Lumen que ha recibido el SMS, **quiero** escribir, pegar o autocompletar el código y firmar con facilidad, **para** completar la transferencia sin reescribir ni cambiar de teclado.

**Casos:** happy path pasos 4 a 6, E04 (media), E05 (media), E07 (media). **Prioridad:** Alta. **Estado:** criterio provisional en el autocompletado (T7).

```gherkin
Escenario: Happy path. Firma correcta
  Dado que el cliente está en P2 con un código vigente de 6 dígitos
  Cuando lo introduce y pulsa "Firmar"
  Entonces el botón se bloquea y se muestra "Firmando…"
  Y al confirmarse la ejecución se abre P3 "Transferencia realizada"

Escenario: Código pegado con espacios o guiones (E04)
  Dado que el cliente pega "123 456" o "123-456"
  Entonces el campo acepta el pegado y lo normaliza a "123456"
  Y puede firmar sin reescribir

Escenario: Código incompleto, con letras o vacío (E05)
  Dado que el campo está vacío, incompleto o contiene letras
  Cuando el cliente pulsa "Firmar"
  Entonces no se envía nada
  Y se muestra "El código tiene 6 dígitos. Te faltan [n]." junto al campo
  Y el foco va al campo

Escenario: Teclado numérico y autocompletado (E07)
  Dado que el cliente usa un móvil
  Entonces el campo muestra teclado numérico y ofrece el código del SMS si el navegador lo soporta <navegadores objetivo — pendiente T7>
  Y el campo tiene etiqueta visible, no solo placeholder

Escenario: Enter y orden de teclado (E07)
  Dado que el cliente usa solo teclado
  Cuando pulsa Enter en el campo
  Entonces equivale a pulsar "Firmar"
  Y el orden de tabulación es campo, "Firmar", reenviar, volver
```

**Dependencias:** HU-03. **Notas:** el campo actual es `type="text"` con placeholder y sin etiqueta (observación del mapa; la evaluación formal va en `05`). Pregunta: T7.

## HU-05 · Firmar una sola vez aunque se envíe dos veces

**Como** cliente de Banco Lumen que firma con mala conexión, **quiero** que la firma se ejecute una única vez aunque toque dos veces o tenga la operación abierta en dos pestañas, **para** no enviar el dinero duplicado.

**Casos:** E17 (alta), E12 (alta). **Prioridad:** **Crítica** (riesgo de duplicar dinero). **Estado:** **BLOQUEADA** por T1 (referencia única e idempotencia).

```gherkin
Escenario: Doble toque o Enter más toque (E17)
  Dado que el cliente ha pulsado "Firmar"
  Cuando vuelve a pulsar "Firmar" o Enter antes de recibir respuesta
  Entonces el botón ya estaba bloqueado, el campo es de solo lectura y la zona tiene aria-busy
  Y solo sale una petición de firma

Escenario: Reenvío de la petición con red lenta (E17)
  Dado que una petición de firma se repite con la misma referencia
  Cuando llega al servidor más de una vez
  Entonces se ejecuta una sola transferencia
  Y la repetición devuelve el mismo resultado
  Y el cliente ve un único resultado

Escenario: Misma operación en dos pestañas o dispositivos (E12)
  Dado que la misma operación está abierta en dos pestañas
  Cuando se firma en una y después se intenta firmar en la otra
  Entonces solo se ejecuta la primera firma
  Y la segunda pestaña muestra el estado actual de la operación
  Y no muestra un error genérico

Escenario: Anuncio del bloqueo (accesibilidad)
  Dado que el cliente usa lector de pantalla
  Cuando pulsa "Firmar"
  Entonces se anuncia "Firmando. No cierres esta pantalla." mediante role="status"
```

**Dependencias:** HU-04. **Notas:** el bloqueo del cliente no basta. La garantía real está en el servidor (T1). Sin T1, esta historia no se puede dar por cerrada. La pantalla actual cambia el texto a "Procesando…" pero deja el botón activo.

## HU-06 · Corregir un código incorrecto y entender el bloqueo por intentos

**Como** cliente de Banco Lumen que se equivoca al escribir el código, **quiero** saber que es incorrecto y poder corregirlo, y si me bloquean, saber cómo y cuándo seguir, **para** no quedarme sin salida.

**Casos:** X09 (alta), X10 (media), X11 (alta). **Prioridad:** Alta. **Estado:** **BLOQUEADA** por N1 (intentos), N6 (duración y desbloqueo del bloqueo), N7 (contacto) y T4 (código nuevo invalida el anterior).

```gherkin
Escenario: Código incorrecto (X09)
  Dado que el cliente tiene intentos disponibles <N intentos — pendiente N1>
  Cuando firma con un código incorrecto
  Entonces aparece junto al campo "El código no es correcto. Revisa el SMS y vuelve a escribirlo."
  Y el campo tiene aria-invalid y el mensaje se anuncia con role="alert"
  Y el foco va al campo con el contenido seleccionado
  Y la referencia de la operación se conserva

Escenario: Intentos restantes (X09)
  Dado que negocio decide si se muestran <¿mostrar intentos restantes? — pendiente N1>
  Entonces el mensaje los muestra solo si la respuesta es sí

Escenario: Código antiguo o ya usado (X10)
  Dado que el cliente escribe un código que ya no vale <¿un código nuevo invalida el anterior? — pendiente T4>
  Cuando pulsa "Firmar"
  Entonces se muestra "Ese código ya no vale. Usa el del último SMS."

Escenario: Intentos agotados (X11)
  Dado que el cliente ha agotado <N intentos — pendiente N1>
  Entonces se muestra "Has superado los intentos. La transferencia no se ha realizado."
  Y la pantalla no tiene campo de código
  Y indica cuándo y cómo volver a intentarlo según <duración y desbloqueo — pendiente N6>
  Y ofrece contacto por <canal — pendiente N7>
  Y el estado final es "No realizada"
```

**Dependencias:** HU-04. **Notas:** sin N7 el bloqueo es un callejón. No se muestra ningún número de intentos hasta que N1 se responda.

## HU-07 · Entender el tiempo del código y pedir otro si caduca

**Como** cliente de Banco Lumen que tarda en escribir el código, **quiero** ver el tiempo que queda y pedir uno nuevo en un toque sin perder la operación, **para** firmar aunque el código caduque antes de que lo teclee.

**Casos:** E09 (alta), E10 (alta), X12 (alta). **Prioridad:** Alta. **Estado:** **BLOQUEADA** por N2 (duración, reenvío y destino de la operación al caducar) y T6 (hora del servidor).

```gherkin
Escenario: Tiempo restante visible y estable (E09)
  Dado que el código dura <duración del código — pendiente N2>
  Cuando el cliente está en P2
  Entonces ve el tiempo restante de forma pasiva
  Y el lector de pantalla no anuncia cada segundo
  Y se anuncia un aviso con role="status" al llegar a <umbral de aviso — pendiente N2>

Escenario: Vuelta desde la app de mensajes (E10)
  Dado que el cliente salió a leer el SMS y vuelve al navegador
  Cuando P2 recupera el foco
  Entonces el tiempo se recalcula con la hora del servidor <¿hora del servidor? — pendiente T6>
  Y lo escrito en el campo se conserva
  Y si el código ya caducó, se indica cuándo caducó y se ofrece pedir uno nuevo

Escenario: Código caducado al pulsar Firmar (X12)
  Dado que el código caducó
  Cuando el cliente pulsa "Firmar"
  Entonces se muestra "El código ha caducado. No se ha movido dinero."
  Y aparece "Enviar código nuevo", o "Empezar de nuevo" si <¿hay reenvío? — pendiente N2>
  Y el cliente no pierde destino, importe ni concepto

Escenario: Pedir código nuevo en un toque (E09)
  Dado que el código caducó
  Cuando el cliente pulsa "Enviar código nuevo"
  Entonces se anuncia "Código enviado", el campo se limpia y el tiempo se reinicia
```

**Dependencias:** HU-04. **Notas:** hipótesis del mapa, a validar con Accesibilidad: si la caducidad es por seguridad, es una excepción a 2.2.1 y hay que abaratar el reintento. Es el motivo de llamada «el código caduca antes de escribirlo» del reto. Ningún valor de duración se ha inventado.

## HU-08 · Resolver un SMS que no llega o reenviar el código

**Como** cliente de Banco Lumen que no recibe el SMS, **quiero** pedir otro código y recibir ayuda si sigue sin llegar, **para** poder firmar o saber a quién acudir.

**Casos:** E16 (media), X06 (alta), X07 (media), X08 (media). **Prioridad:** Alta. **Estado:** **BLOQUEADA** por N2, N4 (espera y máximo de reenvíos), N7 y N9 (otro canal o cambio de número).

```gherkin
Escenario: SMS no recibido (X06)
  Dado que el cliente no ha recibido el SMS
  Cuando pulsa "¿No has recibido el código?"
  Entonces se abre ayuda con el número terminado en 47, comprobar cobertura y esperar <tiempo de espera — pendiente N2>
  Y ofrece reenviar y, si persiste, contactar con la referencia por <canal — pendiente N7>
  Y ofrece, si existe, <otro canal o cambio de número — pendiente N9>

Escenario: Reenvío correcto con espera (E16)
  Dado que el reenvío está permitido <¿reenvío posible? — pendiente N2>
  Cuando el cliente pulsa "Reenviar" y la espera entre reenvíos es <tiempo entre reenvíos — pendiente N4>
  Entonces se anuncia "Código enviado"
  Y el botón muestra una cuenta atrás visible
  Y se indica "Usa el último código"

Escenario: Falla el reenvío (X07)
  Dado que el envío falla
  Entonces se muestra "No hemos podido enviar el código. Inténtalo otra vez."
  Y si el código anterior sigue vigente, se dice

Escenario: Máximo de reenvíos (X08)
  Dado que el cliente ha pedido <N reenvíos máximos — pendiente N4>
  Entonces se muestra "Has pedido el máximo de códigos." con el siguiente paso <pendiente N7>
  Y el cliente puede contactar o empezar de nuevo
```

**Dependencias:** HU-04. **Notas:** el enlace actual no lleva a ninguna parte (observación del mapa). Hipótesis: puede que el número ya no sea del cliente.

## HU-09 · Firmar con mala conexión sin quedarse a ciegas

**Como** cliente de Banco Lumen con conexión inestable, **quiero** que la pantalla me diga si la firma se ha enviado o no, **para** saber si puedo volver a intentarlo sin riesgo.

**Casos:** E18 (alta), X14 (media). **Prioridad:** Alta. **Estado:** criterio provisional (T3, umbral de espera).

```gherkin
Escenario: Sin conexión antes de enviar la firma (X14)
  Dado que el dispositivo está sin conexión
  Cuando el cliente pulsa "Firmar"
  Entonces se muestra "Sin conexión. No hemos enviado la firma ni se ha movido dinero."
  Y el código escrito se conserva
  Y la firma no se reintenta sola

Escenario: Reintento al volver la red (X14)
  Dado que vuelve la conexión y el código sigue vigente
  Cuando el cliente pulsa "Firmar"
  Entonces la firma se envía una sola vez

Escenario: Firma lenta (E18)
  Dado que la firma tarda
  Entonces se muestra "Firmando… No cierres ni recargues esta pantalla."
  Y el bloqueo se mantiene mientras dure

Escenario: Se supera el umbral de espera (E18)
  Dado que pasa <umbral de espera de la firma — pendiente T3> sin respuesta
  Entonces se pasa a "Pendiente de confirmar" (HU-12)
  Y no se muestra un error ni un éxito
```

**Dependencias:** HU-05, HU-12. **Notas:** la diferencia entre «no enviado» (X14) y «enviado sin respuesta» (X15) debe quedar clara en el texto.

---

# Épica C. Saber con certeza qué pasó

## HU-10 · Ver que la transferencia se ha realizado

**Como** cliente de Banco Lumen que ha firmado, **quiero** ver una confirmación con importe, destino, referencia y fecha, **para** saber que el dinero se ha enviado y poder guardarlo.

**Casos:** happy path pasos 6 y 7. **Prioridad:** Alta. **Estado:** lista para refinar (el texto exacto depende de Contenido).

```gherkin
Escenario: Happy path. Transferencia realizada
  Dado que el sistema confirma la ejecución
  Cuando se abre P3
  Entonces se muestra "Transferencia realizada. Hemos enviado [importe] a [destino]."
  Y se ven fecha y referencia copiable
  Y el foco está en el título

Escenario: Acciones finales
  Dado que P3 muestra "Realizada"
  Entonces el cliente puede elegir "Ver movimiento" o "Nueva transferencia"

Escenario: Resultado ya confirmado no cambia
  Dado que P3 mostró "Realizada"
  Cuando el cliente no tiene conexión al volver a P3
  Entonces se muestra el último estado conocido con su hora
  Y el estado "Realizada" no cambia
```

**Dependencias:** HU-04. **Notas:** «Ver movimiento» supone una pantalla de movimientos o estado (T2). Si no existe, hay que decidir otra salida.

## HU-11 · Ver que la transferencia no se ha realizado y que no se movió dinero

**Como** cliente de Banco Lumen cuya firma ha sido rechazada o ha fallado, **quiero** que me diga qué ha pasado, si se ha movido dinero y qué hacer, **para** no llamar al soporte para averiguarlo.

**Casos:** X17 (alta), X18 (alta); estado «No realizada» al que convergen X11, X12 y E15. **Prioridad:** **Crítica** (estado inequívoco, origen de las llamadas). **Estado:** **BLOQUEADA** por T5 (catálogo de errores).

```gherkin
Escenario: Rechazo definitivo (X18)
  Dado que el sistema confirma que no se ejecutó la transferencia (fondos, antifraude o destino)
  Cuando se abre P3
  Entonces se muestra "La transferencia no se ha realizado. No se ha movido dinero."
  Y se muestra el motivo solo si se puede mostrar <¿qué motivos se pueden mostrar? — pendiente T5>
  Y el cliente puede corregir y empezar de nuevo, o contactar

Escenario: Error genérico del servidor con resultado conocido (X17)
  Dado que el servidor devuelve un error <código técnico — significado pendiente T5>
  Y se sabe que no se movió dinero
  Entonces el mensaje explica la causa y la acción
  Y el código técnico queda en segundo plano para soporte
  Y el cliente nunca ve solo "Error 4012"

Escenario: Error genérico con resultado desconocido (X17)
  Dado que no se puede saber si se movió dinero
  Entonces se trata como "Pendiente de confirmar" (HU-12)

Escenario: Un estado, un mensaje
  Dado que el cliente llega a "No realizada" desde intentos agotados, código caducado, rechazo o abandono
  Entonces ve el mismo mensaje base de "No realizada"
  Y la pantalla nunca ofrece un formulario firmable
```

**Dependencias:** HU-04. **Notas:** hasta que T5 no clasifique errores definitivos frente a desconocidos, no se puede decidir cuál va a «No realizada» y cuál a «Pendiente». Ante la duda, siempre «Pendiente».

## HU-12 · Saber que la firma está pendiente de confirmar y comprobar el estado

**Como** cliente de Banco Lumen cuya conexión se corta tras firmar, **quiero** ver «Pendiente de confirmar» con una forma de comprobar el estado, **para** no volver a firmar a ciegas ni llamar al soporte sin referencia.

**Casos:** X15 (alta), E18 (alta, paso al umbral). **Prioridad:** **Crítica** (origen de las llamadas y riesgo de duplicado). **Estado:** **BLOQUEADA** por N3 (qué pasa con la transferencia tras el corte), T2 (consulta por referencia) y T3 (umbral).

```gherkin
Escenario: Firma enviada sin respuesta (X15)
  Dado que la firma ha salido y no llega respuesta (corte, timeout o respuesta desconocida)
  Cuando se supera <umbral de espera — pendiente T3>
  Entonces P3 muestra "Pendiente de confirmar", nunca "error" ni "éxito"
  Y el texto dice "Hemos recibido tu firma, pero aún no sabemos si la transferencia se ha hecho. No vuelvas a firmar."
  Y muestra la referencia copiable

Escenario: Comprobar el estado (X15)
  Dado que P3 muestra "Pendiente de confirmar"
  Cuando el cliente pulsa "Comprobar estado" o salta la consulta automática limitada
  Entonces se consulta el estado por referencia <¿hay consulta por referencia? — pendiente T2>
  Y se pasa a "Realizada" o "No realizada" si el sistema ya lo sabe
  Y mientras tanto se anuncia "Comprobando el estado de tu transferencia…" con role="status"

Escenario: Sigue sin saberse (X15)
  Dado que la consulta no resuelve el estado
  Entonces se ofrece ver movimientos o contactar con la referencia por <canal — pendiente N7>
  Y se indica en cuánto tiempo se sabrá <plazo — pendiente N3>

Escenario: Sin conexión al comprobar
  Dado que no hay red
  Cuando el cliente pulsa "Comprobar estado"
  Entonces se muestra el último estado conocido con su hora
  Y "Comprobar estado" queda disponible al volver la red
```

**Dependencias:** HU-05, HU-09. **Notas:** es el caso principal del reto. El texto no promete que la transferencia se ejecute ni se cancele: eso es N3. La consulta automática es limitada y su límite no está definido.

## HU-13 · No poder duplicar la transferencia tras un estado pendiente

**Como** cliente de Banco Lumen con una firma pendiente de confirmar, **quiero** que el sistema no me deje firmar de nuevo a ciegas, **para** no enviar el dinero dos veces.

**Casos:** X16 (alta). **Prioridad:** **Crítica** (riesgo de duplicado). **Estado:** **BLOQUEADA** por T1 y N3.

```gherkin
Escenario: Intento de firmar tras Pendiente (X16)
  Dado que la operación está en "Pendiente de confirmar" y no hay estado conocido
  Cuando el cliente vuelve a P2 o intenta firmar
  Entonces no se ofrece "Firmar"
  Y se ofrece "Comprobar estado"

Escenario: Estado conocido al volver (X16)
  Dado que el sistema ya conoce el estado
  Cuando el cliente vuelve a la operación
  Entonces se muestra "Realizada" o "No realizada" según corresponda

Escenario: Firma repetida que llega al servidor (X16)
  Dado que una firma repetida llega con la misma referencia
  Entonces se reutiliza la referencia
  Y no se ejecuta otra transferencia
```

**Dependencias:** HU-12. **Notas:** mismo requisito de idempotencia que HU-05 (T1). Un cliente con una nueva transferencia equivalente (mismo destino e importe) es una operación distinta: no se bloquea, pero eso es una regla de negocio que se pregunta, no se supone.

## HU-14 · Saber qué pasó con mi transferencia si la sesión caduca

**Como** cliente de Banco Lumen cuya sesión caduca durante la firma, **quiero** que al volver a entrar me enseñen el estado real de la operación, **para** no repetir una transferencia que quizá ya se hizo.

**Casos:** X13 (alta). **Prioridad:** **Crítica** (estado ambiguo). **Estado:** **BLOQUEADA** por N5 (duración de sesión y datos conservados) y T2 (consulta por referencia).

```gherkin
Escenario: La sesión caduca en medio del proceso (X13)
  Dado que la sesión caduca entre P2 y P3
  Entonces se muestra "Tu sesión ha terminado."
  Y se ofrece iniciar sesión

Escenario: Estado real tras el login (X13)
  Dado que el cliente inicia sesión de nuevo
  Cuando vuelve al flujo
  Entonces el sistema consulta el estado por referencia antes de ofrecer nada <consulta por referencia — pendiente T2>
  Y muestra P3 con "Realizada", "No realizada" o "Pendiente de confirmar"

Escenario: No se promete que la operación siga viva (X13)
  Dado que el estado no es "Realizada"
  Entonces el texto no promete que la operación pueda continuar
  Y solo conserva los datos que permita <datos conservables — pendiente N5>

Escenario: Sesión caducada al consultar el estado
  Dado que el cliente está en P3 y la sesión caduca
  Cuando pulsa "Comprobar estado"
  Entonces tras el login vuelve a P3 por referencia
```

**Dependencias:** HU-12. **Notas:** si no hay estado conocido, converge en «Pendiente de confirmar». Los datos personales de la operación no deben ir en la URL de retorno (pregunta a Tecnología).

## HU-15 · Retomar la operación tras recargar, volver atrás o abandonar

**Como** cliente de Banco Lumen que recarga, vuelve atrás o abandona y regresa, **quiero** retomar donde estaba o ver el resultado, **para** no empezar de nuevo ni firmar otra vez algo ya firmado.

**Casos:** E11 (alta), E14 (alta), E13 (media), E15 (media). **Prioridad:** **Crítica** en E14 y E11 (riesgo de duplicado), alta en el resto. **Estado:** **BLOQUEADA** por T1, T2 y N2.

```gherkin
Escenario: Recarga en P2 (E11)
  Dado que el cliente recarga P2 o pierde la pestaña
  Cuando vuelve a la operación
  Entonces se recupera la operación pendiente por referencia <consulta por referencia — pendiente T2>
  Y no se crea otra operación ni se envía otro SMS
  Y se muestra el tiempo restante
  Y si ya se firmó, se muestra el resultado

Escenario: Atrás o recarga tras el resultado (E14)
  Dado que P3 muestra un estado final
  Cuando el cliente pulsa atrás o recarga
  Entonces se muestra el mismo resultado
  Y nunca se abre un formulario firmable

Escenario: Vuelta atrás antes de firmar (E13)
  Dado que el cliente está en P2 sin haber firmado
  Cuando pulsa la flecha del encabezado o atrás del navegador
  Entonces se avisa "Si sales, la operación no se firma. Tus datos se conservan."
  Y puede permanecer en P2 o volver a P1 con los datos
  Y el código deja de valer <hipótesis — pendiente N2>

Escenario: Vuelve minutos u horas después (E15)
  Dado que el cliente abandonó y regresa
  Cuando la operación sigue vigente <vigencia — pendiente N2>
  Entonces vuelve a P2
  Y si no sigue vigente, se muestra "No se firmó. No se ha movido dinero." con los datos precargados
```

**Dependencias:** HU-01, HU-12. **Notas:** la flecha actual hace `history.back()` sin avisar (observación del mapa).

---

# Épica D. Accesibilidad transversal

## HU-16 · Completar la firma con lector de pantalla

**Como** cliente de Banco Lumen que usa lector de pantalla (VoiceOver o TalkBack), **quiero** que cada paso y cada resultado se anuncie de forma clara, **para** firmar y saber el resultado sin ayuda visual.

**Casos:** E06 (alta), E19 (media). **Prioridad:** Alta. **Estado:** criterio provisional. El anuncio real **no está verificado**: hay que probar en dispositivo (sección 7 del mapa).

```gherkin
Escenario: Llegada a P2
  Dado que el cliente llega a P2
  Entonces el foco va al título y se anuncia "Firma de la operación"
  Y el campo tiene una etiqueta programáticamente asociada
  Y el teléfono se lee "terminado en 4 7", sin símbolos

Escenario: Tiempo, reenvío y estados
  Dado que el cliente usa lector de pantalla
  Entonces el tiempo se anuncia solo en umbrales
  Y "Código enviado" y "Firmando" se anuncian con role="status"
  Y los errores se anuncian con role="alert"

Escenario: Resultado (E19)
  Dado que se abre P3
  Entonces el foco va al título y se anuncia el estado ("Transferencia realizada", "No realizada" o "Pendiente de confirmar")
  Y la referencia de 19 dígitos está en un bloque aparte, copiable y agrupada para leerla

Escenario: Verificación en dispositivo
  Dado que los criterios anteriores están implementados
  Cuando QA los prueba con VoiceOver en iOS y TalkBack en Android
  Entonces cada anuncio coincide con la tabla de la sección 7 del mapa
  Y lo que no se pueda comprobar se registra como pendiente
```

**Dependencias:** HU-03, HU-04, HU-10. **Notas:** no se da por cumplido por revisar HTML estático.

## HU-17 · Firmar con ampliación, texto grande y teclado virtual abierto

**Como** cliente de Banco Lumen con baja visión que amplía la pantalla o usa texto grande, **quiero** ver el error, el tiempo y el botón "Firmar" aunque el teclado esté abierto, **para** poder firmar sin perder el botón.

**Casos:** E08 (media), E07 (media, teclado). **Prioridad:** Media. **Estado:** lista para refinar.

```gherkin
Escenario: Reflow a 320 px (E08)
  Dado que el cliente amplía al 200 % o al 400 % o usa texto grande
  Entonces no hay desplazamiento horizontal a 320 px de ancho
  Y no se pierde información ni función

Escenario: Teclado virtual abierto (E08)
  Dado que el teclado virtual está abierto en P2
  Entonces el mensaje de error, el tiempo restante y "Firmar" están visibles o alcanzables sin cerrarlo

Escenario: Tamaño de objetivos táctiles (E08)
  Dado cualquier control interactivo de P2
  Entonces mide al menos 24 por 24 px, o cumple la excepción de espaciado de 2.5.8

Escenario: Foco visible y orden (E07)
  Dado que el cliente navega con teclado
  Entonces el foco es visible en cada control
  Y el orden es campo, "Firmar", reenviar, volver
```

**Dependencias:** HU-04. **Notas:** comprobable en un navegador móvil real o emulado. Los umbrales son los de WCAG 2.2 AA, no valores propios.

---

# Tabla resumen

| ID | Título | Prioridad | Depende de | Bloqueo |
|---|---|---|---|---|
| HU-01 | Pedir el código sin duplicar la operación | Alta | - | Provisional (T1, T3) |
| HU-02 | Corregir los errores del formulario | Alta | HU-01 | **N8, N7** |
| HU-03 | Revisar y confirmar lo que firmo | Alta | HU-01 | Provisional (S3) |
| HU-04 | Introducir el código y firmar | Alta | HU-03 | Provisional (T7) |
| HU-05 | Firmar una sola vez | **Crítica** | HU-04 | **T1** |
| HU-06 | Código incorrecto e intentos | Alta | HU-04 | **N1, N6, N7, T4** |
| HU-07 | Tiempo del código y caducidad | Alta | HU-04 | **N2, T6** |
| HU-08 | SMS no recibido y reenvío | Alta | HU-04 | **N2, N4, N7, N9** |
| HU-09 | Firmar con mala conexión | Alta | HU-05, HU-12 | Provisional (T3) |
| HU-10 | Ver transferencia realizada | Alta | HU-04 | T2 (salida) |
| HU-11 | Ver transferencia no realizada | **Crítica** | HU-04 | **T5** |
| HU-12 | Pendiente de confirmar y comprobar estado | **Crítica** | HU-05, HU-09 | **N3, T2, T3** |
| HU-13 | No duplicar tras estado pendiente | **Crítica** | HU-12 | **T1, N3** |
| HU-14 | Sesión caducada | **Crítica** | HU-12 | **N5, T2** |
| HU-15 | Retomar tras recarga, atrás o abandono | **Crítica** (E11, E14) | HU-01, HU-12 | **T1, T2, N2** |
| HU-16 | Lector de pantalla | Alta | HU-03, HU-04, HU-10 | Provisional (verificar en dispositivo) |
| HU-17 | Ampliación, texto grande y teclado virtual | Media | HU-04 | - |

## Orden de implementación sugerido

1. **Base:** HU-01, HU-03, HU-04, HU-10 (el happy path completo).
2. **Dinero:** HU-05, HU-12, HU-13, HU-11, HU-14, HU-15. Dependen de T1 y T2: son la primera conversación con Tecnología.
3. **Fricción:** HU-06, HU-07, HU-08, HU-09, HU-02. Dependen de las respuestas de negocio N1, N2, N4, N8.
4. **Accesibilidad:** HU-16 y HU-17 se aplican en cada historia anterior. Se verifican al final en dispositivo.

## Trazabilidad con el mapa

**Alta prioridad (20 de 20 cubiertos):**

| Caso | Historia | Caso | Historia |
|---|---|---|---|
| E02 | HU-01 | X02 | HU-02 |
| E06 | HU-16 | X05 | HU-01 |
| E09 | HU-07 | X06 | HU-08 |
| E10 | HU-07 | X09 | HU-06 |
| E11 | HU-15 | X11 | HU-06 |
| E12 | HU-05 | X12 | HU-07 |
| E14 | HU-15 | X13 | HU-14 |
| E17 | HU-05 | X15 | HU-12 |
| E18 | HU-09, HU-12 | X16 | HU-13 |
| - | - | X17 | HU-11 |
| - | - | X18 | HU-11 |

**Media y baja:** E01 HU-02 · E03 HU-01 · E04 HU-04 · E05 HU-04 · E07 HU-04, HU-17 · E08 HU-17 · E13 HU-15 · E15 HU-15 · E16 HU-08 · E19 HU-16 · X01 HU-02 · X03 HU-02 · X04 HU-01 · X07 HU-08 · X08 HU-08 · X10 HU-06 · X14 HU-09.

**Casos sin cubrir:** ninguno.

## Preguntas abiertas que bloquean

Las del mapa, sin respuesta. No se ha asumido ningún valor.

| Pregunta | Bloquea |
|---|---|
| N1 intentos y si se muestran | HU-06 |
| N2 duración del código, reenvío, destino de la operación al caducar | HU-07, HU-08, HU-15 |
| N3 qué pasa tras un corte justo después de firmar y en cuánto se sabe | HU-12, HU-13 |
| N4 espera y máximo de reenvíos | HU-08 |
| N5 sesión y datos conservados tras el login | HU-14 |
| N6 duración y desbloqueo del bloqueo | HU-06 |
| N7 canal de contacto, horario y datos que debe dar el cliente | HU-02, HU-06, HU-08, HU-12 (sin esto, los cierres duros no tienen salida) |
| N8 validación, límites, momento de comprobar saldo | HU-02 |
| N9 otro canal si el SMS no llega | HU-08 |
| T1 referencia única e idempotencia | HU-01, HU-05, HU-13, HU-15 |
| T2 consulta de estado por referencia | HU-10, HU-12, HU-14, HU-15 |
| T3 umbral de espera | HU-01, HU-09, HU-12 |
| T4 código nuevo invalida el anterior | HU-06 |
| T5 catálogo de errores | HU-11 |
| T6 hora del servidor | HU-07 |
| T7 autocompletado del código | HU-04 |

**Pregunta nueva (no está en el mapa):** si el cliente repite una transferencia con los mismos datos tras un «Pendiente de confirmar», ¿hay alguna regla de duplicado a nivel de negocio? Afecta a HU-13.

## Comprobación INVEST (resumen)

- **Independientes:** las dependencias están anotadas. No hay ciclos. HU-09 y HU-12 se referencian entre sí a nivel de comportamiento, no de entrega: HU-09 puede entregarse antes con X14 y E18 en espera, y enlazarse a HU-12 después.
- **Estimables:** las bloqueadas **no son estimables** hasta que se responda su pregunta. Las provisionales lo son con riesgo.
- **Pequeñas:** ninguna pasa de 5 escenarios. HU-15 es la más grande y podría dividirse en «recarga y resultado» (E11, E14) y «atrás y abandono» (E13, E15) si el equipo la estima por encima de la media.
- **Testeables:** todo criterio nombra un resultado observable. Los de lector de pantalla requieren dispositivo.

## Límites

- Los textos son borradores del mapa. No son copy aprobado.
- Estas historias no evalúan la pantalla actual. Eso va en `04-heuristicas.md` y `05-accesibilidad.md`.
- No se han inventado datos de usuarios, métricas ni reglas de negocio. Lo desconocido está marcado como `<... — pendiente Nn/Tn>`.
