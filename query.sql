show databases ;

CREATE DATABASE demo;

USE demo;

CREATE TABLE Products (
                          id int auto_increment primary key ,
                          productCode varchar(50),
                          productName varchar(50),
                          productPrice double,
                          productAmount int,
                          productDescription varchar(50),
                          productStatus bit
);

insert into products ( productCode, productName, productPrice, productAmount, productDescription, productStatus)
values ('001', 'A1', 50, 2, 'New', 1),
       ('002', 'A2', 45, 2, 'Old', 1),
       ('003', 'A3', 60, 2, 'New', 0),
       ('004', 'B1', 55, 2, 'New', 1),
       ('005', 'B2', 35, 2, 'Old', 0);

#3.1 Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
ALTER TABLE Products ADD UNIQUE INDEX productCode_index (productCode);

#3.2 Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
alter table Products
    add index index_productName_productPrice (productName, productPrice);

#Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
explain select * from products where productCode = '001';
explain select * from products where productName = 'A2';

# Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
CREATE VIEW products_view AS
select productCode, productName, productPrice, productStatus
from Products;

select *
from products_view;

# Tiến hành sửa đổi view

create or replace view products_view as
select productCode, productName
from Products;

select *
from demo.products_view;

# Tiến hành xoá view

drop view products_view;

# Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product

delimiter //

create procedure productsDetail ()
begin
select * from products;

end //
delimiter ;

call productsDetail();

# Tạo store procedure thêm một sản phẩm mới

delimiter //

create procedure addProduct (
    IN inputProductCode varchar(50),
    in inputProductName varchar(50)
)
begin
insert into products (productCode, productName)
values (inputProductCode, inputProductName);
end //
delimiter ;

call addProduct(005, 'B3');
select *
from products;

# Tạo store procedure sửa thông tin sản phẩm theo id

delimiter //
create procedure editProduct
(
    in searchProductID int,
    in newProductCode varchar(20),
    in newProductName varchar(50)

)
begin
update Products
set productCode = newProductCode,
    productName = newProductName
where Products.ID = searchProductID;
end
// delimiter ;

call editProduct(001, '008', 'B4');
select *
from products;

# Tạo store procedure xoá sản phẩm theo id

delimiter //
create procedure deleteProduct
(in searchProductID int)
begin
delete from Products
where ID = searchProductID;
end
// delimiter ;


call deleteProduct(1);

select *
from products;