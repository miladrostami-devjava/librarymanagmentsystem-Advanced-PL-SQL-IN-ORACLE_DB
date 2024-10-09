
-- create object

create or replace type Complex as object (
                                             rpart real,
                                             ipart real,
                                             member function plus(x Complex) return Complex,
                                             member function less(x Complex) return Complex,
                                             member function times(x Complex) return Complex,
                                             member function divby ( x Complex) return Complex
                                         );

create type body Complex as
    member function plus(x Complex) return Complex is

    begin
        return Complex(rpart + x.rpart,ipart+ x.ipart);
    end plus;

    member function less(x Complex) return Complex is
    begin
        return Complex(rpart-x.rpart,ipart-x.ipart);
    end less;

    member function times(x Complex) return Complex is
    begin
        return Complex(rpart*x.rpart - ipart*x.ipart,rpart*x.rpart + ipart*x.ipart);
    end times;

    member function divby(x Complex) return Complex is
        z real := x.rpart**2 + x.ipart**2;
    begin
        return Complex((rpart*x.rpart + ipart*x.ipart)/z, (rpart*x.rpart - ipart*x.ipart)/z);
    end divby;

end;


-- create object address

create or replace type address as object (
                                             houre_no varchar2(50),
                                             street varchar2(45),
                                             city varchar2(50),
                                             state varchar2(76),
                                             pincode varchar2(200)
                                         );

declare
    residence address;
begin
    residence := address('Teh_433','daneshgar street 23sd','tehran','ghohak','23233223');
    dbms_output.put_line('houre_no' || ' ' || residence.houre_no);
    dbms_output.put_line('street' || ' ' ||  residence.street);
    dbms_output.put_line('city' || ' ' ||  residence.city);
    dbms_output.put_line('pincode' || ' ' ||  residence.pincode);
end;




