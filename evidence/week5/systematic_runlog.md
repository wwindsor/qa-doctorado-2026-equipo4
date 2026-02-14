# RUNLOG — Informe de Ejecución de Pruebas Sistemáticas

**Endpoint:** GET /booking/{id}  
**Técnica de Prueba:** Clases de Equivalencia (EQ) + Valores Límite (BV)  
**Fecha de Ejecución:** 2026-02-14 10:03:58  
**URL Base:** http://localhost:3001  
**Comando de Ejecución:** ./scripts/systematic_cases.sh

---

## Ambiente de Ejecución

- **SO:** Darwin
- **Shell:** Bash
- **Cliente HTTP:** curl
- **SUT:** Restful Booker (http://localhost:3001)

---

## Registro de Ejecución

### Inicialización
- URL Base: http://localhost:3001
- Directorio de Evidencia: evidence/week4
- Marca de Tiempo: 2026-02-14 10:03:58

### Preparación de Datos de Prueba
Creando 10 bookings de prueba...

### Resultados de Casos de Prueba

| TC-ID | Estado | Detalles |
|-------|--------|----------|
| TC-001 | FAIL | ID=1, HTTP 404 (esperado 200) |
| TC-002 | FAIL | ID=5, HTTP 404 (esperado 200) |
| TC-003 | FAIL | ID=10, HTTP 404 (esperado 200) |
| TC-004 | PASS | ID=0, HTTP 404 (error esperado) |
| TC-005 | PASS | ID=-1, HTTP 404 (error esperado) |
| TC-006 | PASS | ID=99999, HTTP 404 (no encontrado) |
| TC-007 | PASS | ID=999999999, HTTP 404 (error esperado) |
| TC-008 | PASS | ID=abc, HTTP 404 (error esperado) |
| TC-009 | AMBIGUOUS | ID=(vacío), HTTP 200 (comportamiento SUT-específico) |
| TC-010 | PASS | ID=null, HTTP 404 (error esperado) |
| TC-011 | AMBIGUOUS | ID=12.5, HTTP 404 (comportamiento SUT-específico) |
| TC-012 | FAIL | ID=1, HTTP 404 (esperado 200) |
| TC-013 | FAIL | ID=2, HTTP 404 (esperado 200) |
| TC-014 | FAIL | ID=3, HTTP 404 (esperado 200) |
| TC-015 | FAIL | ID=4, HTTP 404 (esperado 200) |

---

## Resumen

- **Total de Casos:** 15
- **Aprobados:** 6
- **Reprobados:** 7
- **Ambiguos:** 2
- **Tasa de Aprobación:** 40.0%

---

## Conclusión

✓ Ejecución de pruebas sistemáticas completada exitosamente.

**Ubicación de Evidencia:** evidence/week4/
- Respuestas individuales: TC-001_response.json a TC-015_response.json
- Archivo de resumen: summary.txt
- Este registro: RUNLOG.md

