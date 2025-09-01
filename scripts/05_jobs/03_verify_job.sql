SET SERVEROUTPUT ON;
SET PAGESIZE 50;
SET LINESIZE 120;

COLUMN JOB_NAME FORMAT A25;
COLUMN ARGUMENT_NAME FORMAT A10;
COLUMN ARGUMENT_TYPE FORMAT A10;
COLUMN VALUE FORMAT A10;
COLUMN STATUS FORMAT A10;
COLUMN INFO FORMAT A15;
COLUMN STATE FORMAT A10;
COLUMN REPEAT_INTERVAL FORMAT A25;
COLUMN PROCHAINE_EXECUTION FORMAT A25;
COLUMN  DATE_EXECUTION  FORMAT A15;



PROMPT === VERIFICATION DES JOBS PLANIFIES ===

-- 1. Jobs dans le schema utilisateur
PROMPT 1. JOBS DANS LE SCHEMA :
SELECT 
    job_name,
    enabled,
    state,
    TO_CHAR(next_run_date,'DD/MM/YYYY HH24:MI:SS') AS prochaine_execution,
    repeat_interval
FROM user_scheduler_jobs
WHERE job_name IN ('JOB_PRIX_MENSUEL', 'JOB_LISTE_LOCATAIRES')
ORDER BY job_name;

PROMPT

-- 2. Verification des historiques (7 derniers jours)
PROMPT 2. HISTORIQUE DES EXECUTIONS :
SELECT 
    job_name,
    status,
    TO_CHAR(log_date,'DD/MM/YYYY HH24:MI:SS') AS date_execution,
    SUBSTR(additional_info,1,100) AS info
FROM user_scheduler_job_log
WHERE log_date > SYSDATE - 7
  AND job_name IN ('JOB_PRIX_MENSUEL','JOB_LISTE_LOCATAIRES')
ORDER BY log_date DESC;

PROMPT

-- 3. Arguments des jobs (si existants)
PROMPT 3. ARGUMENTS DES JOBS :
SELECT 
    job_name,
    argument_name,
    argument_position,
    argument_type,
    value
FROM user_scheduler_job_args
WHERE job_name IN ('JOB_PRIX_MENSUEL','JOB_LISTE_LOCATAIRES')
ORDER BY job_name, argument_position;

PROMPT

-- 4. Test manuel des jobs
PROMPT 4. TEST MANUEL DES JOBS :
BEGIN
    BEGIN
        DBMS_SCHEDULER.RUN_JOB('JOB_PRIX_MENSUEL');
        DBMS_OUTPUT.PUT_LINE('JOB_PRIX_MENSUEL execute');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('JOB_PRIX_MENSUEL : ' || SQLERRM);
    END;

    BEGIN
        DBMS_SCHEDULER.RUN_JOB('JOB_LISTE_LOCATAIRES');
        DBMS_OUTPUT.PUT_LINE('JOB_LISTE_LOCATAIRES execute');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('JOB_LISTE_LOCATAIRES : ' || SQLERRM);
    END;
END;
/