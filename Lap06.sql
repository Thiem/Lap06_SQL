IF EXISTS (SELECT * FROM sys.databases WHERE Name= 'QLBanHang')
DROP DATABASE QLBanHang
GO
CREATE DATABASE QLBanHang
GO
USE QLBanHang
GO
CREATE TABLE Customer
(
	CustomerID CHAR(10) NOT NULL,
	Name NVARCHAR(50),
	[Address] NVARCHAR(50),
	PhoneNumber bigint NOT NULL,
	CONSTRAINT PK_CustomerID PRIMARY KEY (CustomerID)
)

CREATE TABLE [Order]
(
	OrderID CHAR(10) NOT NULL,
	CustomerID CHAR(10) NOT NULL,
	DateOrder DATETIME,
	[Status] INT,
	CONSTRAINT fk_CusID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	CONSTRAINT PK_OrderID PRIMARY KEY (OrderID)
)

CREATE TABLE Category
(
	CatID CHAR(10) NOT NULL,
	Name NVARCHAR(100),
	CONSTRAINT PK PRIMARY KEY (CatID)
)

CREATE TABLE Product
(
	ProductID CHAR(10) NOT NULL,
	CatID CHAR(10) NOT NULL,
	Name NVARCHAR(50),
	Unit VARCHAR(10),
	Price FLOAT,
	[Description] NVARCHAR(100),
	SoLuong INT,
	CONSTRAINT fk_CatID FOREIGN KEY (CatID) REFERENCES Category(CatID),
	CONSTRAINT PK_ProducID PRIMARY KEY (ProductID)
)

CREATE TABLE OrderDetail
(
	OrderDetailID CHAR(10) NOT NULL,
	ProductID CHAR(10) NOT NULL,
	OrderID CHAR(10) NOT NULL,
	Price FLOAT,
	SoLuong CHAR(10),
	CONSTRAINT fk_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	CONSTRAINT fk_Order FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
	CONSTRAINT PK_OrderDetailID PRIMARY KEY (OrderDetailID)
)
INSERT INTO Category
VALUES(1,'Dien thoai'),(2,'May Tinh'),(3,'May In')

INSERT INTO Product
VALUES(1,1,'Nokia 5670','Chiec',200,'Dien thoai dang hot',100),
(2,2,'May Tinh T450','Chiec',1000,'May nhap moi',50),
(3,3,'May In SamSung 450','Chiec',100,'May in dang e',150)

INSERT INTO Customer
VALUES(1,'Nguyen Van An','111 Nguyen Trai, Thanh Xuan, Ha noi',987654321),
(2,'Tran Thi Hoa','23 Cau Giay, Ha Noi',123321123),
(3,'Nguyen Van Nam','69 Kim Ma, Ba Dinh, Ha Noi',9898767689),
(4,'Tran Van Toan','Son Tay, Ha Noi', 9235445386),
(5,'Bui Thi Xuan','Tay Do, Hung Ha, Thai Binh',9048462334)

INSERT INTO [Order]
VALUES(123,1,'2017-08-13',1)

ALTER TABLE OrderDetail
   ADD ThanhTien FLOAT(10);

INSERT INTO OrderDetail
VALUES(1,1,123,1000,1,1000),
(2,2,123,200,2,400),
(3,3,123,100,1,100)

--a) Liệt kê danh sách khách hàng đã mua hàng ở cửa hàng.
SELECT * FROM Customer INNER JOIN [Order] ON Customer.CustomerID = [Order].CustomerID

--b) Liệt kê danh sách sản phẩm của của hàng
SELECT * FROM Product

--c) Liệt kê danh sách các đơn đặt hàng của cửa hàng.
SELECT * FROM OrderDetail

--a) Liệt kê danh sách khách hàng theo thứ thự alphabet.
SELECT * FROM Customer
ORDER BY Name ASC

--b) Liệt kê danh sách sản phẩm của cửa hàng theo thứ thự giá giảm dần.
SELECT * FROM Product
ORDER BY Price DESC

--c) Liệt kê các sản phẩm mà khách hàng Nguyễn Văn An đã mua.
SELECT  FROM OrderDetail INNER JOIN Product ON OrderDetail.ProductID = Product.ProductID
WHERE 