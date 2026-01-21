#!/bin/bash
# UpdateBooking.sh

# Define las variables para la URL de la API
# http://localhost:3001/
HOST="${HOST:-localhost}"
PORT="${PORT:-3001}"
BASE_URL="${BASE_URL:-http://${HOST}:${PORT}}"

# Define dirección de la evidencia y el archivo log
MARCADETIEMPO=$(date +"%Y%m%d_%H%M%S")
DIRECCION_EVIDENCIA="evidence/week2"
ARCHIVO_DE_REGISTRO="${DIRECCION_EVIDENCIA}/updateBooking ${MARCADETIEMPO}.log"

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
log "  Restful-Booker UpdateBooking Test"
log "  URL básica: $BASE_URL"
log "  Marca de Tiempo: $(date '+%Y-%m-%d %H:%M:%S')"
log "  Archivo de Registro: $ARCHIVO_DE_REGISTRO"
log "================================================"
log ""


# Obteniendo el ID
RESPONSE=$(curl -s -w "\n%{http_code}" "$BASE_URL/booking")
BOOKING_DATA=$(echo "$RESPONSE" | sed '$d')
FIRST_BOOKING_ID=$(echo "$BOOKING_DATA" | grep -o '"bookingid":[0-9]*' | head -n1 | grep -o '[0-9]*')
#Obtener token de autenticación para operaciones de actualización
AUTH_RESPONSE=$(curl -s -X POST "$BASE_URL/auth" \
    -H "Content-Type: application/json" \
    -d '{"username": "admin", "password": "password123"}')
TOKEN=$(echo "$AUTH_RESPONSE" | grep -o '"token":"[^"]*"' | cut -d'"' -f4)


log "----------Inicia a jecutar el test: UpdateBooking---------------"
if [ ! -z "$TOKEN" ]; then
    if [ ! -z "$FIRST_BOOKING_ID" ] ; then
        UPDATE_PAYLOAD='{
            "firstname": "UpdatedSmokeTest Grupo4",
            "lastname": "UpdatedUser Grupo4",
            "totalprice": 456,
            "depositpaid": false,
            "bookingdates": {
                "checkin": "2026-02-01",
                "checkout": "2026-02-03"
            },
            "additionalneeds": "Lunch"
        }'
        RESPONSE=$(curl -s -w "\n%{http_code}" -X PUT "$BASE_URL/booking/$FIRST_BOOKING_ID" \
            -H "Content-Type: application/json" \
            -H 'Accept: application/json' \
            -H "Cookie: token=$TOKEN" \
            -d "$(printf '%s' "$UPDATE_PAYLOAD")")
        HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
        if [ "$HTTP_CODE" -eq 200 ]; then

            RESPONSE_BOOKING_BY_ID_CODE=$(curl -s -w "\n%{http_code}" "$BASE_URL/booking/$FIRST_BOOKING_ID")          
            ACTUAL_FIRSTNAME=$(echo "$RESPONSE_BOOKING_BY_ID_CODE" | grep -o '"firstname":"[^"]*"' | cut -d':' -f2- | sed 's/^"//;s/"$//')
            
            if [ "$ACTUAL_FIRSTNAME" = "UpdatedSmokeTest Grupo4" ] ; then
                imprimir_resultado 0 "UpdateBooking actualizó el nombre correctamente para el ID $FIRST_BOOKING_ID"
            else
                imprimir_resultado 1 "UpdateBooking falló al actualizar el nombre para el ID $FIRST_BOOKING_ID"
            fi           
        else
            imprimir_resultado 1 "UpdateBooking failed (HTTP $HTTP_CODE)"
        fi
    else
        imprimir_resultado 1 "No hay ID de reserva disponible para UpdateBooking"
    fi
else    
    imprimir_resultado 1 "autenticación fallida de token"
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
