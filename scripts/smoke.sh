#!/bin/bash
# Restful-Booker Smoke Tests
# smoke.sh

# Define las variables para la URL de la API
# http://localhost:3001/
HOST="${HOST:-localhost}"
PORT="${PORT:-3001}"
BASE_URL="${BASE_URL:-http://${HOST}:${PORT}}"

# Define dirección de la evidencia y el archivo log
MARCADETIEMPO=$(date +"%Y%m%d_%H%M%S")
DIRECCION_EVIDENCIA="evidence/week2"
ARCHIVO_DE_REGISTRO="${DIRECCION_EVIDENCIA}/smoke ${MARCADETIEMPO}.log"

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
        ((PASSED++))
    else
        #Escribir en consola y archivo de log
        echo -e "${RED}✗ FAILED${NC}: $2"
        #Escribir en el archivo de log
        echo "✗ FAILED: $2" >> "$ARCHIVO_DE_REGISTRO"
        ((FAILED++))
    fi
}
# Obtener token de autenticación para operaciones de actualización/eliminación
AUTH_RESPONSE=$(curl -s -X POST "$BASE_URL/auth" \
    -H "Content-Type: application/json" \
    -d '{"username": "admin", "password": "password123"}')
TOKEN=$(echo "$AUTH_RESPONSE" | grep -o '"token":"[^"]*"' | cut -d'"' -f4)
if [ ! -z "$TOKEN" ]; then
    imprimir_resultado 0 "autenticación  exitosa de token"
else    
    imprimir_resultado 1 "autenticación fallida de token"
fi


log "================================================"
log "  Restful-Booker Smoke Tests"
log "  URL básica: $BASE_URL"
log "  Marca de Tiempo: $(date '+%Y-%m-%d %H:%M:%S')"
log "  Archivo de Registro: $ARCHIVO_DE_REGISTRO"
log "================================================"
log ""

# Test 1: CreateBooking1
log "----------Test 1: CreateBooking---------------"
PARAMETROS='{
    "firstname" : "Grupo 4",
    "lastname" : "Grupo 4",
    "totalprice" : 111,
    "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2018-01-01",
        "checkout" : "2019-01-01"
    }
}'
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$BASE_URL/booking" \
    -H "Content-Type: application/json" \
    -d "$(printf '%s' "$PARAMETROS")")
if [ "${RESPONSE##*$'\n'}" = "200" ]; then 
    imprimir_resultado 0 "CreateBooking creó la reserva exitosamente"
else
    imprimir_resultado 1 "CreateBooking falló"
fi
log ""


# Test 2: GetBookingIds
log "----------Test 2: GetBookingIds---------------"
if curl -s "$BASE_URL/booking" | tee /tmp/booking_body.json | grep -q . \
   && [ "$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/booking")" -eq 200 ]; then
    imprimir_resultado 0 "GetBookingIds realizado exitosamente"
else
    imprimir_resultado 1 "GetBookingIds falló"
fi
log ""


# Test 3: GetBooking por Id
log "--------------Test 3: GetBooking por Id---------------------"
# Obteniendo el ID
RESPONSE=$(curl -s -w "\n%{http_code}" "$BASE_URL/booking")
BOOKING_DATA=$(echo "$RESPONSE" | sed '$d')
FIRST_BOOKING_ID=$(echo "$BOOKING_DATA" | grep -o '"bookingid":[0-9]*' | head -n1 | grep -o '[0-9]*')

RESPONSE_BOOKING_ID_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
        "$BASE_URL/booking/$FIRST_BOOKING_ID")
if [ "$RESPONSE_BOOKING_ID_CODE" -eq 200 ] && [ ! -z "$BOOKING_DATA" ]; then    
   imprimir_resultado 0 "GetBooking devolvió el ID de reserva exitosamente"
else
   imprimir_resultado 1 "GetBooking falló"
fi
log ""


# Test 4: UpdateBooking
log "----------------Test 4: UpdateBooking-------------------"
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
if [ "$HTTP_CODE" -eq 200 ] && [ ! -z "$FIRST_BOOKING_ID" ] && [ ! -z "$TOKEN" ]; then
    imprimir_resultado 0 "UpdateBooking actualizó exitosamente"
else
    imprimir_resultado 1 "UpdateBooking falló"
fi
log ""


# Test 5: PartialUpdateBooking
log "-----------------Test 5: PartialUpdateBooking------------------"
PARTIAL_UPDATE_PAYLOAD='{
        "firstname": "PartiallyUpdated - Grupo 4",
        "lastname": "SmokeUser - Grupo 4"
    }'    
RESPONSE=$(curl -s -w "\n%{http_code}" -X PATCH "$BASE_URL/booking/$FIRST_BOOKING_ID" \
        -H "Content-Type: application/json" \
        -H "Cookie: token=$TOKEN" \
        -d "$PARTIAL_UPDATE_PAYLOAD")
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)   
if [ "$HTTP_CODE" -eq 200 ] && [ ! -z "$FIRST_BOOKING_ID" ] && [ ! -z "$TOKEN" ]; then
    imprimir_resultado 0 "PartialUpdateBooking actualizó exitosamente"
else
    imprimir_resultado 1 "PartialUpdateBooking falló"
fi
log ""

# Test 6: DeleteBooking
log "-----------------Test 6: DeleteBooking------------------"
RESPONSE=$(curl -s -w "\n%{http_code}" -X DELETE "$BASE_URL/booking/$FIRST_BOOKING_ID" \
        -H "Cookie: token=$TOKEN")
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
    
if [ ! -z "$FIRST_BOOKING_ID" ] && [ ! -z "$TOKEN" ] && [ "$HTTP_CODE" -eq 201 ]; then
   imprimir_resultado 0 "DeleteBooking eliminó exitosamente la reserva"
else
   imprimir_resultado 1 "DeleteBooking falló"
fi
log ""

# Resumen de resultados
log "================================================"
log "  Resumen de Resultados de Pruebas"
log "================================================"
echo -e "${GREEN}Pasaron: $PASSED${NC}"
echo -e "${RED}Fallaron: $FAILED${NC}"
log_to_file "Pasaron: $PASSED"
log_to_file "Fallaron: $FAILED"
log "Total: $((PASSED + FAILED))"
log ""

# registrar el resultado final en el archivo de log y salir con el código adecuado
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN} Todos los tests pasaron!${NC}"
    log_to_file "Todos los tests pasaron!"
    log ""
    log "La evidencia se guardó en: $ARCHIVO_DE_REGISTRO"
    exit 0
else
    echo -e "${RED}Algunos tests fallaron!${NC}"
    log_to_file "Algunos tests fallaron!"
    log ""
    log "La evidencia se guardó en: $ARCHIVO_DE_REGISTRO"
    exit 1
fi
