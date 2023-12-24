#Xây dựng data models cho Module Sales của Dataste Wide Word Importers dùng dbt 

Dataset : https://dataedo.com/samples/html2/WideWorldImporters/#/doc/d5/wideworldimporters

- Bước 1: setup dbt project 
- Bước 2: thiết kế diagram của các bảng cho dbt projects 
  - Folder analytics: các bảng sẽ được end users dùng để tạo dashboard, phục vụ cho mục đích analytics
  - Folder staging: các bảng dùng để tạo ra bảng trong folder analytics

  - Diagram của bảng được follow method Dimensional Modelling (star schema )
![datawarehouse course drawio](https://github.com/LeThiThuHang/project01_dbt/assets/7856528/6fe00475-bcb6-4af1-9122-5bbaef3daf51)

- Bước 3: modeling
  - Thiết kế các bảng fact và dimension trong Excel trước
  - Thiết kế các bảng với file sql
  - Chi tiết ở trong link này:
https://abyssinian-rice-cd0.notion.site/project1dbt-eabe6ddb7ac04873a930d2ea2ff115ee?pvs=4 
