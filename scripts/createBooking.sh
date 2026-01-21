#!/bin/bash
# CreateBooking.sh

# Define las variables para la URL de la API
# http://localhost:3001/
HOST="${HOST:-localhost}"
PORT="${PORT:-3001}"
BASE_URL="${BASE_URL:-http://${HOST}:${PORT}}"

# Define dirección de la evidencia y el archivo log
MARCADETIEMPO=$(date +"%Y%m%d_%H%M%S")
DIRECCION_EVIDENCIA="evidence/week2"
ARCHIVO_DE_REGISTRO="${DIRECCION_EVIDENCIA}/createBooking ${MARCADETIEMPO}.log"

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
log "  Restful-Booker CreateBooking Test"
log "  URL básica: $BASE_URL"
log "  Marca de Tiempo: $(date '+%Y-%m-%d %H:%M:%S')"
log "  Archivo de Registro: $ARCHIVO_DE_REGISTRO"
log "================================================"
log ""

log "----------Inicia a jecutar el test: CreateBooking---------------"
PARAMETROS='{
    "firstname" : "Grupo-4",
    "lastname" : "Grupo-4",
    "totalprice" : 112,
    "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2017-12-31",
        "checkout" : "2018-12-31"
    }
}'
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$BASE_URL/booking" \
    -H "Content-Type: application/json" \
    -d "$(printf '%s' "$PARAMETROS")")
if [ "${RESPONSE##*$'\n'}" = "200" ]; then

CREATED_BOOKING_ID=$(echo "${RESPONSE%$'\n'*}" | grep -o '"bookingid":[0-9]*' | grep -o '[0-9]*')
BOOKING_OBJECT=$(echo "$RESPONSE" | sed -n 's/.*"booking":\(.*\)}/\1/p')
ACTUAL_JSON_BOOKING=$(echo "$BOOKING_OBJECT" | tr -d ' \n\r\t')

ACTUAL_FIRSTNAME=$(echo "$ACTUAL_JSON_BOOKING" | grep -o '"firstname":"[^"]*"' | cut -d':' -f2 | tr -d '"')
ACTUAL_LASTNAME=$(echo "$ACTUAL_JSON_BOOKING" | grep -o '"lastname":"[^"]*"' | cut -d':' -f2 | tr -d '"')
ACTUAL_TOTALPRICE=$(echo "$ACTUAL_JSON_BOOKING" | grep -o '"totalprice":[0-9]*' | cut -d':' -f2)
ACTUAL_DEPOSIT=$(echo "$ACTUAL_JSON_BOOKING" | grep -o '"depositpaid":\(true\|false\)' | cut -d':' -f2)

if  [ "$ACTUAL_FIRSTNAME" = "Grupo-4" ] && \
    [ "$ACTUAL_LASTNAME" = "Grupo-4" ]&& \
    [ "$ACTUAL_TOTALPRICE" = 112 ]&& \
    [ "$ACTUAL_DEPOSIT" = true ]&& \
    [ -n "$CREATED_BOOKING_ID" ]; then
   
    imprimir_resultado 0 "CreateBooking creado exitosamente con el ID $CREATED_BOOKING_ID"
    imprimir_resultado 0 "CreateBooking creado exitosamente con datos  $BOOKING_OBJECT"
  else
    imprimir_resultado 1 "CreateBooking retorna 200 pero no se encontró el ID de la reserva"
  fi
else
  imprimir_resultado 1 "CreateBooking falló (HTTP ${RESPONSE##*$'\n'})"
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
