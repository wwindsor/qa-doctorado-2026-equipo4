# Guía del Oponente — Revisión bisemanal (Semanas 3 y 4)

**Rol:** realizar una crítica metodológica breve y útil sobre el trabajo del equipo que presenta.  
**Enfoque:** razonamiento, trazabilidad y defendibilidad. **No** evaluar cantidad de pruebas ni cantidad de endpoints.

**Tiempo total:** 6 minutos

- 1 min: Fortalezas
- 3 min: Preguntas críticas
- 2 min: Recomendaciones accionables

---

## 0) Contexto del proyecto (para preparar la oponencia)

**GRUPO 2**
**SUT:** Sistema de Chatbot conversacional (`POST /chatmemory`).  
**Fuentes en repo (revisar antes de la sesión):**

- `risk/risk_matrix.csv` — matriz de riesgos; `risk/test_strategy.md` — estrategia y trazabilidad Semana 3.
- `quality/scenarios.md` — escenarios Q1, Q2, Q4 referenciados.
- `design/test_cases.md` — casos sistemáticos (EQ por particiones P1–P5); `design/oracle_rules.md` — OR1–OR6.
- `evidence/week3/` y `evidence/week4/` — evidencia ejecutada (logs, CSV, respuestas por TC).

**Presentación del equipo:** ver `slides/s3_s4_form.md` (6 slides: priorización, trazabilidad, riesgo residual, objeto de prueba + técnica, oráculos, validez + mejora).

---

## 1) Estructura de la intervención (plantilla)

### A. Fortalezas (máx. 2)

- **Fortaleza 1:** Trazabilidad explícita **riesgo → escenario → evidencia → oráculo → riesgo residual** en Slide 2 y en `risk/test_strategy.md` (R5→Q4, R1→Q1, R3→Q2 con rutas de evidencia y oráculos pass/fail). Es defendible porque permite reproducir y auditar la decisión de priorización y el alcance aceptado.
- **Fortaleza 2:** Declaración clara de riesgo residual (Slide 2 y 3) y de amenazas a la validez con mitigaciones (Slide 6: interna, constructo, externa). Mejora la calidad metodológica al hacer explícito qué queda fuera y qué límites tiene la evidencia.

### B. Preguntas críticas (2–3 preguntas)

- **Pregunta 1 (Semana 3 - riesgo y falsación):** En Slide 2, para R5 declaran oráculo "Pass si cada sesión mantiene coherencia" y riesgo residual "No se evalúa concurrencia real ni entornos distribuidos". ¿Cómo se reconcilia que la evidencia (`scalability.log`, smoke_test) permita afirmar ese Pass si explícitamente no se evalúa concurrencia real? ¿Bajo qué condiciones observables considerarían que R5 _no_ está mitigado y qué evidencia haría falsa la afirmación de reducción de riesgo?
- **Pregunta 2 (Semana 3 - trazabilidad evidencia → oráculo):** Para R1 (Disponibilidad), el oráculo es "Pass si el fallo se maneja con error controlado". La evidencia citada es `availability.log` y smoke_test. ¿Qué operación concreta generó esa evidencia (p. ej. simular caída de API, timeout, rate limit) y cómo se verifica en el log que el oráculo se cumple? ¿La trazabilidad evidencia → oráculo es reproducible solo con esos archivos?
- **Pregunta 3 (Semana 4 - oráculo/diseño):** En Slide 5, OR6 es "estricta" y depende de datos factuales (Av. América Este, Cochabamba). Si el instituto cambia de dirección, el oráculo falla aunque el sistema se comporte correctamente. ¿Cómo justifican que OR6 sea defendible y qué harían cuando el valor esperado cambie? En `design/test_cases.md`, TC09 (P4) aplica OR6 y TC10 (P4) aplica OR5 para la misma partición "ubicación": ¿qué criterio decide qué oráculo aplica a cada caso y cómo se mantiene la cobertura sistemática?

### C. Recomendaciones accionables (máx. 2)

- **Recomendación 1:** Unificar terminología en Slide 4 (o en `design/test_cases.md`): añadir una frase que aclare si la técnica es _EQ con oráculo por existencia de tokens_ o _EO aplicado a particiones EQ_, para que presentación y repo sean coherentes. Verificable: que la misma denominación aparezca en slide y en el encabezado de `design/test_cases.md`.
- **Recomendación 2:** Hacer explícito en Slide 4 el vínculo Semana 3 → Semana 4: una frase indicando qué riesgo o escenario (R5/R1/R3 o Q4/Q1/Q2) justifica priorizar `POST /chatmemory` como objeto de prueba. Verificable: que en Slide 4 figure al menos una referencia a un riesgo o escenario de la Semana 3.

---

## 2) Dónde verificar en la presentación (referencia a slides)

| Slide | Contenido esperado                                               | En este proyecto                                                                                         |
| ----- | ---------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| 1     | Top 3 riesgos con score y justificación                          | R5 (Escalabilidad, 20), R1 (Disponibilidad, 15), R3 (Latencia, 12); tabla con I, P, Evidencia, Escenario |
| 2     | Trazabilidad Riesgo → Escenario → Evidencia → Oráculo → Residual | Tabla con R5→Q4, R1→Q1, R3→Q2; rutas `evidence/week2/`, `evidence/week3/`; oráculos pass/fail por riesgo |
| 3     | Riesgo residual (qué queda fuera)                                | Tabla: Robustez, Seguridad de datos, Precisión; calificación y justificación                             |
| 4     | Objeto de prueba + técnica                                       | `POST /chatmemory`; técnica "EO" (existencia de tokens); justificación y cobertura declarada             |
| 5     | Oráculos mínimos vs estrictos                                    | OR1–OR3 mínimas; OR4–OR5 por partición; OR6 estricto; ambigüedad (precios/fechas)                        |
| 6     | Amenazas a la validez + mejora concreta                          | Interna, constructo, externa con mitigaciones; mejora: métricas cuantitativas para LLMs                  |

