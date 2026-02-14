# Resumen Quality Gate — Semana 5

**Fecha:** 2026-02-14 14:03:58 UTC

## Resultado global
**FAIL** — 3 check(s) fallaron.

## Checks
| # | Check | Evidencia principal | Estado |
|---|-------|---------------------|--------|
| 1 | Contrato / disponibilidad | contract_http_code.txt | PASS |
| 2 | Persistencia (R001/Q5) | persistency_check.log | FAIL |
| 3 | Rechazo sin auth (R002/Q7) | auth_rejection_http_code.txt | PASS |
| 4 | Casos sistemáticos (Semana 4) | systematic_summary.txt | FAIL |

## Evidencia en `evidence/week5/`
- contract_http_code.txt, health_response.json
- persistency_check.log, persistency_response.json
- auth_rejection_http_code.txt, auth_rejection_response.json
- systematic_results.csv, systematic_summary.txt, RUNLOG.md
