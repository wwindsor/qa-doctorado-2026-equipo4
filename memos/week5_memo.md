# Memo Semana 5: Quality Gate e Integración Continua

**Proyecto:** Restful Booker – QA Doctoral Activity  
**Equipo:** Grupo 4  
**Semana:** 5

---

## Objetivos

1. Definir un **quality gate** mínimo y confiable que reduzca riesgo de regresiones
2. Integrar el gate en **CI** (ejecutable en push y pull_request)
3. Generar **evidencia reproducible** en `evidence/week5/`
4. Mantener **trazabilidad** con riesgos (Semana 3) y oráculos/casos (Semana 4)
5. Publicar evidencia como **artifact** en cada run de CI
6. Asegurar que el gate use checks **deterministas** (alta señal / bajo ruido)

---

## Logros principales

### 1. Quality gate definido
**Archivo:** `ci/quality_gates.md`

- 4 checks documentados con claim, oráculo, evidencia y trazabilidad
- **Check 1:** Contrato / disponibilidad del SUT → `risk/test_strategy.md` (Semana 3)
- **Check 2:** Persistencia (R001/Q5) → `risk/top3_scenario_mapping.md`, `quality/scenarios.md` (Semana 3)
- **Check 3:** Rechazo sin autenticación (R002/Q7) → `risk/test_strategy.md` (Semana 3)
- **Check 4:** Casos sistemáticos → `design/test_cases.md`, `design/oracle_rules.md` (Semana 4)
- Nota de diseño: el gate NO falla por métricas inestables (latencia, etc.); solo códigos HTTP, JSON válido y oráculos explícitos

### 2. Gate ejecutable local y en CI
**Archivos:** `ci/run_quality_gates.sh`, `Makefile`, `.github/workflows/ci.yml`

- **Local:** `make quality-gate` o `bash ci/run_quality_gates.sh`
- **CI:** workflow en push y pull_request sobre todas las ramas
- Variable `SKIP_SUT_START=1` en CI para no levantar SUT (se usa API pública o SUT ya levantado)
- Variable `BASE_URL` configurable para SUT local o remoto (https://restful-booker.herokuapp.com en CI)

### 3. Evidencia week5 generada y publicada como artifact
**Carpeta:** `evidence/week5/`

| Archivo | Contenido |
|---------|-----------|
| `RUNLOG.md` | Log de ejecución con fecha, pasos y resultado por check |
| `SUMMARY.md` | Resumen pass/fail por check y resultado global |
| `contract_http_code.txt` | Código HTTP de health/contrato |
| `health_response.json` | Respuesta del endpoint de disponibilidad |
| `persistency_check.log` | Evidencia Check 2 (R001/Q5) |
| `persistency_response.json` | Respuesta GET /booking |
| `auth_rejection_http_code.txt` | Código HTTP de PUT sin token |
| `auth_rejection_response.json` | Respuesta del rechazo de auth |
| `systematic_results.csv` | Resultados de casos sistemáticos |
| `systematic_summary.txt` | Resumen de systematic_cases |

**CI:** La evidencia se sube como artifact `evidencia-week5` en cada run (incluso si el gate falla, `if: always()`).

### 4. Relación con riesgos (S3) y oráculos/casos (S4)

| Check | Riesgo (Semana 3) | Oráculos/Casos (Semana 4) |
|-------|-------------------|---------------------------|
| 1 | Disponibilidad (test_strategy) | — |
| 2 | R001 Pérdida de datos → Q5 Persistencia | OR-001, OR-002 (HTTP, JSON) |
| 3 | R002 Acceso no autorizado → Q7 Rechazo sin token | Oráculo explícito 401/403 |
| 4 | — | design/test_cases.md (15 TCs), design/oracle_rules.md (6 oráculos) |

**Trazabilidad:** Riesgo → Escenario → Evidencia → Oráculo, documentada en `ci/quality_gates.md`.

---

## Evidencia principal

| Artefacto | Ubicación | Estado |
|-----------|-----------|--------|
| Quality Gate Spec | ci/quality_gates.md | Definido |
| Run Script | ci/run_quality_gates.sh | Ejecutable |
| CI Workflow | .github/workflows/ci.yml | Push, PR, artifact |
| RUNLOG | evidence/week5/RUNLOG.md | Generado por run |
| SUMMARY | evidence/week5/SUMMARY.md | Pass/fail por check |
| Evidencia checks | evidence/week5/*.json, *.log, *.txt, *.csv | Generada |

---

## Retos y notas

1. **SUT local vs. público:** El contenedor Docker oficial de Restful Booker devuelve 500 en POST /booking en algunos entornos. Se adoptó la API pública (restful-booker.herokuapp.com) para CI por estabilidad y datos precargados.
2. **Orden de checks:** Check 4 (casos sistemáticos) se ejecuta antes de Check 2 para crear bookings y permitir GET /booking/1; en API pública ya existen datos.
3. **Código de salida:** El script retorna 0 si todos los checks pasan, 1 si alguno falla; CI usa ese código para marcar el job como passed/failed.

---

## Lecciones aprendidas

1. **Alta señal / bajo ruido:** Priorizar códigos HTTP y JSON válido evita fallos por métricas inestables (latencia, red).
2. **Trazabilidad explícita:** Vincular cada check a riesgo (S3) o diseño (S4) hace el gate auditable y justificable.
3. **Artifact siempre:** Subir evidencia con `if: always()` permite diagnosticar fallos aunque el job falle.
4. **API pública para CI:** Usar una instancia estable reduce dependencia de Docker local y acelera el pipeline.

---

## Próximos pasos

### Corto plazo
1. Ejecutar el gate localmente contra API pública para validar checks
2. Revisar evidencia descargada del artifact en runs fallidos
3. Considerar añadir Check para R003 (carga concurrente) como registro informativo (sin bloqueo)

### Mediano plazo
1. Extender el gate si se agregan nuevos endpoints o riesgos
2. Documentar criterios de “FAIL justificado” para Check 4
3. Integrar reporte de tendencia (evidencia histórica)

### Largo plazo
1. Evaluar trade-off: gate determinista vs. cobertura de performance
2. Documentar patrón de quality gate reutilizable en el paper final

---

## Checklist de entregables

- [x] ci/quality_gates.md — Especificación del gate
- [x] ci/run_quality_gates.sh — Script ejecutable
- [x] make quality-gate — Target en Makefile
- [x] .github/workflows/ci.yml — CI en push/PR, artifact evidencia-week5
- [x] evidence/week5/ — Evidencia generada por run
- [x] memos/week5_memo.md — Este memo

---

**Memo completado:** 14 de febrero de 2026  
**Estado:** Listo para revisión  
**Responsable de follow-up:** Equipo
