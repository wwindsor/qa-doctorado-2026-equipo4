# Memo de Progreso - Semana 2

**Fecha**: 21/01/2026 
**Equipo**: Equipo 4
**Semana**: 2 de 8

## Objetivos de la semana
- Convertir “calidad” en afirmaciones **falsables y medibles** mediante escenarios (estímulo–entorno–respuesta–medida).
- Definir un conjunto mínimo de **4 escenarios de calidad** aplicables al SUT (Restful-Booker).
- Implementar scripts para recolectar evidencia reproducible.
- Generar y versionar evidencias (logs)

## Logros
- Escenarios de calidad definidos y documentados en `quality/scenarios.md` (Q1–Q4) para la API Restful-Booker.
- Script de smoke tests implementado (`scripts/smoke.sh`) que valida los 6 endpoints críticos de la API.
- Tests individuales implementados para cada escenario de calidad:
  - `scripts/createBooking.sh` - Validación de creación de reservas (Q1)
  - `scripts/getBookingById.sh` - Validación de obtención de reservas por ID (Q2)
  - `scripts/updateBooking.sh` - Validación de actualización completa de reservas (Q3)
  - `scripts/deleteBooking.sh` - Validación de eliminación de reservas con autenticación (Q4)
- Evidencias generadas y organizadas en `evidence/week2/` con timestamps únicos para cada ejecución.
- Sistema de logging automático implementado para trazabilidad y reproducibilidad de pruebas.

## Evidencia principal
- Escenarios y métricas: `quality/scenarios.md`.
- Script de smoke tests:
  - `scripts/smoke.sh` - Validación de 6 endpoints críticos (GetBookingIds, GetBooking, CreateBooking, UpdateBooking, PartialUpdateBooking, DeleteBooking)
  - `evidence/week2/smoke_*.log` - Logs de ejecución con timestamp
- Scripts individuales por escenario:
  - `scripts/createBooking.sh` → `evidence/week2/createBooking_*.log`
  - `scripts/getBookingById.sh` → `evidence/week2/getBookingById_*.log`
  - `scripts/updateBooking.sh` → `evidence/week2/UpdateBooking_*.log`
  - `scripts/deleteBooking.sh` → `evidence/week2/deleteBooking_*.log`
- Cada script incluye:
  - Verificación de códigos HTTP esperados
  - Validación de datos en respuestas
  - Autenticación con tokens cuando es requerida
  - Logging automático con marcas de tiempo

## Retos y notas
- Configuración del entorno: Los tests se ejecutan contra servidor local en Docker (`http://localhost:3001`), requiere que el SUT esté ejecutándose antes de correr los tests.
- Autenticación: Los endpoints de actualización y eliminación requieren token de autenticación obtenido mediante POST /auth con credenciales predefinidas.
- Dependencias entre tests: Algunos tests dependen de la existencia previa de datos (por ejemplo, DeleteBooking requiere que exista al menos una reserva).
- Estado compartido: Las ejecuciones consecutivas modifican el estado del sistema, lo que puede afectar resultados de tests subsecuentes si no se ejecutan de forma aislada.

## Lecciones aprendidas
- "Calidad" se vuelve operable cuando se expresa como **escenarios con métricas falsables**; definir estímulo, entorno, respuesta esperada y medidas concretas permite verificación objetiva.
- Guardar evidencia con timestamps únicos permite trazabilidad completa de cada ejecución y facilita auditoría.
- Los tests de la API REST requieren manejo adecuado de autenticación, códigos HTTP específicos y validación de estructura de datos en las respuestas.
- La implementación de scripts bash con funciones de logging reutilizables (log, log_to_file, imprimir_resultado) facilita mantenimiento y consistencia entre tests.
- Definir oráculos claros (HTTP 200 para éxito, HTTP 201 para DELETE, HTTP 404 post-eliminación) reduce ambigüedad en la interpretación de resultados.

## Próximos pasos (Semana 3) - (Potenciales pasos, a ser discutidos con el equipo)
- Elaborar una matriz de riesgo y derivar cobertura priorizada (riesgo → pruebas → evidencia).
- Formalizar reglas de oráculo y casos de prueba en `design/test_cases.md` y `design/oracle_rules.md`.
- Definir criterios de aceptación (entry/exit) y una estrategia de pruebas ligera basada en riesgo.
- Extender la evidencia para incluir estabilidad (repeticiones) o disponibilidad básica (múltiples checks) si el equipo lo considera relevante.

---

**Preparado por**: Equipo 4
**Próxima revisión**: Semana 3