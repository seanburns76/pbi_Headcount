use HumanResources;


select distinct x.*,
case when x.EmpStartDate=x.OpsDate then 1 else 0 end as HireDay,
case when x.TermDate=x.OpsDate then 1 else 0 end as TermDay,
DATEDIFF(d,x.empstartdate,x.opsdate)/365.0 as Tenure

from
(
SELECT
distinct
h.OpsDate, 
h.EmployeeID,
h.EmployeeName,
h.DepartmentID,
h.EmpStatus,
case when h.EmpStartDate is null then
( select top 1 t.opsdate from HeadCount t where t.EmployeeID = h.EmployeeID  order by t.OpsDate asc) else h.EmpStartDate end as EmpStartDate,


isnull(( select top 1 t.opsdate from HeadCount t where t.EmployeeID = h.EmployeeID and t.EmpStatus='terminated' order by t.OpsDate desc
),'3000-01-01 00:00:00.000')  as TermDate

 FROM  HeadCount h 
 ) x where x.EmpStartDate<x.OpsDate and x.TermDate = '20180713'
