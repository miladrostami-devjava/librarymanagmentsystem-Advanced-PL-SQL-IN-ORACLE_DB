select * from dual;

-- inner join
select * from
             regions r1 inner join COUNTRIES c1 on
                 r1.REGION_ID = c1.REGION_ID;

-- left join
select * from REGIONS r left join COUNTRIES c
on  r.REGION_ID = c.REGION_ID;


-- right join
select * from REGIONS r right join COUNTRIES c
                                  on  r.REGION_ID = c.REGION_ID;


-- left join with null checks:
select * from REGIONS r
left join COUNTRIES c on r.REGION_ID= c.REGION_ID
where c.REGION_ID is null ;


-- right join with null checks:
select * from REGIONS r
                  right join  COUNTRIES c on r.REGION_ID= c.REGION_ID
where r.REGION_ID is null ;


-- full join
select * from REGIONS r full outer join COUNTRIES c
on r.REGION_ID= c.REGION_ID;

--full join with null checks
select * from REGIONS r full outer join COUNTRIES c
on r.REGION_ID=c.REGION_ID where r.REGION_ID is null  or c.REGION_ID is null ;

