DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS authenticated_user;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS type;
DROP TABLE IF EXISTS tag;
DROP TABLE IF EXISTS photo;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS notification;
DROP TABLE IF EXISTS support;



-- Drop types
DROP TYPE IF EXISTS category_types;
DROP TYPE IF EXISTS post_types;


-- Types
CREATE TYPE category_types AS ENUM ('music', 'tv show', 'cinema', 'theatre', 'literature');
CREATE TYPE post_types AS ENUM ('news', 'article','review');

CREATE TABLE post(
    id integer PRIMARY KEY,
    title text NOT NULL,
    thumbnail text NOT NULL,
    content text NOT NULL,
    is_spoiler boolean DEFAULT FALSE,
    created_at DATE NOT NULL,
    n_views integer NOT NULL DEFAULT 0,
    id_type integer NOT NULL REFERENCES type(id) ON DELETE CASCADE,
    id_category integer NOT NULL REFERENCES category(id) ON DELETE CASCADE,
);




CREATE TABLE authenticated_user (
    id integer PRIMARY KEY,
    username text UNIQUE NOT NULL,
    name text NOT NULL,
    email text UNIQUE NOT NULL ,
    password text NOT NULL,
    birthdate DATE NOT NULL,
    gender genders NOT NULL,
    instagram text,
    twitter text,
    facebook text,
    linkedin text,
    show_people_i_follow boolean DEFAULT FALSE NOT NULL,
    show_tags_i_follow boolean DEFAULT FALSE NOT NULL,
    is_moderator boolean DEFAULT FALSE NOT NULL,
    is_system_manager boolean DEFAULT FALSE NOT NULL,
    id_photo integer NOT NULL REFERENCES photo(id) ON DELETE CASCADE,
    CONSTRAINT min_age CHECK (birthdate <= (CURRENT_DATE - interval '13' year )),
);

CREATE TABLE category(
    id integer PRIMARY KEY,
    name category_types UNIQUE NOT NULL
);

CREATE TABLE type(
    id integer PRIMARY KEY,
    name post_types UNIQUE NOT NULL
);

CREATE TABLE tag(
    id integer PRIMARY KEY,
    name text UNIQUE NOT NULL
);

CREATE TABLE photo(
    id integer PRIMARY KEY,
    path text NOT NULL,
    id_post integer NOT NULL REFERENCES photo(id) ON DELETE CASCADE
);

CREATE TABLE comment(
    id integer PRIMARY KEY,
    content text NOT NULL,
    comment_date DATE NOT NULL,
    id_post integer NOT NULL REFERENCES post(id) ON DELETE CASCADE
);

CREATE TABLE notification(
    id integer PRIMARY KEY,
    message_text text NOT NULL,
    received_date DATE NOT NULL
);

CREATE TABLE support(
    id integer PRIMARY KEY,
    problem text NOT NULL,
    browser text NOT NULL,
    frequency text NOT NULL,
    impact integer NOT NULL,
    contact text NOT NULL
);