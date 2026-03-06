# Plantilla de presentación — Informe breve "Estado del arte" (8–10 slides)

# Informe breve — Estado del arte — Grupo 4
**Tema:** Quality gates modernos y gobernanza (must-pass vs informativos, evidencia, excepciones, auditoría)  
**Pregunta guía (1 frase):** ¿Cómo deben diseñarse y gobernarse los quality gates modernos para que funcionen como mecanismos reales de decisión go/no-go y no como controles decorativos o manipulables?  
**Fuentes analizadas:** 9  
**Tesis principal (1 frase):** Los quality gates modernos son más efectivos cuando combinan métricas automáticas, evidencia verificable, gobernanza explícita y validaciones distribuidas por fases del pipeline.

---

## Slide 1 — Contexto y propósito
- Por qué este tema importa hoy: en entornos CI/CD, las decisiones sobre integración y despliegue deben ser rápidas, repetibles y basadas en evidencia.
- Qué problema de QA/ingeniería aborda: evita que el quality gate se convierta en un indicador decorativo, rígido o manipulable por métricas aisladas.
- Qué mejora/decisión habilita (1 línea): permite decisiones go/no-go más confiables sobre integración y liberación de software.

---

## Slide 2 — Pregunta guía y alcance
- Pregunta guía: ¿Cómo diseñar quality gates modernos que equilibren automatización, evidencia y gobernanza sin generar bloqueos injustificados?
- Incluye (2–3 puntos):
  - diferenciación entre checks must-pass e informativos;
  - uso de artifacts y evidencia verificable;
  - gestión de excepciones, auditoría y revisión periódica del gate.
- No incluye (1–2 puntos):
  - implementación detallada de una herramienta específica;
  - evaluación experimental propia en un caso real.
- Definiciones mínimas (si aplica, 2 términos):
  - **Quality gate:** conjunto de reglas o verificaciones que determinan si un cambio puede avanzar en el pipeline.
  - **Gobernanza del gate:** proceso para definir, revisar, justificar y auditar cambios, excepciones y criterios del gate.

---

## Slide 3 — Método de revisión (cómo construimos el informe)
- Estrategia de búsqueda (1–2 líneas): se revisaron fuentes industriales, estándares y estudios académicos sobre CI/CD, quality gates, gobernanza, auditoría, evidencia y fallos en pipelines.
- Criterios de inclusión (2–3 puntos):
  - fuentes directamente relacionadas con quality gates o validaciones en CI/CD;
  - documentos con aporte práctico, normativo o empírico;
  - material útil para entender evidencia, riesgos y gobernanza.
- Criterios de exclusión (1–2 puntos):
  - fuentes sin relación directa con decisiones de calidad en pipeline;
  - material demasiado general sin aporte concreto sobre gates o control del proceso.
- Tipos de fuente usados (Industria / Estándar / Estudio): Industria, Estándar y Estudio.

---

## Slide 4 — Panorama: mapa de hallazgos (visión general)
> 4–6 puntos, cada uno con ID(s) de evidencia.

- Hallazgo A: los quality gates automatizan decisiones go/no-go usando métricas objetivas del pipeline. (IDs: S1, S4, S5)
- Hallazgo B: un gate efectivo requiere evidencia verificable, trazabilidad y auditoría. (IDs: S2, S7)
- Hallazgo C: detectar fallos tempranos reduce costo, riesgo y tiempo de retroalimentación. (IDs: S3, S6)
- Hallazgo D: las métricas pueden ser manipuladas cuando se usan como objetivo rígido. (IDs: S4, S8)
- Hallazgo E: la gobernanza del gate debe incluir excepciones, cambios controlados y revisión periódica. (IDs: S4, S9)

---

