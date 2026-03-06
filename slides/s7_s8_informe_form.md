# Plantilla de presentación — Informe breve "Estado del arte" (8–10 slides)

# Informe breve — Estado del arte — Grupo 4
**Tema:** Quality gates modernos y gobernanza  
**Pregunta guía (1 frase):** ¿Cómo deben diseñarse quality gates modernos para equilibrar riesgo, evidencia y productividad sin generar gaming ni burocracia?  
**Fuentes analizadas:** 10  
**Tesis principal (1 frase):** Los quality gates modernos deben diseñarse como mecanismos de gobernanza basados en riesgo y evidencia diferenciada por fase, no como filtros rígidos basados en métricas aisladas.

---

## Slide 1 — Contexto y propósito
- Por qué este tema importa hoy: Los pipelines CI/CD modernos requieren mecanismos automatizados de decisión que permitan aprobar o bloquear cambios antes de llegar a producción.
- Qué problema de QA/ingeniería aborda: Evitar que los gates se conviertan en burocracia técnica, métricas manipulables (Goodhart), bloqueos innecesarios y riesgo sistémico tardío.
- Qué mejora/decisión habilita (1 línea): Permite diseñar pipelines con control explícito de riesgo, trazabilidad auditable y decisiones go/no-go confiables.

---

## Slide 2 — Pregunta guía y alcance
- Pregunta guía: ¿Cómo diseñar quality gates modernos que maximicen detección temprana sin sacrificar productividad ni gobernanza, con evidencia y métricas útiles?
- Incluye (2–3 puntos): Must-pass vs informativos; evidencia automatizada y trazable; gestión de excepciones; riesgos de gaming y flakiness.
- No incluye (1–2 puntos): Diseño técnico detallado de herramientas específicas; comparativa comercial de plataformas CI/CD.
- Definiciones mínimas (si aplica, 2 términos): Quality gate: punto de decisión que condiciona la promoción de artefacto según evidencia verificable. Must-pass: criterio bloqueante obligatorio alineado a riesgo crítico. Gobernanza de calidad: proceso que define reglas, evidencia y responsables de las decisiones de calidad.

---

## Slide 3 — Método de revisión (cómo construimos el informe)
- Estrategia de búsqueda (1–2 líneas): Revisión de literatura reciente sobre CI/CD, quality gates y gobernanza de QA, combinando fuentes industriales, estándares y estudios académicos.
- Criterios de inclusión (2–3 puntos): Publicaciones 2015–2025; relevancia directa a CI/CD y gobernanza; aplicabilidad industrial; fuentes verificables; evidencia sobre decisiones de calidad automatizadas.
- Criterios de exclusión (1–2 puntos): Opinión sin evidencia; material sin aplicación práctica.
- Tipos de fuente usados (Industria / Estándar / Estudio): Industria / Estándar / Estudio.

---

## Slide 4 — Panorama: mapa de hallazgos (visión general)
> 4–6 puntos, cada uno con ID(s) de evidencia.

- Hallazgo A: Los quality gates actúan como mecanismos automáticos para bloquear código que no cumple métricas de calidad. (IDs: S1)  
- Hallazgo B: La gobernanza efectiva de calidad requiere evidencia verificable y auditoría del proceso. (IDs: S2)  
- Hallazgo C: Los gates deben diferenciar fases del pipeline, especialmente pre-merge y post-merge. (IDs: S3)  
- Hallazgo D: El pre-merge es el punto óptimo para la detección intensiva y temprana de fallos. (IDs: S3)  
- Hallazgo E: Los controles deben separarse en criterios must-pass e informativos para evitar rigidez excesiva. (IDs: S1, S2, S3)

---

## Slide 5 — Hallazgo clave 1 (explicado)
- Qué afirma (1 frase): Los quality gates evalúan automáticamente métricas del código y pueden detener pipelines si no se cumplen los criterios definidos.
- Evidencia principal (IDs): S1.
- Implicación práctica (1–2 puntos): Permite prevenir la integración de código defectuoso mediante métricas como cobertura, duplicación o vulnerabilidades; mejora la consistencia en estándares de calidad.
- Condiciones de aplicabilidad (1 punto): Debe existir integración con herramientas de análisis y pipelines CI automatizados.

---

## Slide 6 — Hallazgo clave 2 (explicado)
- Qué afirma: La gobernanza de calidad debe basarse en evidencia verificable y evaluaciones estructuradas del proceso.
- Evidencia principal (IDs): S2.
- Implicación práctica: Permite auditoría de decisiones de calidad y reduce la arbitrariedad en la aprobación de software.
- Condiciones de aplicabilidad: La organización debe definir criterios claros, responsables del proceso y evidencia auditable.

---

