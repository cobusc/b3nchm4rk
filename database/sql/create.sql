--
-- Run this script as the 'postgres' user to
-- create the benchmark database and user.
-- 

DROP DATABASE IF EXISTS benchmark;
DROP USER IF EXISTS benchmark;

CREATE DATABASE benchmark
       ENCODING 'UTF8'
       TEMPLATE template0;

CREATE USER benchmark;

GRANT ALL ON DATABASE benchmark TO benchmark;

--
-- Create template tables using the 'benchmark' user
--

\connect benchmark;
SET ROLE benchmark;


CREATE TABLE hash_algorithm 
(
    id SERIAL PRIMARY KEY,                                
    name VARCHAR NOT NULL UNIQUE                          
);

COMMENT ON COLUMN hash_algorithm.id IS 'The hash algorithm ID';
COMMENT ON COLUMN hash_algorithm.name IS 'A name describing the hash algorithm';

CREATE TABLE member 
(
    id BIGSERIAL PRIMARY KEY,                             
    username VARCHAR NOT NULL UNIQUE,                     
    email_address VARCHAR NOT NULL UNIQUE,                
    salt VARCHAR NOT NULL,                                
    hash_algorithm INTEGER REFERENCES hash_algorithm(id), 
    password_hash VARCHAR NOT NULL,                       
    external_id VARCHAR NOT NULL UNIQUE                   
);

COMMENT ON COLUMN member.id IS 'The internal user ID';
COMMENT ON COLUMN member.username IS 'The username used to identify and address the member';
COMMENT ON COLUMN member.email_address IS 'The email address used for password resets and other communique';
COMMENT ON COLUMN member.salt IS 'The salt used to hash the password';
COMMENT ON COLUMN member.hash_algorithm IS 'The hash algorithm used to hash the password';
COMMENT ON COLUMN member.external_id IS 'Some character string used in external links to identify the member';

--
-- The category table contains the base definitions required by other category tables
--

CREATE TABLE category
(
    id SERIAL PRIMARY KEY,                                
    name VARCHAR NOT NULL UNIQUE,                         
    description VARCHAR NOT NULL                          
);

COMMENT ON COLUMN category.id IS 'The category ID';
COMMENT ON COLUMN category.name IS 'The name of the category';
COMMENT ON COLUMN category.description IS 'A description of the category';

CREATE TABLE asset_category 
(
    PRIMARY KEY (id),
    UNIQUE(name)
)
INHERITS (category);

COMMENT ON COLUMN asset_category.id IS 'The asset category ID';
COMMENT ON COLUMN asset_category.name IS 'The name of the asset category';
COMMENT ON COLUMN asset_category.description IS 'A description of the asset category';

CREATE TABLE liability_category
(
    PRIMARY KEY (id),
    UNIQUE(name)
)
INHERITS (category);

COMMENT ON COLUMN liability_category.id IS 'The liability category ID';
COMMENT ON COLUMN liability_category.name IS 'The name of the liability category';
COMMENT ON COLUMN liability_category.description IS 'A description of the liability category';

CREATE TABLE member_asset
(
    member_id BIGINT REFERENCES member(id),
    asset_category_id INTEGER REFERENCES asset_category(id),
    value INTEGER NOT NULL DEFAULT 0,
    notes VARCHAR NOT NULL DEFAULT ''
);

CREATE INDEX member_asset_member_asset_category_index
ON member_asset(member_id, asset_category_id);

CREATE INDEX member_asset_member_index
ON member_asset(member_id);

CREATE INDEX member_asset_asset_category_index
ON member_asset(asset_category_id);

CREATE TABLE member_liability
(
    member_id BIGINT REFERENCES member(id),
    liability_category_id INTEGER REFERENCES liability_category(id),
    value INTEGER NOT NULL DEFAULT 0,
    notes VARCHAR NOT NULL DEFAULT ''
);

CREATE INDEX member_liability_member_liability_category_index
ON member_liability(member_id, liability_category_id);

CREATE INDEX member_liability_member_index
ON member_liability(member_id);

CREATE INDEX member_liability_liability_category_index
ON member_liability(liability_category_id);


