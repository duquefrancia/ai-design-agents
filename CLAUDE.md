# Reglas del proyecto Design Agents

Claude Code lee este archivo al empezar cada sesión en esta carpeta.

## Idioma y tono
- Responde y escribe los entregables en español de España.
- Frases cortas y concretas. Nada de relleno.

## Criterios de diseño
- Accesibilidad: WCAG 2.2 AA como mínimo.
- Plataformas: Apple HIG en iOS, Material 3 en Android.
- Design system: solo tokens semánticos o de componente; reutilizar antes que crear.

## Honestidad
- No inventes datos de usuarios, métricas, citas ni reglas de negocio. Si faltan, escríbelos como pregunta abierta o hipótesis.
- Lo que no se puede verificar se dice, no se da por bueno.
- En operaciones con dinero o datos personales, el riesgo de error pesa más que la estética.

## Demo
- `demo/problemas-sembrados.md` y `demo/hoja-evaluacion-heuristicas.md` son hojas de respuestas. No las leas ni las uses al evaluar ninguna pantalla de `demo/`: sirven para comprobar después lo que encontraron los agentes.
- Cada auditoría es independiente: no leas ni modifiques informes anteriores de `entregables/` salvo que te lo pidan. Escribe solo en la ruta que te indiquen.

## Evaluaciones: alcance de las acciones
Esta sección se aplica a evaluaciones y auditorías (heurísticas, accesibilidad y las de los demás agentes del plugin). En este flujo **prevalece** sobre «Los entregables de cada caso van en `entregables/<caso>/`» y «Cada cambio terminado es un commit».

- **Evaluar, guardar y hacer commit son tres acciones distintas.** Pedir una evaluación autoriza a hacerla y entregar el resultado en la conversación. No autoriza a guardar un informe ni a crear un commit.
- **Guardar** requiere que se pida, en la ruta indicada o en una acordada antes.
- **Hacer commit** requiere autorización para ese trabajo. Si ya existe, no se vuelve a preguntar.
- Si solo se pide evaluar, entrega la evaluación y termina. No ofrezcas guardarla.
- «Los entregables van en `entregables/<caso>/`» dice **dónde** guardar cuando corresponde. «Cada cambio es un commit» regula el versionado de cambios autorizados. Ninguna de las dos autoriza a crear entregables nuevos.
- No leas ni listes informes anteriores, el archivo de pruebas (`evals/archivo/`) ni el historial de git que los contiene, salvo que te lo pidan.

## Organización
- Los entregables de cada caso van en `entregables/<caso>/`, numerados en orden (`00-plan.md`, `01-flujo.md`…).
- El plugin está en `plugins/design-team/`. Cuando cambie una skill o un agente, sube la versión en `plugins/design-team/.claude-plugin/plugin.json` y añade la entrada en `CHANGELOG.md`.
- Tras cambiar estados en `panel/inventario.json`, regenera el panel con `python3 panel/build_panel.py`.
- Cada cambio terminado es un commit de git con un mensaje claro.
