CREATE TABLE SALESMAN (
SALESMAN_ID VARCHAR(4) PRIMARY KEY,
NAME VARCHAR(20),
CITY VARCHAR(20),
COMMISSION VARCHAR(20));

CREATE TABLE CUSTOMER (
CUSTOMER_ID VARCHAR(5) PRIMARY KEY,
CUST_NAME VARCHAR(20),
CITY VARCHAR(20),
GRADE VARCHAR(4),
SALESMAN_ID VARCHAR(6),
FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN (SALESMAN_ID) ON DELETE SET NULL);

CREATE TABLE ORDERS (
ORD_NO VARCHAR(5) PRIMARY KEY,
PURCHASE_AMT VARCHAR(10),
ORD_DATE DATE,
CUSTOMER_ID VARCHAR(4),
SALESMAN_ID VARCHAR(4),
FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID) ON DELETE CASCADE,
FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN (SALESMAN_ID) ON DELETE CASCADE);

INSERT INTO SALESMAN VALUES(101,'RICHARD','LOS ANGELES','18%');
INSERT INTO SALESMAN VALUES(103,'GEORGE','NEWYORK','32%');
INSERT INTO SALESMAN VALUES(110,'CHARLES','BANGALORE','54%');
INSERT INTO SALESMAN VALUES(122,'ROWLING','PHILADELPHIA','46%');
INSERT INTO SALESMAN VALUES(126,'KURT','CHICAGO','52%');
INSERT INTO SALESMAN VALUES(132,'EDWIN','PHOENIX','41%');

INSERT INTO CUSTOMER VALUES('501','SMITH','LOS ANGELES','10','103');
INSERT INTO CUSTOMER VALUES('510','BROWN','ATLANTA','14','122');
INSERT INTO CUSTOMER VALUES('522','LEWIS','BANGALORE','10','132');
INSERT INTO CUSTOMER VALUES('534','PHILIPS','BOSTON','17','103');
INSERT INTO CUSTOMER VALUES('543','EDWARD','BANGALORE','14','110');
INSERT INTO CUSTOMER VALUES('550','PARKER','ATLANTA','19','126');

INSERT INTO ORDERS VALUES('1','1000', '05-04-2017','501','103');
INSERT INTO ORDERS VALUES('2','4000','01-20-2017','522','132');
INSERT INTO ORDERS VALUES('3','2500', '02-24-2017','550','126');
INSERT INTO ORDERS VALUES('5','6000','04-13-2017','522','103');
INSERT INTO ORDERS VALUES('6','7000', '03-092017','550','126');
INSERT INTO ORDERS VALUES ('7','3400','01-20-2017','501','122');

SELECT GRADE, COUNT (CUSTOMER_ID) FROM
CUSTOMER GROUP BY GRADE
HAVING GRADE > (SELECT AVG (GRADE) FROM
CUSTOMER WHERE CITY='BANGALORE');

SELECT SALESMAN_ID,NAME
FROM SALESMAN A
WHERE 1 <(SELECT COUNT(*) FROM CUSTOMER
WHERE SALESMAN_ID=A.SALESMAN_ID);

SELECT S.SALESMAN_ID,NAME,CUST_NAME,COMMISSION FROM SALESMAN
S,CUSTOMER C WHERE S.CITY = C.CITY
UNION
SELECT SALESMAN_ID, NAME, 'NO MATCH',COMMISSION FROM SALESMAN
WHERE NOT CITY = ANY (SELECT CITY
FROM CUSTOMER) ORDER BY 2 DESC;

CREATE VIEW VW_ELITSALESMAN AS
SELECT B.ORD_DATE,A.SALESMAN_ID,A.NAME FROM SALESMAN A, ORDERS B
WHERE A.SALESMAN_ID = B.SALESMAN_ID AND B.PURCHASE_AMT=(SELECT
MAX(PURCHASE_AMT) FROM ORDERS C
WHERE C.ORD_DATE = B.ORD_DATE);

SELECT * FROM VW_ELITSALESMAN;

DELETE FROM SALESMAN WHERE SALESMAN_ID=101;




