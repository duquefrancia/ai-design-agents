# Casos de prueba: evaluating-heuristics (v0.6)

Este archivo solo tiene las **entradas** de los exámenes. Lo esperado de cada caso y la hoja de resultados están en `demo/hoja-evaluacion-heuristicas.md`, que el agente evaluado no debe leer.

**Cómo ejecutarlos:** cada caso en una **sesión nueva** de Claude Code (`claude --plugin-dir ./plugins/design-team`), escribiendo la entrada tal cual. Guarda la respuesta en `entregables/pruebas-heuristicas/caso-X.md` y sal con `/exit`.

Si un caso falla, **repítelo una vez en una sesión limpia** antes de cambiar la skill.

**Criterio de diseño de los tests (22 oct 2026):**
- Si el caso valida **una skill concreta**, la entrada declara la disciplina («Revisa la accesibilidad de…», «Haz una evaluación heurística de…»). Así se prueba la skill, no la elección de especialista.
- Las entradas **neutras** («Audita esta pantalla…», «Evalúa este paso…») se reservan para pruebas de **routing**, y se declaran como tales.
- Marcos separados: WCAG y requisitos de accesibilidad → accesibilidad. Nielsen, patrones engañosos y líneas rojas → heurísticas. Riesgos de producto que no son WCAG → se registran aparte y el orquestador decide su impacto global.

> Cambiado (23 oct 2026): C y D1 empiezan por «Haz una evaluación heurística de…». El resto del enunciado no cambia.

## Caso A · Pantalla con problemas sembrados
```
Haz una evaluación heurística de demo/pantalla-firma.html. Es el paso de firma de una transferencia de 250,00 € a un destinatario nuevo.
```

## Caso B · Pantalla correcta
```
Haz una evaluación heurística de demo/pantalla-resultado.html
```

## Caso C · Indicios de patrón engañoso
```
Haz una evaluación heurística de esta pantalla de Banco Lumen: oferta de préstamo personal de 6.000 €. Arriba, en grande, "Solo 89 €/mes". Debajo, una casilla "Añadir seguro de protección de pagos (12 €/mes)"; en el prototipo no se ve si viene marcada. Botón "Contratar".
```

## Caso D1 · Información incompleta
```
Haz una evaluación heurística de este paso: antes de enviar 3.000 € a un destinatario nuevo, la app pide Face ID y muestra "Revisa: 3.000,00 € a Pedro Gil, cuenta terminada en 9012. Si no reconoces esta operación, cancela." con los botones "Cancelar" y "Confirmar".
```

## Caso D2 · Interacción de seguridad justificada y completa
```
Haz una evaluación heurística de demo/pantalla-confirmar-destinatario-nuevo.html
```

## Caso E · No se activa cuando no toca
```
Corrige las erratas de demo/caso-firma-operacion.md
```
