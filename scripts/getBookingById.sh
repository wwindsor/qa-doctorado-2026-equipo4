#!/bin/bash
# GetBookingById.sh

# Define las variables para la URL de la API
# http://localhost:3001/
HOST="${HOST:-localhost}"
PORT="${PORT:-3001}"
BASE_URL="${BASE_URL:-http://${HOST}:${PORT}}"

# Define dirección de la evidencia y el archivo log
MARCADETIEMPO=$(date +"%Y%m%d_%H%M%S")
DIRECCION_EVIDENCIA="evidence/week2"
ARCHIVO_DE_REGISTRO="${DIRECCION_EVIDENCIA}/getBookingById ${MARCADETIEMPO}.log"

# Crear folder de evidencia si no existe
mkdir -p "$DIRECCION_EVIDENCIA"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
PASSED=0
FAILED=0

# Function to log output to both console and file
log() {
    echo -e "$1" | tee -a "$ARCHIVO_DE_REGISTRO"
}
# Function to log without color codes to file
log_to_file() {
    echo "$1" >> "$ARCHIVO_DE_REGISTRO"
}

# funcion para imprimir resultados de pruebas
imprimir_resultado() {
    if [ $1 -eq 0 ]; then
        #Escribir en consola y archivo de log
        echo -e "${GREEN}✓ PASSED${NC}: $2"
        #Escribir en el archivo de log
        echo "✓ PASSED: $2" >> "$ARCHIVO_DE_REGISTRO"
        PASSED=1
    else
        #Escribir en consola y archivo de log
        echo -e "${RED}✗ FAILED${NC}: $2"
        #Escribir en el archivo de log
        echo "✗ FAILED: $2" >> "$ARCHIVO_DE_REGISTRO"
        FAILED=1
    fi
}

log "================================================"
log "  Restful-Booker GetBookingById Test"
log "  URL básica: $BASE_URL"
log "  Marca de Tiempo: $(date '+%Y-%m-%d %H:%M:%S')"
log "  Archivo de Registro: $ARCHIVO_DE_REGISTRO"
log "================================================"
log ""


log "----------Inicia a jecutar el test: GetBookingById---------------"
# Obteniendo el ID
RESPONSE=$(curl -s -w "\n%{http_code}" "$BASE_URL/booking")
BOOKING_DATA=$(echo "$RESPONSE" | sed '$d')
FIRST_BOOKING_ID=$(echo "$BOOKING_DATA" | grep -o '"bookingid":[0-9]*' | head -n1 | grep -o '[0-9]*')

if [ ! -z "$FIRST_BOOKING_ID" ]; then
    RESPONSE_BOOKING_BY_ID_CODE=$(curl -s -w "\n%{http_code}" "$BASE_URL/booking/$FIRST_BOOKING_ID")
    HTTP_CODE=$(echo "$RESPONSE_BOOKING_BY_ID_CODE" | tail -n1)
    BODY_BOOKING_BY_ID_CODE=$(echo "$RESPONSE_BOOKING_BY_ID_CODE" | sed '$d')
    BOOKING_OBJECT=$(echo "$RESPONSE_BOOKING_BY_ID_CODE" | sed -n 's/.*"booking":\(.*\)}/\1/p')
    ACTUAL_JSON_BOOKING=$(echo "$BOOKING_OBJECT" | tr -d ' \n\r\t')
    ACTUAL_FIRSTNAME=$(echo "$ACTUAL_JSON_BOOKING" | grep -o '"firstname":"[^"]*"' | cut -d':' -f2 | tr -d '"')
    ACTUAL_LASTNAME=$(echo "$ACTUAL_JSON_BOOKING" | grep -o '"lastname":"[^"]*"' | cut -d':' -f2 | tr -d '"')

   if  [ "$ACTUAL_FIRSTNAME" != "" ] && \
    [ "$ACTUAL_LASTNAME" != "" ]&& \    
    [ "$HTTP_CODE" -eq 200 ]; then
        imprimir_resultado 0 "GetBooking devolvió el ID de reserva $FIRST_BOOKING_ID exitosamente"
        imprimir_resultado 0 "GetBooking devolvió datos de la reserva $BODY_BOOKING_BY_ID_CODE exitosamente"
    else
        imprimir_resultado 1 "GetBooking falló para el ID $FIRST_BOOKING_ID (HTTP $HTTP_CODE)"
    fi
else
    imprimir_resultado 1 "GetBooking falló - no hay ID de reserva disponible"
fi
log ""

# Resumen
log "================================================"
log "  Resumen de Pruebas"
log "================================================"
echo -e "${GREEN}Pasaron: $PASSED${NC}"
echo -e "${RED}Fallaron: $FAILED${NC}"
log_to_file "Pasaron: $PASSED"
log_to_file "Fallaron: $FAILED"
log ""

# registrar el resultado final en el archivo de log y salir con el código adecuado
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN} El test  pasó!${NC}"
    log_to_file "El test pasó!"
    log ""
    log "La evidencia se guardó en: $ARCHIVO_DE_REGISTRO"
    exit 0
else
    echo -e "${RED}El test falló!${NC}"
    log_to_file "El test falló!"
    log ""
    log "La evidencia se guardó en: $ARCHIVO_DE_REGISTRO"
    exit 1
fi
