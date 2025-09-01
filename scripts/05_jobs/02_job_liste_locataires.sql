SET SERVEROUTPUT ON;
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name        => 'job_liste_locataires',
    job_type        => 'STORED_PROCEDURE',
    job_action      => 'pkg_agence.liste_locataires',
    number_of_arguments => 1,
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'FREQ=DAILY; BYHOUR=12; BYMINUTE=0; BYSECOND=0',  -- chaque jour à midi
    -- repeat_interval => 'FREQ=SECONDLY; INTERVAL=10',
    end_date        => NULL,
    enabled         => FALSE
  );

  -- Passer l’argument (code immeuble)
  DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_liste_locataires', 1, 'IMM001');
  DBMS_SCHEDULER.ENABLE('job_liste_locataires');
END;
/
