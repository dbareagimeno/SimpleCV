#!/bin/bash

# Script para actualizar cv.md con el contenido de otro archivo
# Uso: ./update-cv.sh <archivo-origen>

if [ $# -eq 0 ]; then
    echo "Error: Debes proporcionar un archivo como parámetro"
    echo "Uso: ./update-cv.sh <archivo-origen>"
    exit 1
fi

ORIGEN="$1"

if [ ! -f "$ORIGEN" ]; then
    echo "Error: El archivo '$ORIGEN' no existe"
    exit 1
fi

# Obtener el directorio del script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DESTINO="$SCRIPT_DIR/cv.md"

# Copiar el archivo
cp "$ORIGEN" "$DESTINO"

if [ $? -eq 0 ]; then
    echo "✓ CV actualizado exitosamente"
    echo "  Origen: $ORIGEN"
    echo "  Destino: $DESTINO"
else
    echo "✗ Error al copiar el archivo"
    exit 1
fi
