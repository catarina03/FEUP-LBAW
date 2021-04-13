DROP TABLE IF EXISTS post CASCADE;
DROP TABLE IF EXISTS authenticated_user CASCADE;
DROP TABLE IF EXISTS tag CASCADE;
DROP TABLE IF EXISTS post_tag CASCADE;
DROP TABLE IF EXISTS photo CASCADE;
DROP TABLE IF EXISTS "comment" CASCADE;
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
DROP TYPE IF EXISTS user_types;
DROP TYPE IF EXISTS frequency_types;
DROP TYPE IF EXISTS notification_types;

CREATE TYPE category_types AS ENUM ('music', 'tv show', 'cinema', 'theatre', 'literature');
CREATE TYPE post_types AS ENUM ('news', 'article','review');
CREATE TYPE report_motives AS ENUM ('Fake news', 'Innapropriate content', 'Abusive content', 'Hate speech', 'Other');
CREATE TYPE user_types AS ENUM ('System Manager', 'Moderator', 'Regular');
CREATE TYPE frequency_types AS ENUM ('Rarely', 'Often', 'Very Often');
CREATE TYPE notification_types AS ENUM ('publish', 'follow', 'vote', 'comment', 'report');

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
    user_id integer NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE,
    comment_date TIMESTAMP DEFAULT NOW() NOT NULL,
    post_id integer REFERENCES post(id) ON DELETE CASCADE,
    comment_id integer REFERENCES "comment"(id) ON DELETE CASCADE,
    CHECK ((post_id is not null and comment_id is null) or (comment_id is not null and post_id is null))
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
    accepted BOOLEAN,
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
    notificated_user integer NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE,
    read BOOLEAN DEFAULT FALSE NOT NULL,
    type notification_types NOT NULL,
    post_id integer REFERENCES post(id) ON DELETE CASCADE, --> publish notification
    follower_id integer REFERENCES authenticated_user(id) ON DELETE CASCADE, --> follow notification
    comment_id integer REFERENCES "comment"(id) ON DELETE CASCADE, --> comment notification
    voted_comment integer, --> vote comment notification
    voted_post integer, --> vote post notification
    voted_user integer, --> vote notification
    CONSTRAINT pk_vote_post_not FOREIGN KEY (voted_user, voted_post) REFERENCES vote_post(user_id, post_id) ON DELETE CASCADE, --> vote post notification
    CONSTRAINT pk_vote_comment_not FOREIGN KEY (voted_user, voted_comment) REFERENCES vote_comment(user_id, comment_id) ON DELETE CASCADE, --> vote comment notification
    report_id integer REFERENCES report(id) ON DELETE CASCADE, --> report notification
    CHECK(
        (type = 'publish' AND post_id is not null AND follower_id is null AND comment_id is null AND voted_comment is null AND voted_post is null AND voted_user is null AND report_id is null) --> publish notification
        OR
        (type = 'follow' AND post_id is null AND follower_id is not null AND comment_id is null AND voted_comment is null AND voted_post is null AND voted_user is null AND report_id is null) --> follow notification
        OR
        (type = 'vote' AND post_id is null AND follower_id is null AND comment_id is null AND voted_comment is not null AND voted_post is null AND voted_user is not null AND report_id is null) --> vote comment notification
        OR
        (type = 'vote' AND post_id is null AND follower_id is null AND comment_id is null AND voted_comment is null AND voted_post is not null AND voted_user is not null AND report_id is null) --> vote post notification
        OR
        (type = 'comment' AND post_id is null AND follower_id is null AND comment_id is not null AND voted_comment is null AND voted_post is null AND voted_user is null AND report_id is null) --> comment notification
        OR
        (type = 'report' AND post_id is null AND follower_id is null AND comment_id is null AND voted_comment is null AND voted_post is null AND voted_user is null AND report_id is not null) --> report notification
    )

);


---------------> INDEXES
CREATE INDEX author_post ON post USING HASH(user_id);
CREATE INDEX post_date ON post USING BTREE(created_at);
CREATE INDEX user_tags ON follow_tag USING HASH(user_id);
CREATE INDEX post_comments ON comment USING HASH(post_id);
CREATE INDEX search_post ON post USING GIN(
    (setweight(to_tsvector('english',title),'A') ||  setweight(to_tsvector('english',content),'B')));


