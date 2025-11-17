#!/bin/bash

# DIRECTORIOS
SRC="/home"
DEST="/bacaaron"

# FECHA Y NUMERO DE LA SEMANA
SEMANA=$(date +%V)
FECHA=$(date +%Y-%m-%d)

# NOMBRE DEL ARCHIVO DEL BACKUP
BACKUP_FILE="$DEST/CopDifSem-$SEMANA.tar.gz"

# REALIZAR COPIA DIFERENCIAL
if [ ! -f "$LAST_FULL" ]; then
    # SI NO EXISTE UNA COPIA COMPLETA, REALIZARLA
    tar -cpzf "$BACKUP_FILE" "$SRC"
    date +%Y-%m-%d > "$LAST_FULL"
else
    # COPIA DIFERENCIAL USANDO TAR CON --listed-incremental
    TAR_SNAPSHOT="$DEST/snapshot.snar"
    tar --listed-incremental="$TAR_SNAPSHOT" -cpzf "$BACKUP_FILE" "$SRC"
fi

echo "Backup realizado: $BACKUP_FILE"
