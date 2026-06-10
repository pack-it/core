CREATE TABLE people (
    id INTEGER PRIMARY KEY,
    name TEXT,
    age INTEGER,
    location TEXT
);

INSERT INTO people (name, age, location) VALUES
('Eve', 17, 'Rust, Germany'),
('Bob', 10, 'Charlotte, North Carolina'),
('Linus', 20, 'Shellingford, UK'),
('Bob', 25, 'Dublin, Ireland (Somewhere in a pub)');

SELECT id, name, age
FROM people
ORDER BY name ASC, age DESC;
