

-- Associative arrays (index-by-tables)
declare
type assoc_type is table of varchar2(200) index by pls_integer;
my_assoc assoc_type;
name varchar2(55);
begin

    my_assoc(1) := 'milad';
    my_assoc(2) := 'rostami';
    my_assoc(3) := 'rostami';
    my_assoc(4) := 'rostami';
    my_assoc(5) := 'rostami';
    my_assoc(6) := 'rostami';
    my_assoc(7) := 'rostami';
    my_assoc(8) := 'rostami';

-- printing the table
    name := my_assoc.first;
    while name is not null loop
            dbms_output.put_line('my assoc' || 'is :' || name);
            name:= my_assoc.next(name);
end loop;

end;

-- example two for declare index-by-table collections in plsql in oracle

declare
type milad_collection is table of  pls_integer index by varchar2(43);
    rostami_type milad_collection;
    print_collection varchar2(43);

    begin
rostami_type('ali') := 20;
rostami_type('milad') := 19;
rostami_type('sara') := 14;

print_collection:= rostami_type.FIRST;
while print_collection is not null loop
    DBMS_OUTPUT.PUT_LINE('name:' || print_collection || ' ' || 'value :' || rostami_type(print_collection));
    print_collection:=rostami_type.NEXT(print_collection);

    end loop;

end;



-- example three for index-by-table :
--Management of website page views (Page Views)
DECLARE
    TYPE page_views_type IS TABLE OF PLS_INTEGER INDEX BY VARCHAR2(100);
    page_views page_views_type;
    v_url VARCHAR2(100);
BEGIN
    -- Add page visit information
 page_views('/home') := 150;
    page_views('/about') := 95;
    page_views('/contact') := 60;

    -- Browse and display the visit information of each page
    v_url := page_views.FIRST;
    WHILE v_url IS NOT NULL LOOP
            DBMS_OUTPUT.PUT_LINE('URL: ' || v_url || ' , Views: ' || page_views(v_url));
            v_url := page_views.NEXT(v_url);
        END LOOP;

    -- Add or update page views
    IF page_views.EXISTS('/home') THEN
        page_views('/home') := page_views('/home') + 1; -- Increase home page visits
    ELSE
        page_views('/home') := 1; -- First visit
    END IF;

    -- Display updated hit count
    DBMS_OUTPUT.PUT_LINE('Updated Views for /home: ' || page_views('/home'));
END;








-- nested tables collection
-- example one for nested tables
DECLARE
    TYPE nested_table_type IS TABLE OF VARCHAR2(100);
    my_table nested_table_type := nested_table_type();
BEGIN
    my_table.EXTEND;
    my_table(1) := 'First Value';
    my_table.EXTEND;
     my_table(2) := 'Two Value';
    my_table.EXTEND(4);
 my_table(3) := 'Three Value';
    my_table(4) := 'Four Value';
    my_table(5) := 'Five Value';
    my_table(6) := 'Five Value';
END;


-- example two for nested tables
--  customers orders management

DECLARE
    TYPE order_type IS RECORD (
                                  order_id PLS_INTEGER,
                                  product_name VARCHAR2(100),
                                  quantity PLS_INTEGER
                              );

    TYPE orders_table IS TABLE OF order_type;

    TYPE customer_orders_type IS TABLE OF orders_table INDEX BY VARCHAR2(100);

    customer_orders customer_orders_type;
    v_customer VARCHAR2(100);
    v_orders orders_table;

BEGIN
    -- Add orders for customers
 customer_orders('Milad') := orders_table(order_type(1, 'Laptop', 2), order_type(2, 'Mouse', 3));
    customer_orders('Sara') := orders_table(order_type(3, 'Keyboard', 1), order_type(4, 'Monitor', 1));

    -- Display the orders of each customer
    v_customer := customer_orders.FIRST;
    WHILE v_customer IS NOT NULL LOOP
            DBMS_OUTPUT.PUT_LINE('Customer: ' || v_customer);

            v_orders := customer_orders(v_customer);

            FOR i IN 1..v_orders.COUNT LOOP
                    DBMS_OUTPUT.PUT_LINE('Order ID: ' || v_orders(i).order_id || ', Product: ' || v_orders(i).product_name || ', Quantity: ' || v_orders(i).quantity);
                END LOOP;

            v_customer := customer_orders.NEXT(v_customer);
        END LOOP;
END;







-- varray collections
-- example one for varray

DECLARE
    TYPE varray_type IS VARRAY(10) OF VARCHAR2(50);
    my_varray varray_type := varray_type('Value 1', 'Value 2','Value 3','Value 4'
                             ,'Value 5','Value 6','Value 7','Value 8','Value 9',
                                         'Value 10');
BEGIN
    DBMS_OUTPUT.PUT_LINE(my_varray(1)); -- Output: Value 1
    DBMS_OUTPUT.PUT_LINE(my_varray(2));
    DBMS_OUTPUT.PUT_LINE(my_varray(3));
END;

-- example two for varray
--Manage users' favorites list
DECLARE
    TYPE favorite_products_varray IS VARRAY(5) OF VARCHAR2(100);

    TYPE user_favorites_type IS TABLE OF favorite_products_varray INDEX BY VARCHAR2(100);

    user_favorites user_favorites_type;
    v_user VARCHAR2(100);
    v_favorites favorite_products_varray;

BEGIN
    -- Add favorites for users
    user_favorites('Ali') := favorite_products_varray('Laptop', 'Mouse', 'Monitor');
    user_favorites('Sara') := favorite_products_varray('Keyboard', 'Headphones');

    -- Display the list of favorites
    v_user := user_favorites.FIRST;
    WHILE v_user IS NOT NULL LOOP
            DBMS_OUTPUT.PUT_LINE('User: ' || v_user || ' Favorites:');

            v_favorites := user_favorites(v_user);

            FOR i IN 1..v_favorites.COUNT LOOP
                    DBMS_OUTPUT.PUT_LINE(' - ' || v_favorites(i));
                END LOOP;

            v_user := user_favorites.NEXT(v_user);
        END LOOP;

    -- Add new product to wish list (if possible)
    IF user_favorites('Ali').COUNT < 5 THEN
        user_favorites('Ali').EXTEND;
                user_favorites('Ali')(user_favorites('Ali').COUNT) := 'Smartphone';
        DBMS_OUTPUT.PUT_LINE('Smartphone added to Ali'' s favorites.');
 ELSE
 DBMS_OUTPUT.PUT_LINE('Ali''s favorites list is full.');
    END IF;
END;


