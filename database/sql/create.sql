CREATE DATABASE b3nchm4rk;
CREATE USER b3nchm4rk;

GRANT ALL ON DATABASE b3nchm4rk TO b3ncm4rk;


CREATE TABLE hash_algorithm 
(
    id SERIAL PRIMARY KEY,                                -- The hash algorithm ID
    name VARCHAR NOT NULL UNIQUE                          -- A name describing the hash algorithm
);

CREATE TABLE user 
(
    id BIGSERIAL PRIMARY KEY,                             -- The internal user ID
    username VARCHAR NOT NULL UNIQUE,                     -- The username used to identify and address the user
    email_address VARCHAR NOT NULL UNIQUE,                -- The email address used for password resets and other communique
    salt VARCHAR NOT NULL,                                -- The salt used to hash the password
    hash_algorithm INTEGER REFERENCES hash_algorithm(id), -- The hash algorithm used to hash the password
    password_hash VARCHAR NOT NULL,                       -- The result of hash_algorithm(salt+password)
    external_id VARCHAR NOT NULL UNIQUE                   -- Some character string Used in external links to identify the user
);

CREATE TABLE asset_category
(
    id SERIAL PRIMARY KEY,                                -- The asset category ID
    name VARCHAR NOT NULL UNIQUE,                         -- The name of the asset category
    description VARCHAR NOT NULL                          -- A description of the asset category
);

CREATE TABLE liability_category
(
    id SERIAL PRIMARY KEY,                                -- The debt category ID
    name VARCHAR NOT NULL UNIQUE,                         -- The name of the debt category
    description VARCHAR NOT NULL                          -- A description of the debt category
);


CREATE TABLE user_asset
(
    user_id BIGINT REFERENCES user(id),
    asset_category_id REFERENCES asset_category(id),
    value INTEGER NOT NULL DEFAULT 0,
    notes VARCHAR NOT NULL DEFAULT ''
);

CREATE INDEX user_asset_user_asset_category_index
ON user_asset(user_id, asset_category_id);

CREATE INDEX user_asset_user_index
ON user_asset(user_id);

CREATE INDEX user_asset_asset_category_index
ON user_asset(asset_category_id);

CREATE TABLE user_liability
(
    user_id BIGINT REFERENCES user(id),
    liability_category_id REFERENCES liability_category(id),
    value INTEGER NOT NULL DEFAULT 0,
    notes VARCHAR NOT NULL DEFAULT ''
);

CREATE INDEX user_liability_user_liability_category_index
ON user_liability(user_id, liability_category_id);

CREATE INDEX user_liability_user_index
ON user_liability(user_id);

CREATE INDEX user_liability_liability_category_index
ON user_liability(liability_category_id);


