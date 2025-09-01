SET SERVEROUTPUT ON;

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name        => 'job_prix_mensuel',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'DECLARE v_prix NUMBER; BEGIN v_prix := pkg_agence.prix_mensuel(''IMM001''); END;',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'FREQ=MINUTELY; INTERVAL=10',  -- toutes les 10 minutes
    -- repeat_interval => 'FREQ=SECONDLY; INTERVAL=10',
    end_date        => NULL,
    enabled         => TRUE
  );
END;
/
