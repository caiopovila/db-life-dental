
INSERT INTO users (user, password) VALUES
('nicolas', 'nicolas'),
('caio', 'caio'),
('Augusto', 'Augusto'),
('Diogo', 'Diogo'),
('Sabrina', 'Sabrina'),
('Joaquim', 'Joaquim');

INSERT INTO customers (id_user, name, street, city, state, credit_limit) VALUES 
(1, 'Nicolas Diogo Cardoso', 'Acesso Um', 'Porto Alegre', 'RS', 475),
(2, 'Cecilia Olivia Rodrigues', 'Rua Sizuka Usuy', 'Cianorte', 'PR', 3170),
(3, 'Augusto Fernando Carlos Eduardo Cardoso', 'Rua Valdomiro Koerich', 'Palhoça', 'SC', 1067),
(4, 'Nicolas Diogo Cardoso', 'Acesso Um', 'Porto Alegre', 'RS', 475),
(5, 'Sabrina Heloisa Gabriela Barros', 'Rua Engenheiro Tito Marques Fernandes', 'Porto Alegre', 'RS', 4312),
(6, 'Joaquim Diego Lorenzo Araújo', 'Rua Vitorino', 'Novo Hamburgo', 'RS', 2314);

INSERT INTO natural_person (id_user, cpf) VALUES 
(6, '26774287840'),
(1, '97918477200'),
(2, '22222222222'),
(3, '33333333333'),
(4, '44444444444'),
(5, '55555555555');

INSERT INTO categories (name) VALUES
('Superior'),
('Super Luxury'),
('Modern'),
('Nerd'),
('Infantile'),
('Robust'),
('Wood');

INSERT INTO products (name, amount, price, id_categories, id_user) VALUES 
('Blue Chair', 30, 300.00, 7, 1),
('Red Chair', 200, 2150.00, 2, 2),
('Disney Wardrobe', 400, 829.50, 4, 3),
('Blue Toaster', 20, 9.90, 3, 4),
('Solar Panel', 30, 300.25, 4, 5);
