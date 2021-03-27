DROP TABLE IF EXISTS post CASCADE;
DROP TABLE IF EXISTS authenticated_user CASCADE;
DROP TABLE IF EXISTS tag CASCADE;
DROP TABLE IF EXISTS post_tag CASCADE;
DROP TABLE IF EXISTS photo CASCADE;
DROP TABLE IF EXISTS "comment" CASCADE;
DROP TABLE IF EXISTS user_comment CASCADE;
DROP TABLE IF EXISTS saves CASCADE;
DROP TABLE IF EXISTS support CASCADE;
DROP TABLE IF EXISTS faq CASCADE;
DROP TABLE IF EXISTS follow_tag CASCADE;
DROP TABLE IF EXISTS vote_post CASCADE;
DROP TABLE IF EXISTS vote_comment CASCADE;
DROP TABLE IF EXISTS block_user CASCADE;
DROP TABLE IF EXISTS follow_user CASCADE;
DROP TABLE IF EXISTS report CASCADE;
DROP TABLE IF EXISTS notification CASCADE;
DROP TABLE IF EXISTS publish_notification CASCADE;
DROP TABLE IF EXISTS follow_notification CASCADE;
DROP TABLE IF EXISTS vote_notification CASCADE;
DROP TABLE IF EXISTS comment_notification CASCADE;
DROP TABLE IF EXISTS report_notification CASCADE;

DROP TYPE IF EXISTS category_types;
DROP TYPE IF EXISTS post_types;
DROP TYPE IF EXISTS report_motives;
DROP TYPE IF EXISTS user_type;
DROP TYPE IF EXISTS frequency;

CREATE TYPE category_types AS ENUM ('music', 'tv show', 'cinema', 'theatre', 'literature');
CREATE TYPE post_types AS ENUM ('news', 'article','review');
CREATE TYPE report_motives AS ENUM ('Fake news', 'Innapropriate content', 'Abusive content', 'Hate speech', 'Other');
CREATE TYPE user_types AS ENUM ('Regular' , 'Moderator', 'System Manager');
CREATE TYPE frequency_types AS ENUM ('Rarely', 'Often', 'Very Often');


CREATE TABLE tag(
    id SERIAL PRIMARY KEY,
    name text UNIQUE NOT NULL
);

CREATE TABLE authenticated_user (
    id SERIAL PRIMARY KEY,
    username text UNIQUE NOT NULL,
    name text NOT NULL,
    email text UNIQUE NOT NULL ,
    password text NOT NULL,
    birthdate DATE NOT NULL,
    bio TEXT NOT NULL DEFAULT 'Welcome to my profile',
    instagram text,
    twitter text,
    facebook text,
    linkedin text,
    show_people_i_follow boolean DEFAULT FALSE NOT NULL,
    show_tags_i_follow boolean DEFAULT FALSE NOT NULL,
    authenticated_user_type user_types NOT NULL DEFAULT 'Regular',
    profile_photo BYTEA,
    CONSTRAINT min_age CHECK (birthdate <= (CURRENT_DATE - interval '13' year ))
);

CREATE TABLE post(
    id SERIAL PRIMARY KEY,
    title text NOT NULL,
    thumbnail BYTEA NOT NULL,
    content text NOT NULL,
    is_spoiler boolean DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    n_views integer NOT NULL DEFAULT 0,
    type post_types NOT NULL,
    category category_types NOT NULL,
    user_id integer NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE
);

CREATE TABLE photo(
    id SERIAL PRIMARY KEY,
    photo BYTEA NOT NULL,
    post_id integer NOT NULL REFERENCES post(id) ON DELETE CASCADE
);

CREATE TABLE post_tag(
    post_id integer REFERENCES post(id) ON DELETE CASCADE,
    tag_id integer REFERENCES tag(id) ON DELETE CASCADE,
    CONSTRAINT pk_post_tag PRIMARY KEY (post_id, tag_id)
);

CREATE TABLE "comment"(
    id SERIAL PRIMARY KEY,
    content text NOT NULL,
    comment_date TIMESTAMP DEFAULT NOW() NOT NULL,
    post_id integer NOT NULL REFERENCES post(id) ON DELETE CASCADE,
    comment_id integer  REFERENCES "comment"(id) ON DELETE CASCADE
);

CREATE TABLE user_comment(  
    comment_id integer REFERENCES "comment"(id) ON DELETE CASCADE,
    user_id integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    CONSTRAINT pk_user_comment PRIMARY KEY (comment_id, user_id)
);

CREATE TABLE saves(
    user_id integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    post_id integer REFERENCES post(id) ON DELETE CASCADE,
    CONSTRAINT pk_save_post PRIMARY KEY (user_id, post_id)
);

