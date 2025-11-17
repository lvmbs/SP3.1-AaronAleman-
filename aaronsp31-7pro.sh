#!/bin/bash

# ARCHIVO CON LA LISTA DE PROGRAMAS
ARCHIVO="programas.txt"

# VERIFICACIÓN DE LA EXISTENCIA DEL COMANDO, SI NO EXISTE EL PROGRAMA TERMINA
if [[ ! -f "$ARCHIVO" ]]; then
    echo "El archivo programas.txt no se encuentra en $DIR"
    return
fi

# WHILE QUE LEE LAS LINEAS DEL ARCHIVO Y BORRA LOS PROGRAMAS
while IFS= read -r PROGRAMA || [[ -n "$PROGRAMA" ]]; do
    # DESINSTALAR LOS PROGRAMAS
    echo "Desinstalando $PROGRAMA..."
    sudo apt-get remove -y "$PROGRAMA"
done < "$ARCHIVO"

# MENSAJE FINAL
echo "Proceso finalizado."