## Slide 7 — Hallazgo clave 3 (explicado)
- Qué afirma: El pre-merge es el punto óptimo de control dentro del pipeline.
- Evidencia principal (IDs): S3 — Sun et al., “Good and Bad Failures in Industrial CI/CD”.
- Implicación práctica: Pre-merge para detección intensiva y rápida; post-merge para validación sistémica; pre-release con tolerancia cero a fallos críticos.
- Condiciones de aplicabilidad: Organizaciones con CI/CD automatizado y estructurado en fases con validaciones progresivas.

---

## Slide 8 — Marco aplicable (elige 1 según tu tema)
> Completar SOLO una de las dos opciones:

### Opción A: Estándares/guías relevantes (si tu tema los usa)
- Marco 1: ISO/IEC 330xx (SPICE) Process Assessment Model → aporte concreto: define un modelo de evaluación de procesos basado en evidencia verificable, útil para gobernanza y auditoría de decisiones de calidad. (ID: S2)  
- Marco 2: Gobernanza de quality gates por fases → aporte concreto: orienta a distribuir los controles según el nivel de riesgo del pipeline y evitar decisiones rígidas en una sola etapa. (ID: S3)

### Opción B: Prácticas/Patrones industriales (si tu tema es más práctico)
- Práctica/patrón 1: Quality gates basados en métricas automáticas → por qué se usa: permite decisiones rápidas y objetivas con base en cobertura, duplicación y vulnerabilidades. (ID: S1)  
- Práctica/patrón 2: Separación de controles por fase del pipeline → por qué se usa: distribuye validaciones según riesgo y momento del ciclo de integración. (ID: S3)  
- Práctica/patrón 3: Gobernanza apoyada en evidencia auditable → por qué se usa: mejora la trazabilidad, la rendición de cuentas y la consistencia de aprobación. (ID: S2)

---

## Slide 9 — Límites, riesgos y trade-offs (siempre aplica)
- Límite 1 (qué no cubre o dónde falla): Los quality gates no pueden capturar todos los aspectos de calidad del software.
- Riesgo 1 (qué puede salir mal al aplicarlo): La dependencia excesiva de métricas automáticas puede generar gaming de métricas.
- Trade-off 1 (qué se gana vs qué se sacrifica): Más controles aumentan la calidad, pero pueden ralentizar el pipeline y afectar la productividad.
- Mitigación (1–2 líneas, si aplica): Separar checks en must-pass e informativos y revisar periódicamente los thresholds para mantener equilibrio entre control y flujo.

---

## Slide 10 — Recomendaciones (implementables) + Top 5
**Recomendaciones implementables:**
- R1: Integrar quality gates en CI/CD con métricas automáticas de calidad. (IDs: S1)  
- R2: Definir reglas de gobernanza basadas en evidencia y auditoría del proceso. (IDs: S2)  
- R3: Priorizar validaciones tempranas en pipelines para detectar fallos antes del merge. (IDs: S3)

**Top 5:**
- 3 ideas/prácticas que se presentan al grupo:
  1) Implementar quality gates automatizados en CI/CD.
  2) Basar decisiones de calidad en evidencia verificable.
  3) Priorizar validaciones tempranas en el pipeline.
- 2 anti-patrones/errores a evitar:
  1) Usar métricas de calidad sin contexto.
  2) Crear gates rígidos que bloqueen el flujo de desarrollo.

---

# Plantilla de matriz de evidencia (1 página)
>En caso de que la matriz sea muy extensa para la presentación, elabore una version mas corta, para mostrar y revisar rápidamente. Sin embargo es fuertemente recomendado tenerla completa para un control interno y de revisión. La versión completa puede estar en un documento por separado.

| ID | Tipo (Industria/Estándar/Estudio) | Fuente (título corto) | Año | Idea clave (1 frase) | Qué aporta (nuevo conocimiento) | Riesgo/limitación | Recomendación derivada |
|---|---|---|---|---|---|---|---|
| S1 | Industria | Quality gates usan métricas automáticas para aprobar o bloquear código | 2024 | Los quality gates usan métricas automáticas para aprobar o bloquear código. | Define métricas como cobertura, duplicación y vulnerabilidades para decisiones automáticas. | Dependencia excesiva de métricas automáticas. | Integrar quality gates en CI/CD. |
| S2 | Estándar | ISO/IEC 330xx (SPICE) Process Assessment | 2015 | La evaluación de procesos debe basarse en evidencia verificable. | Proporciona base de gobernanza y auditoría para decisiones de calidad. | Puede ser pesado si se aplica completo. | Usar sus principios para gobernanza de gates. |
| S3 | Estudio | Good/Bad Failures CI/CD | 2025 | Los fallos tempranos son preferibles y deben gestionarse por fases. | Propone un modelo por fases para ubicar controles según riesgo. | La optimización del pipeline puede ser riesgosa si no se equilibra con gobernanza. | Priorizar controles pre-merge y validación progresiva. |
