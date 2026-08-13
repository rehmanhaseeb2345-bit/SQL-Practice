 CREATE TABLE photos (
	id SERIAL PRIMARY KEY,
	url VARCHAR(200),
	user_id INTEGER REFERENCES users(id)
 );

INSERT INTO photos (url, user_id)
VALUES
	('http;//Img1', 1),
	('http;//Img1', 1),
	('http;//Img3', 3),
	('http;//Img2', 2),
	('http;//Img3', 3),
	('http;//Img4', 4)