
CREATE VIEW users_info
AS 
SELECT 
c.id_user,
e.user,
np.cpf,
name,
street,
city,
state,
credit_limit,
c.date_updated,
c.date_register
FROM
users e
INNER JOIN natural_person np ON np.id_user = e.id
INNER JOIN customers c ON c.id_user = e.id;