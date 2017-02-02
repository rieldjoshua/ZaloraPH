Select A.Employee_id as"Employee Id",A.Absence_plan ,A.End_bal ,(A.End_bal-A.Accrued-A.used) as "Carry Over"
,A.used as "Leave Taken",A.Accrued as "Yearly Accrual" ,B.FULL_NAME FROM
(Select (Select name from ANC_ABSENCE_PLANS_F_TL ap where ap.absence_plan_id=pa.Plan_id and :D
 between effective_start_date and effective_end_date and language='US') Absence_plan,
 (Select pf.Person_number
 from per_all_people_f pf where pf.Person_id=PA.person_id and 
 :D between effective_start_date and Effective_end_date) Employee_id, End_bal,person_id,Accrued,used from ANC_PER_ACCRUAL_ENTRIES PA 
where PER_ACCRUAL_ENTRY_ID in ( Select  max(PER_ACCRUAL_ENTRY_ID) from ANC_PER_ACCRUAL_ENTRIES Pb where Accrual_period= :D group by Plan_id,person_id   )) A ,PER_PERSON_NAMES_F B, PER_ALL_ASSIGNMENTS_M J
Where 
J.PRIMARY_ASSIGNMENT_FLAG = 'Y'
AND J.ASSIGNMENT_STATUS_TYPE='ACTIVE'
AND J.EFFECTIVE_START_DATE =(SELECT MAX(B.EFFECTIVE_START_DATE) FROM PER_ALL_ASSIGNMENTS_M B  WHERE B.PERSON_ID= J.PERSON_ID AND B.EFFECTIVE_START_DATE <= :D)
AND J.EFFECTIVE_SEQUENCE = (select MAX(B1.EFFECTIVE_SEQUENCE) from PER_ALL_ASSIGNMENTS_M B1 WHERE B1.PERSON_ID = J.PERSON_ID and B1.BUSINESS_GROUP_ID =  
J.BUSINESS_GROUP_ID AND B1.EFFECTIVE_START_DATE = J.EFFECTIVE_START_DATE)
AND J.person_id=A.Person_id

AND A.person_id=B.Person_id
AND :D Between B.Effective_start_date and B.Effective_end_date
AND name_type='GLOBAL'
AND A.Absence_plan in(:Leave_Plan)