---

## 3) Lista de verificación rápida (Semanas 3 y 4)

### Semana 3 — Estrategia basada en riesgo

**Verificar en la presentación (Slides 1–3):**

- [ ] Top 3 riesgos están justificados (impacto/probabilidad/score y razón breve) → Slide 1: R5, R1, R3 con I, P, Motivo, Evidencia
- [ ] Existe trazabilidad explícita: **riesgo → escenario → evidencia → oráculo** → Slide 2: tabla con Riesgo, Escenario (Q4/Q1/Q2), Evidencia, Oráculo mínimo
- [ ] La evidencia está referenciada con rutas del repo (ej.: `evidence/week3/...`) → Slide 1 y 2: `evidence/week2/`, `evidence/week3/scalability.log`, `availability.log`, `latency.csv`
- [ ] Se declara el **riesgo residual** (qué queda fuera y por qué) → Slide 2 (columna "Riesgo residual") y Slide 3 (tabla Robustez, Seguridad, Precisión)

**Preguntas de ejemplo (adaptadas al proyecto, más complejas):**

- **R5 – coherencia oráculo/residual:** Slide 2 declara "Pass si cada sesión mantiene coherencia" y "No se evalúa concurrencia real". ¿Cómo se sostiene el Pass con evidencia que no evalúa concurrencia real? ¿Qué evidencia falsaría la afirmación de reducción de riesgo?
- **R1 – trazabilidad evidencia → oráculo:** Para "Pass si el fallo se maneja con error controlado", ¿qué operación concreta generó `availability.log` (simular caída de API, timeout, rate limit?) y cómo se lee en el log el cumplimiento del oráculo? ¿Es reproducible la trazabilidad solo con esos archivos?
- **R3 – evidencia solo Semana 2:** Para R3 la evidencia es solo `evidence/week2/latency.csv` (no hay week3). ¿Cómo se conecta un único artefacto de Semana 2 con la estrategia de Semana 3? ¿Qué evidencia nueva de Semana 3 actualiza o refuerza la decisión sobre R3?
- **Slide 3 – calificación 5 y aceptación:** Robustez y Seguridad tienen calificación 5 y "acciones de mejora" (regex, limitar información). ¿Calificación 5 significa riesgo aceptado para esta etapa o solo pospuesto? ¿Qué criterio formal (I×P, decisión explícita) justifica dejar fuera prompt injection y exposición de API key, y dónde está documentada esa aceptación?

---

### Semana 4 — Diseño sistemático + oráculos

**Verificar en la presentación (Slides 4–6):**

- [ ] Se eligió 1 objeto de prueba (endpoint/función) y se justifica → Slide 4: `POST /chatmemory`; justificación (endpoint principal, evaluable con métricas)
- [ ] Técnica sistemática declarada (EQ/BV o pairwise) y coherente con los casos → Slide 4: "EO" (existencia de tokens); en repo: EQ por particiones P1–P5 en `design/test_cases.md`
- [ ] Hay ≥ 5 reglas de oráculo (mínimas vs estrictas) → Slide 5: OR1–OR3 mínimas; OR4–OR5 por partición; OR6 estricta (≥ 5 reglas)
- [ ] Casos y oráculos son trazables a evidencia (ej.: `evidence/week4/...`) → `evidence/week4/TC01_response.txt` … `TC12_response.txt`, `results.csv`, `summary.txt`
- [ ] Se reconoce al menos 1 ambigüedad y cómo se resolvió → Slide 5: ambigüedad "precios vs fechas de inicio"; nota sobre decisión de prueba

**Preguntas de ejemplo (adaptadas al proyecto, más complejas):**

- **OR6 estricta y datos factuales:** OR6 exige "Av. América Este" y "Cochabamba". Si el instituto cambia de dirección, el mismo comportamiento correcto del sistema haría fallar el oráculo. ¿Por qué consideran OR6 "defendible" y qué política de actualización tienen cuando el valor esperado cambia? ¿Qué distingue operativamente "mínima" de "estricta" más allá del tipo de criterio (formato vs contenido factual)?
- **Misma partición, oráculos distintos:** En `design/test_cases.md`, TC09 (P4, ubicación) aplica OR6 y TC10 (P4, ubicación) aplica OR5. Misma partición, oráculos diferentes. ¿Qué criterio decide qué oráculo aplica a cada input y cómo garantizan que la partición P4 queda cubierta de forma sistemática y no arbitraria?
- **Coherencia vs estructura:** Slide 6 declara que "usar códigos JSON como proxy de robustez no cubre otras dimensiones" y la mejora es "métricas cuantitativas para coherencia". OR1–OR5 verifican formato, presencia de `content`, no 5xx, y existencia de cadenas ("Bs", email). ¿Qué dimensión de "coherencia" o corrección de la respuesta cubren realmente estos oráculos? ¿Se está evaluando solo estructura o también validez del contenido?
- **Ambigüedad precios vs fechas:** Slide 5 registra ambigüedad "precios de los cursos o fechas de inicio" y optan por precios (OR4). ¿Con qué criterio resolvieron la ambigüedad (prioridad de stakeholder, trazabilidad a requisito, riesgo)? ¿Está documentada esa decisión en el repo?
- **EO vs EQ y sistematicidad:** En slides: "EO (existencia de tokens)"; en repo: "EQ por particiones P1–P5". Los casos se derivan de particiones de entrada pero el oráculo es existencia de tokens. ¿Cómo justifican que esa combinación sea "sistemática"? ¿Falta algo para que sea claramente EQ (p. ej. valor por partición, valores límite)?

---
