-- USERS (create first, others depend on it)
CREATE TABLE users (
  id       SERIAL PRIMARY KEY,
  username VARCHAR(40) NOT NULL
);


-- PHOTOS (depends on users)
CREATE TABLE photos (
  id      SERIAL PRIMARY KEY,
  url     VARCHAR(100) NOT NULL,
  user_id INT REFERENCES users(id)
);


-- COMMENTS (depends on both users and photos)
CREATE TABLE comments (
  id       SERIAL PRIMARY KEY,
  photo_id INT REFERENCES photos(id),
  content  VARCHAR(240) NOT NULL,
  user_id  INT REFERENCES users(id)
);


-- --------------------------------
-- DUMMY DATA
-- --------------------------------

INSERT INTO users (id, username) VALUES
(1, 'alex_smith'),
(2, 'sara_jones'),
(3, 'mike_dev'),
(4, 'priya_k'),
(5, 'dan_codes');

INSERT INTO photos (id, url, user_id) VALUES
(1, 'https://images.com/sunset.jpg',      1),
(2, 'https://images.com/mountains.jpg',   1),
(3, 'https://images.com/city_night.jpg',  2),
(4, 'https://images.com/beach.jpg',       3),
(5, 'https://images.com/forest.jpg',      3),
(6, 'https://images.com/coffee.jpg',      4),
(7, 'https://images.com/desk_setup.jpg',  5),
(8, 'https://images.com/road_trip.jpg',   2);

INSERT INTO comments (id, photo_id, content, user_id) VALUES
(1,  1, 'Beautiful shot!',             2),
(2,  1, 'Love the colors here',        3),
(3,  2, 'Where is this place?',        4),
(4,  2, 'Stunning view!',              5),
(5,  3, 'Great night photography',     1),
(6,  4, 'I need to visit this beach',  2),
(7,  4, 'Perfect weather that day',    3),
(8,  5, 'So peaceful looking',         4),
(9,  6, 'What coffee is that?',        1),
(10, 7, 'Clean setup bro',             3),
(11, 7, 'What monitor is that?',       2),
(12, 8, 'Road trips are the best',     4);