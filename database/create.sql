DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS authenticated_user;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS type;
DROP TABLE IF EXISTS tag;
DROP TABLE IF EXISTS photo;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS notification;
DROP TABLE IF EXISTS support;
DROP TABLE IF EXISTS assign_report;
DROP TABLE IF EXISTS vote_post;
DROP TABLE IF EXISTS follow_category;
DROP TABLE IF EXISTS follow_tag;
DROP TABLE IF EXISTS follow_type;
DROP TABLE IF EXISTS thread_comment;
DROP TABLE IF EXISTS vote_comment;

-- 24 - 31
DROP TABLE IF EXISTS post_report;
DROP TABLE IF EXISTS comment_report;
DROP TABLE IF EXISTS publish_notification;
DROP TABLE IF EXISTS follow_notification;
DROP TABLE IF EXISTS vote_notification;
DROP TABLE IF EXISTS comment_notification;
DROP TABLE IF EXISTS post_report_notification;
DROP TABLE IF EXISTS comment_report_notification;



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

CREATE TABLE assign_report (
    id_user integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    id_report integer REFERENCES report(id) ON DELETE CASCADE,
    CONSTRAINT pk_user_report PRIMARY KEY (id_user, id_report))
);

CREATE TABLE vote_post (
    id_user integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    id_post integer REFERENCES post(id) ON DELETE CASCADE,
    like boolean NOT NULL,
    CONSTRAINT pk_user_post PRIMARY KEY (id_user, id_post))
);

CREATE TABLE follow_category (
    id_user integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    id_category integer REFERENCES category(id) ON DELETE CASCADE,
    CONSTRAINT pk_user_category PRIMARY KEY (id_user, id_category))
);

CREATE TABLE follow_tag (
    id_user integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    id_tag integer REFERENCES tag(id) ON DELETE CASCADE,
    CONSTRAINT pk_user_tag PRIMARY KEY (id_user, id_tag))
);

CREATE TABLE follow_type (
    id_user integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    id_type integer REFERENCES type(id) ON DELETE CASCADE,
    CONSTRAINT pk_user_type PRIMARY KEY (id_user, id_type))
);

CREATE TABLE thread_comment (
    id_comment integer REFERENCES comment(id) PRIMARY KEY ON DELETE CASCADE,
    id_initial_comment integer REFERENCES comment(id) NOT NULL ON DELETE CASCADE
);

CREATE TABLE vote_comment (
    id_user integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    id_comment integer REFERENCES comment(id) ON DELETE CASCADE,
    like boolean NOT NULL,
    CONSTRAINT pk_user_comment PRIMARY KEY (id_user, id_comment))
);


-- 24 - 31
CREATE TABLE post_report(
    id integer PRIMARY KEY,
    reported_date DATE NOT NULL,
    id_motive text NOT NULL REFERENCES motive(id) ON DELETE CASCADE,
    closed BOOLEAN NOT NULL,
    closed_date DATE,
    id_post INTEGER NOT NULL REFERENCES post(id) ON DELETE CASCADE,
);

CREATE TABLE post_report(
    id integer PRIMARY KEY,
    reported_date DATE NOT NULL,
    id_motive text NOT NULL REFERENCES motive(id) ON DELETE CASCADE,
    closed BOOLEAN NOT NULL,
    closed_date DATE,
    id_comment INTEGER NOT NULL REFERENCES comment(id) ON DELETE CASCADE,
);

CREATE TABLE publish_notification(
    id integer PRIMARY KEY,
    id_user INTEGER NOT NULL REFERENCES authenticated_user(id),
    message TEXT NOT NULL,
    received_date DATE NOT NULL,
    id_post INTEGER NOT NULL REFERENCES post(id) ON DELETE CASCADE,
);

CREATE TABLE follow_notification(
    id integer PRIMARY KEY,
    id_receiver INTEGER NOT NULL REFERENCES authenticated_user(id),
    message TEXT NOT NULL,
    received_date DATE NOT NULL,
    id_follower INTEGER NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE,
);

CREATE TABLE vote_notification(
    id integer PRIMARY KEY,
    id_user INTEGER NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    received_date DATE NOT NULL,
    id_post INTEGER NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE,
);

CREATE TABLE comment_notification(
    id integer PRIMARY KEY,
    id_user INTEGER NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    received_date DATE NOT NULL,
    id_post_report INTEGER NOT NULL REFERENCES post_report(id) ON DELETE CASCADE,
);

CREATE TABLE post_report_notification(
    id integer PRIMARY KEY,
    id_user INTEGER NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    received_date DATE NOT NULL,
    id_comment_report INTEGER NOT NULL REFERENCES comment_report(id) ON DELETE CASCADE,
);
