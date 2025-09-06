
alter table dbo.HR_Analytics
add attrition_value int;

update dbo.HR_Analytics set attrition_value = 
case 
when attrition = 'Yes' then 1
else 0
end from dbo.HR_Analytics

select * from dbo.HR_Analytics


alter table dbo.HR_Analytics drop column YearsWithCurrManager
-- checking of duplicate rows 
select empid,ROW_NUMBER() over (partition by empid order by empid) as num_rows
from dbo.HR_Analytics
order by 2 desc


select distinct * into dbo.HR2
from dbo.HR_Analytics

truncate table dbo.HR_analytics

insert into dbo.HR_Analytics select * from dbo.HR2;

drop table dbo.HR2

select empid,ROW_NUMBER() over (partition by empid order by empid) as num_rows
from dbo.HR_Analytics
order by 2 desc


select BusinessTravel  from dbo.HR_Analytics
group  by BusinessTravel

update dbo.HR_Analytics
set BusinessTravel='Travel_Rarely'
where BusinessTravel='TravelRarely'

select BusinessTravel  from dbo.HR_Analytics
group  by BusinessTravel


--Table for Attrition vs Age
drop view if exists AttVSAge

create view AttVSAge as(
select AgeGroup,sum(Attrition_value) as [number of employee attrited] ,count(agegroup)as [Employee count],(convert(float,sum(Attrition_value))/convert(float,count(AgeGroup)) )*100 as Attrition_percentage
from dbo.HR_Analytics
group by AgeGroup)

select * from AttVSAge

--Table for Attrition by department
drop view if exists AttVSDep

create view AttVSDep as
select Department,sum(Attrition_value) as [number of employee attrited] ,count(Department)as TotalEmployeePerDepartment,(convert(float,sum(Attrition_value))/convert(float,count(Department)) )*100 as Attrition_percentage
from dbo.HR_Analytics
group by Department

select * from AttVSDep

--Table for Attrition vs Educational field
drop view if exists AttVSEdu

create view AttVSEdu as
select EducationField,sum(Attrition_value) as [number of employee attrited] ,count(EducationField)as TotalEmployeePerEducation
,(convert(float,sum(Attrition_value))/convert(float,count(EducationField)) )*100 as Attrition_percentage
from dbo.HR_Analytics
group by EducationField

select * from AttVSEdu

--Table for Attrition vs Job role
drop view if exists AttVSJob

create view AttVSJob as
select JobRole,sum(Attrition_value) as [number of employee attrited] ,count(JobRole)as TotalEmployeePerJobrole
,(convert(float,sum(Attrition_value))/convert(float,count(JobRole)) )*100 as Attrition_percentage
from dbo.HR_Analytics
group by JobRole

select * from AttVSJob

--Table for Attrition vs Salary slab
drop view if exists AttVSSal

create view AttVSSal as
select SalarySlab,sum(Attrition_value) as [number of employee attrited] ,count(SalarySlab)as TotalEmployeePerSalarySlab
,(convert(float,sum(Attrition_value))/convert(float,count(SalarySlab)) )*100 as Attrition_percentage
from dbo.HR_Analytics
group by SalarySlab

select * from AttVSSal

--Table for Attrition vs Years at company
drop view if exists AttVSYrs

create view AttVSYrs as
select YearsAtCompany,sum(Attrition_value) as [number of employee attrited] ,count(YearsAtCompany)as TotalEmployeePerYearsAtCompany
,(convert(float,sum(Attrition_value))/convert(float,count(YearsAtCompany)) )*100 as Attrition_percentage
from dbo.HR_Analytics
group by YearsAtCompany

select * from AttVSYrs

--Table for Attrition by overtime
drop view if exists AttVSOverT

create view AttVSOverT as
select OverTime,sum(Attrition_value) as [number of employee attrited] ,count(OverTime)as TotalEmployeePerOverTime
,(convert(float,sum(Attrition_value))/convert(float,count(OverTime)) )*100 as Attrition_percentage
from dbo.HR_Analytics
group by OverTime

select * from AttVSOverT

--Table for Attrition vs Gender
drop view if exists AttVSGen

create view AttVSGen as
select gender,sum(Attrition_value) as [number of employee attrited] ,count(gender)as TotalEmployeePerGender
,(convert(float,sum(Attrition_value))/convert(float,count(Gender)) )*100 as Attrition_percentage
from dbo.HR_Analytics
group by Gender

select * from AttVSGen


with cte (AgeGroup,emp_attri,count_age)as(
select AgeGroup,sum(Attrition_value) as [emp_attri] ,count(agegroup)
from dbo.HR_Analytics
group by AgeGroup)
select *,(convert(float,emp_attri)/convert(float,count_age))*100
from cte
order by emp_attri desc
