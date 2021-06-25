BEGIN;

CREATE TABLE alembic_version (
    version_num VARCHAR(32) NOT NULL, 
    CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);

-- Running upgrade  -> 81eaa7c150a2

CREATE TABLE "user" (
    id SERIAL NOT NULL, 
    username VARCHAR(20) NOT NULL, 
    email VARCHAR(120) NOT NULL, 
    password VARCHAR(60) NOT NULL, 
    PRIMARY KEY (id), 
    UNIQUE (email), 
    UNIQUE (username)
);

CREATE TABLE products (
    id SERIAL NOT NULL, 
    user_id INTEGER NOT NULL, 
    product_name VARCHAR(100) NOT NULL, 
    product_description VARCHAR(550), 
    category VARCHAR(50) NOT NULL, 
    minimum_bid BIGINT NOT NULL, 
    post_created TIMESTAMP WITHOUT TIME ZONE, 
    last_updated TIMESTAMP WITHOUT TIME ZONE, 
    last_date_to_bid TIMESTAMP WITHOUT TIME ZONE, 
    picture VARCHAR(1600) NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(user_id) REFERENCES "user" (id)
);

CREATE TABLE bidder (
    id SERIAL NOT NULL, 
    bidders_id INTEGER NOT NULL, 
    product_id INTEGER NOT NULL, 
    bid_value DECIMAL NOT NULL, 
    note VARCHAR(500), 
    PRIMARY KEY (id), 
    FOREIGN KEY(product_id) REFERENCES products (id)
);

INSERT INTO alembic_version (version_num) VALUES ('81eaa7c150a2') RETURNING alembic_version.version_num;

COMMIT;

