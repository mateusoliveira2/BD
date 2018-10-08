-- Q12
SELECT D.dname AS nome
FROM department D, dept_locations L
WHERE L.dlocation like 'S%';

-- Q13
SELECT E.fname, E.lname, D.dependent_name
FROM employee E, dependent D
WHERE E.ssn = D.essn;

-- Q14
SELECT (fname ||' '|| minit ||'. '|| lname) AS full_name, salary
FROM employee 
WHERE salary>50000;

-- Q15
SELECT P.pname AS project, D.dname
FROM project P, department D 
WHERE salary>50000;

-- Q16
SELECT P.pname AS project, E.fname AS menager
FROM project P, department D, employee E
WHERE (P.dnum = D.dnumber) AND (D.mgrssn = E.ssn);

-- Q17
SELECT P.pname AS project, E.fname
FROM project P, department D, employee E
WHERE (P.dnum = D.dnumber) AND (D.dnumber = E.dno);

-- Q18
SELECT EMP.fname, DEP.dependent_name, DEP.relationship
FROM project PRO, department D, employee EMP, dependent DEP
WHERE (PRO.pnumber = 91) AND (PRO.dnum = D.dnumber) AND(D.dnumber = EMP.dno) AND(DEP.essn = EMP.ssn);