## Slide 5 — Hallazgo clave 1 (explicado)
- Qué afirma (1 frase): los quality gates modernos permiten automatizar decisiones de aprobación o bloqueo con base en métricas y verificaciones del pipeline.
- Evidencia principal (IDs): S1, S5, S6.
- Implicación práctica (1–2 puntos):
  - se puede impedir que cambios con vulnerabilidades, baja cobertura o fallos críticos lleguen a ramas principales;
  - el gate deja de ser solo un panel de métricas y se convierte en un control operativo.
- Condiciones de aplicabilidad (1 punto): requiere integración con CI/CD y criterios mínimos bien definidos según el nivel de riesgo.

---

## Slide 6 — Hallazgo clave 2 (explicado)
- Qué afirma: la evidencia verificable y la gobernanza explícita son indispensables para evitar decisiones arbitrarias o manipulables.
- Evidencia principal (IDs): S2, S7, S9.
- Implicación práctica:
  - los gates deben dejar artifacts, registros de excepción y reglas auditables;
  - debe existir criterio sobre quién aprueba cambios del gate y cómo se documentan.
- Condiciones de aplicabilidad: funciona mejor cuando la organización tiene disciplina de proceso y control sobre cambios en repositorio y pipeline.

---

## Slide 7 — Hallazgo clave 3 (explicado)
- Qué afirma: priorizar controles tempranos en fases pre-merge reduce el costo de corrección y mejora el feedback.
- Evidencia principal (IDs): S3, S6, S8.
- Implicación práctica:
  - conviene ubicar validaciones críticas antes del merge para evitar fallos tardíos más costosos;
  - el pipeline debe distribuir controles según riesgo y momento de ejecución.
- Condiciones de aplicabilidad: requiere balancear rapidez, costo computacional y severidad de los checks para no frenar innecesariamente el flujo.

---

## Slide 8 — Marco aplicable (elige 1 según tu tema)
> Completar SOLO una de las dos opciones:

### Opción A: Estándares/guías relevantes (si tu tema los usa)
- Marco 1: ISO/IEC 330xx → aporte concreto: provee principios de evaluación basada en evidencia y soporte para gobernanza y auditoría del proceso. (ID: S2)  
- Marco 2: OWASP SAMM → aporte concreto: ofrece un modelo estructurado para definir controles de seguridad y calidad dentro del SDLC. (ID: S7)  
- Marco 3: SSDF / prácticas de desarrollo seguro → aporte concreto: refuerza la necesidad de verificaciones trazables y controladas dentro del ciclo de desarrollo. (ID: S7)

### Opción B: Prácticas/Patrones industriales (si tu tema es más práctico)
- Práctica/patrón 1: required checks y branch protection → por qué se usa: convierten validaciones automáticas en condiciones reales de integración. (ID: S9)  
- Práctica/patrón 2: Clean as You Code → por qué se usa: concentra el gate en código nuevo o modificado para no bloquear por deuda histórica. (ID: S4)  
- Práctica/patrón 3: approvals y quality gates en DevOps → por qué se usa: combinan automatización, aprobaciones y evidencia antes de avanzar de etapa. (ID: S6)

---

## Slide 9 — Límites, riesgos y trade-offs (siempre aplica)
- Límite 1 (qué no cubre o dónde falla): un gate no garantiza por sí solo calidad total ni sustituye criterio técnico, revisión humana o pruebas más profundas.
- Riesgo 1 (qué puede salir mal al aplicarlo): puede incentivar gaming de métricas, bloqueos innecesarios o dependencia excesiva del tooling.
- Trade-off 1 (qué se gana vs qué se sacrifica): se gana control, trazabilidad y reducción de riesgo, pero se sacrifica cierta flexibilidad y velocidad si el gate está mal calibrado.
- Mitigación (1–2 líneas, si aplica): separar checks must-pass de informativos, revisar métricas periódicamente, documentar excepciones y ajustar el gate según riesgo real.

---

