use ecommerce;

CREATE TABLE users(
user_id INT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50),
email VARCHAR(50),
phone BIGINT NOT NULL,
gender VARCHAR(10)
);

CREATE TABLE auth (
  auth_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  username VARCHAR(50) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE sessions (
  session_id VARCHAR(255) PRIMARY KEY,
  user_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  expires_at DATETIME,
  user_agent VARCHAR(255),
  ip_address VARCHAR(45),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE refresh_tokens (
  token_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  refresh_token TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  expires_at DATETIME,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE categories(
category_id INT PRIMARY KEY,
category_name VARCHAR(50) NOT NULL,
url VARCHAR(70) UNIQUE NOT NULL
);

CREATE TABLE products(
product_id INT PRIMARY KEY,
product_name VARCHAR(40) NOT NULL,
product_description VARCHAR(255),
category_id INT NOT NULL,
FOREIGN KEY (category_id) references categories(category_id)
);

CREATE TABLE variant(
variant_id INT PRIMARY KEY,
product_id INT NOT NULL,
color VARCHAR(20) NOT NULL,
price FLOAT NOT NULL,
stock_quantity INT DEFAULT 0,
FOREIGN KEY (product_id) references products(product_id)
);

CREATE TABLE carts(
cart_id INT PRIMARY KEY,
user_id INT NOT NULL,
FOREIGN KEY(user_id) references users(user_id)
);

CREATE TABLE cart_items(
cart_items_id INT PRIMARY KEY,
cart_id INT NOT NULL,
product_id INT NOT NULL,
variant_id INT NOT NULL,
FOREIGN KEY(cart_id) references carts(cart_id),
FOREIGN KEY(product_id) references products(product_id),
FOREIGN KEY(variant_id) references variant(variant_id)
);

CREATE TABLE orders(
order_id INT PRIMARY KEY,
user_id INT NOT NULL,
order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
total_amount FLOAT NOT NULL,
shipping_amount FLOAT NOT NULL,
order_status VARCHAR(20) CHECK (order_status IN('placed','ongoing','cancelled','delivered')),
payment_status VARCHAR(20) CHECK (payment_status IN('paid','not paid','refunded')),
payment_type VARCHAR(20) CHECK (payment_type IN('net banking','UPI','cash on delivery')),
payment_transc_id VARCHAR(50),
FOREIGN KEY(user_id) references users(user_id)
);

CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  variant_id INT NOT NULL,
  quantity INT NOT NULL,
  price_at_purchase FLOAT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (variant_id) REFERENCES variant(variant_id)
);


CREATE TABLE address(
address_id INT PRIMARY KEY,
user_id INT NOT NULL,
FOREIGN KEY(user_id) references users(user_id),
full_address VARCHAR(255) NOT NULL,
state VARCHAR(30),
city VARCHAR(30),
pincode INT,
country VARCHAR(50) DEFAULT 'India'
);

CREATE TABLE order_address(
oa_id INT PRIMARY KEY,
order_id INT NOT NULL,
address_id INT NOT  NULL,
FOREIGN KEY(order_id) references orders(order_id),
FOREIGN KEY(address_id) references address(address_id)
);