---------------> TRIGGERS
DROP FUNCTION IF EXISTS block_user() CASCADE;
DROP FUNCTION IF EXISTS check_comment_date() CASCADE;
DROP FUNCTION IF EXISTS check_comment_report_assignment() CASCADE;
DROP FUNCTION IF EXISTS check_comment_report_author() CASCADE;
DROP FUNCTION IF EXISTS check_post_comment_author() CASCADE;
DROP FUNCTION IF EXISTS check_post_report_assignment() CASCADE;
DROP FUNCTION IF EXISTS check_post_report_author() CASCADE;
DROP FUNCTION IF EXISTS check_thread_comment() CASCADE;
DROP FUNCTION IF EXISTS check_thread_comment_date() CASCADE;
DROP FUNCTION IF EXISTS check_vote_comment() CASCADE;
DROP FUNCTION IF EXISTS check_vote_post() CASCADE;
DROP FUNCTION IF EXISTS generate_comment_notification() CASCADE;
DROP FUNCTION IF EXISTS generate_follow_notification() CASCADE;
DROP FUNCTION IF EXISTS generate_publish_notification() CASCADE;
DROP FUNCTION IF EXISTS generate_report_notification() CASCADE;
DROP FUNCTION IF EXISTS generate_thread_comment_notification() CASCADE;
DROP FUNCTION IF EXISTS generate_vote_comment_notification() CASCADE;
DROP FUNCTION IF EXISTS generate_vote_post_notification() CASCADE;

-- BLOCK USER
CREATE FUNCTION block_user() RETURNS TRIGGER AS 
$BODY$ 
BEGIN 
	DELETE
	FROM follow_user
	WHERE NEW.blocked_user = following_user AND NEW.blocking_user = followed_user
    OR NEW.blocking_user = following_user AND NEW.blocked_user = followed_user;

	RETURN NEW; 
END 
$BODY$ 
LANGUAGE plpgsql;

CREATE TRIGGER block_user 
	AFTER INSERT ON block_user 
	FOR EACH ROW 
	EXECUTE PROCEDURE block_user();



-- CHECK VOTE POST AUTHOR
CREATE FUNCTION check_vote_post() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF EXISTS (
		    SELECT *
			FROM post
			WHERE NEW.post_id = id AND NEW.user_id = user_id
        )
		THEN
			RAISE EXCEPTION 'The author of a post cant like/dislike their own post.';
	END IF;
	
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER check_vote_post
    AFTER INSERT ON vote_post
    FOR EACH ROW
    EXECUTE PROCEDURE check_vote_post();



-- CHECK VOTE COMMENT AUTHOR
CREATE FUNCTION check_vote_comment() RETURNS TRIGGER AS
$BODY$
BEGIN
   IF EXISTS (
            SELECT *
            FROM comment 
            WHERE NEW.comment_id = comment.id AND NEW.user_id = comment.user_id
        )
		THEN
			RAISE EXCEPTION 'The author of a comment cant like/dislike their own comment.';
	END IF;
	
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER check_vote_comment
    AFTER INSERT ON vote_comment
    FOR EACH ROW
    EXECUTE PROCEDURE check_vote_comment();



-- CHECK COMMENT AUTHOR
CREATE FUNCTION check_post_comment_author() RETURNS TRIGGER AS
$BODY$
BEGIN
   IF EXISTS (
            SELECT NEW.id
            FROM post
            WHERE NEW.post_id = post.id AND NEW.user_id = post.user_id
        )
		THEN
			RAISE EXCEPTION 'The author cannot comment on their own post.';
	END IF;
	
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER check_post_comment_author
    AFTER INSERT ON comment
    FOR EACH ROW
    EXECUTE PROCEDURE check_post_comment_author();



-- CHECK COMMENT DATE
CREATE FUNCTION check_comment_date() RETURNS TRIGGER AS
$BODY$
BEGIN
   IF EXISTS (
            SELECT *
            FROM post
            WHERE NEW.post_id = id 
            AND NEW.comment_date::timestamp < created_at::timestamp
        )
	    THEN
		   RAISE EXCEPTION 'The comment has to be made more recently than the post.';
	END IF;
	
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER check_comment_date
   AFTER INSERT ON comment
   FOR EACH ROW
   EXECUTE PROCEDURE check_comment_date();