## Slide 10 — Recomendaciones (implementables) + Top 5
**Recomendaciones implementables:**
- R1: separar checks críticos must-pass de checks informativos para evitar gates decorativos o excesivamente rígidos. (IDs: S1, S9)  
- R2: exigir artifacts y evidencia verificable por cada decisión relevante del gate. (IDs: S2, S7)  
- R3: priorizar validaciones tempranas pre-merge y revisar periódicamente métricas y excepciones. (IDs: S3, S4, S8)

**Top 5:**
- 3 ideas/prácticas que se presentan al grupo:
  1) Quality gates como decisión go/no-go, no solo como indicador.
  2) Evidencia verificable y auditoría para sostener la gobernanza.
  3) Validaciones tempranas y calibradas según riesgo.
- 2 anti-patrones/errores a evitar:
  1) convertir métricas en fines y no en medios.
  2) bloquear todo por igual sin distinguir severidad, contexto ni excepciones.

---

# Plantilla de matriz de evidencia (1 página)
> En caso de que la matriz sea muy extensa para la presentación, elabore una versión más corta para mostrar y revisar rápidamente. Sin embargo, es fuertemente recomendado tenerla completa para un control interno y de revisión. La versión completa puede estar en un documento por separado.

| ID | Tipo (Industria/Estándar/Estudio) | Fuente (título corto) | Año | Idea clave (1 frase) | Qué aporta (nuevo conocimiento) | Riesgo/limitación | Recomendación derivada |
|---|---|---|---|---|---|---|---|
| S1 | Industria | SonarSource – Quality Gates | 2024 | Los quality gates usan métricas automáticas para aprobar o bloquear código. | Define métricas como cobertura, duplicación y vulnerabilidades. | Dependencia de métricas automáticas. | Integrar quality gates al CI/CD. |
| S2 | Estándar | ISO/IEC 330xx Process Assessment Model | 2015 | La evaluación de procesos debe basarse en evidencia verificable. | Base de gobernanza y auditoría para decisiones del gate. | Puede ser pesado si se aplica completo. | Usar sus principios para gobernanza de gates. |
| S3 | Estudio | Good/Bad Failures in CI/CD | 2025 | Los fallos tempranos son preferibles a los fallos tardíos. | Propone una visión por fases y resalta el valor del pre-merge. | Optimización parcial o riesgosa si se descuida el resto del pipeline. | Priorizar controles tempranos pre-merge. |
| S4 | Industria | SonarSource – Clean as You Code / Quality Gate | 2023 | Los gates automatizados ayudan a mantener calidad continua en código nuevo. | Integra control de calidad con foco en cambios recientes. | Puede incentivar gaming de métricas si se usa mal. | Revisar y ajustar métricas periódicamente. |
| S5 | Industria | Software Engineering at Google – Testing Overview | 2020 | Testing y gates reducen riesgo dentro del desarrollo a gran escala. | Modelo industrial de testing y control de calidad escalable. | Alto costo organizacional. | Diseñar gates por nivel de riesgo. |
| S6 | Industria | Microsoft DevOps Quality Gates | 2022 | Los quality gates se integran al pipeline DevOps para controlar el avance entre etapas. | Ejemplo práctico de automatización y validación dentro de CI/CD. | Dependencia del tooling. | Automatizar validaciones relevantes. |
| S7 | Estándar | OWASP SAMM | 2023 | La gobernanza de seguridad y calidad debe estructurarse dentro del SDLC. | Modelo maduro para definir controles y verificaciones. | Requiere madurez organizacional. | Usarlo para definir controles del gate. |
| S8 | Estudio | Continuous Integration Practices Study | 2018 | La integración continua mejora la detección temprana de defectos. | Evidencia empírica en proyectos reales. | Los resultados dependen del contexto. | Implementar CI con controles graduales. |
| S9 | Industria | GitHub Branch Protection & Required Checks | 2023 | Los required checks funcionan como quality gates en repositorios modernos. | Implementación práctica de checks obligatorios antes del merge. | Puede generar bloqueos si se configura mal. | Separar checks must-pass de informativos. |
