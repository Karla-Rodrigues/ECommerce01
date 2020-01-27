/* Karla Rodrigues #300997958

/*  drop all tables */ 

DROP TABLE comm_category CASCADE CONSTRAINTS;
DROP TABLE comm_products CASCADE CONSTRAINTS;
DROP TABLE comm_prod_description CASCADE CONSTRAINTS;
DROP TABLE comm_prod_auditing CASCADE CONSTRAINTS;
DROP TABLE comm_customers CASCADE CONSTRAINTS;
DROP TABLE comm_cust_address CASCADE CONSTRAINTS;
DROP TABLE comm_order CASCADE CONSTRAINTS;
DROP TABLE comm_order_financial CASCADE CONSTRAINTS;
DROP TABLE comm_order_item CASCADE CONSTRAINTS;


/*  comm_category table */ 

CREATE TABLE comm_category
( cat_code#          CHAR    (8)PRIMARY KEY,
  cat_short          CHAR    (10),
  cat_long           VARCHAR2(20) );


/*  comm_products table */ 

CREATE TABLE comm_products
( pro_code#          NUMBER  (5,0)PRIMARY KEY,
  pro_category       CHAR    (8),
  CONSTRAINT comm_pro_category_fk FOREIGN KEY (pro_category)
  REFERENCES comm_category (cat_code#));


/*   comm_products_description table */ 

CREATE TABLE comm_prod_description
( prod_code#         NUMBER  (5)PRIMARY KEY,
  prod_short         CHAR    (10),
  prod_long          VARCHAR2(20),
  prod_colour        VARCHAR2(10),
  prod_height        NUMBER  (3,2),
  prod_width         NUMBER  (3,2),
  prod_length        NUMBER  (3,2));


/*  comm_products_auditing table */ 

CREATE TABLE comm_prod_auditing
( proa_code#         NUMBER  (5)PRIMARY KEY,
  proa_retail        NUMBER  (7,2),
  proa_cost          NUMBER  (7,2),
  proa_discount      NUMBER  (7,2),
  proa_stock         NUMBER  (5,0),
  proa_supplier      VARCHAR2(10));


/*  comm_customers table */ 

CREATE TABLE comm_customers
( cus_id#            NUMBER  (5)PRIMARY KEY,
  cus_email          VARCHAR2(30) UNIQUE,  
  cus_first_name     VARCHAR2(20),
  cus_last_name      VARCHAR2(20), 
  cus_phone          NUMBER  (10) );


/*  comm_cust_address table */ 
  
CREATE TABLE comm_cust_address  
( cusa_id#           NUMBER  (5),
  cusa_address#      NUMBER  (2),
  cusa_address_desc  VARCHAR2(15),
  cusa_principal     CHAR    (1),
  cusa_street        VARCHAR2(15),
  cusa_number        VARCHAR2(5),
  cusa_complement    VARCHAR2(5),
  cusa_city          VARCHAR2(20),
  cusa_province      CHAR    (2),
  cusa_postcode      VARCHAR2(10),
  CONSTRAINT comm_cust_address_pk PRIMARY KEY(cusa_id#, cusa_address#),
  CONSTRAINT comm_cust_address_principal  CHECK (cusa_principal IN ('Y','N')));


/*  comm_order table */ 

CREATE TABLE comm_order
( ord_code#          NUMBER(5) PRIMARY KEY,
  ord_customer       NUMBER(5),
  ord_address        NUMBER(2),
  CONSTRAINT comm_order_cust_fk FOREIGN KEY(ord_customer)
  REFERENCES comm_customers (cus_id#),
  CONSTRAINT comm_order_address_fk FOREIGN KEY   (ord_customer,   ord_address)  REFERENCES comm_cust_address (cusa_id#, cusa_address#));


 
/*  comm_order_financial table */ 
/*  OR - Order     PA - Pay    DE - Delivered    CA - Cancel */

CREATE TABLE comm_order_financial
( ordf_code#         NUMBER(5) PRIMARY KEY,
  ordf_customer      NUMBER(5),
  ordf_status        CHAR  (2),
  ordf_items         NUMBER(2),
  ordf_date_order    DATE,
  ordf_date_pay      DATE,
  ordf_date_delivery DATE,
  ordf_date_cancel   DATE, 
  CONSTRAINT comm_order_financial_fk FOREIGN KEY(ordf_customer)
  REFERENCES comm_customers (cus_id#),
  CONSTRAINT comm_order_status CHECK (ordf_status
 IN ('OR','PA','DE','CA')));



/*  comm_order_item table */ 

CREATE TABLE comm_order_item
( ordi_code#        NUMBER(5),
  ordi_item#        NUMBER(5),
  ordi_product      NUMBER(5),
  ordi_price        NUMBER(7,2),
  CONSTRAINT comm_order_item_pk PRIMARY KEY(ordi_code#, ordi_item#),
  CONSTRAINT comm_order_item_fk FOREIGN KEY(ordi_product)
  REFERENCES comm_products (pro_code#));

 

/* insert values to comm_category table */ 

INSERT INTO comm_category
VALUES ('HOME0001','Fur Garden','Furniture for Garden');

INSERT INTO comm_category
VALUES ('HOME0002','Kitchen','Kitchen Appliances');

INSERT INTO comm_category
VALUES ('KIDS0001','Sports','Sports and Games');

INSERT INTO comm_category
VALUES ('KIDS0002','Dolls','Dolls and acessories');

INSERT INTO comm_category
VALUES ('CAR 0001','Car Sport','Car Sportive acessor');

INSERT INTO comm_category
VALUES ('CAR 0002','Car Family','Car Family acessorie');

INSERT INTO comm_category
VALUES ('CHIL0001','Ch Cloths','Children Cloths');

INSERT INTO comm_category
VALUES ('CHIL0002','Ch Shoes','Children Shoes');

INSERT INTO comm_category
VALUES ('WOMA0001','Wo Cloths','Woman Cloths');

INSERT INTO comm_category
VALUES ('WOMA0002','Wo Shoes','Woman Shoes');



/* insert values to comm_products table */ 

INSERT INTO comm_products
VALUES (10001,'HOME0001');

INSERT INTO comm_products
VALUES (10002,'HOME0001');

INSERT INTO comm_products
VALUES (10003,'HOME0002');

INSERT INTO comm_products
VALUES (10004,'HOME0002');

INSERT INTO comm_products
VALUES (20001,'KIDS0001');

INSERT INTO comm_products
VALUES (20002,'KIDS0001');

INSERT INTO comm_products
VALUES (20003,'KIDS0002');

INSERT INTO comm_products
VALUES (20004,'KIDS0002');

INSERT INTO comm_products
VALUES (30001,'CAR 0001');

INSERT INTO comm_products
VALUES (30002,'CAR 0001');



/* insert values to comm_prod_description table */ 

INSERT INTO comm_prod_description
VALUES (10001,'flowers   ','flowers for spring  ',
        'pink      ',0.30,0.30,0.30);

INSERT INTO comm_prod_description
VALUES (10002,'chair     ','garden chair        ',
        'white     ',1.5,1.5,1.5);

INSERT INTO comm_prod_description
VALUES (10003,'plates    ','plates with flowers ',
        'blue      ',0.50,0.50,0.50);

INSERT INTO comm_prod_description
VALUES (10004,'potes     ','potes in plastic    ',
        'transparen',0.30,0.30,0.30);

INSERT INTO comm_prod_description
VALUES (20001,'balls     ','balls soccer        ',
        'white     ',0.40,0.40,0.40);

INSERT INTO comm_prod_description
VALUES (20002,'balls     ','balls basketball    ',
        'orange    ',0.50,0.50,0.50);

INSERT INTO comm_prod_description
VALUES (20003,'doll      ','doll baby           ',
        'pink      ',0.50,0.40,0.30);

INSERT INTO comm_prod_description
VALUES (20004,'ted bear  ','ted bear with navy  ',
        'brown     ',0.30,0.40,0.50);

INSERT INTO comm_prod_description
VALUES (30001,'tire      ','tire car sport      ',
        'black     ',0.60,0.60,0.60);

INSERT INTO comm_prod_description
VALUES (30002,'tire snow ','tire snow car sport ',
        'black     ',0.70,0.70,0.70);



/* insert values to comm_prod_auditing */ 

INSERT INTO comm_prod_auditing
VALUES (10001,1.99,0.99,0.00,
        599, 'Garden1010');

INSERT INTO comm_prod_auditing
VALUES (10002,14.99,7.59,1.99,
        76, 'Garden1010');

INSERT INTO comm_prod_auditing
VALUES (10003,3.99,1.99,0.99,
        678, 'plates0199');

INSERT INTO comm_prod_auditing
VALUES (10004,5.99,2.99,1.99,
        1234, 'plastic199');

INSERT INTO comm_prod_auditing
VALUES (20001,25.00,15.00,0.00,
        29, 'Balls00188');

INSERT INTO comm_prod_auditing
VALUES (20002,35.00,20.00,0.00,
        59, 'Balls00378');

INSERT INTO comm_prod_auditing
VALUES (20003,18.00,10.00,0.99,
        99, 'Dolly99011');

INSERT INTO comm_prod_auditing
VALUES (20004,10.99,5.99,0.00,
        99, 'Dolly99011');

INSERT INTO comm_prod_auditing
VALUES (30001,171.00,71.00,0.00,
        99, 'Cars 00199');

INSERT INTO comm_prod_auditing
VALUES (30002,172.00,72.00,0.00,            
        99, 'Cars 00199');



/* insert values to comm_customers table */ 

INSERT INTO comm_customers
VALUES (11,'smith@gmail.com',
        'Peter','Smith',1234567890);

INSERT INTO comm_customers
VALUES (12,'psantos@gmail.com',
        'Primo','Santos',1234567890);

INSERT INTO comm_customers
VALUES (13,'amanda@gmail.com',
        'Amanda','Alvares',1234567890);

INSERT INTO comm_customers
VALUES (14,'smaryann@gmail.com',
        'MaryAnn','Smith',1234567890);

INSERT INTO comm_customers
VALUES (15,'pp@gmail.com',
        'Peter','Peterson',1234567890);

INSERT INTO comm_customers
VALUES (21,'smithmichael@gmail.com',
        'Michael','Smith',1234567890);

INSERT INTO comm_customers
VALUES (22,'irene_stark@gmail.com',
        'Irene','Stark',1234567890);

INSERT INTO comm_customers
VALUES (23,'pedro9090@gmail.com',
        'Pedro','Alvares',1234567890);

INSERT INTO comm_customers
VALUES (24,'mary-peterson@gmail.com',
        'Mary','Peterson',1234567890);

INSERT INTO comm_customers
VALUES (25,'macfarllen@gmail.com',
        'Charlie','MacFarllen',1234567890);



/* insert values to comm_cust_address */ 

INSERT INTO comm_cust_address
VALUES (11,01,'my home  ','Y',
        'Green St       ','998  ','1212 ',
        'Toronto             ','ON',
        'M5S-1G5   ');

INSERT INTO comm_cust_address
VALUES (12,01,'office   ','Y',
        'Front Street   ','300  ','2134 ',
        'Toronto             ','ON',
        'M8S-1G8   ');

INSERT INTO comm_cust_address
VALUES (13,01,'mum house ','Y',
        'Progress Av    ','1234 ','     ',
        'Toronto             ','ON',
        'M5T-1G5   ');

INSERT INTO comm_cust_address
VALUES (14,01,'mum house ','Y',
        'Progress Av    ','1344 ','23   ',
        'Toronto             ','ON',
        'M5T-1G5   ');

INSERT INTO comm_cust_address
VALUES (15,01,'house     ','Y',
        'Yonge          ','789  ','23   ',
        'Toronto             ','ON',
        'M9T-1G9   ');

INSERT INTO comm_cust_address
VALUES (21,01,'house     ','Y',
        'Yonge          ','76788','23   ',
        'Toronto             ','ON',
        'M1T-1G1   ');
INSERT INTO comm_cust_address
VALUES (21,02,'school    ','N',
        'Mont Pleasent  ','1234 ','Ro123',
        'Toronto             ','ON',
        'M6T-6G6   ');
INSERT INTO comm_cust_address
VALUES (21,03,'office    ','N',
        'Mont Pleasent  ','1299 ','     ',
        'Toronto             ','ON',
        'M4T-4G4   ');

INSERT INTO comm_cust_address
VALUES (22,01,'house     ','Y',
        'Mont Pleasent  ','123  ','123  ',
        'Toronto             ','ON',
        'M1T-1P1   ');

INSERT INTO comm_cust_address
VALUES (23,01,'apartment ','Y',
        'Hampton St     ','123  ','     ',
        'Toronto             ','ON',
        'M3T-3P7   ');

INSERT INTO comm_cust_address
VALUES (24,01,'apartment ','Y',
        'Acacia St      ','987  ','12A  ',
        'Toronto             ','ON',
        'M9T-9P7   ');

INSERT INTO comm_cust_address
VALUES (25,01,'home     ','Y',
        'Oliver Street  ','77   ','1511 ',
        'Toronto             ','ON',
        'M5S-1G5   ');
INSERT INTO comm_cust_address
VALUES (25,02,'office   ','N',
        'Front Ave      ','500  ','12A  ',
        'Toronto             ','ON',
        'M9S-9G5   ');



/* insert values to comm_order */ 

INSERT INTO comm_order
VALUES (02011,00011,1);

INSERT INTO comm_order
VALUES (02012,00012,1);

INSERT INTO comm_order
VALUES (02013,00013,1);

INSERT INTO comm_order
VALUES (02014,00014,1);

INSERT INTO comm_order
VALUES (02015,00014,1);

INSERT INTO comm_order
VALUES (02016,00014,1);

INSERT INTO comm_order
VALUES (03015,00015,1);

INSERT INTO comm_order
VALUES (03021,00021,1);

INSERT INTO comm_order
VALUES (03022,00021,2);

INSERT INTO comm_order
VALUES (03023,00021,3);

INSERT INTO comm_order
VALUES (05022,00022,1);

INSERT INTO comm_order
VALUES (05023,00023,1);

INSERT INTO comm_order
VALUES (05025,00023,1);

INSERT INTO comm_order
VALUES (06024,00024,1);

INSERT INTO comm_order
VALUES (01025,00025,1);

INSERT INTO comm_order
VALUES (01026,00025,2);



/* insert values to comm_order_financial */ 
/* Status: */
/* OR - order     PA - Pay    DE - Delivered    CA - Cancel */
 

INSERT INTO comm_order_financial
VALUES (2011,11,
	'OR',2,'19-04-01',NULL,NULL,NULL);

INSERT INTO comm_order_financial
VALUES (2012,12,
	'PA',1,'19-04-03','19-04-03',NULL,NULL);

INSERT INTO comm_order_financial
VALUES (2013,13,
	'OR',1,'19-04-01',NULL,NULL,NULL);

INSERT INTO comm_order_financial
VALUES (2014,14,
	'CA',1,'19-04-01',NULL,NULL,'19-04-02');

INSERT INTO comm_order_financial
VALUES (2015,14,
	'DE',1,'19-04-01','19-04-02','19-04-03',NULL);

INSERT INTO comm_order_financial
VALUES (2016,14,
	'DE',1,'19-04-04','19-04-05','19-04-06',NULL);

INSERT INTO comm_order_financial
VALUES (3015,15,
	'CA',1,'19-04-01',NULL,NULL,'19-04-05');

INSERT INTO comm_order_financial
VALUES (3021,21,
	'OR',1,'19-04-07',NULL,NULL,NULL);

INSERT INTO comm_order_financial
VALUES (5022,22,
	'DE',3,'19-04-07','19-04-07','19-04-09',NULL);

INSERT INTO comm_order_financial
VALUES (5023,23,
	'PA',1,'19-04-01','19-04-01',NULL,NULL);

INSERT INTO comm_order_financial
VALUES (5025,23,
	'PA',1,'19-04-01','19-04-07',NULL,NULL);

INSERT INTO comm_order_financial
VALUES (6024,24,
	'DE',1,'19-03-31','19-04-01','19-04-01',NULL);

INSERT INTO comm_order_financial
VALUES (1025,25,
	'CA',2,'19-04-01',NULL,NULL,'19-04-09');



/* insert values to comm_order_item */ 

INSERT INTO comm_order_item
VALUES (2011,1,10001,1.99);

INSERT INTO comm_order_item
VALUES (2011,2,10001,1.99);

INSERT INTO comm_order_item
VALUES (2012,1,30002,172.00);

INSERT INTO comm_order_item
VALUES (2013,1,20001,25.00);

INSERT INTO comm_order_item
VALUES (2014,1,10004,5.99);

INSERT INTO comm_order_item
VALUES (2015,1,10003,3.99);

INSERT INTO comm_order_item
VALUES (2016,1,10001,1.99);

INSERT INTO comm_order_item
VALUES (3015,1,10004,5.99);

INSERT INTO comm_order_item
VALUES (3021,1,30001,171.00);

INSERT INTO comm_order_item
VALUES (5022,1,20002,35.00);

INSERT INTO comm_order_item
VALUES (5022,2,20001,25.00);

INSERT INTO comm_order_item
VALUES (5022,3,20003,18.00);

INSERT INTO comm_order_item
VALUES (5023,1,10003,3.99);

INSERT INTO comm_order_item
VALUES (5025,1,30001,171.00);

INSERT INTO comm_order_item
VALUES (6024,1,20001,25.00);

INSERT INTO comm_order_item
VALUES (1025,1,20003,18.00);

INSERT INTO comm_order_item
VALUES (1025,2,20004,10.99);




/*QUERY 1* - Products information * */

SELECT * 
FROM   comm_products, comm_category, comm_prod_description
WHERE  pro_category = cat_code#
AND    pro_code#    = prod_code#;


/*QUERY 2* - Products stock information by supplier * */

SELECT proa_supplier, pro_code#, pro_category, prod_short, proa_stock
FROM comm_prod_auditing, comm_products, comm_prod_description
WHERE proa_code# = pro_code#
AND   prod_code# = pro_code#
ORDER BY proa_supplier;


/*QUERY 3* - Customers with focus on address * */

SELECT cusa_id#, cus_first_name, cus_last_name,
       cusa_address#, cusa_address_desc, cusa_principal,
       cusa_street, cusa_postcode 
FROM comm_cust_address, comm_customers
WHERE cusa_id# = cus_id#
ORDER BY cusa_id#, cusa_address#;

 
/*QUERY 4* - Orders with customer's information + address * */

SELECT ord_code#, cus_id#, cus_first_name, cus_last_name, cus_email,
       ord_address, cusa_address_desc
FROM comm_customers,comm_order, comm_cust_address
WHERE cus_id#       = ord_customer
AND   ord_customer = cusa_id#
AND   ord_address  = cusa_address#
ORDER BY ord_code#;


/*QUERY 5* - Orders with customer's information + financial * */

SELECT ord_code#, ord_customer,
       cus_first_name, cus_last_name,
       cus_email, ord_address,
       ordf_status, ordf_items
FROM comm_order, comm_customers, comm_order_financial
WHERE ord_code# = ordf_code#
AND   cus_id#   = ord_customer;


/*QUERY 6* - Orders items + customer           */ 
/*         + financial    + prod description * */

SELECT ord_code#, ord_customer, cus_email, 
       ordf_status, ordf_items,
       ordi_item#, ordi_product,
       prod_long
FROM comm_order, comm_customers, 
     comm_order_financial, comm_order_item,
     comm_prod_description
WHERE ord_customer = cus_id#  
AND   ord_code# = ordf_code#
AND   ord_code# = ordi_code#
AND   ordi_product = prod_code#
ORDER BY ord_code#;


/*QUERY 7* - Customers with focus on order status (financial) */

SELECT cus_id#, cus_first_name, cus_last_name, cus_email,
       ordf_status, ordf_items
FROM comm_customers,comm_order, comm_order_financial
WHERE cus_id# = ord_customer
AND   cus_id# = ordf_customer;
  