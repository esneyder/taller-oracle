SET SERVEROUTPUT ON
--consulta que devuelve el id departamento mayor
-- CON LA FUNCIÓN MAX VALIDO EN DEPARTMENT_ID MAYOR Y DEVUELVO EL VALOR.
DECLARE 
  v_max_deptno number(4);
  --nomdepartamendo VARCHAR2(30);
BEGIN
  SELECT MAX(DEPARTMENT_ID)
  INTO v_max_deptno
  FROM DEPARTMENTS;
  dbms_output.put_line('El departamento con id maximo es : ' || v_max_deptno );
END; 

--==============================================================cursor
--EL CURSOR CONSISTE EN REALIZAR UNA CONSULTA ENTRE LA TABLA DEPARTMENTS Y LA TABLA EMPLOYEES
--PRIMERO CONSULTARE EN LA TABLA DEPARTMENTS TODOS AQUELLOS DEPARTMENT_ID CUYOS VALORES SEAN MENORES A 100,
--ESTE CONDICIÓN CLARO ESTTA LA PODEMOS CAMBIAR SI ASÍ LO DESEAMOS.
--.............
--LUEGO CONSULTARE EN LA TABLA EMPLOYEES Y SOLICITATRÉ QUE SE ME MUESTREN AQUELLOS DEPARTMENT_ID RELACIONADOS CON LA TABLA DEPARTMENTS
--Y TAMBIEN QUE SEAN MENORES A 200 PARA ESTE CASO COMO EJEMPLO, ESTET PARAMETRO SE PUEDE ELEGIR SEGUN NUESTRA NECESIDAD
--QUE NOS DEVOLVERA EL CURSOR
--PRIMERO NOS DEVOLVERA TODOS AQUELLOS DEPARTAMENTOS CUYO ID SEAN MENOR A 100 O EL VALOR QUE LE DEMOS
--SEGUIDAMENTE, APARTIR DE ESOS ID DEPARTAMENTOS ENCONTRADOS NOS DEVOLVERA LOS DATOS DE LOS EMPLEADOS QUE ESTEN RELACIONADOS CON LOS ID DEPARTAMENTOS
-- Y QUE ADEMÁS SU EMPLOYEE_ID SEA MENOR A 200 O EL PARAMÉTRO QUE LE DEMOS..
DECLARE
  CURSOR DEPT_CURSOR IS
  SELECT DEPARTMENT_ID, DEPARTMENT_NAME
  FROM DEPARTMENTS
  WHERE DEPARTMENT_ID < 100
  ORDER BY DEPARTMENT_ID;
  
  CURSOR EMP_CURSOR(DEPT_NUM NUMBER) IS
  SELECT LAST_NAME, JOB_ID, HIRE_DATE, SALARY
  FROM EMPLOYEES
  WHERE EMPLOYEE_ID < 200 AND DEPARTMENT_ID = DEPT_NUM;
  
--variables departamento
  
  V_DEPT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE;
  V_DEPT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
  
 --variables empleados
   
   V_LAST_NAME EMPLOYEES.LAST_NAME%TYPE;
   V_JOB_ID EMPLOYEES.JOB_ID%TYPE;
   V_HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE;
   V_SALARY EMPLOYEES.SALARY%TYPE;
   
BEGIN
  OPEN DEPT_CURSOR;
  LOOP
    FETCH dept_cursor INTO v_dept_id, v_dept_name;
    EXIT WHEN DEPT_CURSOR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID Departamento: ' || V_DEPT_ID || '  -- ID Departamento : ' || V_DEPT_NAME);
    OPEN EMP_CURSOR(v_dept_id);
    DBMS_OUTPUT.PUT_LINE(' LAST_NAME '  || ' JOB_ID ' ||  '  HIRE_DATE  ' || 'SALARY');
    LOOP    
      FETCH EMP_CURSOR INTO V_LAST_NAME, V_JOB_ID, V_HIRE_DATE, V_SALARY;
       EXIT WHEN EMP_CURSOR%NOTFOUND;
       
       DBMS_OUTPUT.PUT_LINE(V_LAST_NAME || '     ' || V_JOB_ID || '      ' || V_HIRE_DATE || '     ' || V_SALARY);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('------------------------------------TDEA-------------------------------------------------------');
    CLOSE EMP_CURSOR;
  END LOOP;
  CLOSE DEPT_CURSOR;
END;
--
--=========================================================================jobs

--
-- eliminar un jobs a partir de su id ingresado como  paramétrto de entrada
-- SI EL REGISTRO TIENE ALGUNA RELACIÓN CON OTRA TABLA,NO SE PODRA ELIMINAR
DECLARE
  job_id_param JOBS.job_id%TYPE := '&Ingrese_Job_ID';
  num_rows_return NUMBER;
  job_id_doesnt_exist EXCEPTION;
  choice VARCHAR2(8);
BEGIN
  SELECT COUNT(*)
  INTO num_rows_return
  FROM JOBS
  WHERE job_id = job_id_param;
  
  IF num_rows_return = 0 THEN
    RAISE job_id_doesnt_exist;
  ELSE
    choice := '&confirmar_SI_O_NO';
    IF choice = 'SI' OR choice = 'si' THEN
      DEL_JOB(job_id_param);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Eliminación cancelada');
    END IF;
  END IF;

EXCEPTION
  WHEN job_id_doesnt_exist THEN
    DBMS_OUTPUT.PUT_LINE('Error, verifique el dato ingresado.no se encuentra en la base de datos');
END;


