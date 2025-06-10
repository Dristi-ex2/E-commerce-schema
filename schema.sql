CREATE DATABASE ecommerce_schema;
use ecommerce_schema;

CREATE TABLE user (
  user_id INT PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50),
  email VARCHAR(50),
  phone BIGINT NOT NULL,
  Gender VARCHAR(10)
);

CREATE TABLE categories (
  category_id INT PRIMARY KEY,
  categoryName VARCHAR(50) NOT NULL,
  url VARCHAR(70) UNIQUE NOT NULL
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(40) NOT NULL,
  product_description VARCHAR(255),
  category_id INT NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE variant (
  variant_id INT PRIMARY KEY,
  product_id INT NOT NULL,
  color VARCHAR(20) NOT NULL,
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE carts (
  cart_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE carts_items (
  carts_items_id INT PRIMARY KEY,
  cart_id INT NOT NULL,
  product_id INT NOT NULL,
  variant_id INT NOT NULL,
  quantity INT DEFAULT 1,
  FOREIGN KEY (cart_id) REFERENCES carts(cart_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (variant_id) REFERENCES variant(variant_id)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  total_amount FLOAT NOT NULL,
  shipping_amount FLOAT NOT NULL,
  order_status VARCHAR(20) CHECK (order_status IN ('placed','ongoing','cancelled','delivered')),
  Payment_status VARCHAR(20) CHECK (Payment_status IN ('paid','not paid','refunded')),
  Payment_type VARCHAR(20) CHECK (Payment_type IN ('net banking','UPI','cash on delivery')),
  Payment_transc_id VARCHAR(50),
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE address (
  address_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  full_address VARCHAR(255) NOT NULL,
  state VARCHAR(30),
  city VARCHAR(30),
  pincode INT,
  country VARCHAR(50) DEFAULT 'India',
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE order_address (
  oa_id INT PRIMARY KEY,
  order_id INT NOT NULL,
  address_id INT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (address_id) REFERENCES address(address_id)
);