CREATE TABLE support(
    id SERIAL PRIMARY KEY,
    problem text NOT NULL,
    browser text NOT NULL,
    frequency frequency_types NOT NULL,
    impact integer NOT NULL CHECK (impact > 0 AND impact < 6),
    email text UNIQUE NOT NULL
);

CREATE TABLE faq(
    id SERIAL PRIMARY KEY,
    question text NOT NULL,
    answer text NOT NULL
);

CREATE TABLE follow_tag (
    user_id integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    tag_id integer REFERENCES tag(id) ON DELETE CASCADE,
    CONSTRAINT pk_user_tag PRIMARY KEY (user_id, tag_id)
);

CREATE TABLE vote_post (
    user_id integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    post_id integer REFERENCES post(id) ON DELETE CASCADE,
    "like" boolean NOT NULL,
    CONSTRAINT pk_user_post PRIMARY KEY (user_id, post_id)
);

CREATE TABLE vote_comment (
    user_id integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    comment_id integer REFERENCES "comment"(id) ON DELETE CASCADE,
    "like" boolean NOT NULL,
    CONSTRAINT pk_vote_comment PRIMARY KEY (user_id, comment_id)
);

CREATE TABLE block_user(
    blocking_user integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    blocked_user integer REFERENCES authenticated_user(id) ON DELETE CASCADE,
    CONSTRAINT pk_blocking_blocked PRIMARY KEY (blocking_user, blocked_user),
    CHECK (blocking_user  IS DISTINCT FROM blocked_user)
);

CREATE TABLE follow_user(
    following_user integer NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE,
    followed_user integer NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE,
    CONSTRAINT pk_following_followed PRIMARY KEY (following_user, followed_user), 
    CHECK (following_user IS DISTINCT FROM followed_user)
);

CREATE TABLE report(
    id SERIAL PRIMARY KEY,
    reported_date DATE NOT NULL DEFAULT NOW(),
    closed BOOLEAN NOT NULL DEFAULT false,
    closed_date DATE,
    motive report_motives NOT NULL,
    user_reporting integer REFERENCES authenticated_user(id),
    user_assigned integer REFERENCES authenticated_user(id),
    comment_reported integer REFERENCES "comment"(id) ON DELETE CASCADE,
    post_reported integer  REFERENCES post(id) ON DELETE CASCADE,
    CHECK(user_reporting IS DISTINCT FROM user_assigned), 
    CHECK((comment_reported IS NULL AND post_reported IS NOT NULL) OR (comment_reported IS NOT NULL AND post_reported IS NULL)),
    CHECK(reported_date < closed_date)
);

CREATE TABLE notification(
    id SERIAL PRIMARY KEY,
    created_date TIMESTAMP DEFAULT NOW() NOT NULL,
    user_id integer NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE
);


CREATE TABLE publish_notification(
    id SERIAL PRIMARY KEY,
    notification_id integer NOT NULL REFERENCES notification(id) ON DELETE CASCADE,
    post_id integer NOT NULL REFERENCES post(id) ON DELETE CASCADE
);

CREATE TABLE follow_notification(
    id SERIAL PRIMARY KEY,
    notification_id integer NOT NULL REFERENCES notification(id) ON DELETE CASCADE,
    follower_id integer NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE
);

CREATE TABLE vote_notification(
    id SERIAL PRIMARY KEY,
    notification_id integer NOT NULL REFERENCES notification(id) ON DELETE CASCADE,
    comment_id integer NOT NULL,
	user_id integer NOT NULL,
	post_id integer NOT NULL,
    CONSTRAINT pk_vote_post_not FOREIGN KEY (user_id, post_id) REFERENCES vote_post(user_id, post_id) ON DELETE CASCADE,
	CONSTRAINT pk_vote_comment_not FOREIGN KEY (user_id, comment_id) REFERENCES vote_comment(user_id, comment_id) ON DELETE CASCADE,
    CHECK((comment_id IS NULL AND post_id IS NOT NULL) OR (comment_id IS NOT NULL AND post_id IS NULL))
);

CREATE TABLE comment_notification(
    id SERIAL PRIMARY KEY,
    notification_id integer NOT NULL REFERENCES notification(id) ON DELETE CASCADE,
    comment_id integer NOT NULL REFERENCES "comment"(id) ON DELETE CASCADE
);

CREATE TABLE report_notification(
    id SERIAL PRIMARY KEY,
    notification_id integer NOT NULL REFERENCES notification(id) ON DELETE CASCADE,
    reported integer NOT NULL REFERENCES report(id) ON DELETE CASCADE
);


