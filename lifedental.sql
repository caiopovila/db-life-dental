CREATE DATABASE IF NOT EXISTS lifeDental;
USE lifeDental;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  user VARCHAR(100) NOT NULL,
  password VARCHAR(100) NOT NULL,
  date_updated DATETIME
);

CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  name VARCHAR(100) NOT NULL,
  date_register DATETIME,
  date_updated DATETIME
);

CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  name VARCHAR(100) NOT NULL,
  amount INT NOT NULL,
  price DECIMAL(10,2) NOT NULL, 
  id_categories INT,
  id_user INT NOT NULL,
  date_register DATETIME,
  date_updated DATETIME,

      CONSTRAINT cateProdFk
      FOREIGN KEY (id_categories) REFERENCES categories(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
        
      CONSTRAINT userProdFk
      FOREIGN KEY (id_user) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FULLTEXT (name)
);

CREATE TABLE IF NOT EXISTS customers (
  id_user INT PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  street VARCHAR(255) NOT NULL,
  city  VARCHAR(255) NOT NULL,
  state  VARCHAR(2) NOT NULL,
  credit_limit DECIMAL(10,2),
  date_updated DATETIME,
  date_register DATETIME,
  
      CONSTRAINT userCustomersfk
      FOREIGN KEY (id_user) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS natural_person (
  id_user INT PRIMARY KEY NOT NULL,
  cpf VARCHAR(14) NOT NULL,

      CONSTRAINT customersfk
      FOREIGN KEY (id_user) REFERENCES customers(id_user)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS sales (
  id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_user INT,
  date_register DATETIME,

      CONSTRAINT userSalesfk
      FOREIGN KEY (id_user) REFERENCES users(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS productsSale (
  id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_sale INT NOT NULL,
  id_product INT NOT NULL,

      CONSTRAINT userSalesProdfk
      FOREIGN KEY (id_sale) REFERENCES sales(id)
        ON DELETE cascade
        ON UPDATE CASCADE,
        
      CONSTRAINT prodSalesfk
      FOREIGN KEY (id_product) REFERENCES products(id)
        ON DELETE cascade
        ON UPDATE CASCADE
);