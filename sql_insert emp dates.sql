


insert into Humanresources.dbo.EmployeeDates (
EmployeeID,
EmployeeName,
HireDate,
TermDate)

SELECT
distinct 
a.ID as EmployeeID,
a.[Name] as EmployeeName,
(select top 1 c.applydate from usnewsdmartdg.[etime].[dbo].vw_ASSA_VP_OT_AMERISTAR c where c.ID=a.ID and c.Employee_status=a.Employee_status order by c.APPLYDATE asc)
 as HireDate,
(select top 1 b.APPLYDATE from usnewsdmartdg.[etime].[dbo].vw_ASSA_VP_OT_AMERISTAR b where b.ID=a.ID and a.Employee_status=b.Employee_status order by b.APPLYDATE desc
) as TermDate
  FROM usnewsdmartdg.[etime].[dbo].[vw_ASSA_VP_OT_AMERISTAR] a
  where Employee_status = 'Terminated'

  union

  select 
  e.PERSONNUM as EmployeeID,
  e.PERSONFULLNAME as EmployeeName,
  e.BADGEEFFECTIVEDATE as HireDate,
  e.BADGEEXPIRATIONDATE as TermDate
  from usnewsdmartdg.[etime].[dbo].[vw_VP_EMPLOYEE_Ameristar] e