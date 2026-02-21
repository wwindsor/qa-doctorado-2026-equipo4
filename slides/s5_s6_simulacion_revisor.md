# Evaluación de Propuesta - Equipo 4
**Propuesta evaluada:** C — Empresa: NorthStar Quality Lab
**Veredicto:** Rechazar

> Regla: Todo punto debe estar **respaldado por la propuesta**.
> Si algo no está en la propuesta, debe ir en "Vacíos" o "Preguntas", no como afirmación.

---

## Slide 1 — Qué ofrece la propuesta (solo hechos del texto)
- Objetivo declarado (copiar 1 frase o resumir): Sostener calidad continua sin frenar el flujo mediante checks críticos (must-pass) y mecanismo formal de excepciones.
  **Referencia:** Sección 1
- Alcance / exclusiones (2+ puntos):
  - Incluye escenarios (6–10), matriz de riesgo, Top 3, diseño sistemático (≥12 casos), oráculos, gate CI con artifacts, política de excepciones y registro de cambios. **Ref:** Sección 3
  - Excluye performance a gran escala y pruebas de seguridad especializadas. **Ref:** Sección 3
- Entregables principales (3+ puntos):
  - Gate CI con checks críticos bloqueantes y publicación de artifacts. **Ref:** Sección 4 (Fase 4)
  - Matriz de riesgo impacto×probabilidad y Top 3. **Ref:** Sección 4 (Fase 2)
  - Política de excepciones y registro de cambios del gate. **Ref:** Sección 5 y Sección 6

---

## Slide 2 - Fortalezas (basadas en texto)
> 3-5 fortalezas. Cada una debe citar una sección.

- F1: Metodología Clara con pasos identificables
  **Evidencia en propuesta:** Sección 4
  **Por qué es valioso (1 frase):** Porque permite identificar y ajustar en caso de ser necesario
- F2: Costo determinado
  **Evidencia en propuesta:** Sección 7
  **Por qué es valioso:** Por que se sabe el precio a primera instancia
- F3: Politica y Gobernanza identificable
  **Evidencia en propuesta:** Sección 5 y 6
  **Por qué es valioso:** Enfoque explicito porque determina rasgos claros y no ambiguos.
- F4: Separación entre checks críticos (must-pass) e informativos.
  **Evidencia en propuesta:** Sección 4 Fase 2 y 4
  **Por qué es valioso:** Mejora señal/ruido del gate y evita bloqueo prematuro por inestabilidad inicial.
- (Opcional) F4/F5: ___ (mismo formato)

---

## Slide 3 - Debilidades / riesgos (basadas en texto)
> 3-6 debilidades. Marcar severidad: **Crítica / Mayor / Menor**.
> Cada debilidad debe citar una sección de la propuesta.

- D1 (Severidad: Crítica): No tiene alcance: Cantidad de pruebas, dias de trabajo, equipo de trabajo, nivel de servicio
  **Texto/Sección relacionada:** Sección 1
  **Riesgo/impacto (1 frase):** No se puede medir el impacto económico financiero
- D2 (Severidad: Critico): No tiene reuniones ni reportes diarios
  **Texto/Sección relacionada:** Sección 4
  **Riesgo/impacto:** Impacto negativo en la produccion diaria.
- D3 (Severidad: Menor): No hay control de cambios que permitan la trazabilidad ni la auditoria de los Gate
  **Texto/Sección relacionada:** Sección 6
  **Riesgo/impacto:** Dificulta la auditoria y trazabilidad de la modificación del Gate
- (Opcional) D4/D5/D6: ___ (mismo formato)

---

## Slide 4 - Cobertura explícita vs vacíos
### A) Lo que la propuesta sí define (3-5 puntos)
- Escenarios con medida y evidencia esperada **Ref:** Sección 4
- Matriz de riesgos, impacto por probabilidad **Ref:** Sección 4
- Gate safe con checks criticos bloqueantes  **Ref:** Sección 4
- Revisión semanal y auditorias **Ref:** Sección 6
- Entregas incrementales con hitos **Ref:** Sección 6

### B) Vacíos/ambigüedades que impiden evaluar bien (3-5 puntos)
- Vacío 1: Criterio concreto para estabilizar el base line
  **Qué falta exactamente:** Definición operativa.
  **Por qué importa (1 frase):** Por que sin ella no se puede evaluar el Gate
- Vacío 2: El plazo maximo para un check.
  **Qué falta exactamente:** Falta hitos de revision ejemplos, dias, sprints, entre otros.
  **Por qué importa:** Evita que los check se desactiven indefinidamente.
- Vacío 3: Financiero
  **Qué falta exactamente:** Entregables con costos y desglose.
  **Por qué importa:** Complica la evaluación del valor y la negociacion por fases.

### C) Preguntas de aclaración al proveedor (2-4 preguntas)
- P1: Nos puede proporcionar el SLA y KPI para la propuesta?
- P2: Cual es el plazo recomendado para mantener un check, antes de decidir si reactivar o eliminar?
- P3: Cantidad de dias y cantidad de pruebas?
- P4: Que formato y que campos minimos tendran la bitacora del Gate?, y en que repositorio o herramienta se mantendra.

---

## Slide 5 — Goodhart / Gaming (solo si se deriva del texto)
> Debe basarse en señales explícitas del documento (ej.: "mantener gate verde", "ajustar umbrales", "excepciones", "reruns", etc.)

- Señal en la propuesta (citar): Si un check no funcional bloquea el gate, se permite aprobar mediante una excepción registrada
  **Referencia:** Sección 5
- Riesgo de gaming (1 frase): Rebajar la severidad
- Consecuencia probable (1 frase): Gate pierde significado
- Mitigación/condición (1 frase): Limitar excepciones por periodo

---

## Slide 6 - Condiciones para aceptar (solo si el veredicto lo requiere)
> 2-4 condiciones **verificables**. Deben apuntar a corregir debilidades o llenar vacíos.

- C1: Definir umbrales cuantitativos explícitos para todos los checks críticos.
  **Cómo se verifica:** 
  **Motivo (D# o Vacío #):** ___
- C2: ___  
  **Cómo se verifica:** ___  
  **Motivo:** ___
- (Opcional) C3/C4: ___ 

---

## Slide 7 - Veredicto (decisión final)
- Decisión: ___
- Justificación (máximo 3 puntos, conectados a D# o Vacíos):
  1) ___ (D# / Vacío #)
  2) ___ (D# / Vacío #)
  3) ___ (D# / Vacío #)

