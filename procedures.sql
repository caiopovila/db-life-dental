
DELIMITER $$

CREATE PROCEDURE register_user(
	IN v_user VARCHAR(100),
	IN v_password VARCHAR(100),
    IN v_name VARCHAR(255),
	IN v_street VARCHAR(255),
	IN v_city  VARCHAR(255),
	IN v_state  VARCHAR(2),
    IN v_cpf VARCHAR(14)
  )
BEGIN
  DECLARE l_user_id INT DEFAULT 0;
  DECLARE find_user INT DEFAULT 0;
  
  IF ((v_password != '') && (v_user != '') && (v_cpf != '')) THEN
  
	SELECT COUNT(*) INTO find_user FROM users WHERE user = v_user;
    
  IF find_user > 0 THEN
    SELECT 0 AS 'E';
	
    ELSE
    
      START TRANSACTION;
        
        INSERT INTO users (user, password) 
        VALUES (v_user, v_password);

		SET l_user_id = LAST_INSERT_ID();
        
        INSERT INTO customers (id_user, name, street, city, state, credit_limit, date_register) 
        VALUES (l_user_id, v_name, v_street, v_city, v_state, 50, NOW());
        
        INSERT INTO natural_person (id_user, cpf) 
        VALUE (l_user_id, v_cpf);
        
        SELECT id_user, name, credit_limit FROM customers WHERE id_user = l_user_id;
        
      COMMIT;
      
  END IF;
      
  ELSE
    SELECT 0 AS 'E';
  END IF;
END

$$


DELIMITER $$

CREATE PROCEDURE put_user(
	IN v_id INT,
	IN v_user VARCHAR(100),
	IN v_password VARCHAR(100),
    IN v_name VARCHAR(255),
	IN v_street VARCHAR(255),
	IN v_city  VARCHAR(255),
	IN v_state  VARCHAR(2),
    IN v_cpf VARCHAR(14),
    IN v_credit_limit  DECIMAL(10,2)
  )
BEGIN
  DECLARE find_user INT DEFAULT 0;
  
  IF ((v_id != '') && (v_user != '') && (v_cpf != '')) THEN
  
	  SELECT COUNT(*) INTO find_user FROM users WHERE user = v_user AND id <> v_id;
    
	  IF find_user > 0 THEN
	  
		SELECT 0 AS 'E';
		
		ELSE
  
		 IF (v_password != '') THEN
			  UPDATE users 
			  SET 
				user = v_user,
				password = v_password,
				date_updated = NOW()
			  WHERE id = v_id;
		  ELSE
			  UPDATE users 
			  SET 
				user = v_user,
				date_updated = NOW()
			  WHERE id = v_id;
		  END IF;       
          
          UPDATE `customers` SET `name` = v_name, `street` = v_street, `city` = v_city, `state` = v_state, `credit_limit` = v_credit_limit, date_updated = NOW() WHERE `id_user` = v_id;
          
          UPDATE `natural_person` SET `cpf` = v_cpf WHERE `id_user` = v_id;
          
  END IF;
          
  ELSE
    SELECT 0 AS 'E';
  END IF;
END

$$

DELIMITER $$

CREATE PROCEDURE put_product(
	  IN v_name VARCHAR(100),
	  IN v_amount INT,
	  IN v_price DECIMAL(10,2), 
	  IN v_id_categories INT,
	  IN v_id INT,
      IN v_id_user INT
  )
BEGIN
  IF ((v_name != '') && (v_price != '') && (v_id_categories != '') && (v_id != '') && (v_id_user != '')) THEN
  
           UPDATE products SET 
            name = v_name,
            amount = v_amount,
            price = v_price,
            id_categories = v_id_categories,
            date_updated = NOW()
			WHERE id = v_id AND id_user = v_id_user;
            
  ELSE
    SELECT 0 AS 'E';
  END IF;
END

$$

DELIMITER $$

CREATE PROCEDURE register_product(
  IN v_name VARCHAR(100),
  IN v_amount INT,
  IN v_price DECIMAL(10,2), 
  IN v_id_categories INT,
  IN v_id_user INT
  )
BEGIN
  IF ((v_name != '') && (v_price != '') && (v_id_categories != '') && (v_amount != '') && (v_id_user != '')) THEN
  
	INSERT INTO products (name, amount, price, id_categories, id_user, date_register) VALUES 
	(v_name, v_amount, v_price, v_id_categories, v_id_user, NOW());
    
  ELSE
    SELECT 0 AS 'E';
  END IF;
END

$$

DELIMITER ;;

CREATE PROCEDURE auth_user(
  IN v_user VARCHAR(100),
  IN v_password VARCHAR(100)
  )
BEGIN
  DECLARE x INT DEFAULT 0;

  IF ((v_user != '') && (v_password != '')) THEN
  
        SELECT COUNT(*) INTO x FROM users WHERE user = v_user AND password = v_password;
        
        IF x > 0 THEN
        
            SELECT id, user FROM users WHERE user = v_user AND password = v_password;
            
        ELSE
        
            SELECT 0 AS 'E';
            
        END IF;
        
    ELSE
  
    SELECT 0 AS 'E';    
  
  END IF;
  
END

;;


DELIMITER ;;

CREATE PROCEDURE del_product(
  IN v_id_user INT,
  IN v_id INT
  )
BEGIN
  DECLARE x INT DEFAULT 0;

  IF ((v_id_user != '') && (v_id != '')) THEN
  
	DELETE FROM `products` WHERE id_user = v_id_user AND id = v_id;

    ELSE
  
    SELECT 0 AS 'E';    
  
  END IF;
  
END

;;

DELIMITER ;;

CREATE PROCEDURE list_product(
  IN v_id_user INT,
  IN v_limit INT
  )
BEGIN

  IF ((v_id_user != '')) THEN
  
	SELECT  `id`, `name`, `amount`, `price`, `id_categories`, `id_user` FROM `products` WHERE id_user = v_id_user ORDER BY `id` DESC LIMIT v_limit;

    ELSE
  
    SELECT 0 AS 'E';    
  
  END IF;
  
END

;;

DELIMITER ;;

CREATE PROCEDURE get_product(
  IN v_id_user INT,
  IN v_id INT
  )
BEGIN

  IF ((v_id_user != '') && (v_id != '')) THEN
  
	SELECT `id`, `name`, `amount`, `price`, `id_categories`, `id_user` FROM `products` WHERE `id` = v_id AND `id_user` = v_id_user;

	ELSE
  
    SELECT 0 AS 'E';    
  
  END IF;
  
END

;;


DELIMITER ;;

CREATE PROCEDURE get_cpf(
  IN v_id_user INT
  )
BEGIN

  IF ((v_id_user != '')) THEN
  
	SELECT `id_user`, `cpf` FROM `natural_person` WHERE `id_user` = v_id_user;

	ELSE
  
    SELECT 0 AS 'E';    
  
  END IF;
  
END

;;


DELIMITER ;;

CREATE PROCEDURE get_user_info(
  IN v_id_user INT
  )
BEGIN

  IF ((v_id_user != '')) THEN
  
	SELECT * FROM `users_info` WHERE `id_user` = v_id_user;

	ELSE
  
    SELECT 0 AS 'E';    
  
  END IF;
  
END

;;

DELIMITER $$

CREATE PROCEDURE search_products(
    IN v_q CHAR(200),
    IN v_off INT,
    IN v_row INT
  )
BEGIN

  SELECT * FROM products WHERE MATCH(name) AGAINST(v_q IN BOOLEAN MODE) LIMIT v_off, v_row;

END

$$
