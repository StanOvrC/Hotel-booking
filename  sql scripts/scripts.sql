CREATE TABLE rooms (
    id SERIAL PRIMARY KEY,
    number VARCHAR(50) NOT NULL,
    type VARCHAR(20) NOT NULL,
    price_per_night NUMERIC(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    description VARCHAR(500)
);


INSERT INTO rooms (number, type, price_per_night, status, description) VALUES
('101', 'SINGLE', 50.00, 'AVAILABLE', 'Single room on first floor'),
('102', 'DOUBLE', 80.00, 'AVAILABLE', 'Double room'),
('201', 'FAMILY', 120.00, 'BOOKED', 'Family room, second floor');


CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    role VARCHAR(20) NOT NULL
);


INSERT INTO users (username, password, email, role) VALUES
('ivan', '1234', 'ivan@mail.com', 'USER'),
('maria', 'abcd', 'maria@mail.com', 'MANAGER'),
('oleg', 'qwerty', 'oleg@mail.com', 'ADMIN');


CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    room_id INT REFERENCES rooms(id) ON DELETE CASCADE,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price NUMERIC(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL
);


INSERT INTO bookings (user_id, room_id, check_in_date, check_out_date, total_price, status) VALUES
(1, 1, '2025-11-10', '2025-11-12', 100.00, 'CONFIRMED'),
(2, 2, '2025-11-15', '2025-11-18', 240.00, 'PENDING'),
(3, 3, '2025-11-20', '2025-11-25', 600.00, 'CANCELLED');

