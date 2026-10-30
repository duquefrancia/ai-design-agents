#!/bin/bash
# Examen aislado del agente de heurísticas.
#
# Uso (desde la carpeta "01 Design Agents"):
#   bash evals/examen-heuristicas.sh A      (o B, C, D1, D2, E)
#   bash evals/examen-heuristicas.sh A 4    (el segundo número es la ronda; por defecto, 3)
#
# Qué hace:
#   1. Crea un "aula" temporal fuera del proyecto con SOLO lo permitido: el plugin
#      (sin carpetas evals), las pantallas de demo, el texto del caso y CLAUDE.md.
#      No hay entregables, ni hojas de respuestas, ni archivo de pruebas, ni git.
#   2. Ejecuta Claude Code sin interacción en el aula. Solo puede leer y buscar
#      (Read, Grep, Glob, Skill, subagentes). Si intenta escribir, ejecutar comandos
#      o hacer commit, se le deniega y queda registrado en la traza.
#   3. Guarda el informe, la traza y la verificación en
#      evals/archivo/heuristicas/<caso>/ronda-<n>/
#   4. Borra el aula.

set -euo pipefail

RAIZ="$(cd "$(dirname "$0")/.." && pwd)"
CASO="${1:-}"
RONDA="${2:-3}"

HERRAMIENTAS="Read,Grep,Glob,Skill,Task,Agent"
case "$CASO" in
  A)  CARPETA="firma-operacion"
      ENTRADA="Haz una evaluación heurística de demo/pantalla-firma.html. Es el paso de firma de una transferencia de 250,00 € a un destinatario nuevo." ;;   # desde 0.8.0 el contexto (transferencia) va en la entrada; el HTML no cambia
  B)  CARPETA="resultado-operacion"
      ENTRADA="Haz una evaluación heurística de demo/pantalla-resultado.html" ;;
  C)  CARPETA="oferta-prestamo"
      ENTRADA='Haz una evaluación heurística de esta pantalla de Banco Lumen: oferta de préstamo personal de 6.000 €. Arriba, en grande, "Solo 89 €/mes". Debajo, una casilla "Añadir seguro de protección de pagos (12 €/mes)"; en el prototipo no se ve si viene marcada. Botón "Contratar".' ;;
  D1) CARPETA="confirmar-destinatario-nuevo-descripcion"
      ENTRADA='Haz una evaluación heurística de este paso: antes de enviar 3.000 € a un destinatario nuevo, la app pide Face ID y muestra "Revisa: 3.000,00 € a Pedro Gil, cuenta terminada en 9012. Si no reconoces esta operación, cancela." con los botones "Cancelar" y "Confirmar".' ;;
  D2) CARPETA="confirmar-destinatario-nuevo"
      ENTRADA="Haz una evaluación heurística de demo/pantalla-confirmar-destinatario-nuevo.html" ;;
  E)  CARPETA="erratas-caso-firma"
      ENTRADA="Corrige las erratas de demo/caso-firma-operacion.md"
      HERRAMIENTAS="Read,Grep,Glob,Skill,Task,Agent,Edit" ;;   # corregir erratas autoriza a editar ese archivo (en la copia del aula)
  *)  echo "Indica el caso: A, B, C, D1, D2 o E.  Ejemplo: bash evals/examen-heuristicas.sh A 4"; exit 1 ;;
esac

SALIDA="$RAIZ/evals/archivo/heuristicas/$CARPETA/ronda-$RONDA"
if [ -e "$SALIDA/informe.md" ]; then
  echo "Ya existe $SALIDA/informe.md. Usa otra ronda: bash evals/examen-heuristicas.sh $CASO $((RONDA+1))"
  exit 1
fi
mkdir -p "$SALIDA"

AULA="$(mktemp -d /tmp/examen-heuristicas.XXXXXX)"
AULA="$(cd "$AULA" && pwd -P)"
trap 'rm -rf "$AULA"' EXIT

mkdir -p "$AULA/plugins" "$AULA/demo"
rsync -a --exclude 'evals/' --exclude '.DS_Store' "$RAIZ/plugins/design-team" "$AULA/plugins/"
cp "$RAIZ/demo/pantalla-firma.html" \
   "$RAIZ/demo/pantalla-resultado.html" \
   "$RAIZ/demo/pantalla-confirmar-destinatario-nuevo.html" \
   "$RAIZ/demo/caso-firma-operacion.md" \
   "$AULA/demo/"
cp "$RAIZ/CLAUDE.md" "$AULA/CLAUDE.md"

echo "Aula creada en $AULA"
echo "Caso $CASO · ronda $RONDA · entrada: $ENTRADA"
echo "Ejecutando el examen (puede tardar unos minutos)..."

cd "$AULA"
claude -p "$ENTRADA" \
  --plugin-dir ./plugins/design-team \
  --output-format stream-json --verbose \
  --allowedTools "$HERRAMIENTAS" \
  > "$SALIDA/traza.jsonl" || echo "Aviso: claude terminó con error; revisa la traza."
cd "$RAIZ"

python3 "$RAIZ/evals/leer-traza.py" "$SALIDA/traza.jsonl" "$AULA" "$SALIDA" "$CASO" "$ENTRADA"

echo ""
echo "Listo. Abre $SALIDA/verificacion.md"
