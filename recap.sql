/*
Foundation Recap Exercise
 
Use the table PatientStay.  
This lists 44 patients admitted to London hospitals over 5 days between Feb 26th and March 2nd 2024
*/
 
--SELECT
--    *
--FROM
--    PatientStay ps ;
 
/*
1. List the patients -
a) in the Oxleas or PRUH hospitals and
b) admitted in February 2024
c) only the Surgery wards
 
2. Show the PatientId, AdmittedDate, DischargeDate, Hospital and Ward columns only, not all the columns.
3. Order results by AdmittedDate (latest first) then PatientID column (high to low)
4. Add a new column LengthOfStay which calculates the number of days that the patient stayed in hospital, inclusive of both admitted and discharge date.
*/
 
--SELECT
--    ps.PatientId, ps.AdmittedDate, ps.DischargeDate, ps.Hospital, ps.Ward, DATEDIFF(day,ps.AdmittedDate,ps.DischargeDate)+1 as 'LengthOfStay', DATEADD(week,-2,ps.AdmittedDate) AS 'ReminderDate'
--FROM
--    PatientStay ps 
--    where ps.Hospital in ('oxleas', 'pruh')
 --   and ps.AdmittedDate between '2024-02-01' and '2024-02-29'
 --   and ps.ward like '%surgery'
 --   order by ps.AdmittedDate desc, ps.PatientID desc
 --   ;
 
 
/*
5. How many patients has each hospital admitted?
6. How much is the total tarriff for each hospital?
7. List only those hospitals that have admitted over 10 patients
8. Order by the hospital with most admissions first
*/
 
--SELECT
--    ps.hospital, count(*) as 'NumberOfPatients', sum(ps.Tariff) as 'TotalTariff'
--FROM
    --PatientStay ps 
    
    select ps.PatientId,ps.Hospital,h.[Type],h.[Size], h.Reach,ps.ward, ps.tariff, ps.AdmittedDate, ps.DischargeDate from patientstay ps
left join DimHospitalbad h on ps.Hospital = h.Hospital
    where h.type = 'Teaching'
    or h.type is null;