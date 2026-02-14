# Quality Gate (Semana 5)

## Objetivo del gate

Reducir el **riesgo de regresiones** sobre los riesgos priorizados (Semana 3) y sobre el conjunto de casos diseñados de forma sistemática (Semana 4), mediante un conjunto mínimo de chequeos automatizados con oráculos pass/fail claros y evidencia trazable.  
**No** pretende certificar calidad total, ni sustituir pruebas manuales o de seguridad avanzada; solo aportar **señal confiable** en cada cambio (bloqueo solo por fallos deterministas y reproducibles).

---

## Checks del gate (máximo 4)

### 1) Contrato / disponibilidad del SUT

| Campo | Detalle |
|-------|--------|
| **Claim** | El SUT expone un punto comprobable (health o contrato) y responde de forma coherente. |
| **Oráculo** | PASS: HTTP 200 y cuerpo interpretable (JSON o texto). FAIL: otro código HTTP o cuerpo no válido. |
| **Evidencia** | `evidence/week5/contract_http_code.txt`, `evidence/week5/health_response.json` (o equivalente). |
| **Trazabilidad** | Semana 3: `risk/test_strategy.md`, disponibilidad/contrato; `quality/scenarios.md`. |

### 2) Persistencia de datos (R001 / Q5)

| Campo | Detalle |
|-------|--------|
| **Claim** | Tras operación de lectura sobre una reserva existente, la respuesta es correcta y bien formada (datos íntegros). |
| **Oráculo** | PASS: GET /booking/{id} devuelve HTTP 200 y JSON con campos obligatorios (`firstname`, `lastname`, `totalprice`, `depositpaid`, `bookingdates`). FAIL: código ≠ 200 o JSON malformado/faltan campos. |
| **Evidencia** | `evidence/week5/persistency_check.log`, `evidence/week5/persistency_response.json`. |
| **Trazabilidad** | Semana 3: `risk/test_strategy.md` (R001), `risk/top3_scenario_mapping.md`, `quality/scenarios.md` (Q5). |

### 3) Rechazo sin autenticación (R002 / Q7)

| Campo | Detalle |
|-------|--------|
| **Claim** | Una petición PUT /booking/{id} sin token de autenticación es rechazada y no modifica datos. |
| **Oráculo** | PASS: código HTTP 401 o 403. FAIL: HTTP 200 (actualización aceptada sin token). |
| **Evidencia** | `evidence/week5/auth_rejection_http_code.txt`, `evidence/week5/auth_rejection_response.json`. |
| **Trazabilidad** | Semana 3: `risk/test_strategy.md` (R002), `risk/top3_scenario_mapping.md`, `quality/scenarios.md` (Q7). |

### 4) Casos sistemáticos (Semana 4)

| Campo | Detalle |
|-------|--------|
| **Claim** | El conjunto de casos derivado por método (EQ/BV) se ejecuta y se evalúa con oráculos explícitos; el gate valida que la ejecución termina y produce evidencia. |
| **Oráculo** | PASS: script genera resumen y artefactos; ningún FAIL no justificado. Cualquier FAIL requiere revisión/acción del equipo (no se ignora). |
| **Evidencia** | `evidence/week5/systematic_results.csv`, `evidence/week5/systematic_summary.txt`, `evidence/week5/RUNLOG.md`. |
| **Trazabilidad** | Semana 4: `design/test_cases.md`, `design/oracle_rules.md`; `evidence/week4/` (patrón de evidencia). |

---

## Por qué estos checks son alta señal / bajo ruido

- **Determinismo:** Solo se usan códigos HTTP y estructura JSON (parseable), sin umbrales de tiempo ni métricas sensibles al entorno como criterio de bloqueo.
- **Repetibilidad:** Misma secuencia de requests y mismos oráculos en cada ejecución; la evidencia se guarda en archivos fijos en `evidence/week5/`.
- **Oráculos claros:** Cada check tiene condición PASS/FAIL explícita y trazable a `risk/` o `design/`, lo que permite falsar y auditar.

---

## Nota de diseño (obligatoria)

**El gate NO debe fallar por métricas inestables** (por ejemplo, latencia, throughput o tiempos de respuesta variables). Si se mide algo variable (p. ej. tiempo de respuesta en carga concurrente, R003/Q6), debe quedar como **registro informativo** en `evidence/week5/` (p. ej. en RUNLOG o en un archivo de métricas), **no como criterio de bloqueo**. Los únicos criterios de bloqueo son: códigos HTTP, validez de JSON, y resultado explícito pass/fail de los oráculos definidos en este documento.

---

## Ejecución local (equivalente a CI)

- `make quality-gate` (o el script definido en `ci/`) — genera y actualiza `evidence/week5/`.
