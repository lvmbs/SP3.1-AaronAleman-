# FUNCIÓN QUE GENERA Y MUESTRA EL MENÚ
function menu {
    Clear-Host
    Write-Host "========== MENÚ DE TIPOS DE REGISTROS =========="
    Write-Host " Selecciona un tipo de registro de eventos:"
    Write-Host "================================================="
    Write-Host "0. Salir"

    # OBTENCIÓN DE LOS REGISTROS DISPONIBLES (solo con eventos existentes)
    $logs = Get-WinEvent -ListLog * | Where-Object {$_.RecordCount -gt 0} | Select-Object -ExpandProperty LogName

    # ASIGNACIÓN DE LOS TIPOS A LOS NÚMEROS DE LAS OPCIONES DEL MENÚ
    $menuMap = @{}
    $i = 1
    foreach ($log in $logs) {
        Write-Host "$i. $log"
        $menuMap[$i] = $log
        $i++
    }
    Write-Host "================================================="

    return $menuMap
}
# FUNCIÓN QUE GENERA Y MUESTRA EL MENÚ
function menu {
    Clear-Host
    Write-Host "========== MENÚ DE TIPOS DE REGISTROS =========="
    Write-Host " Selecciona un tipo de registro de eventos:"
    Write-Host "================================================="
    Write-Host "0. Salir"

    # SOLO LOGS ESTÁNDAR
    $logs = @("Application", "System", "Security", "Setup") | Where-Object {
        (Get-WinEvent -ListLog $_).RecordCount -gt 0
    }

    # ASIGNACIÓN DE LOS TIPOS A LOS NÚMEROS DE LAS OPCIONES DEL MENÚ
    $menuMap = @{}
    $i = 1
    foreach ($log in $logs) {
        Write-Host "$i. $log"
        $menuMap[$i] = $log
        $i++
    }
    Write-Host "================================================="

    return $menuMap
}

# DO WHILE QUE TERMINA CUANDO LA OPCIÓN SELECCIONADA SEA 0
do {
    # LLAMADA DE LA FUNCIÓN Y OBTENCIÓN DEL MAPA
    $menuMap = menu
    
    # SELECCIÓN DE OPCIÓN
    $op = Read-Host "Introduce una opción"
    
    if ($op -eq '0') {
        Write-Host "Saliendo..."
        continue
    }

    if ($menuMap.ContainsKey([int]$op)) {
        $logName = $menuMap[[int]$op]
        Write-Host "Mostrando los 12 últimos eventos del registro: $logName" -ForegroundColor Yellow
        
        Get-WinEvent -LogName $logName -MaxEvents 12 |
            Select-Object TimeCreated, Id, LevelDisplayName, Message |
            Format-Table -AutoSize
        
        Pause
    } else {
        Write-Host "Opción no válida" -ForegroundColor Red
        Pause
    }

} while ($op -ne 0)
