
with dt as (
select distinct
a.EmployeeID,
a.EmployeeName,
case when a.empstartdate is null then (select top 1 h.OpsDate from HeadCount h where h.EmployeeID=a.EmployeeID order by a.OpsDate asc) else a.EmpStartDate end as EmpStartDate,
case when a.EmpStatus = 'terminated' then 
	(select top 1 t.OpsDate from HeadCount t where t.EmployeeID=a.EmployeeID order by t.OpsDate desc)
	 else '30000101' end as EmpEndDate
from HeadCount a)

select distinct
h.EmployeeID,
h.EmployeeName,

h.DepartmentID,
h.OpsDate,

d.EmpStartDate,
d.EmpEndDate,
case when h.OpsDate=d.EmpStartDate then 1 else 0 end as HireDay,
case when h.OpsDate=d.EmpEndDate then 1 else 0 end as TermDay,
datediff(d,d.empstartdate,h.opsdate)/365.0 as Tenure
from HeadCount h left join dt d on d.EmployeeID=h.EmployeeID
