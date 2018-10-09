-- MATEUS DE LIMA OLIVEIRA - 117110219
-- Q1
SELECT * FROM department;
-- Q2
SELECT * FROM dependent;
-- Q3
SELECT * FROM dept_locations;
-- Q4
SELECT * FROM employee;
-- Q5
SELECT * FROM project;
-- Q6
SELECT * FROM works_on;
-- Q7
SELECT fname, lname
FROM employee
WHERE sex='M';
-- Q8
SELECT fname
FROM employee
WHERE superssn IS NULL;
--Q9 - DUVIDA REVISAR
SELECT E.fname AS funcionario, S.fname AS supervisor
FROM employee E, employee S
WHERE E.superssn = S.ssn;
-- Q10
SELECT fname
FROM employee 
WHERE superssn = (  SELECT ssn
                    FROM employee
                    WHERE fname = 'Franklin');
-- Q11
SELECT D.dname, L.dlocation
FROM dept_locations L, department D
WHERE L.dnumber = D.dnumber;
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