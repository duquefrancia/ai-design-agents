# Las 10 heurísticas de Nielsen: controles generales y por sector

Para cada heurística: qué mirar siempre (control general) y qué mirar según el sector. Usa solo la columna del sector de la pantalla. Los ejemplos son orientativos: un hallazgo necesita evidencia en la entrada, no basta con que encaje en la tabla.

## Controles generales

| # | Heurística | Control general |
|---|---|---|
| H1 | Visibilidad del estado del sistema | ¿Se sabe qué está pasando? Carga, envío, guardado, paso actual, tiempo restante, resultado de la acción |
| H2 | Relación entre el sistema y el mundo real | ¿Palabras de la persona y no jerga interna? ¿Iconos, formatos y orden siguen convenciones conocidas? |
| H3 | Control y libertad | ¿Se puede cancelar, volver, deshacer o salir sin perder trabajo? |
| H4 | Consistencia y estándares | ¿Mismo término y componente para lo mismo? ¿Convenciones de la plataforma? |
| H5 | Prevención de errores | ¿Se evita el error antes de que ocurra? Resumen antes de confirmar, valores por defecto seguros, límites, protección contra doble envío |
| H6 | Reconocer antes que recordar | ¿Está a la vista lo necesario o hay que recordarlo de un paso anterior? ¿Números largos agrupados? |
| H7 | Flexibilidad y eficiencia | ¿Atajos para quien repite (autocompletar, rellenar códigos, favoritos) sin complicar a quien empieza? |
| H8 | Diseño estético y minimalista | ¿Cada elemento aporta a la tarea? ¿Lo importante destaca y no compite con lo accesorio? |
| H9 | Reconocer, diagnosticar y recuperarse de errores | ¿El error dice qué pasó, por qué y cómo seguir, en lenguaje claro y junto a donde ocurre? |
| H10 | Ayuda y documentación | ¿Hay ayuda breve y contextual donde se duda, orientada a la tarea? |

## Controles por sector

| # | Banca digital | Salud y cuidado del paciente | Comercio y SaaS |
|---|---|---|---|
| H1 | Resultado claro tras firmar: hecho, pendiente o fallido; tiempo del código visible | Estado de una cita, receta o resultado: pendiente, validado, antiguo | Estado del pedido, del pago o de la sincronización |
| H2 | TAE, IBAN, SCA, "concepto" sin explicar; códigos internos | Términos clínicos sin traducir; unidades poco habituales | Nombres de plan, "seats", "créditos" sin explicar |
| H3 | Cancelar antes de firmar; reenviar código; salir sin perder la transferencia rellenada | Cancelar o cambiar una cita; retirar permisos de un cuidador | Cancelar suscripción o pedido; deshacer borrados |
| H4 | Mismo nombre para la misma cuenta o producto en todo el flujo | Mismo formato de fechas, dosis y unidades | Precios con o sin IVA siempre igual |
| H5 | Importe, destinatario, cuenta y comisiones visibles antes de confirmar; doble envío bloqueado | Confirmar paciente, dosis y fecha antes de enviar | Resumen del total y de la recurrencia antes de pagar |
| H6 | Referencia y números largos agrupados; datos del paso anterior repetidos al confirmar | Datos del paciente visibles al decidir | Configuración elegida visible en el resumen |
| H7 | `autocomplete="one-time-code"`, teclado numérico, contactos frecuentes | Repetir cita o receta habitual | Acciones masivas, atajos, plantillas |
| H8 | Saldo y datos sensibles solo donde hacen falta | Alertas clínicas que no compiten con publicidad o accesorios | Ofertas que no tapan la tarea principal |
| H9 | "Error 4012" sin causa ni salida; qué pasa con el dinero tras un fallo | Qué hacer si un resultado no carga o no coincide | Pago rechazado: por qué y cómo reintentar |
| H10 | Ayuda junto al código, la firma o el aviso antifraude | Ayuda para preparar una cita o leer un resultado | Ayuda en la configuración y la facturación |

## Controles de accesibilidad que complementan la inspección

Se miran porque cambian si la persona puede completar la tarea. Si aparecen, van en la ficha del problema con el riesgo «Accesibilidad o inclusión». La comprobación de conformidad (ratios, foco, semántica, lector de pantalla) se deriva a `auditing-accessibility`.

| Control | Heurísticas | Qué mirar |
|---|---|---|
| Información solo por color | H1, H9 | Estado, error o éxito que solo se distingue por el color |
| Texto legible | H8 | Texto esencial muy pequeño o muy claro sobre el fondo |
| Objetivos táctiles | H5, H7 | Acciones principales pequeñas o muy juntas |
| Límites de tiempo | H3 | Tiempo para completar sin aviso, ampliación ni reintento |
| Iconos sin texto | H2, H6 | Acciones importantes representadas solo con un icono |
| Lenguaje claro | H2, H9 | Frases largas, jerga o símbolos que se leen mal en voz alta |

## Dónde se cruzan con las líneas rojas

Estos cruces **orientan la inspección**: si ves una línea roja, revisa también estas heurísticas. **No propagan severidad** al semáforo.

- H1 + H5 en operaciones con dinero → líneas rojas U1 y U2.
- H3 → U3 y P4 (salida obstruida).
- H9 → U4.
- H8 en dashboards → P10 (integridad de dashboards).