-- CHECK THREAD COMMENT DATE
CREATE FUNCTION check_thread_comment_date() RETURNS TRIGGER AS
$BODY$
BEGIN
   IF EXISTS (
		SELECT *
			FROM comment
			WHERE NEW.comment_id = id AND NEW.comment_date::timestamp < comment_date::timestamp
        )
		THEN
			RAISE EXCEPTION 'The thread comment has to be made more recently than the main comment.';
	END IF;
	
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER check_thread_comment_date
    AFTER INSERT ON comment
    FOR EACH ROW
    EXECUTE PROCEDURE check_thread_comment_date();



-- CHECK THERE ARE ONLY 2 LEVELS OF COMMENTS
CREATE FUNCTION check_thread_comment() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF EXISTS (
            SELECT *
            FROM comment c1
            WHERE NEW.comment_id = c1.id AND c1.comment_id IS NOT NULL
        ) 
		THEN
			RAISE EXCEPTION 'Comments can only have 2 levels.';
	END IF;
	
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER check_thread_comment
    AFTER INSERT ON comment
    FOR EACH ROW
    EXECUTE PROCEDURE check_thread_comment();



-- CHECK POST REPORT AUTHOR
CREATE FUNCTION check_post_report_author() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF NEW.post_reported IS NOT NULL AND EXISTS (
        SELECT *
        FROM post
        WHERE NEW.post_reported = post.id AND NEW.user_reporting = post.user_id
        ) 
		THEN
			RAISE EXCEPTION 'An authenticated user cannot report their own post.';
	END IF;
	
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER check_post_report_author
   AFTER INSERT ON report
   FOR EACH ROW
   EXECUTE PROCEDURE check_post_report_author();



-- CHECK COMMENT REPORT AUTHOR
CREATE FUNCTION check_comment_report_author() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF NEW.comment_reported IS NOT NULL AND EXISTS (
            SELECT *
            FROM comment
            WHERE NEW.comment_reported = comment.id AND NEW.user_reporting = comment.user_id
        ) 
        THEN
            RAISE EXCEPTION 'An authenticated user cannot report their own comment.';
	END IF;
	
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER check_comment_report_author
   AFTER INSERT ON report
   FOR EACH ROW
   EXECUTE PROCEDURE check_comment_report_author();



-- CHECK POST REPORT ASSIGNMENT
CREATE FUNCTION check_post_report_assignment() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF NEW.post_reported IS NOT NULL AND EXISTS (
            SELECT * 
            FROM post
            WHERE NEW.post_reported = post.id AND NEW.user_assigned = post.user_id
        ) 
        THEN
            RAISE EXCEPTION 'A moderator/system manager cannot be assigned to their own post.';
	END IF;
	
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER check_post_report_assignment
   AFTER INSERT ON report
   FOR EACH ROW
   EXECUTE PROCEDURE check_post_report_assignment();



-- CHECK COMMENT REPORT ASSIGNMENT
CREATE FUNCTION check_comment_report_assignment() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF NEW.comment_reported IS NOT NULL AND EXISTS (
            SELECT *
            FROM comment
            WHERE NEW.comment_reported = comment.id
            AND NEW.user_assigned = comment.user_id
        ) 
        THEN
            RAISE EXCEPTION 'A moderator/system manager cannot be assigned to their own comment.';
	END IF;
	
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER check_comment_report_assignment
   AFTER INSERT ON report
   FOR EACH ROW
   EXECUTE PROCEDURE check_comment_report_assignment();



-- GENERATES FOLLOW NOTIFICATION
CREATE FUNCTION generate_follow_notification() RETURNS TRIGGER AS
$BODY$
BEGIN
   INSERT INTO notification (notificated_user, type, follower_id) 
   VALUES (NEW.followed_user, 'follow', NEW.following_user);

   RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER generate_follow_notification
   AFTER INSERT ON follow_user
   FOR EACH ROW
   EXECUTE PROCEDURE generate_follow_notification();



-- GENERATE VOTE POST NOTIFICATION
CREATE FUNCTION generate_vote_post_notification() RETURNS TRIGGER AS
$BODY$
declare
   notification_receiver_id integer;
