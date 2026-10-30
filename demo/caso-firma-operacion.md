# Caso de demo: firmar una transferencia desde el móvil

> Caso ficticio creado para demostrar el equipo de agentes. "Banco Lumen" no existe; ningún dato procede de un banco real.

## Reto

Banco Lumen quiere reducir las llamadas al soporte relacionadas con la firma de transferencias en su web móvil. Hoy, para confirmar una transferencia, el cliente introduce un código de un solo uso que recibe por SMS.

**¿Cómo podríamos** hacer que firmar una transferencia sea seguro, comprensible y accesible para cualquier cliente, también para quien usa lector de pantalla o tiene mala conexión?

## Lo que sabemos

- El soporte recibe llamadas porque los clientes no saben si la transferencia se ha hecho después de un error.
- Algunos clientes dicen que el código caduca antes de que les dé tiempo a escribirlo.
- La pantalla actual de firma es `demo/pantalla-firma.html`.

## Lo que NO sabemos (preguntas abiertas para negocio)

- Cuántos intentos de código se permiten antes de bloquear la firma.
- Cuánto dura el código y si se puede reenviar.
- Qué pasa con la transferencia si la conexión se corta justo después de firmar.

## Flujo actual

1. El cliente rellena la transferencia: cuenta de destino, importe y concepto.
2. Pulsa "Continuar".
3. Recibe un SMS con un código de 6 dígitos.
4. Introduce el código en la pantalla de firma y pulsa el botón de firmar.
5. Si todo va bien, ve "Operación realizada". Si no, ve un mensaje de error.

## Restricciones

- Cumplimiento: WCAG 2.2 AA y confirmación explícita antes de mover dinero (WCAG 3.3.4).
- Design system existente con botón primario, campo de texto y mensaje de alerta.
- Web móvil (no app nativa) en esta fase.

## Qué debe producir el equipo

1. Mapa de flujo con happy path, edge cases y error cases.
2. Historias de usuario con criterios de aceptación.
3. Componentes necesarios: reutilizar, adaptar o crear.
4. Evaluación heurística y auditoría de accesibilidad de la pantalla actual.
5. Informe final con decisiones, riesgos y preguntas abiertas.
