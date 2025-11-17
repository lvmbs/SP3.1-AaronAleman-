# PARÁMETROS DE LA FECHA DE INICIO Y FECHA DE FIN
param(
    [Parameter(Mandatory=$true)]
    [datetime]$FechaInicio,
    
    [Parameter(Mandatory=$true)]
    [datetime]$FechaFin
)

# OBTENCIÓN DE EVENTOS DE INICIO DE SESIÓN
$eventos = Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id = 4624
    StartTime = $FechaInicio
    EndTime = $FechaFin
} | Where-Object {
    $_.Properties[5].Value -ne 'SYSTEM' # EXCLUYE AL USUARIO SYSTEM DE LA LISTA DE EVENTOS

# SELECCIÓN DE FECHA Y NOMBRE EN LA LISTA DE EVENTOS PARA MOSTRARLOS
} | Select-Object @{
    Name='Fecha'
    Expression = { $_.TimeCreated }
}, @{
    Name='Usuario'
    Expression = { $_.Properties[5].Value }
}

# MUESTRA TODOS LOS REGISTROS ESPECIFICADOS (DE FECHA INICIO A FECHA FIN)
$eventos | Format-Table -AutoSize
