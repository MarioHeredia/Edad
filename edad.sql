
-- Autor: Mario Heredia. Fecha: 12.May.2010.

SELECT 'Hoy '||TO_CHAR(SYSDATE,'DD.MM.YYYY')||'. &1, '||
       DECODE(ANIOS, 0,
              DECODE(MESES, 0,
                     DECODE(SEMANAS, 0,
                            DECODE(DIAS, 0, 'acaba de nacer.', 'tiene '||DIAS||DECODE(DIAS, 1, ' dia', ' dias')||' de vida. '),
                                   'tiene '||SEMANAS||DECODE(SEMANAS, 1, ' semana', ' semanas')||DECODE(DIAS, 0, ' de vida.', ' y '||DIAS||DECODE(DIAS, 1, ' dia', ' dias')||' de vida. ')
                           ), 'tiene '||MESES||DECODE(MESES, 1, ' mes', ' meses')||
                     DECODE(SEMANAS, 0, DECODE(DIAS, 0, ' de vida.', ' y '||DIAS||DECODE(DIAS, 1, ' dia', ' dias')||' de vida. '),
                            DECODE(DIAS, 0, ' y ', ', ')||SEMANAS||DECODE(SEMANAS, 1, ' semana', ' semanas')||DECODE(DIAS, 0, ' de vida.', ' y '||DIAS||
                            DECODE(DIAS, 1, ' dia', ' dias')||' de vida. '))),
              'tiene '||ANIOS||DECODE(ANIOS, 1, ' anio', ' anios')||
              DECODE(MESES, 0,
                     DECODE(SEMANAS, 0,
                            DECODE(DIAS, 0, ' de vida.', ' y '||DIAS||DECODE(DIAS, 1, ' dia', ' dias')||' de vida. '),
                                   DECODE(DIAS, 0, ' y ', ', ')||SEMANAS||DECODE(SEMANAS, 1, ' semana', ' semanas')||DECODE(DIAS, 0, ' de vida.', ' y '||DIAS||
                                   DECODE(DIAS, 1, ' dia', ' dias')||' de vida. ')
                           ), DECODE(DIAS + SEMANAS, 0, ' y ', ', ')||MESES||DECODE(MESES, 1, ' mes', ' meses')||
                     DECODE(SEMANAS, 0, DECODE(DIAS, 0, ' de vida.', ' y '||DIAS||DECODE(DIAS, 1, ' dia', ' dias')||' de vida. '),
                            DECODE(DIAS, 0, ' y ', ', ')||SEMANAS||DECODE(SEMANAS, 1, ' semana', ' semanas')||DECODE(DIAS, 0, ' de vida.', ' y '||DIAS||
                            DECODE(DIAS, 1, ' dia', ' dias')||' de vida. ')))) EDAD
  FROM (
SELECT ANIOS,
       MESES,
       NVL(FLOOR(DIAS / 7), 0) SEMANAS,
       NVL(MOD(DIAS, 7), 0) DIAS
  FROM (
SELECT CASE WHEN MESES >= 12 THEN FLOOR(MESES / 12)
            ELSE 0 END ANIOS,
       CASE WHEN MESES >= 12 THEN MOD(MESES , 12)
            ELSE MESES END MESES,
       CASE WHEN DIA > DIA_ACTUAL THEN DIA - 1 ELSE DIA END DIAS
  FROM (
SELECT NVL(MESES, 0) MESES,
       DECODE(RESTO, 0, 0,
                     0.03, 01, 0.06, 02, 0.09, 03, 0.12, 04, 0.16, 05, 0.19, 06, 0.22, 07, 0.25, 08, 0.29, 09, 0.32, 10,
                     0.35, 11, 0.38, 12, 0.41, 13, 0.45, 14, 0.48, 15, 0.51, 16, 0.54, 17, 0.58, 18, 0.61, 19, 0.64, 20,
                     0.67, 21, 0.70, 22, 0.74, 23, 0.77, 24, 0.80, 25, 0.83, 26, 0.87, 27, 0.90, 28, 0.93, 29, 0.96, 30
             ) DIA,
       DIA_ACTUAL
  FROM (
SELECT DECODE(DIFERENCIA, 0, 0, DECODE(INSTR( DIFERENCIA, '.'), 0, DIFERENCIA, TO_NUMBER(SUBSTR( DIFERENCIA, 1, INSTR( DIFERENCIA, '.') -1)))) MESES,
       DECODE(DIFERENCIA, 0, 0, DECODE(INSTR( DIFERENCIA, '.'), 0, 0, SUBSTR( DIFERENCIA, INSTR( DIFERENCIA, '.'), 3))) RESTO,
       DIA_ACTUAL
  FROM (
SELECT NVL(MONTHS_BETWEEN(TO_CHAR(TRUNC(SYSDATE), 'DD-MON-YYYY'),
                      TO_CHAR(TO_DATE('&2','DD.MM.YYYY'), 'DD-MON-YYYY')), 0) DIFERENCIA,
       TO_CHAR(TRUNC(SYSDATE), 'DD') DIA_ACTUAL
  FROM DUAL
       )))));
