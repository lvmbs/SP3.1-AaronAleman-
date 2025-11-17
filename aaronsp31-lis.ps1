# FUNCIÓN QUE MUESTRA EL MENÚ
function menu {
    Clear-Host
    Write-Host "MENÚ DEL SISTEMA"
    Write-Host "*********************************************************************"
    Write-Host "* 1. Mostrar un listado de los eventos del sistema.                 *"
    Write-Host "* 2. Mostrar un listado de los errores del sistema del último mes.  *"
    Write-Host "* 3. Mostrar un listado de warnings de aplicaciones de esta semana. *"
    Write-Host "* 4. Salir.                                                         *"
    Write-Host "*********************************************************************"
}

# DO WHILE QUE NO TERMINA HASTA QUE SELECCIONES LA OPCIÓN DE SALIR
do {
    # MUESTRA DEL MENÚ
    menu
    # SELECCIÓN DE LA OPCIÓN
    $op = Read-Host "Selecciona una opción del menú (1-4):"
    
    # SWITCH CON LAS OPCIONES
    switch ($op) {
        '1' { # OPCIÓN 1 (MUESTRA LOS ÚLTIMOS 15 ELEMENTOS DEL SISTEMA)
            Write-Host ""
            Write-Host "Listado de eventos del sistema:" -ForegroundColor Yellow
            Get-WinEvent -LogName System -MaxEvents 15 | Format-Table -AutoSize
            Pause
        }
        '2' { # OPCIÓN 2 (MUESTRA LOS ERRORES DEL SISTEMA DEL ÚLTIMO MES)
            Write-Host ""
            Write-Host "Errores del sistema del último mes:" -ForegroundColor Yellow
            $fecha = (Get-Date).AddDays(-30)
            Get-WinEvent -FilterHashtable @{LogName='System'; Level=2; StartTime=$fecha} |
            Select-Object TimeCreated, Id, LevelDisplayName, Message | Format-Table -AutoSize
            Pause
        }
        '3' { # OPCIÓN 3 (MUESTRA LOS WARNINGS DE APLICACIONES DE ESTA SEMANA)
            Write-Host ""
            Write-Host "Warnings de aplicaciones de esta semana:" -ForegroundColor Yellow
            $fecha = (Get-Date).AddDays(-7)
            Get-WinEvent -FilterHashtable @{LogName='Application'; Level=3; StartTime=$fecha} |
            Select-Object TimeCreated, Id, LevelDisplayName, Message | Format-Table -AutoSize
            Pause
        }
        '4' { # OPCIÓN 4 (SALIR DEL MENÚ)
            Write-Host "Saliendo..."
        }
        Default { # OPCIÓN DEFAULT (OPCIÓN NO VÁLIDA)
            Write-Host "Opción no válida" -ForegroundColor Red
            Pause
        }
    }
    
} while ($op -ne '4')