BEGIN
    IF NEW.like = true THEN
        SELECT user_id INTO notification_receiver_id
        FROM post
        WHERE NEW.post_id = post.id;

        INSERT INTO notification (notificated_user, type, voted_post, voted_user) 
        VALUES (notification_receiver_id, 'vote', NEW.post_id, NEW.user_id);
    END IF;
	
	RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER generate_vote_post_notification
   AFTER INSERT ON vote_post
   FOR EACH ROW
   EXECUTE PROCEDURE generate_vote_post_notification();



-- GENERATES VOTE COMMENT NOTIFICATION
CREATE FUNCTION generate_vote_comment_notification() RETURNS TRIGGER AS
$BODY$
declare
   notification_receiver_id integer;
BEGIN
    IF NEW.like = true THEN
        SELECT user_id INTO notification_receiver_id
        FROM comment
        WHERE NEW.comment_id = comment.id;

        INSERT INTO notification (notificated_user, type, voted_comment, voted_user)
        VALUES (notification_receiver_id, 'vote', NEW.comment_id, NEW.user_id);
    END IF;
	
	RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER generate_vote_comment_notification
   AFTER INSERT ON vote_comment
   FOR EACH ROW
   EXECUTE PROCEDURE generate_vote_comment_notification();



-- GENERATES REPORT NOTIFICATION
CREATE FUNCTION generate_report_notification() RETURNS TRIGGER AS
$BODY$
declare                  
   notification_user_id integer;
BEGIN
    IF New.post_reported IS NOT NULL THEN
        SELECT post.user_id INTO notification_user_id
        FROM post
        WHERE new.post_reported = post.id;

        INSERT INTO notification (notificated_user, type, report_id)
        VALUES (notification_user_id, 'report', NEW.id);
    END IF;

    IF New.comment_reported IS NOT NULL THEN
        SELECT comment.user_id INTO notification_user_id
        FROM comment 
        WHERE new.comment_reported = comment.id;

        INSERT INTO notification (notificated_user, type, report_id)
        VALUES (notification_user_id, 'report', NEW.id);
    END IF;

	RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER generate_report_notification
   AFTER INSERT ON report
   FOR EACH ROW
   EXECUTE PROCEDURE generate_report_notification();



-- GENERATES COMMENT COMMENT NOTIFICATION
CREATE FUNCTION generate_comment_notification() RETURNS TRIGGER AS
$BODY$
declare                  
   notification_user_id integer;
BEGIN
    IF New.comment_id IS NULL THEN
        SELECT post.user_id INTO notification_user_id
        FROM "comment" INNER JOIN post 
        ON "comment".post_id = post.id
        WHERE post.id = NEW.post_id;
        
        INSERT INTO notification (notificated_user, type, comment_id) 
        VALUES (notification_user_id, 'comment', NEW.id);
    END IF;

	RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER generate_comment_notification
   AFTER INSERT ON "comment"
   FOR EACH ROW
   EXECUTE PROCEDURE generate_comment_notification();



-- GENERATES THREAD COMMENT NOTIFICATION
CREATE FUNCTION generate_thread_comment_notification() RETURNS TRIGGER AS
$BODY$
declare                  
   notification_user_id integer;
BEGIN
    IF New.comment_id IS NOT NULL THEN
        SELECT comment.user_id INTO notification_user_id
        FROM comment 
        WHERE NEW.comment_id = comment.id;
        
        INSERT INTO notification (notificated_user, type, comment_id) 
        VALUES (notification_user_id, 'comment', NEW.id);
    END IF;

	RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER generate_thread_comment_notification
   AFTER INSERT ON "comment"
   FOR EACH ROW
   EXECUTE PROCEDURE generate_thread_comment_notification();



-- GENERATES PUBLISH NOTIFICATION
CREATE FUNCTION generate_publish_notification() RETURNS TRIGGER AS
$BODY$
declare     
   to_notify record;
BEGIN
    for to_notify IN
        SELECT following_user AS user_to_notify
        FROM follow_user
        WHERE new.user_id = follow_user.followed_user
        loop
            INSERT INTO notification (notificated_user, type, post_id)
        VALUES (to_notify.user_to_notify, 'publish', NEW.id);
	end loop;

	RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER generate_publish_notification
   AFTER INSERT ON post
   FOR EACH ROW
   EXECUTE PROCEDURE generate_publish_notification();
  

