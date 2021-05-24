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

DROP TYPE IF EXISTS category_types;
DROP TYPE IF EXISTS post_types;
DROP TYPE IF EXISTS report_motives;
DROP TYPE IF EXISTS user_types;
DROP TYPE IF EXISTS frequency_types;
DROP TYPE IF EXISTS notification_types;


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
DROP FUNCTION IF EXISTS delete_unused_tag() CASCADE;
DROP FUNCTION IF EXISTS post_search() CASCADE;

DROP TRIGGER IF EXISTS block_user ON block_user;
DROP TRIGGER IF EXISTS check_vote_post ON vote_post;
DROP TRIGGER IF EXISTS check_vote_comment ON vote_comment;
DROP TRIGGER IF EXISTS check_post_comment_author ON comment;
DROP TRIGGER IF EXISTS check_comment_date ON comment;
DROP TRIGGER IF EXISTS check_thread_comment_date ON comment;
DROP TRIGGER IF EXISTS check_thread_comment ON comment;
DROP TRIGGER IF EXISTS check_post_report_author ON report;
DROP TRIGGER IF EXISTS check_comment_report_author ON report;
DROP TRIGGER IF EXISTS check_post_report_assignment ON report;
DROP TRIGGER IF EXISTS check_comment_report_assignment ON report;
DROP TRIGGER IF EXISTS generate_follow_notification ON follow_user;
DROP TRIGGER IF EXISTS generate_vote_post_notification ON vote_post;
DROP TRIGGER IF EXISTS generate_vote_comment_notification ON vote_comment;
DROP TRIGGER IF EXISTS generate_report_notification ON report;
DROP TRIGGER IF EXISTS generate_comment_notification ON comment;
DROP TRIGGER IF EXISTS generate_thread_comment_notification ON comment;
DROP TRIGGER IF EXISTS generate_publish_notification ON post;
DROP TRIGGER IF EXISTS delete_unused_tag ON post_tag;
DROP TRIGGER IF EXISTS post_search ON post;

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
                                    profile_photo text default 'default.png',
                                    CONSTRAINT min_age CHECK (birthdate <= (CURRENT_DATE - interval '13' year ))
);

CREATE TABLE post(
                     id SERIAL PRIMARY KEY,
                     title text NOT NULL,
                     thumbnail text NOT NULL,
                     content text NOT NULL,
                     is_spoiler boolean DEFAULT FALSE,
                     created_at TIMESTAMP DEFAULT NOW() NOT NULL,
                     updated_at TIMESTAMP DEFAULT NOW(),
                     n_views integer NOT NULL DEFAULT 0,
                     type post_types NOT NULL,
                     category category_types NOT NULL,
                     user_id integer NOT NULL REFERENCES authenticated_user(id) ON DELETE CASCADE,
                     search TSVECTOR
);

CREATE TABLE photo(
                      id SERIAL PRIMARY KEY,
                      photo text NOT NULL,
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
        RAISE EXCEPTION 'The thread comment % has to be made more recently than the main comment % .', NEW.id, NEW.comment_id;
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



-- CHECKS IF TAG IS USED, IF NOT DELETES IT
CREATE FUNCTION delete_unused_tag() RETURNS TRIGGER AS
$BODY$
DECLARE
    post_tag_count integer;
BEGIN
    SELECT COUNT(*) INTO post_tag_count
    FROM tag INNER JOIN post_tag ON tag.id = post_tag.tag_id
    WHERE OLD.tag_id = tag.id;

    IF (post_tag_count = 0) THEN
        DELETE FROM tag
        WHERE tag.id = OLD.tag_id;
    END IF;

    RETURN NULL;
END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER delete_unused_tag
    AFTER DELETE ON post_tag
    FOR EACH ROW
EXECUTE PROCEDURE delete_unused_tag();


CREATE OR REPLACE FUNCTION post_search() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF TG_OP = 'INSERT' THEN
        NEW.search = (SELECT setweight(to_tsvector('english', NEW.title), 'A') || setweight(to_tsvector('english',NEW.content), 'B') || setweight(to_tsvector('english', (SELECT name FROM authenticated_user WHERE  id = New.user_id)), 'C'));-- || setweight(to_tsvector('english', (SELECT STRING_AGG(name, ' ')FROM tag JOIN post_tag ON tag.id = post_tag.tag_id WHERE  post_id = New.id)), 'D'));
    ELSEIF TG_OP = 'UPDATE' AND (New.title <> OLD.title OR NEW.content <> OLD.content) THEN
        NEW.search = (SELECT setweight(to_tsvector('english', NEW.title), 'A') || setweight(to_tsvector('english',NEW.content), 'B') || setweight(to_tsvector('english', (SELECT name FROM authenticated_user WHERE  id = New.user_id)), 'C'));
    END IF;
    RETURN NEW;
END;
$BODY$
    LANGUAGE 'plpgsql';

CREATE TRIGGER post_search
    BEFORE INSERT OR UPDATE ON post
    FOR EACH ROW
EXECUTE PROCEDURE post_search();

--TAG
insert into tag (name) values ('uniform');
insert into tag (name) values ('Realigned');
insert into tag (name) values ('Robust');
insert into tag (name) values ('User-centric');
insert into tag (name) values ('transitional');
insert into tag (name) values ('client-driven');
insert into tag (name) values ('national');
insert into tag (name) values ('value-added');
insert into tag (name) values ('Down-sized');
insert into tag (name) values ('Universal');
insert into tag (name) values ('coherent');
insert into tag (name) values ('process improvement');
insert into tag (name) values ('Cross-environment');
insert into tag (name) values ('modular');
insert into tag (name) values ('Test-focused');
insert into tag (name) values ('Function-based');
insert into tag (name) values ('intranet');
insert into tag (name) values ('object-oriented');
insert into tag (name) values ('asymmetric');
insert into tag (name) values ('zero administration');
insert into tag (name) values ('hub');
insert into tag (name) values ('Test');
insert into tag (name) values ('Up-sized');
insert into tag (name) values ('algorithm');
insert into tag (name) values ('bifurcated');
insert into tag (name) values ('portal');
insert into tag (name) values ('Customizable');
insert into tag (name) values ('Sharable');
insert into tag (name) values ('leverage');
insert into tag (name) values ('local area network');
insert into tag (name) values ('Customer-focused');
insert into tag (name) values ('Optional');
insert into tag (name) values ('Multi-channelled');
insert into tag (name) values ('moratorium');
insert into tag (name) values ('Triple-buffered');
insert into tag (name) values ('global');
insert into tag (name) values ('methodical');
insert into tag (name) values ('explicit-content');
insert into tag (name) values ('analyzing');
insert into tag (name) values ('Business-focused');
insert into tag (name) values ('Vision-oriented');
insert into tag (name) values ('needs-based');
insert into tag (name) values ('superstructure');
insert into tag (name) values ('Enhanced');
insert into tag (name) values ('implementation');
insert into tag (name) values ('Intuitive');
insert into tag (name) values ('scalable');
insert into tag (name) values ('even-keeled');
insert into tag (name) values ('radical');
insert into tag (name) values ('Profound');
insert into tag (name) values ('Total');
insert into tag (name) values ('Persevering');
insert into tag (name) values ('static');
insert into tag (name) values ('explicit');
insert into tag (name) values ('Centralized');
insert into tag (name) values ('Organic');
insert into tag (name) values ('6th generation');
insert into tag (name) values ('Cross-platform');
insert into tag (name) values ('music');
insert into tag (name) values ('lan');
insert into tag (name) values ('Extended');
insert into tag (name) values ('background');
insert into tag (name) values ('open architecture');
insert into tag (name) values ('budgetary management');
insert into tag (name) values ('upward-trending');
insert into tag (name) values ('collaboration');
insert into tag (name) values ('5th generation');
insert into tag (name) values ('4th generation');
insert into tag (name) values ('adapter');
insert into tag (name) values ('database');
insert into tag (name) values ('networks');
insert into tag (name) values ('lifestyle');
insert into tag (name) values ('intangible');
insert into tag (name) values ('total');
insert into tag (name) values ('knowledge user');
insert into tag (name) values ('contingency');
insert into tag (name) values ('Versatile');
insert into tag (name) values ('finances');
insert into tag (name) values ('Intranet');
insert into tag (name) values ('solution');
insert into tag (name) values ('vfx');
insert into tag (name) values ('bandwidth-monitored');
insert into tag (name) values ('capacity');
insert into tag (name) values ('homogeneous');
insert into tag (name) values ('utilisation');
insert into tag (name) values ('Friendly');
insert into tag (name) values ('systematic');
insert into tag (name) values ('Networked');
insert into tag (name) values ('academia');
insert into tag (name) values ('toolset');
insert into tag (name) values ('task-force');
insert into tag (name) values ('access');
insert into tag (name) values ('Secured');
insert into tag (name) values ('artificial intelligence');
insert into tag (name) values ('process enhancement');
insert into tag (name) values ('firmware');
insert into tag (name) values ('Adapter');
insert into tag (name) values ('Re-engineered');
insert into tag (name) values ('Operative');
insert into tag (name) values ('Persistent');


--USER
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('vpaulazzi0', 'Veronike', 'vcowburn0@virginia.edu','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '4/19/1990', 'Hello!', null, 'twitter.com/vpaulazzi0', null, null, true, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('ssmoote1', 'Stevana', 'sfrean1@mail.ru','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '1/11/1988', 'Hello!', 'www.instagram.com/ssmoote1/', null, 'www.facebook.com/ssmoote1', null, true, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('abaldi2', 'Alene', 'alequeux2@zdnet.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '12/7/1988', 'Welcome to my profile', null, null, null, null, true, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('scleator3', 'Say', 'shutchason3@soup.io','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '7/28/1980', 'Welcome to my profile', null, 'twitter.com/scleator3', null, null, false, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('dhastilow4', 'Dulcinea', 'dfalkner4@ucla.edu','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '12/10/2003', 'Hello!', 'www.instagram.com/dhastilow4/', null, 'www.facebook.com/dhastilow4', null, false, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('uregglar5', 'Upton', 'ulearmonth5@senate.gov','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '12/31/1988', 'Welcome to my profile', null, 'twitter.com/uregglar5', null, null, true, true, 'System Manager', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('dmcfadin6', 'Dianemarie', 'dspiers6@npr.org','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/25/1982', 'Hello!', 'www.instagram.com/dmcfadin6/', null, 'www.facebook.com/dmcfadin6', null, false, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('gfarnie7', 'Gipsy', 'gdavie7@google.nl','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '1/21/1998', 'Hello!', null, 'twitter.com/gfarnie7', null, null, true, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('kmackimm8', 'Katrine', 'kdimmer8@usda.gov','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '4/6/2004', 'Welcome to my profile', null, 'twitter.com/kmackimm8', null, null, false, true, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('njennions9', 'Noni', 'nmcquaid9@dagondesign.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/28/1985', 'Hello!', null, null, null, null, true, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('rsigharda', 'Risa', 'rchatfielda@1und1.de','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '4/23/2001', 'Welcome to my profile', 'www.instagram.com/rsigharda/', null, 'www.facebook.com/rsigharda', null, false, true, 'Moderator', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('bhandrickb', 'Bondy', 'bmussettib@unicef.org','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '8/18/2006', 'Hello!', 'www.instagram.com/bhandrickb/', null, 'www.facebook.com/bhandrickb', null, false, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('thehnkec', 'Tabbie', 'trossonic@imageshack.us','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '8/1/1987', 'Welcome to my profile', 'www.instagram.com/thehnkec/', 'twitter.com/thehnkec', 'www.facebook.com/thehnkec', null, true, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('ddonnelland', 'Davy', 'dplettsd@paginegialle.it','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '2/3/1985', 'Hello!', 'www.instagram.com/ddonnelland/', 'twitter.com/ddonnelland', 'www.facebook.com/ddonnelland', null, true, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('styrere', 'Steffie', 'seydene@answers.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '4/6/1983', 'Hello!', null, 'twitter.com/styrere', null, null, false, false, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('ddomeneyf', 'Davey', 'dmullearyf@paginegialle.it','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '10/26/1992', 'Hello!', null, 'twitter.com/ddomeneyf', null, null, false, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('nellicombeg', 'Noell', 'nbrogiottig@twitpic.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/31/1985', 'Hello!', null, null, null, null, false, true, 'System Manager', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('kturlh', 'Kristos', 'kbercerosh@geocities.jp','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/12/1987', 'Welcome to my profile', 'www.instagram.com/kturlh/', 'twitter.com/kturlh', 'www.facebook.com/kturlh', null, true, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('ckimberi', 'Codi', 'cmccasteri@ustream.tv','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '6/19/2000', 'Hello!', 'www.instagram.com/ckimberi/', 'twitter.com/ckimberi', 'www.facebook.com/ckimberi', null, false, true, 'Moderator', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('gbloxholmj', 'Ganny', 'gmcguckenj@youku.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '10/20/2003', 'Welcome to my profile', null, 'twitter.com/gbloxholmj', null, null, false, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('gdirobertok', 'Gavra', 'ghanleyk@yahoo.co.jp','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '10/11/1988', 'Welcome to my profile', 'www.instagram.com/gdirobertok/', null, 'www.facebook.com/gdirobertok', null, false, false, 'System Manager', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('gsprowelll', 'Garrett', 'glandl@census.gov','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '6/16/2001', 'Hello!', 'www.instagram.com/gsprowelll/', 'twitter.com/gsprowelll', 'www.facebook.com/gsprowelll', null, true, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('ahoutbym', 'Andrea', 'arosencrantzm@hubpages.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '8/24/1988', 'Welcome to my profile', 'www.instagram.com/ahoutbym/', 'twitter.com/ahoutbym', 'www.facebook.com/ahoutbym', null, true, true, 'System Manager', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('cmcneiln', 'Carline', 'cduntonn@w3.org','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '11/13/1980', 'Hello!', null, null, null, null, false, false, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('seilhertseno', 'Stacee', 'sguytono@scientificamerican.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '7/29/1995', 'Welcome to my profile', null, 'twitter.com/seilhertseno', null, null, true, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('hkeartonp', 'Harli', 'hgallardp@ft.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '6/6/1980', 'Welcome to my profile', null, 'twitter.com/hkeartonp', null, 'linkedin.com/in/hkeartonp', false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('hmacaleesq', 'Hermione', 'hgosselinq@dropbox.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/12/2003', 'Welcome to my profile', null, null, null, null, false, true, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('sdominettir', 'Sollie', 'smechicr@kickstarter.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '11/3/1991', 'Hello!', null, null, null, null, false, false, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('ibaggarleys', 'Irina', 'igeralds@odnoklassniki.ru','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '6/7/1981', 'Hello!', 'www.instagram.com/ibaggarleys/', 'twitter.com/ibaggarleys', 'www.facebook.com/ibaggarleys', null, false, false, 'System Manager', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('bupshallt', 'Brita', 'bebbottst@vinaora.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/17/1987', 'Hello!', null, null, null, null, false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('jballantyneu', 'Jacquelyn', 'jseinu@hao123.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '5/4/2004', 'Hello!', 'www.instagram.com/jballantyneu/', null, 'www.facebook.com/jballantyneu', null, true, false, 'Moderator', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('eferrariov', 'Eb', 'efarndonv@arizona.edu','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '5/17/1983', 'Hello!', null, 'twitter.com/eferrariov', null, null, true, true, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('cdockreayw', 'Cathyleen', 'cgrzegorczykw@fda.gov','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '12/8/1982', 'Hello!', null, null, null, null, false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('gwaistellx', 'Gustavo', 'grutgersx@dedecms.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '12/2/1998', 'Welcome to my profile', null, 'twitter.com/gwaistellx', null, null, false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('kmccaddeny', 'Ki', 'kbarrasy@yale.edu','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '10/10/1992', 'Hello!', null, 'twitter.com/kmccaddeny', null, null, true, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('wsagez', 'Wilhelm', 'wburnz@nationalgeographic.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/7/1987', 'Welcome to my profile', null, null, null, null, true, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('dcockshut10', 'Deanne', 'dboarer10@huffingtonpost.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '12/21/1981', 'Welcome to my profile', 'www.instagram.com/dcockshut10/', null, 'www.facebook.com/dcockshut10', null, true, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('hmccarter11', 'Harbert', 'hfrancomb11@icio.us','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '1/7/2003', 'Welcome to my profile', 'www.instagram.com/hmccarter11/', null, 'www.facebook.com/hmccarter11', 'linkedin.com/in/hmccarter11', false, false, 'Moderator', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('mhunstone12', 'Mabel', 'mfolbige12@marriott.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '2/1/1987', 'Welcome to my profile', null, null, null, null, false, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('cclemintoni13', 'Cecile', 'czelland13@smugmug.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '10/17/1986', 'Hello!', null, 'twitter.com/cclemintoni13', null, null, false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('dpembridge14', 'Delilah', 'dtonsley14@yolasite.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '1/31/1997', 'Welcome to my profile', null, 'twitter.com/dpembridge14', null, null, true, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('vcarvell15', 'Valle', 'vpennell15@cbslocal.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '10/9/2000', 'Hello!', null, null, null, null, false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('kvandevelde16', 'Kori', 'kpighills16@ovh.net','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '7/30/1989', 'Hello!', 'www.instagram.com/kvandevelde16/', null, 'www.facebook.com/kvandevelde16', null, true, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('mhincks17', 'Mordecai', 'mbearfoot17@foxnews.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '4/7/2006', 'Welcome to my profile', null, null, null, null, false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('rdives18', 'Rebeca', 'rproudler18@opera.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '8/31/1998', 'Welcome to my profile', 'www.instagram.com/rdives18/', null, 'www.facebook.com/rdives18', null, true, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('dandriessen19', 'Donia', 'drosbrough19@devhub.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '7/28/1980', 'Hello!', null, 'twitter.com/dandriessen19', null, null, true, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('msterrie1a', 'Michele', 'mfancott1a@php.net','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '4/24/1980', 'Welcome to my profile', 'www.instagram.com/msterrie1a/', 'twitter.com/msterrie1a', 'www.facebook.com/msterrie1a', 'linkedin.com/in/msterrie1a', true, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('lwhitear1b', 'Lowe', 'lmessiter1b@tuttocitta.it','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/24/1987', 'Hello!', 'www.instagram.com/lwhitear1b/', null, 'www.facebook.com/lwhitear1b', null, false, true, 'System Manager', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('amcginley1c', 'Anatol', 'asirmon1c@ox.ac.uk','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '6/20/1996', 'Welcome to my profile', 'www.instagram.com/amcginley1c/', null, 'www.facebook.com/amcginley1c', null, true, true, 'Moderator', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('lmaulden1d', 'Leonard', 'lanthonies1d@github.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '4/9/1986', 'Welcome to my profile', null, 'twitter.com/lmaulden1d', null, null, false, false, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('hseiter1e', 'Hendrika', 'hchristensen1e@engadget.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '6/25/2001', 'Welcome to my profile', null, 'twitter.com/hseiter1e', null, null, true, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('hroutham1f', 'Harbert', 'htreverton1f@seattletimes.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '5/6/1983', 'Hello!', null, 'twitter.com/hroutham1f', null, null, true, true, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('eionesco1g', 'Edlin', 'eauden1g@multiply.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '9/22/1987', 'Welcome to my profile', null, 'twitter.com/eionesco1g', null, 'linkedin.com/in/eionesco1g', true, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('dlaven1h', 'Dorella', 'dsiddons1h@google.es','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '12/21/1994', 'Welcome to my profile', null, 'twitter.com/dlaven1h', null, null, true, true, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('mmaccafferky1i', 'Monica', 'mcheek1i@sciencedaily.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '5/26/2001', 'Welcome to my profile', null, null, null, null, false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('hlaxtonne1j', 'Hewitt', 'hhassin1j@wp.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/13/1991', 'Welcome to my profile', null, 'twitter.com/hlaxtonne1j', null, null, true, false, 'System Manager', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('dslixby1k', 'Debor', 'dleak1k@nyu.edu','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '1/18/2006', 'Welcome to my profile', null, 'twitter.com/dslixby1k', null, null, false, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('msaffen1l', 'Marline', 'mcroster1l@mit.edu','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '9/15/2004', 'Hello!', null, 'twitter.com/msaffen1l', null, null, false, true, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('kmielnik1m', 'Kylila', 'kmoyer1m@hatena.ne.jp','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/15/1999', 'Welcome to my profile', null, null, null, null, false, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('srobertshaw1n', 'Sherlock', 'sgabbatt1n@unesco.org','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '5/1/2004', 'Hello!', null, 'twitter.com/srobertshaw1n', null, null, false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('lkershow1o', 'Lauritz', 'ldench1o@marriott.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '1/5/1992', 'Welcome to my profile', 'www.instagram.com/lkershow1o/', null, 'www.facebook.com/lkershow1o', null, false, false, 'Moderator', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('lmelville1p', 'Lyell', 'ldyhouse1p@theglobeandmail.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '10/31/2006', 'Welcome to my profile', null, null, null, null, true, true, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('jwallhead1q', 'Jordan', 'jrevett1q@eventbrite.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '10/11/1986', 'Welcome to my profile', null, 'twitter.com/jwallhead1q', null, null, true, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('etrelease1r', 'Enos', 'ereyes1r@360.cn','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '1/3/1995', 'Welcome to my profile', 'www.instagram.com/etrelease1r/', null, 'www.facebook.com/etrelease1r', null, false, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('tscarlin1s', 'Tiebold', 'thayne1s@bigcartel.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '12/8/1989', 'Welcome to my profile', null, 'twitter.com/tscarlin1s', null, null, false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('ptomley1t', 'Penrod', 'phowles1t@163.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '1/5/2000', 'Hello!', 'www.instagram.com/ptomley1t/', 'twitter.com/ptomley1t', 'www.facebook.com/ptomley1t', null, false, true, 'System Manager', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('ggrosier1u', 'Griffie', 'gcourtney1u@columbia.edu','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '10/7/2000', 'Hello!', null, null, null, null, true, false, 'System Manager', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('wcrozier1v', 'Wayland', 'wrothon1v@diigo.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '10/29/2006', 'Welcome to my profile', 'www.instagram.com/wcrozier1v/', null, 'www.facebook.com/wcrozier1v', null, false, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('cpegg1w', 'Collin', 'ccornish1w@samsung.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '7/7/1993', 'Welcome to my profile', null, 'twitter.com/cpegg1w', null, null, false, false, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('nstrut1x', 'Nick', 'njills1x@weebly.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '5/24/2001', 'Hello!', null, 'twitter.com/nstrut1x', null, null, true, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('gkilmary1y', 'Gunilla', 'gnicholl1y@tinyurl.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '7/11/1989', 'Welcome to my profile', 'www.instagram.com/gkilmary1y/', null, 'www.facebook.com/gkilmary1y', null, false, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('lyude1z', 'Lorri', 'lentreis1z@technorati.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '2/2/2003', 'Hello!', 'www.instagram.com/lyude1z/', null, 'www.facebook.com/lyude1z', null, false, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('ldanne20', 'Leanor', 'lqueyeiro20@moonfruit.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '6/29/2000', 'Hello!', 'www.instagram.com/ldanne20/', 'twitter.com/ldanne20', 'www.facebook.com/ldanne20', null, false, false, 'System Manager', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('sbevir21', 'Seth', 'svanniekerk21@disqus.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/24/1987', 'Hello!', 'www.instagram.com/sbevir21/', null, 'www.facebook.com/sbevir21', null, false, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('mmcginley22', 'Meyer', 'melders22@dailymotion.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '4/15/1994', 'Welcome to my profile', null, null, null, 'linkedin.com/in/mmcginley22', false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('jelcome23', 'Jerrome', 'jtanswill23@acquirethisname.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/21/2002', 'Hello!', 'www.instagram.com/jelcome23/', null, 'www.facebook.com/jelcome23', null, false, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('egerdes24', 'Estell', 'elampard24@cocolog-nifty.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '4/13/1999', 'Hello!', null, 'twitter.com/egerdes24', null, null, false, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('droddick25', 'Dorotea', 'doldknow25@sourceforge.net','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '12/10/2000', 'Hello!', 'www.instagram.com/droddick25/', 'twitter.com/droddick25', 'www.facebook.com/droddick25', 'linkedin.com/in/droddick25', true, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('lclementi26', 'Lion', 'lflancinbaum26@altervista.org','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '4/13/1987', 'Hello!', 'www.instagram.com/lclementi26/', 'twitter.com/lclementi26', 'www.facebook.com/lclementi26', null, true, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('wgreenhalf27', 'Willie', 'wnend27@princeton.edu','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '6/14/1992', 'Welcome to my profile', 'www.instagram.com/wgreenhalf27/', null, 'www.facebook.com/wgreenhalf27', null, true, false, 'System Manager', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('djosilevich28', 'Debee', 'dcummins28@webnode.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '1/25/1981', 'Hello!', null, 'twitter.com/djosilevich28', null, null, true, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('rcroom29', 'Rayna', 'rrapelli29@cbc.ca','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '7/4/1994', 'Welcome to my profile', 'www.instagram.com/rcroom29/', null, 'www.facebook.com/rcroom29', null, true, false, 'System Manager', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('blever2a', 'Billie', 'bdeviney2a@constantcontact.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '1/5/1996', 'Welcome to my profile', null, 'twitter.com/blever2a', null, 'linkedin.com/in/blever2a', false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('sgyorgy2b', 'Sandye', 'szotto2b@posterous.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '12/15/2000', 'Hello!', 'www.instagram.com/sgyorgy2b/', null, 'www.facebook.com/sgyorgy2b', null, true, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('gnyles2c', 'Ginni', 'gleadbitter2c@usatoday.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '11/16/1983', 'Hello!', 'www.instagram.com/gnyles2c/', 'twitter.com/gnyles2c', 'www.facebook.com/gnyles2c', null, false, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('rwinsor2d', 'Raeann', 'rlaughtisse2d@engadget.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '6/27/1989', 'Welcome to my profile', null, null, null, 'linkedin.com/in/rwinsor2d', true, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('cprall2e', 'Carlin', 'cjaggi2e@wp.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '1/11/1987', 'Hello!', null, 'twitter.com/cprall2e', null, null, false, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('lsuero2f', 'Layla', 'lfurphy2f@pbs.org','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '4/7/1983', 'Welcome to my profile', null, null, null, null, false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('dgarrold2g', 'Donna', 'dgater2g@nydailynews.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '9/6/1993', 'Welcome to my profile', null, 'twitter.com/dgarrold2g', null, null, false, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('nlazonby2h', 'Niall', 'ntranmer2h@bloglines.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '6/30/1986', 'Welcome to my profile', 'www.instagram.com/nlazonby2h/', 'twitter.com/nlazonby2h', 'www.facebook.com/nlazonby2h', null, true, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('mtrevon2i', 'Malena', 'mhyndley2i@epa.gov','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '9/30/1988', 'Hello!', 'www.instagram.com/mtrevon2i/', null, 'www.facebook.com/mtrevon2i', null, false, false, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('rtanti2j', 'Ralph', 'rwaeland2j@free.fr','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '9/28/2000', 'Welcome to my profile', null, null, null, null, true, true, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('bnesey2k', 'Bearnard', 'brubury2k@google.com.au','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '6/27/1986', 'Welcome to my profile', null, null, null, null, false, false, 'Moderator', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('rmowett2l', 'Rosina', 'rgill2l@tinypic.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '2/8/2001', 'Welcome to my profile', null, 'twitter.com/rmowett2l', null, null, true, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('wmannie2m', 'Wendi', 'whorwell2m@indiegogo.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/13/1993', 'Hello!', 'www.instagram.com/wmannie2m/', null, 'www.facebook.com/wmannie2m', null, true, true, 'System Manager', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('chousden2n', 'Calvin', 'ccanape2n@npr.org','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '1/31/1993', 'Welcome to my profile', 'www.instagram.com/chousden2n/', 'twitter.com/chousden2n', 'www.facebook.com/chousden2n', null, true, false, 'Moderator', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('slathwell2o', 'Sherm', 'ssancraft2o@diigo.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '2/28/2007', 'Welcome to my profile', 'www.instagram.com/slathwell2o/', 'twitter.com/slathwell2o', 'www.facebook.com/slathwell2o', null, false, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('rchidlow2p', 'Riannon', 'rhaynes2p@reference.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '12/1/1997', 'Welcome to my profile', null, 'twitter.com/rchidlow2p', null, null, false, false, 'Regular', null);
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('jwyllie2q', 'Jocko', 'jmotherwell2q@hp.com','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '3/18/2005', 'Hello!', 'www.instagram.com/jwyllie2q/', 'twitter.com/jwyllie2q', 'www.facebook.com/jwyllie2q', null, true, true, 'Regular', 'abs.jpeg');
insert into authenticated_user (username, name, email, password, birthdate, bio, instagram, twitter, facebook, linkedin, show_people_i_follow, show_tags_i_follow, authenticated_user_type, profile_photo) values ('dbatram2r', 'Davidson', 'dashburner2r@yahoo.co.jp','$2a$10$UOp0VuqFRc6nJeWehKXccO9N61vdMC91n.YHHJWoovp0y3Hg9KgWW', '8/6/1992', 'Hello!', 'www.instagram.com/dbatram2r/', null, 'www.facebook.com/dbatram2r', null, true, true, 'Regular', 'abs.jpeg');

--POST
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Writers in culture war over rules of the imagination', 'abs.jpeg', 'It is a venerable global cultural institution, dedicated to freedom of expression and set to celebrate its centenary this year. Yet the writers’ association PEN is being drawn into dispute over a declaration claiming the right of authors to imagination, allowing them to describe the world from the point of view of characters from other cultural backgrounds.
At issue is a charter manifesto, The Democracy of the Imagination, passed unanimously by delegates of PEN International at the 85th world congress in Manila in 2019. A year on, through the social upheavals of 2020, PEN’s US arm, PEN America, has not endorsed the manifesto, which includes the principle: “PEN believes the imagination allows writers and readers to transcend their own place in the world to include the ideas of others.”
While welcoming the commitment to freedom of expression, officials at PEN America indicate that aspects of the declaration might be perceived as straying into the contentious territory of cultural appropriation.
A spokesperson for PEN America told the Observer that the manifesto had not been explicitly rejected – two members of PEN America helped draft it – but “that does not necessarily indicate that we as PEN America formally endorse that action on behalf of our staff or board”.
Behind the scenes, however, the manifesto has caused friction between PEN International and companion PEN organizations around the world. Being asked to adjudicate disputes in a time of cultural upheaval is not uncommon for an organization dedicated to supporting writers, but it’s one it would sooner avoid.
Last year PEN International was called on to weigh in on accusations of transphobia against JK Rowling. “The ability to write or speak freely without harassment stands as much for trans writers defending their rights as it does for JK Rowling,” PEN’s president, Jennifer Clement, stated.
', true, TIMESTAMP '2020-05-21 08:05:43', 218, 'article', 'literature', 8);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Charlotte Rampling: ‘I am prickly. People who are prickly can’t be hurt any more’', 'abs.jpeg', '‘That photoshoot was such fun,” Charlotte Rampling says. “I was pinging.”
“You were pinging?”
“Yes, I really was pinging,” she says, with that imperious cut-glass accent. “Pinging is when you’re at the right place at the right time, and you know you can just make magic happen everywhere.” We don’t ping often in life, she says, but when we do, it’s wonderful.
It’s a cold, sunny day in Paris when we Zoom. Rampling is in her apartment in Saint-Germain-des-Prés, “which is just like the old Chelsea that I loved”. She is wearing shades, but takes them off to reveal those famous hooded blue-green eyes.
Does she feel more French than English these days? “I was thinking about this last week. I don’t feel I belong to one specific place. It doesn’t fit with who I am. I like to think I can spread further somehow. It’s a good feeling, actually. Quite often I have felt uncomfortable about it.” Why? “Because I thought it was one of the sources of feeling very alone. But I don’t think it is now.”
She says it is empowering when you accept that there is always a positive side to a negative, and vice versa. “When you think you’re riding on a good wave, you’re pretty sure the next one is going to be shite. We function through contrast.” What would life be like without the shite? “Really dull.”
The 75-year-old actor takes me back to the first time she knowingly pinged. She was 14, shy and withdrawn. The family was living in Harrow, Greater London, having recently returned from Fontainebleau where her army officer father had been stationed. She and her sister Sarah performed before an audience for the first time at the annual cabaret in suburban Stanmore. Anybody who was anybody turned up to The Smoking Concert and did a little turn. To her astonishment, she loved it. “I felt so great on stage. We wore fishnet tights, macs and berets, and sang a series of sweet French songs. I knew I was good, because I was absolutely in tune with myself at that moment.”
', true, TIMESTAMP '2021-01-31 06:47:58', 158, 'review', 'cinema', 46);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The return of Dragon’s Den: it’s business as usual, but the show’s lost its charm', 'abs.jpeg', 'New series of Dragons’ Den (Thursday, 8pm, BBC One), then. No point me saying anything like: “They have changed Dragons’ Den – it is different now.” There is no point in me lying to you. The point of Dragons’ Den is that it is always Dragons’ Den. We are 16 years, 17 series and 18 separate Dragons deep into it now, and we have seen tectonic shifts in the global economy over that time – the collapse of the housing market! Austerity! The impending doom of the post-Covid financial reality! – and no matter what happens, somewhere in Salford Quays, Deborah Meaden is sitting next to a big stack of printed-out money, refusing to spend it.
Listen: I’m never going to dunk on the TV show that gave us Reggae Reggae Sauce. But it is fair to say that Dragons’ Den has started to lose a little of its charm. You know the format by now: nervous pitchers go up in a big goods lift (there are five types: weird inventor; comfortably wealthy businessman who has a wheeze to become even more comfortably wealthy; earnest couple; mum with an idea; strange business odd couple who somehow already have £4m of investment), say their idea, don’t know their turnover for some reason, leave with less equity than they would have liked, but a Dragon onside. That’s it.
Here’s the thing: the most iconic Dragons’ Den pitches are the ones that break the Dragons from their icy facade: you either make Peter Jones laugh (“Look: I like you”) or one of the other ones cry (“I believe in you”). The most boring Dragons’ Den business pitch is the one that is just a business pitch. There is no theatre to that. But Deborah Meaden has heard every possible sob story going. Peter Jones has laughed at every joke. He does not need to ever laugh at a joke again. This week’s episode (featuring an OK idea for a monthly subscription teabag service) fails to get a rise out of them. They hand some money over anyway.
', true, TIMESTAMP '2020-08-07 16:38:31', 173, 'review', 'tv show', 85);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Angela review – Mark Ravenhill’s tale of dance and dementia', 'abs.jpeg', 'Anyone who has observed dementia at close quarters is likely to recognise the unspoken pain contained in Mark Ravenhill’s autobiographical audio drama about his late mother’s Alzheimer’s. But rather than showing us the effects of Angela’s dementia on himself and his father, Ted, the playwright gives primacy to her inner voice and confusions, building a rich subjectivity despite the accompanying sadness.
This play is the first in a series for Sound Stage, an audio-digital theatre platform created by the Royal Lyceum theatre and Pitlochry Festival theatre that aims to give its audience the online experience of going to the theatre (with an interval and after-show discussions). Understated and melancholic, it has none of the brazenness of Ravenhill’s past work.
Under the direction of Polly Thomas, we follow Angela’s stream of consciousness from characterful scenes in early life (peeling potatoes with her mother, she says she no longer wants to be called by her birth name, Rita, and will now be known as Angela) to her am-dram days, the lustful moment of meeting Ted at a dance, and the trauma of a miscarriage that becomes more vivid in late illness (“the girl bled away”). There are snippets from the playwright’s childhood, too, placed alongside her postnatal depression, a heart attack and the onset of Alzheimer’s.
', true, TIMESTAMP '2021-02-22 13:13:46', 92, 'review', 'theatre', 72);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Talawa theatre company: ’It’s time to double down on Black Lives Matter pledges’', 'abs.jpeg', 'Britain’s oldest black theatre company, Talawa, is plotting its 35th-anniversary celebrations and hopes to go big. It might have gone bigger, had its plans to stage an ambitious season of works not been aborted late last year. Michael Buffong, its artistic director, had programmed Black Joy at Birmingham Rep for this autumn, which “was supposed to present a step change” in its scale and ambition.
Then Birmingham Rep decided to hire out space to the Ministry of Justice so it could function as a Nightingale court during the pandemic. Public statements were made by Talawa, whose plans were withdrawn because it “threatened the integrity” of the season. Buffong reflects: “We were presented with the decision: ‘This is what’s happening.’ What we learned is that it caused a lot of upset with black artists and communities in Birmingham [who] we need and want to be part of the Black Joy season. As soon as [the Rep’s] decision was made, it effectively made the season untenable. They were not now engaging with the Rep so how do we make this happen? It becomes impossible.”
Was it also a protest against Britain’s criminal justice system? That’s not for us to say, adds Carolyn ML Forsyth, who came to the company as executive director and joint CEO last November. But it was imperative that Talawa remain sensitive to local communities and artists, they stress.
Buffong says other theatre companies voiced their support privately: “It’s linked to the idea of theatre as safe and neutral spaces, which is very important for art to flourish.” In a statement last year, the Rep said it believed it “must be a theatre for all of Birmingham’s people and communities. In no way have we wished to put any artists or partners of ours in a compromised position.”
', true, TIMESTAMP '2019-10-10 05:13:06', 139, 'review', 'theatre', 86);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Inside review – trio of anxious lockdown studies', 'abs.jpeg', 'Inside comprises three short studies of what it means to be locked down and lonely from the perspective of three older women (a second part will focus on “outside”). Performed live on the stage of the Orange Tree theatre, and directed by Anna Himali Howard, it is a response to the pandemic that stutters at times but also captures the spirit of live theatre on screen.
Much of the drama is contained in its stagecraft: Shankho Chaudhuri’s abstract set is clean and haunting, with doors and windows often illuminated to delineate the boundary between inside and out, while Jessica Hung Han Yun’s beautiful lighting contains a painterly quality playing with light and dark, along with more urgent light flashes of melodrama.
', false, TIMESTAMP '2020-02-01 13:24:47', 85, 'review', 'theatre', 60);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Grey’s Anatomy: the TV show that has always been there for me', 'abs.jpeg', 'There’s a song that I listen to every time I begin to feel the tendrils of sadness take a grip. For nearly 15 years, this song – Grace, by the Norwegian singer Kate Havnevik – has soundtracked every desperate and devastating moment in my life. It’s a little self-indulgent gift I give myself when I need to be enveloped by despair.
However, if I’m honest, I don’t listen to this song because of its lyrics, although they are melancholic, nor because it’s particularly emotional, although it is. I listen to it because of how it made me feel the first time I heard it, which was during the season-two finale of Grey’s Anatomy. After nearly 27 episodes of will-they-won’t-they, the show’s two romantic leads, Dr Meredith Grey and Dr Derek Shepherd, slope off together for an illicit sexual tryst in an exam room. It’s a moment of reckoning for both characters, imbued with lust and sorrow, and I must have seen it more than 10 times.
My emotional reliance on that song reminds me just how inextricably linked my life has become to Grey’s Anatomy. First airing in 2005, the show is now the longest-running medical drama in US television history. Now on its 17th season, it follows the lives of the surgical staff at a fictional Seattle hospital. The first hit series for the inimitable television mogul Shonda Rhimes, the show is renowned for subjecting its characters to catastrophic events, untenable amounts of trauma, horrifying deaths and accidents – and unbearable torrents of heartbreak. Such antics have helped turn it into a multibillion-dollar franchise and, 16 years since it began, it’s still the highest-rated drama for its home network, the Disney-owned ABC.
It’s also one of the most important things in my life. It wouldn’t be far-fetched to say that I begin a re-watch of Grey’s Anatomy every year, either consuming the show from the beginning or working through my favourite episodes as if I’m choosing from a pick ’n’ mix of pain and suffering. No other TV show leaves me as distraught; watching Grey’s Anatomy is often so painful for me that it verges on unpleasant. Yet, time and time again, I keep going back. Why? Because, despite all the suffering and the subsequent excitation-transfer I experience as a result, Grey’s Anatomy has also provided me with comfort and space for self-exploration at the times when I’ve needed it most.
***
I watched my first episode of Grey’s Anatomy when I was 16. It was autumn, two years after my dad moved out and a year after my best friend died of cancer at 15 after a cruel and intense illness. Grief wasn’t so much a feeling as the backbone of my existence; an ache that sat within my chest constantly threatening to crack me in two. When I was hungover on the weekends after Friday and Saturday nights spent in various parks necking bottles of cider, I would watch the show on an old desktop monitor, sitting in an office chair in my pyjamas.
The world of Seattle Grace hospital, the complex lives of the surgical interns and their often-unusual life-or-death medical cases drew me in, but it was the character of Meredith Grey, played by Ellen Pompeo, whom I latched on to. Meredith was complicated, her love life a disaster and her family life even more so. Having been abandoned by her father when she was young, she was dealing with her cold and ambitious mother, who had early-onset Alzheimer’s. The man she was in love with, Dr Derek “McDreamy” Shepherd, played by Patrick Dempsey, had revealed that he was married and that, after his ex-wife’s sudden appearance in Seattle, he would be trying to give his marriage another shot. The only good thing in her life was her friendship with her fellow surgical intern, the competitive, difficult and driven Cristina Yang, played by Sandra Oh.
', true, TIMESTAMP '2021-01-25 06:10:03', 181, 'news', 'tv show', 73);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Falcon and the Winter Soldier episode two recap: androids, aliens, wizards and super soldiers', 'abs.jpeg', 'A big shield to fill
Hello and welcome to the second TFATWS recap. This second episode opens with one of Rhodey’s lines from last week (“The world’s a crazy place right now. Alliances are all torn apart …”), part of Sam’s Washington speech about symbols being nothing without the people that give them meaning, and a reminder that Bucky is having nightmares about his Hydra missions. All in all, a pretty neat precis of what’s about to follow, with the old band getting back together, the new Captain America revealing himself unfit to carry Steve Rogers’ notebook and the Winter Soldier dragged back in to his former life of violence.
Instead of Battleship and drinking games, we get John Walker, Captain America, who is nervous ahead of a ceremony at his old high school in Georgia. We meet Lamar Hoskins, who later reveals himself as Battlestar, new Cap’s Bucky, and an interview in which Walker offers a cringeworthy story about seeing Steve Rogers as a brother, despite having never met him. Cheesy as it may be, it at least motivates Bucky in to action …
Avengers, of sorts … Reassemble
The reunion between our eponymous heroes isn’t quite the grand affair we might have expected, consisting as it does of Bucky barging in to an aircraft hangar to harangue Sam about giving Cap’s shield away.
There’s some expositional dialogue, a nice line about the big three – androids, aliens and wizards – and the definition of a sorcerer, and then they’re off to Munich, where the Flag Smashers have been sighted.
I am a fan of the chemistry between Sebastian Stan and Anthony Mackie, although I hope the reliance on gags about Bucky being old, staring a lot and hating Redwing aren’t overplayed. Sooner or later, they have to bond properly. If you consider their first meeting, though – the Winter Soldier, on the roof of Sam’s car, grabbing the steering wheel out of his hand and trying to kill him – and this is practically a love-in.
', true, TIMESTAMP '2021-03-01 02:17:56', 1, 'news', 'tv show', 23);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Lucille Bluth was the role Jessica Walter was born to play', 'abs.jpeg', 'Jessica Walter racked up a reported 161 film and TV credits over her 70-year acting career. If that number had only been 160, she would have still been the best sort of actor: a safe pair of hands who gets consistent work shoring up individual episodes of long-running shows. The spectrum of series that Walter appeared in over the years was impressive: Flipper, Columbo, Hawaii Five-O, Quincy, Knot’s Landing, Magnum, and Law and Order are just a few. She would pop in for a single episode, class it up a little and leave.
However, she will be remembered for one show above all. As Lucille Bluth in Arrested Development, Walter landed the role she was born to play: a beautifully written, brilliantly wicked character that she elevated to icon status.
Arrested Development was nothing less than a star-making machine. Almost every person involved in the series has gone on to new heights. It made movie stars out of Jason Bateman, Will Arnett, Michael Cera and David Cross, and launched the career of Alia Shawkat, now leading the cult comedy Search Party. Even the show’s longtime directors, the Russo Brothers, ended up making the biggest film of all time.
Yet Lucille was, arguably, the heart of the show. Even more so than Bateman’s Michael, the everyman caught in the middle of his awful warring relatives, Lucille held things together. A parental figure who was always present, consistent and fully in charge. Whenever any of her adult children looked as if they might be edging for the door, she would deploy an arsenal of psychological tactics – bullying, guilt-tripping, reverse psychology, flattery – to keep them in place. There’s no question that Lucille Bluth is a staggeringly bad parent. But you can’t deny that she knows her children well. She smothers Buster (“He’s become too much of a big shot to brush mother’s hair”). She attacks Lindsay with barely veiled criticisms about her weight (“You want your belt to buckle, not your chair”). She “doesn’t care” for Gob. She knows exactly which buttons to push to do the most damage, which at least means she is observant. Lucille is why the Bluths are the Bluths. There would be no Arrested Development without her.
In the last year or so, a lot of love has been shown for Moira Rose, the similarly eccentric matriarch from Schitt’s Creek. Lucille was Moira before Moira, just as moneyed and out of touch, but with no identifiable soft edges. And yet, it was still possible to identify with her. Look at the blizzard of Lucille memes that sprung into action when it was announced that Walter had died. They all show a woman of a certain age who has simply stopped listening to the rules. She’s drunk. She’s dismissive. She’s knowingly cruel. There’s a freedom to Lucille that I think everyone envies just a little bit. This was her masterstroke. She wasn’t likable, but she was aspirational.
', true, TIMESTAMP '2021-03-05 20:24:09', 129, 'news', 'tv show', 38);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The week in theatre: Angela; The Band Plays On; Hear Me Out reviews – shopping and ducking', 'abs.jpeg', 'It is a long way from Shopping and F***ing. In 1996 Mark Ravenhill was celebrated and reviled for his rapid, urban scenes, one of which featured oral sex in Harvey Nicks. Now he has written a domestic, autobiographical audio drama that proclaims the importance of Beatrix Potter’s animal tales.
Angela is the first of eight new plays produced by Sound Stage, the audio-digital theatre platform set up by Pitlochry Festival Theatre and Edinburgh’s Royal Lyceum in collaboration with Naked Productions. It is a promising start. A strong cast includes Toby Jones, Pam Ferris and Joseph Millson. Polly Thomas’s direction is decisive: not bombarded with sound effects but inflected by Alexandra Faye Braithwaite’s music, which falls like a sigh between scenes. Wistfulness and disturbance are intertwined in episodes from the life of the dramatist’s mother.
As a child, she announced she didn’t like her given name – Rita – and wanted to be called Angela, which her own mother thought very la-di-dah. In old age, besieged by Alzheimer’s, she didn’t know who she was, forgot she had a son, and threw scalding tea at her loyal husband. As a young woman, she was in anguish at the miscarriage of a baby girl. As a mother, she brushed aside the anxiety of her sister, who thought ballet-obsessed little Mark might “grow up funny” – and patiently made him a Jemima Puddle-Duck costume.
In an improbable, lovely stroke, that dotty costume mirrors her anguish. Potter was not soft and her stories are full of shadows: her webbed heroine has difficulty hatching her eggs, has some eaten by dogs and is herself nearly killed by a fox. The costume is also a clue to the character of the budding dramatist. The toddler Mark wants an audience, and wants control of the whole story. “He’s got the tights and the beak,” sighs Angela. “Now he wants the shawl.”
', true, TIMESTAMP '2020-06-04 19:12:33', 217, 'article', 'theatre', 46);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Shakespeare’s Globe to reopen in May staging plays with no intervals', 'abs.jpeg', 'Shakespeare’s Globe theatre on Wednesday announced its post-lockdown summer reopening plans, with a series of safety protocols in place – including no intervals.
The play’s the thing and not the glass of wine and dash to the toilet in the middle, theatregoers will realise.
Announcing the season, which will see productions of A Midsummer Night’s Dream, Romeo and Juliet and Twelfth Night, artistic director Michelle Terry said the switch to continuous performances was a good and exciting thing.
“They were never written with intervals so we won’t play them with intervals,” she said. “They’ll work better without them, in my opinion.”
Terry said there is a momentum and accumulation in Shakespeare’s plays which is best not disrupted. An interval breaks “a tension that he is deliberately trying to create”, she said.
Shakespeare himself, in the prologue to Romeo and Juliet, wrote of the “two hours’ traffic of our stage”. As many theatregoers well know, his plays can go on for considerably longer.
Terry said: “I’m not pinning directors down to make it two hours but I’ll think we’ll look for two-hour traffic, two-and-a-half hour traffic plays, and allow these plays to be played as they were written.”
It will also empower audiences, she said. “The joy is you’re not fixed in your seat. If you need to get up and go to the toilet you can go, if you need to get up and get a breath of fresh air, you can go, because we also know that he [Shakespeare] said everything at least three or four times. If he really wants you to know something he’ll make sure he repeats it.”
The outdoor theatre on the South Bank in central London will reopen on 17 May with social distancing in the audience and on stage. Seats will be placed in the space where groundlings normally stand, arrival times will be staggered, entrances allocated and drinks pre-ordered.
In line with government guidelines the distancing will be reduced from 21 June, with the hope being, as vaccination is rolled out across the population, mass congregation returns.
Shakespeare’s Globe theatre, like all arts organisations, has been brought to the brink of closure by the pandemic, using its reserves and benefiting from the government bailout in order to survive.
Chief executive Neil Constable said the theatre would operate this summer at half the scale it was at before the pandemic, with annual turnover expected to be down from £25m to £12m.
Terry said it had clearly been a challenging time for everyone, but “that’s quite enough reality. Now let’s have some imagination, let’s have some play.”
She added: “That’s the aim of this season, to have some catharsis. Not deny the time … [we need to] acknowledge the grief, the loss, the anxiety. But let’s use plays, let’s use theatre to learn how to be together again.”
Luckily, she said, they had a resident writer all too aware of how to emerge from such dark times.
The production of Romeo and Juliet, which had been in rehearsals when the theatre closed last year, will star Alfred Enoch and Rebekah Murrell in the title roles.
Terry said it was a “once in a generation opportunity where the audience will understand the context of the play as much as the players”. For example, no one would need to have “a plague on both your houses” explained to them.
“Not to deny the hell of that play, the dystopia of that play, the broken society, the police brutality. Shakespeare does not shy away from the difficult conversations and neither will we.”
', false, TIMESTAMP '2020-08-15 08:05:54', 240, 'news', 'theatre', 14);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Hausen – grim and grimy German chiller casts a dark shadow', 'abs.jpeg', 'It’s dark, and rain pours down thickly, as wan teenager Juri (Tristan Göbel) and his ursine father Jaschek (Charly Hübner) arrive at the tower block they’ll soon regret calling home, in the opening scene of the German chiller Hausen (Sky Atlantic). Prepare for horror of the dripping, oozing, inky kind, set in a cursed building where the taps seem to be watching you, the condensation on the windows has a threatening aura and mould is a supporting character. It’s grim, grimy, cobwebbed and dank. Very dank.
Jaschek is the flats’ new caretaker, tasked immediately with fixing a heating system clogged with tar that seems to choose which way it flows. That leaves Juri to wander the corridors, stumbling across creepy Shining-like children and cackling vagrants who act as if they know something. We, however, know little for an episode and a half, as Hausen very slowly builds an atmosphere designed to bring on the night-time heebie jeebies.
Eventually we meet the other residents, all of them nervous, wild-haired souls with filthy faces, including a couple who haven’t summoned the energy to name their newborn baby and can’t afford to buy him formula. The dad is addicted to some sort of hallucinogenic snuff, the source of which he stays coy about: from that we have the bones of a story, and by the end of the second hour – Sky wisely debuted Hausen as a double bill, so as not to leave viewers adrift after the coldly baffling first instalment – it can be deduced that there is no malevolent presence haunting the apartment block. Rather, the block itself is the monster. The show’s love of sinewy tangles and suppurating ick give it a body-horror vibe, but this is building-horror.
It must be a multistorey metaphor, but for what? Depression, with the black slime on the walls like a black dog on the shoulders of the building’s inhabitants? Poverty, since the tenants have not only been abandoned in squalor, but also appear to be stuck in a system that actively tries to stop them escaping? The collapse of society, because people who need help struggle to find a neighbour who doesn’t listlessly shut the door in their face? Or simply grief? It seems to be the last of those when Hausen confirms what we suspected from the first minute: Juri’s mother has recently died, and Jaschek’s decision to take the janitor job is an attempt at a fresh start that’s turned out rotten. There are so many things that need mending.
Something will, it is to be hoped, give Hausen an emotional anchor to attach to what otherwise feels like a random carnival of disgust. These initial episodes spend a lot of time trying to create images that will snag their hooks in our minds, but most of them don’t because they’re not quite alien enough to be disturbing without us understanding why they’re there. Nobody these days is going to be spooked by a vision as familiar as a rat mozeying along a ventilation shaft, and the most successful scenes – read: the most degrading and awful – turn on reveals that are more grindingly bleak than memorably horrific.
There is, however, hope in the form of how confident Hausen is in maintaining its dream logic and sludgy aesthetic. It gives off a sense of knowing what it’s doing but taking too long to do it, rather than wandering forward with no plan. Juri and Jaschek’s relationship is promising, too, with its hints towards a tale where extreme adversity hastens the process of recognising that the parent no longer knows better than the child: Jaschek’s old-school practical nous is no use in the new reality he and his son must live with.
Hausen needs to start providing better payoffs, and quickly. Because unlike the people who live in the flats, we’re not trapped. We need a reason to stay.
', true, TIMESTAMP '2019-01-27 23:53:48', 46, 'news', 'tv show', 72);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Serpentwithfeet: Deacon review – a swoon in the Californian sun', 'abs.jpeg', 'There can be few albums this year more wholesome, soppy or unabashedly life-affirming than Deacon, the second full-length outing from Serpentwithfeet, a man whose many facial tattoos include a large pentagram in a circle on his forehead and the new album’s title in block capitals across his throat. Across 11 varied tracks, Deacon is a doom-banishing celebration of love and friendship, a record bathed in California sunshine and gratitude. It is not only at stark odds with the maverick songwriter-producer’s forbidding-looking presence – nose ring, hair in horn-like pigtails – but also with his previous body of work.
Born in Baltimore, transplanted to Brooklyn, but now happily ensconced in Los Angeles, 32-year-old Josiah Wise grew up singing in church, an experience that has coloured his gospel-infused take on R&B. But he also trained in jazz and the classical tradition. This eclectic corpus of knowledge has given rise to a series of arresting EPs and a previous album, 2018’s Soil, full of heavenly vocal gymnastics as well as arrhythmic, atypical chamber-pop inflections. In 2017, he went on tour with indie band Grizzly Bear and duetted with Björk, a fellow traveller in vocal effusion. Since then, Serpentwithfeet has added rapper Ty Dolla Sign, Ellie Goulding and designer-turned-musician Virgil Abloh to his gamut of collaborators.
While Wise’s previous work hasn’t exactly been forbidding, its left-field digitals and multitracked, borderline operatic vocals have tended to dwell on high drama and the agonies of love. Not any more. Deacon is a 180-degree pivot, a record so serene, poppy and loved up you can’t help but swoon along with it.
Its lead single, Same Size Shoe, hinges on a nagging schoolyard chorus: “Me and my boo wear the same size shoe,” he croons, so clearly delighted that he calls for trumpets and then starts scatting. “Bah bah bah dah!”
', false, TIMESTAMP '2020-10-06 13:35:15', 225, 'review', 'music', 61);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Good, clean fun with Mrs Hinch – podcasts of the week', 'abs.jpeg', 'Picks of the week
All the Best (and Worst) With Mr and Mrs Hinch
Instagram’s leading cleaning guru Sophie Hinchliffe has become a vinegar-touting sensation with four million followers. She kicks off her new podcast with the story of how she and husband Jamie met at work. “A good back and a nice set of teeth,” she muses. “You were fit,” he recalls. It’s a tale with the depth of a Love Island bikini in which nothing much happens except a trip to Primark to buy accessories for a date, but fans will lap up the bubbly and likable couple. Hannah Verdier
Born In Ghostland
Where is home, if home doesn’t exist any more? Host Yelena Zhelezov speaks with people from countries or territories which are now extinct, to find out what happens to a person’s sense of self, in a thoughtful show from EastEast Radio, a new online station focused on “stories and music from West Asia, north Africa, the Global east and its diasporas”. Her first guest is Anna Zoria, an artist who was born in Khabarovsk, Russia, at the tail end of the Soviet Union, and who later learned about the realities of communist rule through her parents. Hannah J Davies
Producer pick: I’m Not a Monster
I enjoy listening to podcasts when I have no idea what the outcome will be at the end. It’s hard to find a show that can offer that these days. Often I’ll know what the story is, but will listen for analysis, or deeper knowledge.
I’m Not a Monster by BBC Sounds, Panorama, and PBS Frontline ticked all of the boxes, though. I hadn’t seen host Josh Baker’s original reporting, so I was going in cold. The series is a perfect example of a slow burn teaser throughout. The listener is introduced early on to the titular character, “the monster” – otherwise known as Sam Sally – an American woman who ended up in the heart of the Isis ‘caliphate’ in Syria with her children.
As the series develops, it’s up to the listener to decide whether Sally is a victim, or a mass manipulator – at the end of every episode I had changed my mind and come to new conclusions. Though I didn’t binge it in one go, I was always glad when I went back to it.
', true, TIMESTAMP '2020-07-28 02:19:59', 176, 'review', 'tv show', 28);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Black Power: A British Story of Resistance review – a tortuous fight for justice', 'abs.jpeg', 'Steve McQueen’s film series Small Axe grew out of a desire to tell Britain’s stories of black resistance. So, too, does this complementary documentary (BBC Two), executive produced by McQueen, narrated by Daniel Kaluuya and directed by George Amponsah, whose credits include the 2015 feature documentary The Hard Stop, about the aftermath of Mark Duggan’s death at the hands of the Metropolitan police.
These means are necessary – to borrow a phrase – because so many stories remain overlooked and untold. Narrative cinema has a unique power but, as conversations surrounding the Oscar-nominated Judas and the Black Messiah and The Trial of the Chicago 7 have demonstrated, Hollywood’s requirement that movies be palatable to a wide audience can trump historical accuracy, sometimes in troubling ways.
For many, the first surprise of British black power is that it existed – and not just in the hopeful imaginations of a few sixth-form revolutionaries with cool American cousins. This film describes a multifaceted movement for change that consisted of a variety of groups – the United Coloured People’s Association, the British Black Panthers, the Fasimbas, the Black Liberation Front and many more – all over the UK in the late 60s and early 70s. Interviews with key members and archive clips of others provide insight into what it was really like to be at those meetings, protests, court cases and house parties.
Most British schoolchildren study the US civil rights era, but this country has its own civil rights heroes: the brilliant legal mind and inspirational speaker Darcus Howe (who died in 2017); Altheia Jones-LeCointe, (played by Letitia Wright in McQueen’s film about the Mangrove Nine) whose incisive analyses remain on point; the exhilarating Speakers’ Corner presence Roy Sawh; the “fearless” south London community activist Olive Morris. Amponsah revives their reputations and honours their legacies with an editing device that takes us into the darkrooms of the black photographers Neil Kenlock and Charlie Phillips.
Any tendency towards fanzine-style fawning is kept in check by the inclusion of the movement’s most confusing, conflicted chapters. Candid, regretful accounts of the 1975 “Spaghetti House siege” reveal the extent to which revolutionary ideology is open to exploitation by dangerous elements. Among multiple, faltering attempts to explain how a petty crook and eventual murderer such as Michael “Michael X” de Freitas was able to hoodwink not only the establishment media, but also many good-faith, grassroots activists, it is Howe – speaking in 1998 – who seems to get closest: “I used to like to hear black people say things that were brave and bold, even if it didn’t make sense, because we were too quiet.”
Michael X featured recently in the Adam Curtis series Can’t Get You Out of My Head, but this documentary crams in much more relatively unfamiliar and unseen material – from the murder of Kelso Cochrane in 1959, through three ineffectual iterations of the Race Relations Act, right up to recent Black Lives Matter marches. The resultant sensation is one of struggling to keep up as history whooshes past, balanced by the equally strong impression that nothing ever changes.
Here, in 1964, is the Conservative candidate for Smethwick defending his notorious racist campaign and N-word sloganeering with the same “legitimate concerns” narrative that you hear from racist-appeasing politicians today. Here, in 1970, is an example of heavy-handed Met policing turning a peaceful protest into a violent confrontation.
The popular, long-running BBC drama Dixon of Dock Green ran until 1976, the same year that a new Race Relations Act once again exempted police from anti-racism legislation. While many of the people featured in this documentary have tragic personal experience of police corruption and brutality, the notion that friendly British bobbies could stray so far will remain difficult for many watching to accept.
This is why some of the most affecting moments in Amponsah’s film come not from activists, but from two former Met officers. One breaks down in tears while describing how he witnessed a colleague severely beating a black man in his cell: “I was kind of ashamed I was there, but I didn’t say anything … I didn’t have the courage to do that.” Another suggests with a waggish smile that, in fact, he was the victim: “Not believing that I would do a professional job? Y’know … who had the prejudice?”
Both of these examples are as useful to our understanding of how racism manifests itself in Britain as the most dramatic footage from a National Front rally.
', false, TIMESTAMP '2019-02-28 15:32:15', 226, 'review', 'tv show', 2);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Macy Gray: ‘I tell my kids not to ever let racism get in their way’', 'abs.jpeg', 'I got picked on a lot at school. I was awkward – tall, thin, with a lot of hair I didn’t know what to do with. I had these growth spurts, so I’d go to school and my clothes would be too small. I wanted to fit in but I never really got there. I think that’s what made me want to be somebody.
I’m not a people person. It’s not my gift. People disappoint you, and I’m over being disappointed by people. The only thing I’ve ever really been afraid of is people.
Becoming famous at 28 was shocking. I wasn’t expecting it. I had kids already. I’d been married. I was just enjoying myself, and then I Try happened. I didn’t see it coming.
I didn’t realise how famous I was for a long time, probably until I got mobbed in the Gap, in Times Square, with my son. Fame is difficult. No one trains you for it. It’s a skill. It’s an art. And once you get famous, you have the job of maintaining it, or people will be cruel.
I like being in my 40s and 50s. You develop this natural cockiness – you’re a little bit better than everybody now, because you’re a little bit older, you’ve lived. People can’t tell you shit any more. You’re like, “Fuck you, I did that already!” You know, it’s kind of cool.
I’m very vain. I’m taking pretty good care of myself, but I was not one of those people who took advantage of Covid and started working out and stuff. I sat around and ate for six months.
The thing I’ve missed most during the pandemic? Trips to the movies. What I like to do most is go buy some alcohol and then go to the movies by myself, and just sit there and drink and watch a movie. I’m a Cointreau fan, so I’ll buy little bottles and put them in my Coca-Cola and watch two or three movies and be in heaven. Then I’d Uber home and it would be, like, the best night of my life. I miss being able to do what I want.
My kids know me better than anybody on the planet. They’re 25, 24 and 23 and they’re my best friends. They keep me in check. They ask a lot of questions, which is healthy for me. They keep me grounded, they keep me challenged, and keep my mind working, they understand me, they know the difference between the me I present to the world and the real me.
I want to find love. I’ve not been in love for a while and I don’t want to grow old by myself. That’s important. I mean, you need that in life. You need a partner.
I’m so tired of racism. It’s exhausting. I tell my kids not to ever let it get in their way. I don’t allow them to say, “I didn’t get this because I’m black.” If you absorb that, start living that way, you won’t get anywhere. At this point, when I see people who are racist, I feel sorry for them.
Anyone who says they have no regrets is full of shit. I have millions of them. Probably a million and one.
What’s driving me at this point is money. I want to have a lot of money so when I get older I’m not running around touring and trying to make another I Try. In 10 years from now I don’t want to have to hustle. I don’t want to be on the road. That scares the shit out of me.
', true, TIMESTAMP '2019-08-23 11:42:54', 140, 'news', 'music', 55);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Brockhampton’s Kevin Abstract: ‘I’m tired of this boyband thing. I don’t want to be a boyband’', 'abs.jpeg', 'As the various members of Brockhampton, AKA the self-proclaimed “best boyband since One Direction”, log in to a slightly chaotic eight-way Zoom call, it is quickly apparent that no one is immune to lockdown cliches. The band’s producer Romil Hemnani arrives first, wandering past his laptop cradling a puppy, before returning 10 seconds later holding a different, much larger, dog. There isn’t time for anyone to laugh at my “Not a fan of journalists?” gag after he (the dog, not Hemnani) growls into the camera, before vocalist Joba, AKA Russell Boring, appears sporting shoulder-length hair and a patchy beard that screams “re-open the barbers”. By the time de facto group leader Kevin Abstract emerges, sitting in front of a swimming pool, with his rainbow-coloured dye job, it’s full house on the Zoom bingo card.
For a 13-strong collective of twentysomethings who, along with the eight vocalists and/or producers present today, include photographers and app programmers in their ranks, lockdown’s creative malaise has passed them by. In fact, Abstract says they recorded three records to get to the one they’re happy with – next month’s sixth album in four years – Roadrunner: New Light, New Machine.
Setting the template for the band’s mix of high-octane, sun-kissed pop and ragged skate-punk energy, 2017’s breakthrough Saturation trilogy – created while the band were living together in South Central LA – was quickly followed by 2018’s Iridescence and 2019’s Ginger, the latter two part of an unprecedented $15m contract with RCA. Each helped introduce the world to a new kind of “All-American boyband” that aimed to fuse Odd Future’s gonzo spirit with pop choruses. It was a label they relished subverting, both via their diversity – the group includes black, white, gay, straight, African, Irish, and Latin members – and an egalitarian, DIY ethos underpinned by endearing vulnerability. An early anthem arrived in the shape of Saturation III’s skull-rattling Boogie, with Abstract’s downbeat chorus of “I’ve been beat up my whole life, I’ve been shot down kicked out twice” riding a hedonistic mix of blaring horns, west coast hip-hop and screeching alarms. When they performed it in New York’s Times Square for MTV in blue paint they were quickly swamped by a febrile fanbase drawn to relatable party anthems for a depressed youth.
', true, TIMESTAMP '2020-08-27 16:53:49', 57, 'article', 'music', 34);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Philip Roth: The Biography by Blake Bailey – definitive life of a literary great in thrall to his libido', 'abs.jpeg', 'From the troubled marriages to the breakthroughs that led to Sabbath’s Theater and American Pastoral… a beautifully written book by Roth’s chosen biographer.
In response to that staple biographer’s question, “when were you happiest?”, Philip Roth tended to think of his first year as a graduate student at the University of Chicago, when he was free to pursue his persistent “Byronic dream” of “bibliography by day, women by night”. In the six decades that followed, as Blake Bailey’s compulsively readable life of the novelist reveals, this idealized schedule was generally compromised one way or another, to Roth’s frequent frustration and sometime derangement. In Chicago and subsequently during his two-year national service beginning at Fort Dix, he had regular visits from his first obsessive lover, Maxine Groffsky, and he reminisced fondly to Bailey how on meeting, they would always tear each other’s clothes off at the door. “I haven’t done that in a while,” Roth mused, aged 79. “I take them off nicely, I hang them up, I get into bed and I read. And I enjoy it as much as I enjoyed tearing the clothes off.” That late-life liberation from desire is 900 pages in the making.
The two great and lasting traumas of Roth’s life were his marriages. He came to believe he had been trapped into both of them. First by Margaret Martinson, a waitress five years his senior, whom he had initially seduced as a “test” to see if he could charm a “shiksa blonde” and who Bailey later describes, through Roth’s eyes, as “a bitter, impoverished, sexually undesirable divorcee”. Martinson tricked him into a terrible union with false claims that she was pregnant, backed up with a sample of urine bought for $3 from an expectant mother in a homeless shelter, and threats of suicide if Roth should ever leave her. The second perceived “entrapment” was with the actor Claire Bloom, with whom Roth spent nearly 20 years from 1975, years that she documented in her brutally critical memoir of his role in their drama, Leaving a Doll’s House.
The liberations from these tortured relationships propelled the two great breakthroughs of Roth’s writing career. Portnoy’s Complaint was completed immediately after Martinson, from whom he was long divorced but never free, died in a car crash. His scandalously funny book – the most literal of all “coming of age” fiction – became the biggest-selling novel in the history of his publisher, Random House. It made Roth a pariah within the conservative Jewish community, and a very wealthy man.
', false, TIMESTAMP '2020-10-15 09:22:57', 94, 'review', 'literature', 16);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Stuart Lawrence: ’I really looked up to Stephen’', 'abs.jpeg', 'The younger brother of the murdered teenager on his book about his sibling’s life and death, why it took two decades to process his feelings and the traits his son shares with his ‘superhero’.
Stuart Lawrence is the younger brother of Stephen Lawrence who, on 22 April 1993, aged 18, was murdered in an unprovoked racist attack. Stuart was 16 at the time and is now an educator and motivational speaker. In Silence Is Not an Option, his first book, he reflects on his brother’s life and murder and describes the tools he has used to help him live positively. Written for younger readers (aged 10+), the book aims to help them find their own voice and work towards a better future. Stephen Lawrence Day is held on 22 April each year to commemorate the Londoner’s life.
“You are my superhero”, you say of your brother and movingly write: “After Stephen’s murder, I asked myself what my big brother would want me to do. How would he want me to act?”
I was a younger brother and looked up to him – he was the stereotypical big brother in some senses: I thought he was better looking than I was, had better clothes. It was that admiration you have for an older sibling. We shared a room from when I was about six or seven. Before we went to sleep, we would have conversations about life, music, clothes, our hopes and dreams – Stephen dreamed of being an architect and I dreamed of being an actor. We were very close. That was what was so hard when he was gone because it was like, what do I do? It was like being in the dark. I realised the only way to get through it was to have some foresight into what he would want me to do. I knew he would want me to follow my ambitions and be the greatest I could be, so I charged on in his memory. I want to make Stephen proud.
The book is dedicated to your 10-year-old son, Theo…
Two things happened when he was born – [I felt] a huge sense of responsibility that life was no longer just about what I want and I also realised what my mum would have gone through when Stephen died; to have a child and for them not to be there any more – that was a daunting realisation. Theo reminds me of Stephen – he’s quick-minded, he’s friendly. I can see Stephen’s traits in him already.
You write: “My biggest failure after Stephen died was that I didn’t take some time to process my feelings about what had happened.” At what point did you finally process those feelings?
Quite recently. I think it’s a societal problem that we’re taught to have a stiff upper lip – you know, “You’re a “man, why are you showing emotions?” Those sort of stereotypes were there in my childhood. I think we’ve come a long way to understanding that it’s OK to cry, be upset - it doesn’t matter what gender you are.
What was it like in the immediate aftermath?
It was very difficult. I was so angry that Stephen was being portrayed inaccurately as a gang member in some newspapers, when in fact he was an A-level student and aspiring architect. I did have support from my youth club leader, which really helped me learn self-control. I lived with him for a year when I was 16 and it helped me grow up. Mentors like that are really important.

You explore the tools that have helped move you forwards. What are they?Resilience. Hope and optimism. I’m an optimistic person, which annoys my wife sometimes but what’s the point otherwise? I do try, even though it’s hard at times, to keep the eyes set on the little shard of light and that’s something I hope to pass on to my son. I also wanted to be a good role model to my younger sister, Georgina, like Stephen was to me, which helped me to try to be the best person I could. I almost got kicked out of my first secondary school because I was a bit unruly. Academically, I struggled – I didn’t find out I was dyslexic until I was 21 – but I was always creative and channelled that with help from good mentors. I used to want to be an actor but studied graphic design and became a teacher, then learned that I could help people by sharing my story in schools and organisations as a speaker.
You and your family have done immense amounts in campaigning for a fairer world. The Macpherson report was instrumental in defining race hate crime. How do you feel about the direction in which society is moving now in terms of racial equality?
First of all, I would like to pay my respects to Sir William Macpherson as we sadly lost him quite recently. [He died on 14 February.] It’s upsetting, as there wasn’t the acknowledgment I thought he’d receive through what he did. What’s most important is for each of us to ask the question – are you a good person? We all have a voice and an ability to use our voice for good. For me, there needs to be one clear message: we need to be able to just say “we are an anti-racist country”, then we could tackle all the systemic problems around race.
What’s a great book you read recently?
I’ve been reading David Olusoga’s Black and British – he talks about the end of the [second world] war and how we turned to our neighbours for help and support in the rebuild. This is another chance to rebuild. Now we’ve made the Brexit decision – how are we going to go forward as a country?
What’s next on your reading list?
I’ve just bought Unspoken by Guvna B, which is about toxic masculinity. I’ll be getting into it when I next have a day off – which isn’t until May.
', false, TIMESTAMP '2020-01-15 05:12:45', 204, 'article', 'literature', 4);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Streaming: the best films about dogs', 'abs.jpeg', 'Britain, we’re told, has recently reached “peak dog”. With many of us housebound in the past year, it has seemed the ideal time to adopt a dog – prompting a lot of “for life, not just for Covid” messaging from anxious animal shelters. If you’ve felt the urge for some canine companionship but just don’t feel ready to commit, the movies have you covered — the vicarious subgenre of cinéma du chien is a rich and varied one.
It also gets a fine new entry this week (streamable on Amazon) in Elizabeth Lo’s lovely dogumentary Stray, a moving but notably unsentimental study of Istanbul’s street dogs — a sort of bookend to the same city’s cat-centred travelogue Kedi some years ago, albeit from a different filmmaker. Filming over the course of three years, and eschewing dialogue or voiceover, Lo’s film thoughtfully observes the movements and survival strategies of a population once threatened and now protected by law. Yet when the dogs attach themselves to a group of homeless Syrian refugees, Stray tacitly invites viewers to evaluate their own sympathies.
', true, TIMESTAMP '2020-12-08 12:37:08', 275, 'article', 'cinema', 85);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Rafe Spall to star in West End premiere of To Kill a Mockingbird', 'abs.jpeg', 'Rafe Spall is to play Atticus Finch in the West End premiere of To Kill a Mockingbird when it opens in London next year. Spall replaces Rhys Ifans in the lead role of the production, which had been due to open this May but has been delayed because of the coronavirus pandemic.
To Kill a Mockingbird will now open at the Gielgud theatre in March 2022. It is written by West Wing creator Aaron Sorkin and is based on Harper Lee’s Pulitzer prize-winning 1960 novel. The play began its Broadway run in December 2018. Shortly before New York’s theatres were closed due to the pandemic, its cast gave a free performance at Madison Square Garden in front of 18,000 schoolchildren.
On Broadway, Jeff Daniels played Finch, the small-town lawyer in 1930s Alabama who defends a black man wrongly accused of rape. Adult actors portrayed the children in the story. The New York production opened after the estate of Harper Lee and the play’s producers “amicably settled” lawsuits regarding changes to the characterisations, particularly of Finch.
Spall was last on stage in a barnstorming solo role in Death of England at the National Theatre. He stars in the forthcoming time-travelling comedy film Long Story Short.
As it was on Broadway, To Kill a Mockingbird will be directed by Bartlett Sher and designed by Miriam Buether. Both were nominated for Tony awards for their work on the play. Tickets go on general sale for the London production on 6 April. More than 500 tickets priced between £5 and £10 will be available each week.
', false, TIMESTAMP '2019-03-17 19:11:58', 28, 'review', 'theatre', 50);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Maggie O’Farrell: ‘Severe illness refigures you – it’s like passing through a fire’', 'abs.jpeg', 'Maggie O’Farrell found the prospect of writing the central scenes of her prize-winning novel Hamnet, in which a mother sits helplessly by the bedside of her dying son, so traumatic that she couldn’t write them in the house. Instead, she had to escape to the shed, and “not a smart writing shed like Philip Pullman’s”, she says, “but a really disgusting, spidery, manky potting shed, which has since blown down in a gale”. And she could only do it in short bursts of 15 or 20 minutes before she would have to take a walk around the garden, and then go back in again.
The novel, a fictionalized account of the death of Shakespeare’s only son from the bubonic plague (his twin sister Judith survived) and an at times almost unbearably tender portrayal of grief, was first published a year ago. An interlude halfway through, which follows the journey of the plague in 1595 from a flea on a monkey in Alexandria to a cabin boy back to London and eventually to Stratford, was referred to by an American journalist as “the contact tracing chapter”. “It certainly wasn’t conceived as that when I wrote it,” the author says of the extraordinary coincidence of her novel, set more than 400 years ago, landing in the middle of the pandemic, not least because she delayed writing it for decades.
Hamnet went on to beat Booker winning novels by Hilary Mantel and Bernardine Evaristo to win the Women’s prize last year. “I felt as if I’d been in the coolest gang all summer,” she says of being on the shortlist, the final announcement of which was delayed until September due to the virus. She found out she had won after being persuaded to “pop back” on to a Zoom call (she was in her pajamas and the cat had just been sick). It was the first time she had been shortlisted, which seems remarkable for an author of eight elegant novels, whose writing life spans the 25 years of the prize itself. It is undoubtedly the novel of O’Farrell’s career so far (there was much indignation on Twitter that it didn’t make the Booker longlist) and its release in paperback this week is sure to break the hearts of many more readers.
She found out she had won the Women’s prize on a Zoom call (she was in her pajamas and the cat had just been sick)
“I think I’ve written three books instead of writing Hamnet,” she jokes, from her living room – she lives in Edinburgh with her husband, the novelist William Sutcliffe, and their three children. Her study is too untidy to do interviews, she says, and I’m guessing too private – she describes herself as a “very secretive” writer. We are talking on the first morning that schools in Scotland are allowed to open, and the house is “weirdly quiet”. As writers, she and Sutcliffe are both used to working from home, but she survived the last year by insisting on a sacrosanct daily minimum: “If I’m able to spend an hour a day with my book, then I can just about stay sane,” she says.
This is not the first time she has written the story of a life seen through the lens of death. Her offbeat memoir I Am, I Am, I Am – which documents her own 17 brushes with mortality, including a binoculars-wielding strangler, a couple of near-drownings, a botched caesarean, and acute encephalitis as a child – was a surprise bestseller in 2017. Reading between the near-misses, you learn that the now 48-year-old Irish-British author (she calls herself “a hyphenated person”) was born the middle of three sisters in Northern Ireland, but that much of her childhood was spent in south Wales, until the family moved to Scotland when she was 12. She attended two comprehensives, “one frightening and bewildering, one less so”, before going to Cambridge to study English, where she met her future husband (referred to as “my friend” or “a man” – rather like that other Will, who remains nameless throughout Hamnet).

Her subjects have included motherhood, marital breakdown and madness – the lives of girls and women, to borrow an Alice Munro title (a copy of Munro’s Collected Stories was O’Farrell’s castaway book choice when she was a guest on Desert Island Discs this week – a sure sign of cultural approbation; she also chose the Pogues, Chopin and Radiohead). Her other most straightforwardly historical novel, The Vanishing Act of Esme Lennox explores the plight of women incarcerated in 1930s Ireland and England for the crime of being different; The Hand That First Held Mine, which interweaves the stories of a dazed new mother in present-day London with a young graduate looking for adventure in arty 50s Soho, won the Costa novel award in 2010.
Although she bristles at the term “domestic fiction”, Hamnet is an undeniably domesticated take on the Shakespeare story, with much of the action set not in the Globe or a London tavern, but in the kitchen, bedroom and garden of an Elizabethan Stratford cottage. Conceived as a novel about fathers and sons, as in Hamlet, it ended up a living portrait of a mother and her son.
Like Mantel, who in her own words, “decided to march on to the middle ground of English history and plant a flag”, O’Farrell pulls off the equally audacious trick of making a historical giant (the greatest English writer of all time – no pressure) intimately real, both novelists deftly deploying the continuous present tense to compelling effect: “A boy is coming down a flight of stairs.” But where Mantel’s Thomas Cromwell remains a public as well as a private figure, O’Farrell’s Shakespeare is relegated to a supporting role, known only as “the LatinFF tutor”, “her husband” or “the father”.
', true, TIMESTAMP '2020-07-11 07:06:42', 151, 'news', 'literature', 60);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Hollywood stylists bemoan plans for in-person Oscars ceremony', 'abs.jpeg', 'Hollywood stylists are bemoaning the loss of the virtual red carpet, with the news that the Oscars will be a small live event with no Zoom element to it.
A letter from the Academy of Motion Picture Arts and Sciences released to the film industry website Deadline said: “Our plan is to stage an intimate, in-person event at Union station in Los Angeles, with additional show elements live from the Dolby theatre in Hollywood.”
“You’re wondering about the dress code (as well you should),” added the letter, signed by the ceremony’s producers, including the director Steven Soderbergh. “We’re aiming for a fusion of inspirational and aspirational, which in actual words means formal is totally cool if you want to go there, but casual is really not.”
Virtual red carpets, which have taken place mainly via Instagram, have been liberating for stylists. “It has given us a lot of control as stylists as we’ve been able to manipulate lighting, angles and backgrounds to our liking,” said Wayman Bannerman from the duo Wayman + Micah who dressed Regina King for the Emmys and Critics’ Choice awards.
“I have really enjoyed the way some celebs and their stylists have turned that platform into full-fledged fashion shoots,” said Heather Cocks, a fashion commentator.
“There is a definite fashion bright side to a virtual carpet in that truly anything goes from barefoot in pyjamas to full-on couture,” agreed Elizabeth Stewart, who dressed Viola Davis and Amanda Seyfried for the Golden Globes.
“Virtual dressing has pushed us to think more outside the box and have more fun, whether it be through colours or silhouettes,” added Bannerman.
', false, TIMESTAMP '2019-02-04 05:04:19', 65, 'review', 'cinema', 91);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The silver streamer: older people are bingeing TV? News to me', 'abs.jpeg', 'According to Ofcom, the UK’s communication regulator, Britain has become a country of lockdown binge-watchers, with viewing habits that were previously associated mainly with young people soaring up through the age bands to engulf even my own generation of “silver streamers”.
I do not want any part of that weird cult of sanctimonious souls who proudly refuse to have a TV in their house, and who insist that they fill their time in more virtuous and improving activities of other kinds. I’m not one of those. Never have been. Never will be. I love the telly. But even I have struggled to watch anything like the 6 hours 25 minutes of TV on any single day that Ofcom has found is the average daily viewing figure.
Perhaps that is because, striking though they are, those figures are from April 2020 – the first full month of the first lockdown. Back then, everything about lockdown was new. And the first lockdown was total. In that month, Ofcom was looking at a captive audience.
Since then, things have been more fractured and more blurred. Many people have struggled more with the increasingly complex succession of lockdowns, tiered rules and restriction changes. A lot of us have got more jaded and less engaged about things like TV news, which were far more consuming and seemed far more consequential early on. Ofcom’s figures confirm that we were news junkies in April 2020 – but it doesn’t feel the same a year later, either as a journalist or as a consumer.
I would be pretty sure that our collective attention spans and enthusiasm for watching have loosened a lot ever since.
I am also a bit sceptical about the extent to which older viewers like me have become truly absorbed into the apparent binge-watching mainstream. It is much more striking that 85% of us over-65s are not streamers than that 15% of us (including me) are. Inevitably, though, I base a lot of my unscientific thoughts on my own experiences over the past year. I have no idea whether there are millions of over-65s like me. I have no idea whether over-65s are significantly different from under-65s or whether, in fact and as I suspect, we share rather more than some suppose. But my own experience of lockdown, and my own lockdown viewing habits, suggest that the novelty of April 2020 has worn off in several ways. It isn’t just the news programmes that are harder work in 2021 than they were a year ago. I find the same is true of lots of different types of viewing.
Sport is a good example. Normally, I watch a lot of football and cricket on TV. When the lockdown started, all that suddenly came to a halt (which could be one reason why streaming services boomed at the same time). When the football and cricket resumed later in the summer, it was tremendous at first. I watched an awful lot of games, not least when my club Leeds United returned to the Premier League in September.
Six months later, however, my level of engagement has waned a lot. There is football on telly all the time. But I watch it less and less. That could be because the teams I support are having indifferent seasons. It could be because the absence of crowds makes it feel a hollow experience. It could be because, as I have got older, I have come to hate the commentaries (when crowds return, we need a commentary-free option). It could be because, in the end, it’s just a stupid game and none of it matters. But it could also be, I am fairly sure, because the lockdown has taken a toll on my attention span.
I have certainly found this when it comes to binge-watching. I read and hear a lot of people saying how they have spent days working their way through series, as if they are incapable of stopping once they start. All I can say is that, in complete contrast, I find myself more and more often stopping without a moment’s regret.
', false, TIMESTAMP '2019-02-05 08:29:20', 102, 'article', 'tv show', 41);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('’I wrote it as a fugitive from what my life had become’: Tsitsi Dangarembga on Nervous Conditions', 'abs.jpeg', 'Nervous Conditions is a novel about yearning and wanting, about black girls – in this case Zimbabwean girls – desiring better for themselves and their loved ones. I wrote it as a fugitive. A fugitive from my first memories and of what my life had become.
Early memories were of a foster home in Dover, then of returning to a Rhodesia that had just removed itself from the British empire. After school I returned to England to study for a BSc in medicine at the University of Cambridge. The idea was to proceed to a teaching hospital after I graduated, such as the hospital at the mission in the Eastern Highlands of Zimbabwe where I’d spent several years of my childhood. But the nationalist liberation struggle escalated while I was at college, and in the summer of 1979 a peace treaty resulted in a road map to independence.
I was in London, where I’d spent all my summers since arriving in England, during the peace talks. The bleakness of the Zimbabwean students’ lives, their self-medication with various drugs and episodes of mental collapse related to reliving a war from which they’d fled indicated to me how the mind needed as much treatment as the body.
Returning to Cambridge under strain, I decided there was no point in enduring the pressure of finding cheap digs I could afford for the holidays, of being the only black girl in my college, reading for a degree I was no longer interested in. Nor was anyone aware of, or interested in, the historical upheaval that had ruined lives and families in Rhodesia. I returned to Zimbabwe in the winter and enrolled at the University of Zimbabwe.
I flourished in the new, independent country. Looking back on my cross cultural experiences and my upbringing in a conservative semi-traditional culture, I realised I’d been singularly unprepared to manage the circumstances I’d encountered in England. I’d experienced racism growing up in Rhodesia and hadn’t expected it in England. I didn’t suffer it. But I suffered from lack of interest in and ignorance of a bloody war that had affected my family.
A culture-shocked student at Cambridge, I suffered from sexual predation when I looked for holiday digs, and ended up in cheap B&Bs. It became evident to me that differences between how my elder brother and I had been brought up had an impact on our coping mechanisms. Standing up for oneself, knowing what one wanted and asking for it were not part of my repertoire. I thought young women had to be warned about this.
I wanted to write about a girl many young Zimbabwean women would identify with, someone who was grounded in a Zimbabwean experience, so I chose the character of a rural girl, Tambudzai (the country’s population was more than 70% rural at the time). Babamukuru, her well-off uncle, came to me easily. The extended family, with more and less well-to-do branches, is still a reality and a source of frustration and contention caused by demands, expectations and obligations today.
At first, I didn’t have a clue what I was writing. Then I read Germaine Greer’s The Female Eunuch, which gave me permission to critique what I thought of as my culture. Discarding all previous pages, I started over, writing longhand in A4 exercise books, a fresh one for each chapter. Finally I allowed Tambudzai to want something for herself – her education. I encouraged her to fight for it, and enjoy it after she is taken to be educated at her uncle’s mission in the aftermath of her brother’s death. Six months later, the manuscript was ready to send to the typist.
', false, TIMESTAMP '2020-07-08 09:01:58', 290, 'news', 'literature', 8);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Yaphet Kotto obituary', 'abs.jpeg', 'In the 1985 TV movie Badge of the Assassin, Yaphet Kotto, who has died aged 81, is told by Alex Rocco, playing an NYPD detective, that the only reason he has been assigned to the investigation of a black militant murder of two cops is because he is a black detective. As Rocco storms away, Kotto calls out to him: “Who told you I was a black detective?”
This could be a metaphor for Kotto’s career. His considerable acting talent was often subsumed by his appearance, almost the antithesis of what a Hollywood leading man, especially a black one, needed to be in that era. Tall and strongly built, Kotto was not a handsome Sidney Poitier, the breakthrough black actor of the 1960s. “I’m always called powerful, bulky or imposing … I think I have this image as a monster,” Kotto said, but his distinctive broad face, with sleepy eyes, quick smile and a slight lisp, was a character actor’s dream, a tool he manipulated through violence and sensitivity to bring subtleties to even the least subtle of roles.
He may be best remembered for doing just that in the James Bond film Live and Let Die (1973) – in which he played the Caribbean ruler Dr Kananga and his gangster alter ego, Mr Big, making subtlety even more difficult (“I was too afraid of coming off like Mantan Moreland,” he said, referring to the vaudevillian known for his exaggerated facial expressions) – and in Midnight Run (1988), as the FBI agent Alonzo Mosely, whose chase for his lost ID card drives the plot. His finest film was Paul Schrader’s Blue Collar (1978), a landmark study of both race and class in the US, which would have lost its power had Schrader cast matinee idols instead of Kotto, Harvey Keitel and Richard Pryor.
', true, TIMESTAMP '2019-05-13 02:05:27', 248, 'review', 'cinema', 35);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('We stan together: the wonderful world of Instagram TV fan pages', 'abs.jpeg', 'A cursory scroll through the Explore page on Instagram can feel like a visual assault: sponsored content, taunting influencer pictures and cute pets all vying for your attention through algorithmic targeting. As you work your way through the social media platform’s recommendations, you are also likely to encounter another constant: celebrity fan accounts.
The fan account has long been a fixture of celebrity culture, as the focus has moved away from tabloid newspapers to blogs and fansites, and from there to social media. From the now-closed Instagram page @beyhive, which had 1.2 million followers thanks to its regular Beyoncé updates, to the myriad Harry Styles fan accounts on the platform, and the gossipy shots of Ana de Armas Updates, these pages keep their many followers informed with daily repurposing of their favourite celebrities’ images and content. It is a fandom largely made by fans, for fans.
While the Instagram fan accounts of global music and movie stars might seem a logical extension of their far-reaching appeal and power, there is a proliferation of pages dedicated to British TV stars, too, from Holly Willoughby to David Tennant to Amanda Holden, all racking up followers in the tens of thousands, with many created during the 2020 coronavirus lockdown. But what is behind these more niche accounts, and what prompted their creation?
“When I first set up the page, two months into lockdown, I was on it five or six hours a day,” says 24-year-old Larissa Silva, a student from Rio de Janeiro. Her account, Paul Mescal Pics, has 18,000 followers and posted its first image on 6 May 2020, as the Irish actor’s popularity peaked while he starred in the BBC series Normal People. Her images added to the clamour fans were raising over his character Connell’s cool stoicism, scantily clad romantic scenes and, most bizarrely, his plain silver chain.
', true, TIMESTAMP '2019-04-04 18:57:47', 294, 'news', 'tv show', 54);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('My Rock’n’Roll Friend by Tracey Thorn – a philosophical and furious memoir', 'abs.jpeg', 'The Everything But the Girl singer’s account of her friendship with the Go-Betweens drummer Lindy Morrison illuminates rock’s double standards
At 243 pages, in a relatively easygoing font size, Tracey Thorn’s latest book doesn’t look like a particularly subversive tome. Inside, though, is quiet fury, with ramifications well beyond what is, at a glance, a narrow milieu.
Thorn found fame as half of Everything But the Girl in the 80s and has since published a celebrated series of memoirs and nonfiction books. Here, she turns her clear-eyed candour to dissecting her long friendship with Lindy Morrison, an Australian musician, now 69, who played drums in a band called the Go-Betweens.
Never heard of them? No matter. It helps to know this: the Go-Betweens were wonderful, if chronically underappreciated; originally two guitar-playing singer-songwriters and a drummer, later joined by other members. They remain a cult concern among aficionados and music journalists; often bookish, sensitive males who identified with songwriters Robert Forster and Grant McLennan. (The American author Jonathan Lethem devotes an insightful chapter to them in his essay collection, The Ecstasy of Influence.)
Initially, it furthered the Go-Betweens’ cool no end to have an unconventional female drummer: tall, wild-haired Morrison, who all agreed was “a force of nature” – a designation Thorn unpacks with precise care here. Just as Kim Gordon brought knowledge of art and the avant garde to Sonic Youth but spent years as the token female bass player, Morrison joined Forster and McLennan from a ideologically and artistically fertile punk background. She had worked for years advocating for Indigenous Australian rights. She had hitchhiked around Europe, nannied for Sir Georg Solti, once played bridge with Roger Moore.
There is plenty of granular period gossip in these pages – not least the time when, barely making ends meet in a cold and unfriendly London, Morrison cooked a slap-up Christmas dinner for the boys: her band and their housemates, Nick Cave’s Birthday Party. It went uneaten, as the majority preferred to nod off on heroin. Morrison and Forster were in a relationship; when the Go-Betweens eventually imploded, they did so in breathtakingly gendered fashion.
And yet this is a book about more than music: it recounts the intricacies of female friendship and its crush of projection, permission, allyship and trying-on-for-size. More widely, it is borderline philosophical – about perception and interpretation, seeing and being seen, living with a stiff upper lip versus living with no filter – and how appallingly condescending the British can be towards Australians. Thorn writes incisively about how she constructed Morrison for herself as a hero and mentor – full of qualities Thorn felt herself to lack. The truth, obviously, was more complex: the yin-yang attraction between Thorn, more reserved, and Morrison – loud, blunt, unable to keep secrets, lacking in restraint – asks questions about image and self-image. What is it we see in others?
', true, TIMESTAMP '2019-04-04 18:57:47', 289, 'review', 'literature', 85);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('New photo shows Kristen Stewart as Princess Diana ahead of biopic Spencer', 'abs.jpeg', 'A new image of Kristen Stewart as Princess Diana has been released, as shooting on forthcoming biopic Spencer moves to the UK.
Stewart, 30, will play the late princess in the film, directed by Chilean film-maker Pablo Larraín, whose biopic of Jackie Kennedy starring Natalie Portman won multiple Oscar nominations in 2017.
In the photograph, Stewart smiles directly at the camera, wearing a prosthetic nose and layered blond bob, as well as tartan blazer and diamond engagement ring that appear to be copies of those sported by the real woman.
The film’s autumn release follows rave reviews for the most recent season of Netflix’s The Crown, in which Emma Corrin played the princess, winning a Golden Globe for her performance, as did Josh O’Connor as Prince Charles.
The actor playing Prince Charles in the new film will be Jack Farthing, best known as baddie George Warleggan in BBC’s Poldark. Farthing, 35, also played John Lennon in ITV’s Cilla Black series and featured in The Riot Club, the big-screen version of the play Posh.
The film is scripted by Peaky Blinders’ Steven Knight, and scored by Radiohead’s Jonny Greenwood.
Supporting cast include Timothy Spall, Sally Hawkins and Sean Harris. The actors playing the young princes William and Harry have not been announced; last year, British passport holders were ruled out of contention for the roles over post-Brexit visa concerns.
Spencer is set over the course of a decisive weekend in December 1991, during which Princess Diana spends the Christmas holidays with the royal family at Sandringham, and decides to leave her marriage to Prince Charles.
“The Prince and Princess of Wales’ marriage has long since grown cold,” reads a press release. “Though rumours of affairs and a divorce abound, peace is ordained for the Christmas festivities at Sandringham Estate. There’s eating and drinking, shooting and hunting. Diana knows the game. This year, things will be a whole lot different.”
It’s the first big feature film to be made about the princess since 2013’s much-ridiculed Diana, which starred Naomi Watts and was labelled “car crash cinema” by the Guardian’s Peter Bradshaw.
Stewart described Spencer in a statement as “a dive inside an emotional imagining of who Diana was at a pivotal turning point in her life”.
Filming was taking place in Germany, but has moved to the UK. The film is scheduled for release this autumn.
', true, TIMESTAMP '2020-02-14 22:00:26', 6, 'news', 'cinema', 32);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Richard Mabey: ’Viruses and man-eating tigers and predatory Asian hornets are all part of nature’', 'abs.jpeg', 'In an era when bookshops are thickly forested with new nature tomes, it is easy to forget that for decades Mabey, in Britain, was a lone voice in an empty field. He grew up, a “hedge kid” roaming the countryside around Berkhamsted, for whom nature was a refuge from a bed-ridden, alcoholic father who ruled the household as if by remote control. Writing has always been how Mabey makes sense of things and keeps well. When his father died, “I thought that I really wouldn’t care less whether he was alive or not”, but two hours after the funeral Mabey “sat in my room and just wrote pages and pages on blue Basildon Bond paper about what I’d been feeling. I couldn’t have gone through the rest of the day if I hadn’t done that.”
In the early 1960s, Mabey joined the political protests of the day – arrested during street demos, against the Cuban missile crisis – but it was visiting the Norfolk coast where he encountered traditional foraging for food such as samphire that moved him to write Food for Free (1972), which pre-dates Hugh Fearnley-Whittingstall’s advocacy of wild food by three decades. Mabey, who cites Rachel Carson’s Silent Spring and Annie Dillard’s Pilgrim at Tinker Creek as his key texts, has been consistently trailblazing. His second book, The Unofficial Countryside (1973), is a memorable celebration of wildlife in rubbish dumps and waste ground that foreshadowed other British writers’ interest in “edgelands” by 40 years. His biography of Gilbert White (1986) and epic cultural history of plants, Flora Britannica (1996), are key texts in the revival of nature writing in Britain. More recently, Mabey’s Nature Cure (2005), detailing his mental breakdown after finishing Flora Britannica and the succour he found by belatedly leaving behind his childhood home in the Chilterns for the bleaker south Norfolk countryside, heralded that genre of nature misery memoir.
Eighteen months ago, after a period of poor physical health, Mabey published what sounded like his last ever book, with a suitably elegiac title, Turning the Boat for Home. An expanded collection of 20 years of writing, he calls it “an intellectual autobiography” but admits it sprang from failure. “I badly wanted to write what I thought would be a last book. Some sort of summing up of a life. But I very quickly confirmed that I don’t have the right sort of mind or memory to do what people regard as autobiographies.”
The collection is a reminder of his essayistic talents, from a gorgeous ferret into his bookshelves, which possess “the rampant wildness of an ecosystem, with an agenda of its own”, to an examination of how we might better relate to barn owls, birdsong and whirligig beetles. The most respectful terms of engagement, he argues, are not “anthropomorphism or manufactured empathy” but “a sense of neighbourliness”. This is not friendship but “based on sharing a place, on the common experience of home and habitat and season”. “It might provide a bridge across the great conceptual divide between us and other species.”
', true, TIMESTAMP '2019-11-04 12:25:27', 13, 'article', 'literature', 44);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Booker winner Bernardine Evaristo writing memoir about ’never giving up’', 'abs.jpeg', 'Manifesto will chart the first Black Booker prize winner’s 40-year journey to literary centre-stage and encourage others to pursue creative fulfilment.
Bernardine Evaristo, the first Black woman to win the Booker prize, is writing a memoir about how she “moved from the margins to centre stage” over a career that has spanned more than three decades.
Evaristo’s Manifesto will draw deeply on the award-winning author’s experiences to chart her “creative rebellion against the mainstream and her life-long commitment to the imaginative exploration of ‘untold’ stories”, said publisher Hamish Hamilton, which will release the non-fiction title in October.
“Bernardine Evaristo’s 2019 Booker win – the first by a Black woman – was a revolutionary moment for British culture and for her,” said the publisher. Evaristo won the Booker jointly with Margaret Atwood in 2019 for her eighth novel Girl, Woman, Other. Her writing spans fiction, verse fiction, poetry, drama, essays and literary criticism, and she is professor of creative writing at Brunel University London, and vice-president of the Royal Society of Literature.
“It’s been in the works for quite a while,” said the author of Manifesto. “I wanted to write a non-fiction book that looks at how my life and my background and my politics has shaped my creativity and brought me to this place in my career. It’s a great place to be, but it’s been a very long journey, over 40 years. This felt like the right time, having reached this position as a writer, to reflect back on how I got here.”
Hamish Hamilton said the book, which it described as “Bernardine Evaristo’s manifesto for never giving up”, would offer “a vital contribution to current conversations around social issues such as race, class, feminism, sexuality and ageing”.
“I never seriously entertained the idea of giving up because I couldn’t imagine not being a writer, whether I was seen as successful or not,” said Evaristo. “It’s really about looking at how my life and choices have shaped my creativity and determination to keep going.
“I want it to be for the general reader – including people in the arts, but for anyone who’s interested in looking at how we create the lives we want for ourselves, which might mean breaking with convention and tradition, and making choices that might lead to creative fulfilment but not financial success. I do also like the idea that through my experience, people who are struggling in their careers, in the arts, in their lives, might be given hope through my own story over the decades.”
', true, TIMESTAMP '2021-03-11 09:36:26', 200, 'review', 'literature', 41);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Lonesome Dove author and Brokeback Mountain screenwriter Larry McMurtry dies at 84', 'abs.jpeg', 'Larry McMurtry, the Pulitzer prize-winning author and screenwriter who examined the reality of the American west in novels including Lonesome Dove, has died.
McMurtry, 84, was the author of more than 30 novels, from Terms of Endearment to The Last Picture Show, and received an Academy Award for best adapted screenplay for his work on Brokeback Mountain with Diana Ossana, an award he famously accepted wearing jeans and cowboy boots. His death was confirmed to the New York Times by a spokesperson for his family.
McMurtry, who was born in Texas, published his first novel, Horseman, Pass By, in 1961. Set in a north Texas town on a cattle ranch, it was filmed as Hud, with Paul Newman in the leading role. His third novel, The Last Picture Show, a coming-of-age story set in a small Texas town, was adapted into a 1971 film starring Jeff Bridges and Cybill Shepherd, and brought him to wider fame.
The film adaptation of his novel Terms of Endearment, the story of a widowed mother and her daughter starring Shirley MacLaine, Debra Winger and Jack Nicholson, won the Oscar for best picture, while his 1985 novel Lonesome Dove, following retired Texas rangers driving a cattle herd from Texas to Montana in the 1870s, won him a Pulitzer prize and was adapted into a mini-series starring Robert Duvall and Tommy Lee Jones.
', true, TIMESTAMP '2020-10-17 23:15:03', 185, 'article', 'literature', 95);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Beverly Cleary, beloved children’s author, dies aged 104', 'abs.jpeg', 'Beverly Cleary, the celebrated children’s author whose memories of her Oregon childhood were shared with millions through the likes of Ramona and Beezus Quimby and Henry Huggins, has died. She was 104.
Cleary’s publisher HarperCollins announced Friday that the author died Thursday in northern California, where she had lived since the 1960s. No cause of death was given.
Trained as a librarian, Cleary didn’t start writing books until her early 30s when she wrote Henry Huggins, published in 1950. Children worldwide came to love the adventures of Huggins and his neighbors Ellen Tebbits, Otis Spofford, Beatrice “Beezus” Quimby and her younger sister, Ramona. They inhabit a down-home, wholesome setting on Klickitat Street – a real street in Portland, Oregon, the city where Cleary spent much of her youth.
Among the Henry titles were Henry and Ribsy, Henry and the Paper Route and Henry and Beezus.
Ramona, perhaps her best-known character, made her debut in Henry Huggins with only a brief mention.
“All the children appeared to be only children so I tossed in a little sister and she didn’t go away. She kept appearing in every book,” she said in a March 2016 telephone interview from her California home.
Cleary herself was an only child and said the character wasn’t a mirror.
“I was a well-behaved little girl, not that I wanted to be,” she said. “At the age of Ramona, in those days, children played outside. We played hopscotch and jump rope and I loved them and always had scraped knees.”
In all, there were eight books on Ramona between Beezus and Ramona in 1955 and Ramona’s World in 1999.
Cleary wasn’t writing recently because she said she felt “it’s important for writers to know when to quit”.
“I even got rid of my typewriter. It was a nice one but I hate to type. When I started writing I found that I was thinking more about my typing than what I was going to say, so I wrote it longhand,” she said in March 2016.
', true, TIMESTAMP '2021-01-05 22:11:46', 131, 'news', 'literature', 78);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Sesame Street to Bugbears: the kids’ TV that challenges racism', 'abs.jpeg', 'Sesame Street has always been great at introducing children to difficult subjects. When cast member Will Lee died in 1982, it dedicated a show to exploring the notion of grief. In 2019, it told the story of Karli, a green Muppet whose mother was struggling with opioid addiction. And now it is explicitly teaching kids to dismantle racism.
A new three-minute Sesame Street clip entitled Explaining Race debuted this week. In it, two African-American Muppets – Wes, a five-year-old, and his father Elijah – engage Elmo in a discussion about identity. At one point the father gestures to an autumn tree and says: “When people of all colours come together, we stand strong, like this tree.” It’s hoped that Wes and Elijah will be used to discuss race and racism in a more direct way than Sesame Street has done in the past.
', false, TIMESTAMP '2020-04-16 09:49:51', 274, 'article', 'tv show', 85);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('’She showed what poetry can do’: young London laureates feel the Amanda Gorman effect', 'abs.jpeg', '“I came to poetry by accident, through a workshop at Camden’s Roundhouse. I was 18 at the time, had no money, and was living alone in London. Poetry had not been in my life before. I was awful when I started. But I was so thirsty to get better.
I’m working on my first collection now. I lost my mum at a young age, so a lot of the collection looks at how that might impact a young woman. And I lost my older brother to suicide in 2012. He had a long battle with addiction, and also his sexuality, and I was a carer for him for a really long time. A lot of the poems in the book that I’m working on are looking at his life. I’ve always used writing as a way to figure things out: not necessarily to find answers, more to ask questions about them.
When young people see a poem or film on YouTube or social media, it gets rid of that preconception that poetry has to be this isolated, solitary act of opening a book and reading something old fashioned. I love reading poetry myself, and I believe that young people can, too, but they can also love spoken word or performance poetry, poetry on film or poetry with music.
I’ve worked with young people for almost a decade now, and I’ve experienced first-hand the impact poetry can have on them – something happens when you let yourself be free and creative, it is magic. It’s really empowering for young people to be told that what they have to say is important and valid. We need young voices contributing to the canon, because they usually reflect what’s really going on in the world a lot of the time.
Someone who I use as a springboard for young people is Danez Smith, a non-binary African American poet who talks a lot about race, class, sexuality and gender in their collections Don’t Call Us Dead and Homie.
Roger Robinson’s book A Portable Paradise responded so amazingly to the injustice of Grenfell, as did Jay Bernard’s book Surge. There are so many amazing writers at the moment.”
', true, TIMESTAMP '2020-07-21 06:11:50', 170, 'news', 'literature', 31);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Hamilton review – Australian cast shines bright and brilliant in blockbuster Broadway show', 'abs.jpeg', 'If the world is looking to Australia to lead its primary theatre markets into the future, then it need look no further than Hamilton, which has opened to rapturous applause and an extended standing ovation from a masked, Covid-safe audience at the Sydney Lyric.
Hamilton in Australia might not seem like a natural success. The show’s often too-earnest reverence of its colonial founding mythology is at odds with our longstanding refusal to deify our politicians. We certainly don’t study these figureheads and their adventures and misadventures in our schools (it’s a rightful gap – our unwillingness to look beyond our own colonisers and educate our children on Australian Indigenous history, languages and cultures less so). Plus, the local musical theatre sector has a troubling habit of prioritising whiteness when programming and casting shows.
Still, its arrival was inevitable because, before the global pandemic shut down countless stages, Hamilton reigned. It was the jewel of Broadway, a West End hit, a US touring juggernaut. When a show seizes the collective consciousness – when it pierces the mainstream, hits the Billboard charts, and makes celebrities of its creators (the name of Lin-Manuel Miranda, who wrote the music, book, and lyrics is well known here) – Australia generally follows. We were to be a new but smaller part of the Hamilton experience.
Now there is only Australia. The only Alexander Hamilton is Jason Arrow, a roiling, prideful peacock with a quick mind and quicker mouth. Now his worthy adversary Aaron Burr is only – could only – be Lyndon Watts in a star-making turn, an arch and conspiratorial performer who is droll one minute and devastating the next. They fill the roles like telling this story is as necessary as breathing. The story unspools from their centre, hurtling towards its inevitably tragic end.
', false, TIMESTAMP '2019-07-24 16:31:11', 176, 'review', 'theatre', 85);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Vivian Gornick: ’I couldn’t finish Michelle Obama’s Becoming’', 'abs.jpeg', 'The book I am currently reading
Penelope Fitzgerald: A Life by Hermione Lee. I had actually never read anything by Lee before. I’ve only read 50 or 60 pages, but her style is immensely appealing. The sentences are very simple, there’s no fancy writing – she somehow puts things together in such a lively way that I feel as if I’m listening to her. She hits that marvellous conversational style. I like Fitzgerald’s work and it’s a pleasure seeing how she developed. I’m enjoying it very much.
The book that changed my life
I was well into my 30s when I read The Little Virtues by Natalia Ginzburg and as soon as I began I felt myself deeply connected. It isn’t that it’s the greatest book in the world, but for me it was vital. I felt she was showing me the type of writer I had it in me to be. One of the essays – “My Vocation” – really hit the nail on the head. I identified profoundly with the way in which Ginzburg traced her own development as a nonfiction writer. It made me realise that it was only through this kind of writing I could employ my own storytelling gifts. I reread it irregularly but quite a lot, and I’m always amazed by what she is able to accomplish with the small personal essay.
The book I think is most overrated
A Sport and a Pastime by James Salter is immensely overrated. I could have picked 100 books like that, but this is the one that has been stuck in my craw for a long time.
The last book that made me laugh
Out of Sheer Rage by Geoff Dyer is a brilliant book. For me, the best thing he ever wrote. A little bit of genius, it made me laugh, and laugh, and laugh.
The last book that made me cry
Just Mercy by Bryan Stevenson. It’s written by an Ivy League-educated, middle-class black lawyer who went to work for a non-profit organisation set up to defend the people on death row in the south. The story of what it means to be on death row in Georgia and Alabama is enough to break your heart 15 times over. His description makes it sound like South Africa before apartheid was ended. A nightmare. A wonderfully written book.
The book I couldn’t finish
Michelle Obama’s autobiography, Becoming. Yes, she’s a very nice woman but I found the book tedious, and it just didn’t hold my interest
The book I’m ashamed not to have read
Thomas Mann’s The Magic Mountain. I’ve started it 100 times over – I just can’t get into it. I always feel bad about that. I don’t think I’ll try again.
The book I give as a gift
This depends on who I’m giving the book to. It’s like giving any other kind of gift: you try to keep in mind what the recipient will like, not what you like. But it always has to be something I consider substantial. I would never give somebody the current fiction bestseller or anything like that. If I give a book, it’s one that I value, but most importantly one that the other person will value too.
My earliest reading memory
Little Women by Louisa May Alcott. Our house was full of books and my parents encouraged me to read, but I don’t remember any childhood stories like Winnie the Pooh. I remember fairytales like the Grimms’, but the first time I was really impressed with the experience of reading was Little Women. It went right into me.
My comfort read
The Odd Women by George Gissing. There was a time when I read that book every six months – usually in the winter – for quite a number of years. It’s a book that I treasure to this day. ', false, TIMESTAMP '2020-03-15 00:04:42', 1, 'review', 'literature', 49);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Howl: illuminating draft of Allen Ginsberg’s seminal poem found', 'abs.jpeg', 'A draft of Allen Ginsberg’s Howl has been found, giving rare insight into the mind of the Beat poet as he composed the seminal poem.
The carbon copy was discovered by a family member in the papers of the arts patron Annie Ruff, who hosted poets and other artists, including Ginsberg, in her home over the years. The family member, believing they may have found an early version of Howl, contacted rare book dealer and Beats specialist Brian Cassidy to authenticate it, with Cassidy identifying the draft as a carbon copy struck on Ginsberg’s own typewriter in late January or early February 1956.
Ginsberg famously read aloud from Howl for the first time in October 1955 – “the night of the birth of the San Francisco poetry renaissance”, according to Jack Kerouac.
But the poem, a cry of rage against society which laments how the poet “saw the best minds of my generation destroyed by madness”, was not published until the autumn of 1956. Lawrence Ferlinghetti would be arrested and charged, unsuccessfully, with obscenity for publishing it, a trial that launched Ginsberg’s career into the stratosphere.
The 11-page early draft is for sale at Type Punch Matrix, for $425,000 (£308,000). Cassidy said: “This draft is an important step in the evolution of the poem. Because it is the carbon copy (and not the top copy), you can see many of the original choices made by Ginsberg before he revised them. These are changes that would otherwise be lost.”
Even more significantly, he said, the carbon is the only extant draft version of one complete page of the poem which Ginsberg discarded entirely, with the poet rewriting and revising the whole page. The text of that page had only been known from the first recorded reading of Howl by Ginsberg at Reed College in 1956.
“This typescript allows a look into the mind of the poet while composing what is arguably the most important 20th-century American poem,” said Cassidy. “For a draft of a major work of literature like this to go unknown for so long is extraordinarily unusual … As I’ve joked with some of my colleagues, my career is all downhill from here.”', false, TIMESTAMP '2020-07-02 06:37:09', 48, 'review', 'literature', 8);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('New Gods and dead heroes: why Snyder’s DC plans are temptingly off the wall', 'abs.jpeg', 'The idea that Zack Snyder is a visionary still doesn’t sit quite right, even following his surprisingly excellent Justice League re-cut. After all, this is the director of Batman v Superman: Dawn of Justice, a movie that always seemed as if it had been named by the marketing department and only then sent to the scriptwriter. Was Snyder’s Batman always intended from the start to be a brutish, gun-toting meanie? Or was he forced to reimagine him that way because somebody at DC was determined to see Kal-El and the Dark Knight battle it out on the big screen? It is hard to imagine Michael Keaton or Christian Bale’s good-hearted superheroes suddenly deciding to destroy the last son of Krypton.
The weakest parts of the Snyder Cut are the epilogues, even with the off-kilter joy of seeing Jared Leto play the Joker again. Batman’s Knightmare, it is heavily hinted, is a vision of the future in which Gotham’s defender prowls a horrifying cursed Earth, Superman has been turned evil and Aquaman is dead. It seems to be set earlier than Batfleck’s dream/vision in Dawn of Justice, in which Superman takes bloody revenge on the Dark Knight for killing (we assume) Lois Lane. It is our glimpse at the storylines that would have unfurled in Snyder’s five-movie plan for his DC movies, of which Justice League was only intended to be the third episode.
', true, TIMESTAMP '2019-03-28 11:39:27', 57, 'news', 'cinema', 16);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('William Forsythe: The Barre Project review – a half-hour of perfection', 'abs.jpeg', 'In ballet, exercises at the barre represent the foundation of dance training and the beginning of every dancing day. It’s a ritual that many dancers have continued at home as they’ve been cut adrift by Covid, something to hang on to (literally) from their old life and routine. The ubiquitous piece of studio furniture is rarely seen on stage, but it is the inspiration for William Forsythe’s latest creation, The Barre Project, five short episodes made remotely with New York City Ballet principal Tiler Peck and dancers Lex Ishimoto, Brooklyn Mack and Roman Mejia, filmed on the empty stage of a California theatre.
It is Forsythe’s second foray into using the music of electronic artist James Blake (after Blake Works I, for the Paris Opera Ballet), and the glitched beats, rumbly bass and vulnerable vocals are beautiful in their sparseness. It’s one thing to layer on sounds, the real genius is in taking them away. Same goes for dance steps, when you’re a good enough choreographer not to have to obfuscate. And Forsythe certainly is. There are plenty of steps here, the dancers moving at great speed, but it sings with clarity.
Tiler Peck – who broadcast daily ballet classes during lockdown using her parents’ kitchen counter as a makeshift barre – leads the quartet. She’s sharp, she’s slinky and she’s got attitude, like the casual swipe of a leg that whips her body round with invisible momentum. There’s absolute control and precision on display at every second, in rond de jambe, frappé and petit battement, everything taking place at the barre or within a few metres of it. There’s exciting speed but also restraint – it’s never bombastic. The men do buoyant beats with ease and swift, tight turns. Nothing spills over the edges, but there’s rubato within the strict pulse, fleshing out a move like a pitchbend on a synthesiser. Peck can be machine-like, then suddenly sink into her hip and smile with subtle showgirl flair.
', false, TIMESTAMP '2020-06-21 17:18:47', 98, 'news', 'theatre', 26);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('’Downton Abbey is ludicrous’: the biggest TV hits we’ve never seen – until now', 'abs.jpeg', '24
As with my experience of so many modern cultural touchstones, I first came to 24 via a Simpsons parody. Being only seven years old in 2001, when the 24-episode “real time” thriller first aired, my knowledge of Kiefer Sutherland’s exhausting counter-terror mission to stop the assassination of a presidential hopeful came from a 2007 Simpsons episode starring Lisa and Bart in a split-screen chase to hold off the detonation of a powerful stink bomb at Springfield Elementary.
Watching the real thing for the first time, it is clear that this is a product of the early 00s, from the clumsy racial othering of Dennis Haysbert’s black senator David Palmer and the low-rise jeans everyone is wearing to the clunky technology and nu-metal soundtrack. Yet there is also a timeless sense to the series as it progresses – namely in the relentless charge of Sutherland’s gruff-voiced Jack Bauer and in the snappy split-screen editing, artfully tying together disparate narrative strands.
With each hour episode of the show representing an hour in the life of Bauer and his storyline, one thing 24 has is lots of time to play with. Perhaps my millennial brain has been rotted by the near-instant gratification of the miniseries, but I struggle to stick with the meandering first few episodes. However, once I’m invested – somewhere between the fourth and fifth hour – I’m gripped. I’ve binged 12 hours over the past few days and amid the tectonic thump of the ticking clock, there have been kidnappings, more concussions than I can count and not once has Bauer stopped to go to the toilet. It seems I’ll be in to 24 for the long haul – or at least another 24 hours. Ammar Kalia
Downton Abbey
Until last week, I’d never watched a single second of Downton Abbey. That was no accident. I presumed the show was the platonic ideal of my most loathed TV subgenre: dull and mawkish period dramas, saturated in nostalgia for a rigid class hierarchy I consider deeply disturbing, rather than reassuringly organised. So, imagine my surprise when I discovered that the first episode was actually quite good. Yes, there was a colossal amount of hand-wringing over the finer points of inheritance law, but that was woven into a clever, engaging portrait of a society on the brink of two radical shifts: the success of women’s suffrage and the rise of the middle classes. Rather than being schmaltzy and simplified, the upstairs/downstairs dynamic was portrayed with an ambivalence that highlighted its brutality and symbiotic nature.
And then, in episode three, something ludicrous happened. Then another. And then another. The whirlwind plot increasingly beggared belief; there were CBeebies-levels of expository dialogue; the melodrama was unintentionally hilarious. The rest of it began to disintegrate. Initially, I thought the show was demonstrating the ways human kindness shone through the cracks in this strict social hierarchy, but soon the celebration of decency started to seem like a celebration of the system itself. What had at first appeared to be level-headed appraisal now seemed like nauseatingly sentimental propaganda. I finished series one feeling newly depressed about the implications of Downton’s huge international success. But at least there was one upside: I was right all along. Rachel Aroesti

The West Wing
The West Wing is more daunting than most TV classics. This is no snackable six-parter, or even a 13-episode sprint, but a terrifying seven seasons and 156 episodes’ worth of supposedly brilliant television. Truth be told, I have never been able to face starting it; there is already too much to watch and not enough time. And, as the political climate has become increasingly toxic and ever more shameless, it seemed almost perverse to go back to a time when politics was still boring enough for people to not know what Potus stood for. I assumed that The West Wing would have aged about as well as a yoghurt left in the sun on a hot day.
I watched the first three episodes and there is no doubt that it has dated – has any show employed soaring strings so often, and so bombastically, since? – but i is incredible at fixing you in the dramatic centre of even mundane-seeming conundrums. Aaron Sorkin’s dialogue is not sparse – at the most recent Golden Globes, Tina Fey joked that he “can have seven men talking, and it feels like 100 men talking,” – but I admired the breathless zip of it. It was more sincere and less arch than I have come to expect television to be, for which I blame either Veep or current affairs. As for the politics, I was quickly nostalgic for a time when the Christian right fought for condoms to be removed from high schools, rather than pushing wild insurrectionist conspiracy theories. The West Wing is still daunting – 153 episodes to go! – but I did not expect to find it so soothing. Rebecca Nicholson
', false, TIMESTAMP '2019-10-06 21:33:54', 30, 'article', 'tv show', 81);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('’It’s a statement of exclusion’: music festivals return to UK but lineups still lack women', 'abs.jpeg', 'As the UK festival industry gets back on its feet after a fallow, fun-free year, the issue of gender equality on lineups has fallen by the wayside, Guardian analysis of 31 events has shown.
Friday marked a mini-boom for festival bill announcements, all heavily weighted towards male performers. Headlined by Liam Gallagher, Snow Patrol, David Guetta and Duran Duran, Isle of Wight offered a 73% male lineup.
Gallagher also headlines Scotland’s TRNSMT festival alongside the Chemical Brothers and the Courteeners, topping a bill where all-male acts make up 61% of performers. At Kendal Calling, headlined by Stereophonics, Supergrass, the Streets and Dizzee Rascal, a partial lineup announcement featured 79% men.
“It’s totally unacceptable that after a year of turmoil, women and minorities are being excluded from this return to live,” said Maxie Gedge, UK project manager of Keychange, the PRS Foundation’s initiative encouraging music festivals to pledge to commit to lineups featuring 50% women and gender minorities by 2022.
“We usually stay on the positive side instead of calling people out, but we’re getting tired,” said Gedge. “It’s not an accident any more, it’s a statement of exclusion. The fact that this keeps happening shows that there are certain festivals that just aren’t taking responsibility, or they’re not viewing it as their responsibility when, in actuality, it’s everyone’s.”
', false, TIMESTAMP '2019-09-19 16:46:33', 181, 'review', 'music', 97);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Opera Ballet Vlaanderen: Palmos review – hypnotic instants of connection', 'abs.jpeg', 'Palmos is a ballet that comes drenched in its music– songs taken from albums by the American artist Active Child (Patrick Grossi), who has also written two new tracks for the show. It’s a soundwash of electronic shimmer, ultra-minimal R&B beats and Grossi’s ethereal falsetto vocals (he has a background as a choir boy). But it also comes with a dark chill, like a cold shiver sent across the stage.
Greek choreographer Andonis Foniadakis chose to collaborate with Grossi on this new work Palmos – meaning “pulse” – created for Antwerp’s Opera Ballet Vlaanderen (there’s also additional music by Julien Tarride). The theme is connection, or our memories of connection, what we’re missing in this year of separation. Though in Palmos the dancers are all over each other for the most part, so it’s more like a fantasy of connection: accelerated, hungry and chimerical, fed by months of starvation.
Foniadakis’s figures are never still, the music, lights and dance all flickering. There are ripples and spirals through the bodies, limbs like tendrils, torsos artfully squirming as if they were trying to touch every bit of air around them with each rib. Bourrées en pointe are a recurring motif; tiny repeated steps on the spot (or thereabouts), they give the feeling of action and nervous anticipation all in one. There’s a hard edge in some of the choreography for the women that’s common in contemporary ballet. It’s a knowing display: hips jut, chests forward, chin up, stylish angles and a lot of high kicks, almost weaponised. You could imagine Beyoncé doing it, long hair flicking, pointe shoes like the highest of heels. It’s all very alluring, and it fits with the avant-pop soundtrack, the black stage lit with single red or white fluorescent strips, and the high-cut, nude-backed leotards.
', true, TIMESTAMP '2020-09-09 04:19:48', 182, 'review', 'theatre', 87);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Bertrand Tavernier obituary', 'abs.jpeg', 'The film-maker Bertrand Tavernier, who has died aged 79, invested his movies with a scrupulous and humane curiosity, no matter what the theme, genre or setting. He was catholic in his enthusiasms, moving easily from period drama to policier, swashbuckler to science-fiction, wide-ranging documentary to intimate musical elegy. The Observer critic Philip French said in 2002 that the director “combines a powerful intellect with a strong social conscience and has a greater knowledge of, and feeling for, the history of cinema than any moviemaker alive”.
Tavernier enjoyed international success with A Sunday in the Country (1984), his portrait of an ageing artist and his family at the dawn of the 20th century; it won him the best director prize at the Cannes film festival. Round Midnight (1986) starred the saxophonist Dexter Gordon, who was Oscar-nominated for best actor, as a jazz musician who flees New York for Paris in the 1950s. Herbie Hancock, also seen on screen, won an Oscar for his score. Tavernier’s evocation of the smoky bebop milieu, and his faith in music to do much of the heavy lifting, resulted in one of the most generous and authentic films ever made about jazz.
Also among his finest work was Coup de Torchon (1981), which transposed Jim Thompson’s pulp novel Pop. 1280 to French West Africa in the 1930s, and starred Philippe Noiret and Isabelle Huppert. The crime writer Donald E Westlake considered it the best screen adaptation of Thompson’s writing.
', false, TIMESTAMP '2020-10-09 00:22:12', 264, 'news', 'cinema', 41);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Working from Home review – Johnny Vegas’s chaotic pub quiz is a winner', 'abs.jpeg', '“A year into lockdown, here we are,” says Just the Tonic supremo Darrell Martin, whose Covid travails have been offset by the success of this online format, Working from Home. Launched last May, it’s been pulling in viewers by the thousand – and tonight’s edition sustains the momentum. Its USP is a new “pub quiz type thing” from Johnny Vegas, which is as chaotic as you’d expect. But that’s just one section among many in this three-hour sprawl, ranging across standup sets, Matt Forde’s Boris Johnson tribute act, and loose-hinge Jason Byrne playing a trumpet in the toilet.
It’s great fun, and closer in spirit than most digital offerings to the real-world comedy club experience. The Zoom audience, visible to the acts (“Dale, stop picking stuff out your teeth, I can see you”), is highly involved. Paul in Southampton, swilling gin from a football-sized glass, is practically star of the show. That’s only partly because Byrne is headlining. Sat in his loo, parping gameshow theme tunes on a toy trumpet, the Irishman always puts his audience centre stage, a policy it was fascinating to see mapped on to a digital format.
It still works – even if the audible burble from home viewers threatened to drown out his act. It was 11.30pm by now. Had viewers tuned out after the earlier Show Within a Show section – three acts and a compere, wrapped up within an hour – they’d still have had bang for their buck: Cally Beaton playing the fiftysomething vamp, Hal Cruttenden spoofing his self-absorption, and Chris Turner improvising rap – brilliant if, at Zoom close quarters, oddly anxiety-inducing.
But they’d have missed Vegas in viking helmet, brandishing a Donald Trump piñata and touching himself up with a robot claw. “Alright Darrell, I’m getting the sense that you’re rushing me now,” our host protests when prodded to fulfil question-master duties. A quiz of sorts, and a few technical gremlins, ensue. But this is the kind of show – loose-fitting, open-hearted, in-for-a-penny – that can absorb a few hiccups. “I’ve been busy booking live gigs,” Martin tells us at the end, “they’re coming back soon!” Not, I hope – a new sentiment for me – at the expense of this.
', true, TIMESTAMP '2019-07-29 12:38:23', 290, 'news', 'theatre', 73);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Doubts cast over provenance of unearthed Sappho poems', 'abs.jpeg', 'When two hitherto unknown poems by Sappho were brought to light in early 2014, it was a literary sensation. The sixth-century BC poet is one of the most celebrated writers of Greco-Roman antiquity, a tender chronicler of the agonies of female desire, and a gay icon. But frustratingly few works by her survive, and those that do largely come from ancient papyrus fragments preserved in the dry sands of Egypt.
But now the editors of a scholarly volume in which the circumstances of the discovery were detailed have formally retracted the chapter because the manuscript’s “provenance is tainted,” according to a statement issued through the book’s academic publisher, Brill.
In the years following the publication of the poems, many concerns were raised by scholars about why the manuscript remained unavailable for study, and why documentation concerning its acquisition had not been made public. It was said to belong to a London collector who preferred to remain anonymous.
In the now-retracted article, first published in 2016, it was stated that the papyrus manuscript on which the Sappho poems were written had been recovered by the staff of the London collector from cartonnage – ancient Egyptian papier-mache, often used to create funerary masks. According to this account, this particular piece of cartonnage, perhaps once used as bookbinding, had been formerly in an American collection, and eventually purchased legally by the collector in a Christie’s auction in London in 2011. When the cartonnage was dissolved by the collector’s staff and the individual sheets teased apart, the Sappho poems were revealed. Crucially, the artefact in question had been, according to this account, taken out of Egypt before 1970, the year a Unesco convention on cultural heritage was widely adopted. Strict Egyptian laws govern excavation and trafficking of its ancient artefacts.
A privately circulated Christie’s brochure was revealed in 2019 containing some images of the recovery process described in the article, but the photographs, when analysed by papyrologists, led to yet more questions about the account’s credibility.
Small fragments of the same Sappho manuscript ended up in the private collection of the American billionaire evangelical Green family, who fund the Museum of the Bible in Washington DC. After concerns raised about the legality of a number of artefacts in their possession, museum officials investigated these small fragments of the Sappho manuscript and announced that they had been purchased in 2012 from a Turkish dealer, Yakup Eksioglu, without appropriate documentation. Eksioglu said last year that he was the source of all the Sappho fragments. He called the story of the recovery from cartonnage bought at Christie’s a “fake story”. The Green family has repatriated their portions of the Sappho manuscript to the Egyptian state, along with thousands of other artefacts found to have been wrongfully acquired.
According to the statement from the editors of the retracted chapter, “The repatriation of the Green Sappho fragments has restored these papyri to [their] rightful owner.” The main part of the papyrus manuscript, they said, “remains problematic, not only because its provenance is tainted but also because the papyrus … is inaccessible. We sincerely hope that it will also be made available to the academic community soon and its acquisition circumstances fully explained”. They have not, they say, seen any evidence to suggest that the manuscript is inauthentic.
', false, TIMESTAMP '2021-03-12 12:53:36', 94, 'news', 'literature', 69);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Memories of My Father – loving portrait of a parent', 'abs.jpeg', 'A child’s-eye view of a hero father – Javier Cámara stars as dedicated parent, doctor, human-rights leader and all-round good egg Héctor Abad Gómez – is saturated with a honeyed colour palette and an unapologetically sentimental score. But as the child grows into an adult, the film adopts starker black-and-white photography and a harder-edged approach to Colombia’s tumultuous political backdro. Adapted, somewhat inelegantly, from an autobiographical novel by Héctor Abad Faciolince, Memories of My Father is a touch overlong and soapy and awkwardly structured. But it’s still an engrossingly watchable drama.', false, TIMESTAMP '2019-11-23 21:22:29', 72, 'article', 'cinema', 35);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Tom and Jerry review – wearisome live action adaptation', 'abs.jpeg', 'The long-running feud between cat and smart-aleck mouse gets a new platform in this feature-length adaptation of the Hanna Barbera cartoon. The backdrop is a swanky Manhattan hotel, which is set to host the wedding of the year. The approach, a marriage of cluttered live action with madcap 2D animation, owes an obvious debt to Who Framed Roger Rabbit, but has more in common with the wearisome and unfunny Garfield: The Movie. Chloë Grace Moretz stars as Kayla, an opportunist who cons her way into a job using a stolen résumé. It’s astute casting – Moretz’s habitually overblown acting style seems slightly less jarring when juxtaposed with rampaging cartoon elephants. The film is most entertaining when it wreaks havoc – a car chase involving a commandeered military drone is a slickly executed riot. But lazy writing squashes any real fun as emphatically as an Acme anvil dropped from a roof.', true, TIMESTAMP '2019-07-24 18:02:39', 150, 'review', 'cinema', 10);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('From Strawberries & Creem to Standon Calling: 2021’s best summer festivals', 'abs.jpeg', 'Bigfoot festival
Bigfoot’s USP is IPA. A craft beer paradise, there’ll be just as many kinds of ale as there will be bands, with Primal Scream, Hot Chip, Fat White Family, Baxter Dury, Big Joanie and many more getting all hopped up in the grounds of a lavish stately home.
Go for: The beer tent to end all beer tents, hosted by beloved Hackney boozer The Gun.
Stay for: Club Mexicana’s vegan tacos.
18-20 June, Ragley Hall, Warwickshire

Black Deer
Oddly, Americana’s UK home is just outside Royal Tunbridge Wells. Covering all your blues, folk and country bases, Van Morrison and Robert Plant are heading things up, but there are some new-school gems too, including Bristol’s Lady Nade and Brit-folker Jade Bird.
Go for: The Roadhouse stage, featuring custom motorcycle builds that’ll make an Easy Rider out of an Alan Partridge.
Stay for: An entire arena dedicated to the art of barbecue.
25-27 June, Eridge Park, Kent

Latitude
With Lewis Capaldi, Bastille, Snow Patrol and First Aid Kit in attendance, expect big Radio 2 energy. Mayhem might be in short supply, but if getting a nice coffee and a midnight bedtime (at the latest) is a priority, Latitude’s here for you.
Go for: A terribly pleasant and largely inoffensive time.
Stay for: The comedy bill, which always beats every other fest.
22-25 July, Henham Park, Suffolk
', true, TIMESTAMP '2020-03-29 03:42:39', 150, 'news', 'music', 85);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Teacher wins UK poetry prize with poem on dual heritage', 'abs.jpeg', 'A startling poem with allusions to a rich range of subjects ranging from Salvador Dalí and the Bible to an abused footballer, a revered hip-hop band and the Welsh language has won a prestigious literary award.
The Fruit of the Spirit is Love (Galatians 5:22) by Marvin Thompson, a school teacher in Wales, was judged the best from more than 18,000 poems entered into the National Poetry Competition by more than 7,000 writers from 95 countries.
Thompson, who lives in Torfaen, south Wales, and works in Lliswerry high school in the city of Newport, said he screamed when he heard he had followed in the footsteps of the likes of Carol Ann Duffy as winner of the award. “My children stared at me, wondering what was going on,” he said.
London-born Thompson, 43, is of Jamaican heritage and said one the aims of the poem was to help his children, who live in Wales, understand their dual heritage.
“As with all my poems, it was written for my children, a gift to their future selves,” he said. “A poem to be read on nights when the weight of being a dual-heritage person in Britain feels too heavy to bear.”
He said it was also for his parents. “When they were born in Jamaica, they were British by way of empire. When they made their home in London, they encountered racism and friendship and love. My poem is for anyone who has felt discrimination.”
One element of the poem is the mockery of the footballer Jason Lee on the 90s television show Fantasy Football, in which his hairstyle was compared to a pineapple. Thompson regrets that he laughed along before realising how wrong it was.
He also wonders in the poem if he should play his children the US rap band Wu-Tang Clan or if they will sing calypsos, reflecting his West Indian heritage or the sort of hymns they learn in Wales.
A Welsh word, “cwtch” – a cuddle or hug, also makes an appearance. Thompson said it was the perfect word for what he was trying to convey. “It sounds more comforting than the English words with the hard Ds and G,” he said.
Love also features strongly. “My poem is for everyone, everywhere who lives their life seeking and believing in love,” he said.
One of the judges, Karen McCarthy Woolf, said: “What distinguishes The Fruit of the Spirit is Love is how it operates on multiple, complex levels yet speaks in a voice that is fresh, honest and brave.
“Specific in its geography, natural in diction, this is a poem that asks many distinctly contemporary questions that make you feel as if it could only have been written here and now, in 21st-century post-Brexit Britain.
“What is it to raise dual-heritage children in the UK, and specifically in Wales? How does black identity shape itself in a white environment, where allegiance to a predominantly hostile flag is the paradox of belonging? Will these children be loyal to Wu-Tang or sing hymns in the Welsh choir? Or, as the poem demonstrates, will they do all of these things at once?”
Thompson’s poem will be published on the Poetry Society’s website. It will also appear in the spring issue of the Poetry Society’s poetry journal, The Poetry Review.
', false, TIMESTAMP '2019-02-10 16:56:36', 262, 'news', 'literature', 21);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Dry Cleaning: the post-punks who sing about Meghan Markle and Müller Rice', 'abs.jpeg', '“You’re just what England needs / You’re going to change us,” Florence Shaw intones on Dry Cleaning’s 2019 track Magic of Meghan. It’s a song she’s been thinking about “quite a bit” since the Oprah interview with the Duchess of Sussex aired. “I was just interested in her and trying to forget about a breakup. But I did have an ominous feeling about Meghan – a sense that it was going to go horribly wrong.”
The south London-based quartet’s songs are often eerily prophetic – creating something surreal, touching and hilarious that captures the absurdity of modern life. Their sound marries agitated post-punk with Shaw’s sardonic spoken-word lyrics – think Magazine fronted by a Beat poet who talks about phone scams and Travelodges.
The story goes – according to early interviews – that long-term friends guitarist Tom Dowse, bassist Lewis Maynard and drummer Nick Buxton decided to form the band in 2017 after a drunken karaoke session. “Do you want us to stick to that?” asks Dowse. “Because it isn’t really true. We sang Minerva by Deftones together, which was a bonding experience, but I don’t know if it really ignited the desire to be in a band … ”
A jamming session ensued, and they spent the next few months writing songs and trying to find a singer who wasn’t the usual cliched frontperson. Step forward the band’s friend Shaw, a visual artist who had no musical experience. From the first rehearsal in Maynard’s mum’s garage it was clear that she was the missing link.
The band have since developed a “near-psychic understanding” of how to leave the right amount of space for each other in their songs. “It’s almost like you’re slowing down time and there’s a conversation between us,” says Dowse. Drawing from wider, weirder influences (they mention everyone from Black Sabbath to Augustus Pablo) than on their first two EPs, they wanted their debut album to “sound like its own little world”.
That feeling is only enhanced by Shaw’s muted delivery of surreal lyrics. The album, New Long Leg, sees her revelling in the minutiae of life – particularly food. You’ll hear a whole supermarket’s worth of references on the album, from Müller Corners to pasta bakes: “Recently a journalist asked: ‘So, what’s the deal with the food?’ Now every time I hear the songs I’m like: ‘Fucking hell, there’s food every other line.’”
As lockdown ends, the band are turning their thoughts from the kitchen to the stage. “We did a photoshoot recently and performed the whole album to this photographer who didn’t ask, or want us to,” laughs Maynard. “It was the closest we’ve had to an audience in ages.” Not quite an audience with royalty, but they’ll take it for now.
', false, TIMESTAMP '2020-04-24 21:45:54', 263, 'article', 'music', 6);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('’I feel admonished for being myself’: Yseult, the chanson singer riling the French establishment', 'abs.jpeg', 'Accepting the award for the best newcomer at Victoires de la Musique (the French Grammys) on 12 February, Yseult said: “This is not just a victory for me, it’s a victory for my brothers and sisters. We have snatched this, our freedom, our independence, this space. We deserve it.”
Raised in the Bercy neighbourhood of Paris by Cameroonian parents, the 26-year-old represents the tension between a new French generation and an establishment that resists change. Yseult is a Black woman putting her own take on traditional variété française. “I grew up listening to Edith Piaf, Barbara, Jacques Brel, Lara Fabian, Patricia Kaas,” she says by phone a month post-Victoires. “The pared-down French classicism of their songs was what I always wanted my own music to be about.”
With critical acclaim and millions of YouTube views, she joins a wave of artists changing the face of pop in France. She follows Lous and the Yakuza and Aya Nakamura, two dark-skinned Black Francophone artists, and a dominant French rap scene – all hugely popular despite institutional attempts to minimise and discredit their success.
This year, a heated political climate in France – one where the rebranded far-right National Rally party is likely to challenge the president, Emmanuel Macron, in the upcoming election – has positioned identity politics, intersectionality and decolonising French history as a threat to the supposedly universalist values of the republic. Yseult’s Victoires acceptance speech made her into a flashpoint, prompting online abuse and media hostility. Valeurs Actuelles magazine named her “the star of the crybaby generation”, while the news weekly Marianne stated she had no right to decry racism since her victory “proved” she was the perfect example of social integration.
“France expects its minorities to be docile – ‘they should be content with being here’,” says Rokhaya Diallo, a writer, film-maker and activist and one of France’s foremost anti-racist voices (and often a target for online abuse herself). “So of course a Black woman having a critical view of French society is going to be perceived as ungrateful.” She says Yseult “belongs to a new generation of uninhibited women. She has a profound physical and political conscience, and she imposes her body in a musical genre that is overwhelmingly white.”
It took time for Yseult to find that freedom. She started her career in 2013 as a finalist on Nouvelle Star (the French X Factor), signing with Polydor and releasing a self-titled electropop album two years later. She later described it as superficial and her place in the industry as precarious. The album’s limited success prompted a rethink: Yseult broke her contract with Polydor to start her own music label, YYY. “It’s been intense, and I’ve had to learn a whole new set of producing, managing, marketing, admin and law skills,” she says. “It has been so worth it, though. I’m not in the dark any more.”
Her music changed drastically. In 2019, she released two EPs, Rouge and Noir, the former an upbeat exploration of sensuality punctured by trap beats; the latter an introspective confrontation of her self-doubt, mental health struggles, body image and the burden of other people’s gaze, in a traditional chanson française piano-voix format. Yseult compares her creative process to therapy. “It has led me to realise how deeply I love and hate myself simultaneously, and to finally embrace that duality within me.”
', false, TIMESTAMP '2019-01-09 13:44:14', 92, 'review', 'music', 15);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Helgoland by Carlo Rovelli reiew – a meditation on quantum theory', 'abs.jpeg', 'There are two kinds of geniuses, argued the celebrated mathematician Mark Kac. There is the “ordinary” kind, whom we could emulate if only we were a lot smarter than we actually are because there is no mystery as to how their minds work. After we have understood what they have done, we believe (perhaps foolishly) that we could have done it too. When it comes to the second kind of genius, the “magician”, even after we have understood what has been done, the process by which it was done remains forever a mystery.
Werner Heisenberg was definitely a magician, who conjured up some of the most remarkable insights into the nature of reality. Carlo Rovelli recounts the first act of magic performed by Heisenberg in the opening of Helgoland, his remarkably wide-ranging new meditation on quantum theory.
Rovelli has taken the title from the name of the rocky, barren, windswept island in the North Sea to where the 23-year-old German physicist fled in June 1925 to recover from a severe bout of hay fever and in need of solitude to think. It was during these few days on the island (also called Heligoland) that, on completing calculation after calculation, Heisenberg made a discovery that left him dizzy, shaken and unable to sleep.
With the light touch of a skilled storyteller, Rovelli reveals that Heisenberg had been wrestling with the inner workings of the quantum atom in which electrons travel around the nucleus only in certain orbits, at certain distances, with certain precise energies before magically “leaping” from one orbit to another. Among the unsolved questions he was grappling with on Helgoland were: why only these orbits? Why only certain orbital leaps? As he tried to overcome the failure of existing formulas to replicate the intensity of the light emitted as an electron leapt between orbits, Heisenberg made an astonishing leap of his own. He decided to focus only on those quantities that are observable – the light an atom emits when an electron jumps. It was a strange idea but one that, as Rovelli points out, made it possible to account for all the recalcitrant facts and to develop a mathematically coherent theory of the atomic world.
For all its strangeness, quantum theory explains the functioning of atoms, the evolution of stars, the formation of galaxies, the primordial universe and the whole of chemistry. It makes our computers, washing machines and mobile phones possible. Although it has never been found wanting by any experiment, quantum theory remains more than a little disturbing for challenging ideas that we have long taken for granted.
One of the most well-known counterintuitive discoveries was arguably Heisenberg’s greatest act of quantum conjuring. The uncertainty principle forbids, at any given moment, the precise determination of both the position and the momentum of a particle. It is possible to measure exactly either where a particle is or how fast it is moving, but not both simultaneously. In a quantum dance of give-and-take, the more accurately one is measured the less precisely the other can be known or predicted. Heisenberg’s uncertainty principle is not due to any technological shortcomings of the equipment, but a deep underlying truth about the nature of things.
According to some, including Heisenberg, there is no quantum reality beyond what is revealed by an experiment, by an act of observation. Take Erwin Schrödinger’s famous mythical cat trapped in a box with a vial of poison. It is argued that the cat is neither dead nor alive but in a ghostly mixture, or superposition, of states that range from being totally dead to completely alive and every conceivable combination in between until the box is opened. It is this act of observation, opening the box, which decides the fate of the cat. Some would argue that the cat was dead or alive, and to find out one just had to look in the box. Yet in the “many worlds” interpretation of quantum theory, which is popular among physicists, each and every possible outcome of a quantum experiment actually exists. Schrödinger’s cat is alive in one universe and dead in another.
', false, TIMESTAMP '2020-08-19 01:59:37', 292, 'review', 'literature', 24);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('This week’s new tracks: Beabadoobee, King Kofi and Rosé', 'abs.jpeg', 'Beabadoobee
Last Day on Earth
For someone born in the year 2000, Beabadoobee has an amazing ability to channel the 1990s. This sunny little number, about all the things we should have done before the eternal lockdown hit, lands somewhere between REM at their most earnest and the carefree bounce of Len’s Steal My Sunshine. You can tell that the 1975’s Matty Healy was very involved in the writing, but Beabadoobee really lives up to her name in the chorus, too, which is all “Shoo doo doo, doo doo be doo be doo”. You’ll want it on repeat for at least an hour.

Glaive
I Wanna Slam My Head Against the Wall
Wow, OK Glaive, that is a sentiment I think we can all get behind at this particular moment in time. At 16, the small-town teen already has the measure of the world, and he’s condensed it down into this easy-listening coffee advert soundtrack that suddenly morphs into a thumping hyper-pop panic attack.

King Kofi
White Boys
When Cleopatra and Madonna did it, taking a milk bath was for spurious skincare reasons. For King Kofi it’s a little more political: he takes the milky plunge in the video for this remarkably restrained song about racism in dating. Gentle and warm, the song is indeed like taking a long soak – but the topic is as sour and unpleasant as the curdled milk into which he sinks.
', true, TIMESTAMP '2020-02-14 14:21:39', 285, 'article', 'music', 31);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Tune-Yards: Sketchy – agit-pop punk sweetened with deep grooves', 'abs.jpeg', 'Tune-Yards may deal in cacophonous maximalism – ever-changing rhythms, antic, mutating vocals, drifting snippets of highly infectious melody – but you could never accuse them of mindless exuberance. The California duo’s last record, I Can Feel You Creep Into My Private Life, was a self-eviscerating meditation on white privilege, while 2011’s Whokill discussed both structural inequality and disordered eating. On their fifth album, gender dysphoria, abortion rights and the Larkin-esque horrors of procreation bubble up through the sonic deluge. Yet Sketchy doesn’t feel like a protest album – as the title suggests, it doesn’t have the clarity for that. That can be frustrating: Homewrecker hints at a theme of insidious gentrification, but it’s mostly indecipherable. Elsewhere, however, it allows for exhilarating ambivalence: Sometime muddles through a relatably complex response to climate disaster over a blissful lover’s rock foundation.
Her longtime appropriation of black-originated musical styles is something frontwoman Merrill Garbus has interrogated over the years, but it is clearly a mode she’s sticking with; Sketchy also channels 80s R&B, Afrobeat, Minnie Riperton’s ethereal vocal gymnastics and, most often, 60s soul. Tune-Yards don’t use these sounds for easy appeal; their sweetness, fun and comfort is invariably complicated by dissonance and instability. At the same time, they do make all the dread, guilt and hand-wringing that bit more palatable. It’s a discomfiting, ambitious dynamic from a band attempting to balance social conscience with feelgood entertainment. Sketchy is not that perfect marriage of progressive political messaging and musical pleasure – an elusive holy grail, that, or a contradiction in terms? – but it is a daring, fascinating and frequently very enjoyable attempt to square the circle.
', false, TIMESTAMP '2020-11-15 01:48:09', 120, 'news', 'music', 27);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Kerry Godliman: ’Ben Elton is often overlooked as a standup’', 'abs.jpeg', 'There was a lot more live telly on when I was growing up in the 80s. It all seemed to come to an end once the likes of Shaun Ryder, Jarvis Cocker and Julian Clary had said too many swearwords on the shows.
The programme that really encapsulated the live spirit for me when I was a kid was Friday Night Live. It was this anarchic live show of sketches and comedy hosted by Ben Elton. I watched it every week – if my mum and dad had friends round for drinks or dinner, I’d have the telly on in my room – it was a portable one you could pick up and carry upstairs.
There were so many amazing people who used to be on the show. I remember Fry and Laurie, and Harry Enfield making me laugh. I always forget how influential Elton was for me. I feel like he’s often overlooked as a standup comic by people who just know him more for his TV writing, but I always associated him with that show. He used to wear a shiny suit, and he had this old-world-meets-new-world aesthetic, channelling an American TV host while trying to manage the unpredictable acts and studio audience. It felt to me that anything could happen. I was present when I was watching.
', false, TIMESTAMP '2020-11-09 10:47:08', 16, 'review', 'tv show', 13);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Charles Lloyd & the Marvels: Tone Poem – heady ideas from a celebrated jazz elder', 'abs.jpeg', 'In the 1960s, Charles Lloyd was a reeds-playing jazz-fusion star with a 21-year-old Keith Jarrett for a sideman and a young audience with psychedelic leanings. After a long midlife break from playing, he returned transformed in the 1980s with a poignantly personal sound on saxophone and flute; in the decades since, he has become one of jazz’s most cherished elders. Lloyd is 83 now and, like many original improvisers who have seen a lot of water under the bridge, he conserves his energies more these days. But his art has long inclined more to distillation than expansion – glimpsing the southern blues of his Memphis childhood, John Coltrane’s heart-rending tenor tone or Ornette Coleman’s bluesy skittishness, sometimes even the timbres of eloquent non-jazz singers such as his Greek friend and sometime playing partner Maria Farantouri.
Tone Poem is the third release by Lloyd’s country-steeped band the Marvels, featuring guitarist Bill Frisell – a fan since hearing Lloyd in the 60s as a teenager in Denver – with pedal-steel player Greg Leisz, bassist Reuben Rogers and drummer Eric Harland. There are no singers, but the music constantly evokes the sounds of songs. Lloyd’s tenor is softly preoccupied on Ornette Coleman’s Peace, and he slews breezily across the free-harmony of the same composer’s Ramblin. Over Frisell’s boogieing groove, his quavering upper tone and squabbling whispers muse over languid country-ballad guitar harmonies on Leonard Cohen’s Anthem. Bola de Nieve’s Ay Amor! is a highlight, as is a grippingly dirgelike Monk’s Mood – but the standout is Lloyd’s homage to his old California cronies the Beach Boys, on an ethereally slow-burning bonus-track arrangement of In My Room.
Also out this month
Alone Together (Decca/Universal) is a classic-covers set from the rising young UK piano generation including Reuben James, Joe Armon-Jones and Sarah Tandy – spanning the 1920s hit Crazy Rhythm, through James’s fine reimagining of Duke Ellington’s In My Solitude, Armon-Jones’s punchy account of Golden Brown and Tandy’s thoughtful investigation of Billie Eilish’s idontwannabeyouanymore. Gretchen Parlato, a unique vocalist whose soulfulness is a matter of delicate insinuation and airy Latin grooves, is at her understated best on Flor (Edition), after a six-year recording break. And Slovenian pianist Kaja Draksler’s exhilarating Punkt.Vrt.Plastik trio with bassist Petter Eldh and drummer Christian Lillinger mingles racing, strutting arrhythmic conundrums and bass-walking jazzy grooves on Somit (Intakt). Sharp-end jazz, but succinct, witty, and steered with awesome precision by all three.
', true, TIMESTAMP '2020-07-18 09:57:41', 78, 'news', 'music', 100);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Oscars 2021 ceremony will be in-person and Zoom-free, producers say', 'abs.jpeg', 'The Oscars ceremony in April will be an intimate, in-person gathering, held without Zoom and limited to nominees, presenters and their guests, the producers said on Thursday.
Due to the coronavirus pandemic, events to hand out the highest honours in the film industry will held at both the Union Station in downtown Los Angeles and the traditional home of the Academy Awards at the Dolby Theatre in Hollywood.
All attendees will be tested and there will be a Covid-19 safety team on site throughout the evening on 25 April.
“There will not be an option to Zoom in for the show,” producers Steven Soderbergh, Jesse Collins and Stacey Sher said in note to the more than 200 nominees this year.
“We are going to great lengths to provide a safe and ENJOYABLE evening for all of you in person, as well as for all the millions of film fans around the world, and we feel the virtual thing will diminish those efforts.”
The producers said nominees and their guests would gather at a courtyard in the Union rail station, while other show elements would be held live inside the Dolby Theatre about 13km (8 miles) away.
Normally, hundreds of the world’s top movie stars would gather in the 3,400-seat theatre for a live show preceded by a red carpet packed with photographers and camera crews.
Other awards shows in recent months have replaced the usual gatherings at gala dinners and on stage with pre-recorded appearances or virtual events or a combination.
Television audiences have slumped, with the Golden Globes and the Grammys attracting the smallest numbers in decades.
Nominations for the Oscars were announced on Monday, with 1930s Hollywood drama Mank leading the field with 10, followed by The Father, Black Panther story Judas and the Black Messiah, Korean-language drama Minari, Nomadland, MeToo revenge tale Promising Young Woman, Amazon Studio drama Sound of Metal, and 1960s Vietnam war courtroom drama The Trial of the Chicago 7.
', true, TIMESTAMP '2019-02-04 11:46:00', 147, 'news', 'cinema', 49);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Dream review – the RSC’s hi-tech Shakespeare only goes so far', 'abs.jpeg', 'At 7pm on Tuesday more than 7,000 people were watching. At a later performance – 2am on Wednesday – questions were coming into the post-show Q&A from as far away as Melbourne. The Royal Shakespeare Company reckons that 25% of the audiences for its online Dream are first-time attenders. Drawing on live capture and gaming technology, and inviting interaction from the audience, this visual sprint, produced with Manchester international festival, Marshmallow Laser Feast and the Philharmonia Orchestra, is a tumult of musical movement and images inspired by A Midsummer Night’s Dream. A sample of a research and development project, it is not a replacement for a full-blown play, but it suggests a new arrow for the quiver of live theatre.
The plot is scant and not always clear; the verse is reduced to scattered lines. EM Williams’s Puck guides us through a computer-generated forest, a landscape blasted by climate change, with botanically exact trees tossed by the wildest of winds. Williams appears first on stage in the flesh, then on screen, translated by her motion capture suit into an avatar: disconcertingly this most fluid of characters is a figure made of pebbles. Audiences are encouraged to click on firefly icons to light up the paths, though my attempts were more glow-worm than floodlight, with no discernible effect on the action. Nick Cave has a few sonorous lines as the (speaking not singing) voice of the wood. Fairies, whose movements generate live sound, are conjured from leaves and twigs. Titania’s attendant Cobweb is a staring eyeball, with lashes stretching out like an uprooted plant. Impressively achieved but without an emotional dimension, the impact is alarming rather than intricately disturbing. Metaphor gets into places that an avatar can’t reach.
This coming week sees another ingenious forest-driven piece of theatre, The Litten Trees. The vital production company Fuel has commissioned lighting designers up and down the country to illuminate trees near their homes, gently transforming daily landscapes.
', true, TIMESTAMP '2020-02-09 10:44:33', 76, 'news', 'theatre', 24);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Kindling Hour review – Arthurian legend meets Hitchcockian thrills', 'abs.jpeg', 'What would a time traveller make of it? Someone arriving from 2019 would be perplexed to find this year’s most sociable night out involves six people logging on to their computers from their living rooms to play an intense game of puzzle-solving jeopardy.
And someone arriving from 2001 wouldn’t recognise the words to describe the experience: Zoom, YouTube, QR codes, Instagram, Wikipedia, Google Maps … none of these would be in their vocabulary.
In that sense, The Kindling Hour is of the moment. It’s an escape room-style game that uses online tools to compensate for the demands of social distancing. Throw in a suggestion of whistle-blowing, corporate malpractice and anti-corruption investigations, and you could hardly be more 2021.
Created by Ollie Jones and Clem Garrity of Swamp Motel, this is the third in a trilogy that began with Plymouth Point, in which your team goes on the trail of a missing woman, and continued with The Mermaid’s Tongue, in which you must stop an ancient artefact from falling into the wrong hands.
', true, TIMESTAMP '2020-03-23 00:15:18', 111, 'news', 'theatre', 25);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Oscar contenders: how to watch them in the UK – and why it’s so difficult', 'abs.jpeg', 'This year’s Oscars are billed as the great democratic race. Eligibility for all awards has been relaxed, so films don’t have to have had a conventional theatrical release. This has led to a larger number of titles in contention – 41 on Monday’s shortlist – as well a greater diversity of voices.
But such egality of access has not yet stretched to UK viewers. While audiences in the US are uniquely able to see all the hottest films from the comfort of their own homes (streaming costs permitting), UK audiences are left in the familiar position of playing catchup, hearing exciting things about films still months away from release.
This is because the streaming infrastructure in the UK is less well-established than in the US, so outside major players such as Netflix, Amazon, Disney+ and Apple, distributors do not have the deals in place for straightforward online premieres.
And while US cinemas have only begun reopening in the past fortnight, UK distributors have had periods in which they could screen films in cinemas, and so have sought to delay releases to fit in with these windows.
These goalposts, however, have shifted continually, with a domino effect on films. A smattering of awards movies are now due out in the UK in early April, a hangover from the hope that cinemas would be allowed to reopen in late March. The earliest they can now do so is 17 May; hence a sudden flurry of activity over the past few weeks on digital platforms for titles such as Judas and the Black Messiah, with distributors eager to capitalise on awards buzz and conscious such films might struggle to secure a sizeable cinema audience many weeks down the line.
', false, TIMESTAMP '2020-12-31 23:51:26', 282, 'news', 'cinema', 75);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('David Fincher and Trent Reznor on Mank: ’People were like: Huh. This is very niche’', 'abs.jpeg', 'One of the US’s greatest living directors is keeping his camera switched off for our Zoom call, but he sounds so cheerful – “Hey! It’s Fincher!” – that he might as well be communicating in smiley-face emojis. Perhaps it is the effect of the 10 Oscar nominations announced a few days earlier for Mank, his acclaimed, affectionate film about the writing of Citizen Kane. Meanwhile, Trent Reznor – who, with his musical partner in Nine Inch Nails, Atticus Ross, has composed the scores for all the director’s movies since 2010 – joins the call a moment later, and proves less camera-shy. He pops up in a brown tracksuit, seated beside a keyboard in a bright, cluttered room. Fincher gives him a chipper greeting: “Trent-O!”
They are here to discuss a partnership that has spanned four pictures: the Facebook origin story The Social Network, the thrillers The Girl With the Dragon Tattoo and Gone Girl, and now Mank. It has also brought awards nominations for each of them, as well as an Oscar in 2011 for the baleful, festering music composed by Reznor and Ross for The Social Network, their first film score. I congratulate both men on their most recent nominations. Reznor has received two this year for his scores with Ross: one for Mank, the other for the Pixar fantasy Soul. “It’s brought the ratio down a bit,” he says softly. “It was always nice being able to say: ‘One film, one win.’”
Those 10 nods, which include Fincher’s third for best director, mean that Mank has more nominations than any other film in contention, though perhaps it doesn’t do to get carried away: The Irishman, another prestigious Netflix title, got the same number last year but left empty handed. It feels perverse, though, that a movie about an Oscar-winning writer (Herman J Mankiewicz, played by Gary Oldman) has been overlooked in the best original screenplay category.
“Listen, you can’t expect other people to see the exact same value in things that you do,” Fincher says. “That’s just childish. Ten’s nice. I got no complaints about 10. He won’t be upset.”
', false, TIMESTAMP '2019-11-21 00:17:56', 218, 'article', 'music', 95);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Adventurous review – Zoom dating drama is warmly witty', 'abs.jpeg', 'A pandemic drama that centres on two people in a Zoom conversation is a risky venture at this late stage of lockdown. Not only have many of us had our fill of virtual exchanges but seen them prosaically reflected back to us on screen, complete with well-worn “you’re on mute” jokes and technical glitches.
So it is surprising that Ian Hallard’s debut play about a mid-life couple who meet on an online dating site during the pandemic manages to be so engaging and fresh.
Richard (played by Hallard) is a mild-mannered history teacher and recent divorcee, while Ros (Sara Crowe), who has spent most of her life caring for her late disabled sister, is quirkier than she first appears.
Directed by Khadifa Wong for Jermyn Street theatre in London, they take their first tentative steps towards virtual romance. The action is mainly structured around their Zoom meetings, which begin early on in the first lockdown and continue largely online, though there is one physical meeting – a pub date in the summer between lockdowns in which Richard is too apprehensive about the virus even for a peck on the cheek.
The dialogue is particularly adept at catching a quintessentially British brand of social awkwardness as the couple meet for the first time, from their stiff smiles to their nervous babbling and small talk. The conversational crossed wires are especially funny and Hallard has an ear for accidental humour that makes for moments of supreme silliness.
', false, TIMESTAMP '2020-10-01 13:05:28', 80, 'article', 'theatre', 98);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('For Those I Love: For Those I Love review – an exorcism of grief on the dancefloor', 'abs.jpeg', 'All first albums come with some kind of backstory, but the backstory of the eponymous debut by For Those I Love – the pseudonym of Dublin-based songwriter/producer/vocalist David Balfe – is more harrowing than most. Recording was under way when Paul Curran, his best friend and fellow member of Burnt Out – an artistically ambitious punk collective who attracted attention in Ireland for their visceral depiction of youth in the working-class Dublin suburb of Coolock – killed himself. The opening track, I Have a Love, breaks the fourth wall to striking effect, three-and-a-half minutes in: “A year or so ago, I played this song for you on the car stereo in the night’s breeze / This bit kicked in with its synths and its keys / And you smiled as you sat next to me.”
Mired in grief, anger and bewilderment, For Those I Love is the second album in 18 months to deal with Curran’s passing: fellow Dubliners the Murder Capital said that “every single one” of the songs on their 2019 debut When I Have Fears “related back to his death in some way”, while the album shared its title with his favourite Keats poem. But while the Murder Capital set their lyrics to icy post-punk and raging guitar noise, Balfe’s key inspiration is the bedroom dance music and spoken-word vocals of the Streets. There’s an echo in his delivery of the spiky, heavily-accented sprechgesang approach favoured by the vital current wave of Dublin punk bands, the Murder Capital and Fontaines DC among them, but Balfe shares Mike Skinner’s fixation on apparently mundane details and his fascination with drunken, blokey high jinks, although it’s worth noting that For Those I Love offers a far starker, even nihilistic take on the old Geezers Need Excitement theme.
Balfe sets Curran’s death against a backdrop of late-teenage incidents and scrapes. He never allows the listener to forget that drink and drugs are a temporary escape, and never fails to underline exactly what they’re an escape from. Birthday is a grim depiction of Balfe encountering the body of a murder victim on his estate when still a child; The Pain or Top Scheme vaguely recalls Plan B’s Ill Manors in the sheer, scourging force of its class-conscious anger: “Our troubles and complaints are justified / it’s just numbers and stats until it’s your life.” In fact, he ends up taking issue with Skinner’s breezy approach. “Getting out seems no stage … I’ve felt this way since Turn the Page,” he snaps, a reference to a track from Original Pirate Material that urged the listener to forget the past and “walk away”. “There’s no walk away,” he adds, pointing out that it’s impossible to move on if you’re deprived of the opportunity to escape your surroundings.
', true, TIMESTAMP '2020-08-04 05:33:50', 180, 'article', 'music', 9);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Sex, Lies and Question Time by Kate Ellis – an insider account of ’sleaze and innuendo’ in Canberra', 'abs.jpeg', '“I had only been a politician for a few weeks when I was approached in a Canberra bar and told, ‘The only thing anyone really wants to know about you, Kate, is how many blokes you had to fuck to get into this parliament.’”
So goes the arresting opening line of a chapter in former Labor MP Kate Ellis’s book, arriving in bookstores this weekend with the sort of timing publicists dream of – a compendium of the shameful treatment of women in parliament released at a time when we can speak of nothing but.
The question was posed to the then 27-year-old Ellis just after she arrived in Canberra in 2004 by a man who was the at the time a Liberal staffer, but who then went on to become a senior MP. He interrupted her mid-conversation at the pub. She writes: “I had won a marginal seat in an election when my party was largely annihilated. But, sure, if that’s how he thinks elections work. I had never spoken to him before and subsequently tried to limit our interactions over the next decade.”
It was, Ellis writes, “the kind of run-of-the-mill sleaze and innuendo which is so common it is almost unremarkable in the culture of federal politics”.
With the wild tide of revelations that have been relentlessly coming at us like a set of breakers in the last few weeks, all this is unremarkable no more. And the fact that this exchange had come to be seen as “run-of-the-mill” is cause for a reckoning within the pages of Sex, Lies and Question Time, Ellis’s “insider account” of her 15 years in parliament.
“I often wonder, if we had been more forthright in calling the culture out earlier, would the appalling misogynistic attacks on Julia Gillard still have occurred?” Ellis asks. “Could we have stopped things before they exploded so dramatically? Of course we will never know – but we should do all we can to stop this behaviour now.”
', true, TIMESTAMP '2020-12-09 15:13:41', 235, 'review', 'literature', 20);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Under a White Sky by Elizabeth Kolbert review – the path to catastrophe', 'abs.jpeg', 'Being alive these days means enduring a strange and perhaps historically unique sense of claustrophobia. If you’re paying attention – and if you’ve read Elizabeth Kolbert’s previous books on climate and the ongoing mass extinction – you know that the Earth, its atmosphere, and its oceans are transforming in ways that will mean unimaginable hardships for humans and for billions of other living beings. You also know that almost everything you might do will belch out carbon emissions that will blow us farther down the path to catastrophe. It’s like being stuck in a tunnel and, no matter which direction you attempt to dig, only going deeper.
Kolbert’s most recent book evokes another disquieting sensation, a novel breed of vertigo. In Under a White Sky, she tracks the spiralling absurdity of human attempts to control nature with technology. Grand, Promethean interventions of the sort of which modernity’s boosters were once so proud – a river’s flow reversed to carry waste to a more convenient location, an aquifer tapped to grow alfalfa in the desert, coal and oil extracted from great depths and burned to move machines – spawn unforeseen disasters. Ever grander interventions ensue, which bring fresh calamities, which require still cleverer interventions. By the end of the book, as the zany twists into the full-on apocalyptic, you are left reeling, with little hope to spare.
Kolbert’s reporting is, as always, skilful and subtle. She plays a wry and melancholy Virgil touring varied sterile hells, savouring ironies even when they hurt. She jets across continents, visiting laboratories and warehouse-sized scale models of damaged ecosystems through which scientists traipse like giants. In Chicago, more than a century after the dredging of a canal – “the biggest public works project of its time” – accidentally “upended the hydrology of roughly two-thirds of the United States”, engineers struggle to contain the spread of voracious species of carp introduced to gobble propeller-tangling weeds. Their solution: to electrify the water.
In Louisiana, Kolbert visits Plaquemines Parish, one of “the fastest disappearing places on earth”, a distinction won thanks to flood-control efforts that channel Mississippi river sediment straight into the Gulf of Mexico, preventing coastal lands from renewing themselves. Government engineers now pump mud through miles of pipeline to craft artificial marshlands that will be almost immediately washed away. In Australia, she interviews biologists engaged in a desperate effort at “assisted evolution”, attempting to genetically engineer corals that will survive warmer, more acidic seas as the Greater Barrier Reef dies around them.
', true, TIMESTAMP '2021-03-12 22:49:28', 210, 'review', 'literature', 9);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Black Widow headed to Disney+ as studio shakes up schedule', 'abs.jpeg', 'Disney has announced that Black Widow and Cruella will both be debuting on its streaming service Disney+ at the same time as in cinemas.
The Marvel adventure and 101 Dalmatians prequel had both been intended for traditional theatrical releases but with the box office still underperforming, the studio has made the decision for a hybrid release. “Today’s announcement reflects our focus on providing consumer choice and serving the evolving preferences of audiences,” said Kareem Daniel, chairman of Disney’s media and entertainment distribution.
Both films will be part of the platform’s premier access service, which requires users to pay an additional $30 rental fee, the same model used for Mulan and, most recently, Raya and the Last Dragon, which some US exhibitors have refused to show because of the simultaneous release. Box office intake has slowly started to increase in the US, with cinemas reopening in New York City and Los Angeles, the two biggest markets in the country, but many national locations still remain closed and capacity limits mean that attendance remains low.
The studio has also announced that Pixar’s summer film Luca will eschew any form of theatrical release in territories with Disney+, headed straight to the platform for no additional cost. The same strategy was used in December for Soul. Other films moved back by the company include Marvel’s Shang-Chi and the Legend of the Ten Rings, now opening in September, and the Agatha Christie adaptation Death on the Nile, now being released in February 2022.
Cruella, starring Emma Stone as the titular villain, will be released on 28 May while Black Widow is scheduled to premiere on 9 July. The Scarlett Johansson adventure was initially scheduled for 1 May 2020 but has seen a number of shifts because of Covid-19.
The news comes after Disney claimed its latest Marvel series, The Falcon and the Winter Soldier, was its most watched Disney+ series premiere yet, beating The Mandalorian and WandaVision. The studio recently reported that the platform has over 100 million users in just 16 months of operation.
', false, TIMESTAMP '2019-08-11 13:39:13', 296, 'review', 'cinema', 92);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Oscars ’no Zoom’ policy proving a headache for overseas nominees', 'abs.jpeg', 'The “no Zoom” policy for this year’s Oscars ceremony is proving a headache for multiple nominees who live outside the United States and who are still under pandemic restrictions, according to Hollywood publications.
Variety and Deadline Hollywood reported on Wednesday that publicists and some studio executives have complained to the film academy about logistics, costs and quarantine issues raised by the decision to bar nominees from taking part in the ceremony remotely.
The Academy of Motion Picture Arts and Sciences, which organizes the ceremony, did not return a request for comment on the reports.
Due to the coronavirus pandemic, the 25 April show to hand out the highest honors in the movie industry will be held both at Union Station in Downtown Los Angeles and the traditional home of the Academy Awards at the Dolby Theatre in Hollywood.
Producers said last week that there will “not be an option to Zoom in for the show” and encouraged nominees to attend in person.
At least nine nominees, including the director of Promising Young Woman, Emerald Fennell, and star Carey Mulligan, live in Britain. England next week is expected to ban non-essential international travel until mid-May.
Representatives of the five international feature films – submitted by Denmark, Hong Kong, Romania, Tunisia and Bosnia – could also face hurdles getting to Los Angeles, Variety and Deadline noted.
Some of the other 200 or so nominees will be working on productions that require quarantine or living in restricted “bubbles” with cast and crew, the publications said.
Visitors to California are currently expected to quarantine for 10 days. Travelers to nations outside the United States are also subject to varying quarantine requirements.
Variety said a meeting this week to discuss the issues between the Academy, movie studio executives and publicists had been canceled.
Other awards shows in recent months have replaced the usual in-person gatherings at gala dinners and on stage with pre-recorded appearances or virtual events, or a combination of those with small in-person gatherings.
But television audiences have slumped, with the Golden Globes and the Grammys attracting the smallest numbers in decades.
', true, TIMESTAMP '2019-10-30 13:06:47', 285, 'news', 'cinema', 19);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Johnny Depp loses bid to overturn ruling in libel case', 'abs.jpeg', 'The Hollywood actor Johnny Depp has lost an attempt to overturn a damning high court ruling that concluded he assaulted his ex-wife Amber Heard and left her in fear for her life.
Following a three-week trial in July last year, Mr Justice Nicol dismissed the star’s libel claim against the publisher of the Sun, finding that a column published in April 2018 calling Depp a “wife beater” was “substantially true”.
The judge that ruled Depp, 57, assaulted Heard, 34, on a dozen occasions and put her in “fear for her life” three times.
The actor asked the court of appeal to grant permission for him to challenge the ruling, with the aim of having its findings overturned and a retrial ordered. However, following a hearing last week, on Thursday the court refused Depp permission to appeal.
Lord Justice Underhill and Lord Justice Dingemans emphasised that an appeal against the trial judge’s decision on questions of disputed fact faced serious difficulties.
Part of Depp’s argument relied on further evidence that Heard had not yet given away most of the $7m (£5.1m) she received in her divorce settlement, which she had said she was donating to charity.
At last week’s hearing, Depp’s barrister, Andrew Caldecott QC, said the claim was a “calculated and manipulative lie”which gave Heard “a considerable boost to her credibility as a person”, and “tipped the scales against Mr Depp from the very beginning”.
But Lord Justice Underhill said: “We do not accept that there is any ground for believing that the judge may have been influenced by any such general perception as Mr Caldecott relies on.
“In the first place, he does not refer to her charitable donation at all in the context of his central findings.
“On the contrary, he only mentions it in a very particular context … and after he had already reached his conclusions in relation to the 14 incidents.”
Underhill concluded his ruling by saying: “We refuse Mr Depp’s application to admit further evidence in support of his proposed appeal and we conclude that the appeal has no real prospect of success and that there is no other compelling reason for it to be heard. We accordingly refuse permission to appeal.”
Depp’s UK lawyer, Joelle Rich of Schillings Partners, said the evidence presented at last week’s hearing “further demonstrates that there are clear and objective reasons to seriously question the decision reached in the UK court”.
She said Depp looked forward to “presenting the complete, irrefutable evidence of the truth in the US libel case against Heard where she will have to provide full disclosure”.
A spokesperson for Heard said: “We are pleased – but by no means surprised – by the court’s denial of Mr Depp’s application for an appeal. The evidence presented in the UK case was overwhelming and undeniable.
“To reiterate, the original verdict was that Mr Depp committed domestic violence against Amber on no fewer than 12 occasions and she was left in fear of her life.
“The verdict and lengthy, well-reasoned judgment, including the confidential judgment, have been affirmed. Mr Depp’s claim of new and important evidence was nothing more than a press strategy, and has been soundly rejected by the court.”
A spokesperson for the Sun said: “The Sun had every confidence that this leave to appeal application would not be granted and are pleased with today’s decision.
“The case had a full, fair and proper hearing, and today’s decision vindicates the courageous evidence that Amber Heard gave to the court about domestic abuse, despite repeated attempts to undermine and silence her by the perpetrator. The Sun will continue to stand up and campaign for victims of domestic abuse.”
', true, TIMESTAMP '2019-05-15 19:38:32', 252, 'article', 'cinema', 2);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Curzon cinema looks into vaccine-only and no-jab-only screenings', 'abs.jpeg', 'The Curzon cinema chain is considering offering movie-goers the option of attending screenings reserved exclusively for customers who have proof of a Covid-19 vaccine – alongside screenings where no jab is required.
The announcement came as debate intensified over whether venues such as pubs and nightclubs will require customers to be inoculated. Philip Knatchbull, chief executive of the 21-strong Curzon chain, said giving customers a choice would avoid having to impose a blanket rule, which could trigger legal issues around discrimination.
“Personally, I am not a supporter,” said Knatchbull. “It is extremely difficult to monitor and more importantly it would prejudice against the minority of people who don’t get a vaccine.
“We may get around that by having some screenings where people may need proof of vaccination and some that don’t. We are trying to think how to make our customers comfortable and how our brand should be best reflected by offering flexibility.”
', true, TIMESTAMP '2019-08-06 22:59:08', 45, 'article', 'cinema', 17);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Weeknd’s NFT song', 'abs.jpeg', 'The Weeknd is releasing a new song ‘in NFT space’.
The 31-year-old star - whose real name is Abel Makkonen Tesfaye - took to Twitter to explain that his latest release will be a little different.
He wrote: ‘new song living in NFT space. coming soon...’
He added: ‘p.s. this chapter isn’t quite done yet ...still tying some loose ends (sic).’
NFTs (non-fungible token) are an emerging market within blockchain where single-impression unique digital art and goods, known as the ’token’ can be sold.
Stars including Kings Of Leon, Gorillaz, Banksy and Elon Musk have all recently sold NFTs.
It is unclear if The Weeknd’s new song will be sold as an NFT or if it will be called ’Living in NFT space’.
Meanwhile, The Weeknd recently revealed that he won’t have anything to do with The Grammys in the future, after previously calling the awards ‘corrupt’.
He said: ‘Because of the secret committees I will no longer allow my label to submit my music to the Grammys.’
And he previously said: ‘The Grammys remain corrupt. You owe me, my fans and the industry transparency...’
', false, TIMESTAMP '2020-04-03 11:11:46', 107, 'article', 'music', 9);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Saturday Night Live: Maya Rudolph encounters ghosts – and guest stars', 'abs.jpeg', 'We open with an MTV Spring Break dating show for “hot, infectious singles”, called Snatched, Vaxxed, or Waxed.
Hosted by Cece Vuvuzela (Maya Rudolph), the show, coming live from Miami Beach, Florida, during a global pandemic (“We are so close to the end – let’s ruin it!”) the show sees dumb college bros (and one off-duty cop) compete for equally dumb college women by guessing which of the three title categories they fall under.
It’s all so rapidfire that it’s hard to be clear what’s going on. A few funny lines stick out – “Florida, Adderall, meth!” “Versace murder steps” – but none really land. It’s also a baffling choice for a cold open. One gets the feeling this was a last-minute switch-out.
Former cast member (and current semi-regular) Rudolph hosts. Her optimism about the end of the pandemic and her own children being in the audience puts her in a contemplative mood.
She brings out “the new kids in the cast” – Andrew Dismukes, Punkie Johnson and Lauren Holt (or Chirpy, Little Deedee and Calista Vagina, as she refers to them) – to impart some wisdom.
But thanks to all the brain damage she’s suffered over the years by way of being electrocuted in the bathtub one too many times, she confuses memories of the show with the plot of The Breakfast Club.
This leads to Rudolph and the young comedians singing along to the chorus of Don’t You (Forget About Me). As with the cold open, there are a few funny bits scattered throughout, but it feels a bit pointless.
Up next is a new episode of the popular YouTube talkshow Hot Ones, where “celebrities answer hot questions while eating even hotter wings”. The guest is Beyoncé, who “still can’t tell if this is beneath me”. Regardless, she quickly realizes she’s in over her head, as the various hot sauces – including selections Hitler’s Anus and the Devil’s Diarrhea – has her sweating buckets and trying to keep from “blowing out [her] pants on [the] janky-ass show”.
At one point, she demands her hair stylist “take my wig off, put six ice cubes on my head, and put my wig back on”, only for her controlling publicist to override the order.
Eventually, she calls it quits before her body team swoops in like the CIA and shuts everything down.
Kudos to the show for finding an unexpected setup to place Rudolph’s Beyoncé in. This should be the template for more of their celebrity impression sketches.
Then, A Kamala Harris Unity Seder has Rudolph’s vice-president giving a Passover message to her “adopted people”. She brings out second gentleman and “Semitic smokeshow”, Doug Emhoff (Martin Short), who vacillates between coy shyness and uncontrollable physical passion for his wife.
', true, TIMESTAMP '2019-06-18 11:22:37', 71, 'news', 'tv show', 25);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Radio roadshow: the Beeb’s big move away from London', 'abs.jpeg', 'Just over a week ago, the BBC made an announcement, to its staff and to the press. It was a big’un. Over the next few years, trumpeted the Beeb, it will move various parts of its huge operation to different locations across the UK, so that by 2027, more than 50% of BBC spending will be outside London.
That is, of course, completely right. Even the most kombucha-sozzled media elitist will agree that our national broadcaster should represent everyone who pays its licence fee. The BBC, which employs thousands of people, needs to spread not only its spending across the country, but also its focus and culture. The move out of London is the right one.
For the big radio stations, it won’t happen super-quickly.Alan Davey, head of Radio 3, told me that he expected his station’s move to start in 2023. Radio 3’s aim is to have more than 50% of its programmes made at BBC Salford by 2026 (several are already produced there, including Sound of Cinema and The Early Music Show). The Radio 3 team will spend 2022 working out how best to do this – “seeing the creative possibilities,” said Davey. “This isn’t a token gesture, it’s a meaningful thing.” Davey, who’s from the north-east, insists that though Radio 3 will retain a London base, it should “reflect the rich musical life outside of London, create new roots”.. He mentions Exposure, Radio 3’s experimental showcase broadcast from alternative music venues around the country – he wants to “rediscover a similar spirit”.
Other stations will be doing something similar: 6 Music will strengthen its already established relationship with Salford; Asian Network is moving lock-stock to Birmingham. The problem comes, as it always does, with big-name presenters, who are often loath to relocate from where they live. The general feeling within management is that talent will move house or jump ship, and that this will happen naturally before 2027; plus younger, non-London presenters can be nurtured. Breakfast-show hosts have been spared the push for the moment (“our breakfast shows aren’t part of the change we are announcing today”), but not other programme hosts. If I were Steve Wright or Scott Mills, and I didn’t fancy upping sticks to an as-yet unspecified new location, I might be considering a hop to another station.
', false, TIMESTAMP '2021-01-22 17:38:37', 81, 'article', 'tv show', 75);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('My Rock’n’Roll Friend by Tracey Thorn review – a story of sexism in pop', 'abs.jpeg', 'In March 1983, the singer and author Tracey Thorn was sitting in a dressing room at London’s Lyceum theatre when a woman strode in and asked to borrow a lipstick. Lindy Morrison, drummer in Brisbane art-rockers the Go-Betweens, made an instant impression on Thorn, who was in her second year at university and whose band, Marine Girls, were on the same bill. On the surface, the pair didn’t have much in common. By Thorn’s own admission – and despite her fledgling pop star status – she was shy, quiet and sensible; Morrison, who was 10 years her senior, was loud, full of confidence and sometimes reckless bravado. “It doesn’t occur to me,” Thorn explains, “that this woman who seems to be my opposite might in fact be my reflection, that she might have started out very like me – awkward, insecure, isolated – and has had to fight every step of the way to get to where she is now.”
My Rock’n’Roll Friend is both a biography of Morrison and a memoir of their friendship during which they bonded over books, films and being women in a world of men. In her next band, Everything But the Girl, Thorn would write the song “Blue Moon Rose” (“I have a friend and she taught me daring / Threw back the windows and let the air in”) about Morrison. “I am both inside and outside this story,” she observes.
When, in 1979, Morrison met the Go-Betweens’s singer Robert Forster, she was a part-time actor, a social worker, and a drummer in and out of assorted jazz and punk bands. Her worldliness stood in contrast to this bookish former boarding-school boy who was seven years her junior when they began a relationship. With her presence, the band – which also included the guitarist Grant McLennan – became a trio and set about recording their first album. It’s with some amusement that Thorn notes how the two men imagined having a woman in the band would soften their image, even though Morrison was “about as soft as a right hook”. A friend called the line-up “two wimps and a witch”.
As the Go-Betweens’s career progressed, they were praised by critics and fellow musicians, who swooned over their wonky time signatures and tales of cattle stations and libraries, but this didn’t translate into sales. But if building a career felt like an uphill struggle for Forster and McLennan, for Morrison it was tougher still. To be a female drummer in the early 1980s was seen as transgressive, and, what with the muscles, the sweat and the manspreading pose, deeply unfeminine. Thorn recalls how Morrison struck fear into male interviewers whose sexist assumptions she frequently challenged.
If this makes My Rock’n’Roll Friend sound deeply serious, it isn’t. The author brings wit, candour and vividness to her storytelling, which delights in the more ludicrous aspects of musicians’ lives. She recalls a winter in London during which the Go-Betweens shared a flat with fellow Australians, including some members of the Birthday Party. On Christmas Day, Morrison decided to make Christmas dinner and, when it was ready, called everyone into the living room where she had set up a table. As they sat down, Morrison realised they’d all just shot heroin. “Eyes roll and heads loll,” Thorn writes. “One of them falls forwards, face squashed flat against the tablecloth. The others follow, one by one, slumping in their chairs or resting heads on elbows. Soon she’s the only one left sitting upright, staring ahead at the blasted triumph of the meal … She pours a glass of red wine, knocks it back, and then another. Happy Christmas, you fuckers.”
Thorn and Morrison’s letters to one another prove rich material in recording their respective triumphs and disappointments. Although they have gigged together, holidayed together and got drunk together, much of their lives have unfurled at a distance, sometimes on opposite sides of the world. But Thorn’s interest in Morrison’s story goes beyond documenting a friendship. As a singer-songwriter of over 40 years standing, she herself has experienced pigeonholing and sidelining from an industry that reflexively places male talent on a pedestal. And so, as well as providing a portrait of a mercurial and brilliant musician, the book exposes the sexism and hypocrisy of an industry, and attempts to right a terrible wrong.
Morrison split up with Forster in 1986 and, three years later, was told she was sacked from the band. In the years since, the history of the Go-Betweens has been reimagined and reframed as a duo featuring Forster and McLennan, with Morrison relegated to a supporting cast member, or worse, “the girlfriend”. When the band reunited in 2000, Morrison was not invited, while, in 2016, Forster published a book telling the story of the band which he gallingly called Grant and I. A documentary Right Here, comes with the tagline: “Three Decades. Two Friends. One Band”.
None of this is uncommon: women have been written out of history for centuries, their contributions to culture diminished, dismissed, or viewed solely in relation to the men in their lives. But through her entertaining, affectionate and righteous book, Thorn invites us to witness her friend in all her gobby glory. In explaining her connection to Morrison, she writes, “When I meet her I feel seen.” Now she has returned the favour.', true, TIMESTAMP '2020-04-19 05:46:24', 43, 'review', 'literature', 75);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Bertrand Tavernier, veteran French director of Round Midnight, dies aged 79', 'abs.jpeg', 'Bertrand Tavernier, the veteran French director of a host of acclaimed films including A Sunday in the Country, Round Midnight and These Foolish Things, has died aged 79. The news was announced by the Institut Lumière, the film organisation of which he was president. No cause of death was given.
Tavernier’s output was prolific: he made his directorial debut in 1974 with The Clockmaker of St Paul and worked continuously until 2013, when he released his final feature film, The French Minister. He also took in a wide variety of material, from crime and noir, to comedy, jazz and historical drama.
Born in Lyon in 1941, Tavernier was the son of magazine publisher René Tavernier, whose anti-Nazi principles would greatly influence Bertrand. Like the generation of French New Wave directors that slightly preceded him, Tavernier grew up as a film obsessive; having moved to Paris after the war, he founded his own magazine and managed to get a job as an assistant director to Jean-Pierre Melville on the 1961 film Léon Morin, Prêtre. By his own admission, he was so bad as an AD that Melville instead made him the publicist for its follow-up, Le Doulos. It was in this role that Tavernier made his first mark in the film industry, working as a publicist on a series of New Wave classics, including Jean-Luc Godard’s Contempt and Agnés Varda’s Cleo de 5 à 7. “We were the first film publicists who were film buffs – we only accepted the films we liked,” he told the Guardian in 2008.
However, it was always Tavernier’s ambition to break into directing, and returned to Lyon to make an adaptation of the Georges Simenon novel The Watchmaker of Everton, starring Philippe Noiret, the lugubrious looking actor who would go on to be a regular collaborator. Noiret appeared in Tavernier’s next film, the period drama Let Joy Reign Supreme about an 18th century rebellion against the crown, which won four Césars, the French equivalent to the Oscars.
Tavernier’s interest in American crime literature was demonstrated with films such as Coup de Torchon (1981), adapted from Jim Thompson’s Pop. 1280, and starred Noiret opposite Isabelle Huppert; it was nominated for the best foreign language film Oscar. However, Tavernier’s major international breakthrough was the A Sunday in the Country (1984), a fin-de-siècle-set drama about an elderly painter whose family come to visit; it won wide acclaim and a string of awards, including best director at the Cannes film festival. Tavernier followed it up with what remains arguably his best-known film: Round Midnight, released in 1986, which starred Dexter Gordon as a jazz musician struggling to survive in Paris and New York.
Tavernier had more success with Life and Nothing But, with Noiret as a military investigator after the first world war, and then These Foolish Things, for which he persuaded Dirk Bogarde to come out of retirement for a drama about the relationship between a dying man and his scriptwriter daughter (played by Jane Birkin). In the 90s, Tavernier made well-received crime films L.627 and The Bait, as well as glossy swashbuckler Revenge of the Musketeers, starring Sophie Marceau. In 2002 Tavernier turned to the French film industry itself as a subject with Safe Conduct, based on a memoir by Jean Devaivre and focusing on the Nazi occupation. However, Devaivre fell out with Tavernier, and the director found himself accused by French critics of attacking the New Wave.
In 2009, Tavernier finally realised his ambition of making a Hollywood thriller: the Louisiana-set In the Electric Mist was adapted from a novel by James Lee Burke and starred Tommy Lee Jones as Burke’s detective Dave Robicheaux. However, the experience was not a happy one; Tavernier told the Guardian that he “found everything more difficult than working in France”, and while the film was selected for the Berlin film festival, it was not released in US cinemas.
Back on home ground, the breadth of Tavernier’s enthusiasm for film was showcased in his lengthy 2016 documentary My Journey Through French Cinema, in which he expanded on film-makers such as Melville, Jacques Becker and Robert Bresson.
', true, TIMESTAMP '2020-12-20 02:38:09', 100, 'news', 'cinema', 72);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Mahler/Cooke: Symphony No 10 review – one of the finest recordings of a final masterpiece', 'abs.jpeg', 'Over the last 60 years there have been at least seven completions of the symphony that Gustav Mahler left unfinished at his death in 1911. But it’s the “performing version” of the 10th by Deryck Cooke, which he worked on between 1960 and 1976 with the help of composers Berthold Goldschmidt and David and Colin Matthews, that has become the most widely played and recorded version of this final masterpiece.
By no means all leading Mahler interpreters have taken up Cooke’s completion (or any of the alternative versions for that matter); some, such as Claudio Abbado, Bernard Haitink and Klaus Tennstedt, have preferred to conduct only the opening Adagio of the 10th, one of the two movements the composer left in a more or less finished state. But Osmo Vänskä has now recorded the Cooke score as part of his Mahler cycle with the Minnesota Orchestra; it’s arguably the finest instalment of that continuing project so far, and belongs alongside the performances by Simon Rattle, Thomas Dausgaard and Riccardo Chailly as one of the finest Mahler 10s on disc.
The previous releases in Vänskä’s cycle have shown that he never fusses with this music or overinterprets Mahler, and that neutral, stoic approach pays dividends in the 10th. His tempi may be generally on the slow side – this account of the opening Adagio is one of the most expansive on disc, and that of the central Purgatorio does lack demonic intensity. But the Minnesota Orchestra plays magnificently, and Vänskä’s meticulous attention to instrumental detail and to the weighting of every chord, and his unswerving sense of symphonic coherence and continuity, make the total effect overwhelming.
', false, TIMESTAMP '2019-12-31 05:31:16', 103, 'review', 'music', 57);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('’So much pressure to look a certain way’: why eating disorders are rife in pop music', 'abs.jpeg', 'For eight years of her life, Demi Lovato was served a watermelon cake for her birthday. This wasn’t a watermelon-flavoured version of a proper cake with all the good stuff like butter, sugar and flour, but rather an actual watermelon with some icing on top.
The reason for this was that her team at the time were “trying to keep her weight down”, according to Lovato’s best friend Matthew Scott Montgomery, who is interviewed as part of Demi Lovato: Dancing With the Devil, the YouTube documentary series premiering this week. Her team would police what she ate, he says, and those she was with were also required to eat only when Lovato ate, with no snacking outside of meals, in an attempt to “keep her well” and avoid triggering a relapse into the restrictive eating disorders she struggled with as a teenager.
That anyone thought it appropriate to put someone who had a history of restrictive eating on a restrictive diet is bizarre enough, let alone the fact it was, in Lovato’s own words, at the hands of a robust team consisting of a wellness coach, dietician, nutritionist and therapist. It’s likely this skewed approach to health is centred on the fact that, as Lovato says in the documentary, “there’s just so much pressure as a female in the industry to look a certain way, and to dress a certain way”. Perhaps unsurprisingly, being in this tightly controlled arrangement led to Lovato relapsing into an eating disorder and breaking her sobriety, which, through a series of events, led to an overdose in 2018 that resulted in three strokes and a heart attack. Doctors said she was minutes away from losing her life.
Lovato isn’t the only music star to have spoken openly about having an eating disorder in recent years. Taylor Swift said she starved herself and excessively exercised as a result of media scrutiny of her body and praise for being a small size from stylists, while Kesha said she also starved herself as she became more famous for fear of becoming “fat”. She told Rolling Stone that she thought: “Pop stars can’t eat food – they can’t be fat”. In his memoir Me, Elton John talked about suffering with bulimia while dealing with the stress of taking out multiple libel writs against the Sun for defamatory stories in the 80s, while Zayn revealed in his memoir that he went for days without eating while feeling a lack of control over his life during his time in One Direction. Other affected artists include Florence Welch, Lily Allen, Olly Alexander, Sam Smith and Halsey.
Research suggests eating disorders are prevalent among musicians. A 2017 study of 301 musicians found that 32% had experienced an eating disorder in their lifetime, and 19% were classed as having one at the time of the survey. This is much higher than statistics that suggest eating disorders affect 1.9% to 5.1% of the British population. While the 2017 study is a small sample, primary care physician Charlie Easmon, who supervised the research, says the results are plausible due to a common trait among musicians and eating disorder sufferers of perfectionism, the expectations of the music industry, and “potential insecurity as a child” that leads to a desire to perform. Other potential contributing factors include food insecurity, trauma and family history.
', false, TIMESTAMP '2020-04-10 01:10:42', 167, 'article', 'music', 2);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Britney Spears asks for father to be removed from running personal affairs', 'abs.jpeg', 'Britney Spears has petitioned for her father to be permanently removed from overseeing her personal affairs in the conservatorship that has governed her life since 2008.
Spears’ conservatorship consists of two parts: her finances and her personal life. Jamie Spears temporarily stepped back from managing the latter in September 2019 owing to health issues, but retained control over her finances.
In the latest hearing on Spears’ conservatorship on Wednesday, her lawyer, Samuel D Ingham III, told a Los Angeles judge that Spears wished for her temporary care manager, Jodi Montgomery, to be permanently installed to manage her personal affairs.
Montgomery’s role regards Spears’ healthcare, medical history and insurance, and gives her power to “restrict and limit” visitors, to retain “caretakers and security guards” and to prosecute civil harassment restraining orders on her behalf.
Jamie Spears runs his daughter’s estimated £43.8m estate alongside the private wealth management firm the Bessemer Trust, which in February was appointed as co-conservator of her finances at the singer’s request. Her bid to have her father removed from the financial side of her conservatorship was rejected in November.
In an earlier hearing, Ingham told the court that Spears feared her father and would not return to work while he remained in charge of her personal life.
Last month, Jamie Spears’ lawyer, Vivian Thoreen, spoke out against coverage of the hearings and the theories of the high-profile #FreeBritney movement that suggest the star is being held against her will.
“I understand that every story wants to have a villain, but people have it so wrong here,” said Thoreen. “This is a story about a fiercely loyal, loving and dedicated father who rescued his daughter from a life-threatening situation. People were harming her and they were exploiting her. Jamie saved Britney’s life.”
', true, TIMESTAMP '2019-12-28 20:26:04', 289, 'article', 'music', 6);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Football’s Darkest Secret review – spare and unrelenting', 'abs.jpeg', 'I once – walking through London, not very late at night – came across a man holding fast to a woman’s wrist and setting a dog on her. A crowd was already there, the police already on their way and, as I halted and stared in horror, a fire engine that happened to be passing stopped, and its crew got out and started to intervene. Among the many thoughts I had in the 90 seconds or so that I listened to her screams and watched her flail, silhouetted against the streetlights and lights of the cars streaming past us all, was how much of a lie it gave to what drama presents us as truth. The timbre of her voice, the abandonment terror gave her movements were unmistakably real and irreproducible – the best attempts from actors, you suddenly saw, were the very faintest, palest facsimiles of the real, awful thing.
The same thought passed through my mind as the camera trained itself on the men testifying to their horrifying truths in the three-part documentary series Football’s Darkest Secret (BBC One), about the sexual abuse of young boys by paedophile coaches. The episode titles give you the trajectory – The End of Silence, Missed Opportunities and The Reckoning. The interviewees give you the detail, beginning – as the eventual, ever-widening investigation itself did – with the former footballer Andy Woodward. In November 2016, he went to the police to report being raped and abused for years as a trainee at Crewe Alexandra in the 1980s by the then coach Barry Bennell.
At the same time, Woodward waived anonymity in an interview with the Guardian to encourage other people to come forward. “There’ll be hundreds of others,” he said. “And more. Thousands.” As soon as the story broke, he started getting phone calls and emails. “I knew then,” he says on screen as tears gather, “they were going to come.” Some of the first who did were Steve Walters, a fellow survivor at Crewe, David White – preyed on by Bennell in the 1970s when the coach was at the junior club Whitehill – and Paul Stewart, a survivor of another prolific paedophile Frank Roper, who coached the junior side Nova. To list the names of the survivors and predators that the investigation accumulated would fill the rest of this review and more.
It is a hard, spare and unrelenting three hours that marshals an appalling abundance of material with a compassionate but firm hand. The men’s current and remembered pain is visible in their every expression, their every movement. It’s there in every frame, a constant, pulsing presence, and the makers, wisely, do nothing to ameliorate or obscure it for the viewer. Their stories – so similar, so awful, so devastating for the boys they were and the men they become – are illustrated with footage of them on the field in their glory days. Almost all speak of being unable to give their all to their careers because of what had been done to them. Bennell – very much a star in his own field; an outstanding coach well known for bringing on true talent – is seen giving broadcasters the benefit of his footballing wisdom.
All of it, we know now, thanks to Woodward’s and others’ courage, was against a background of ceaseless grooming, normalising of aberrant behaviour, abuse, escalation and rape. Bennell, Roper and others used their status, the families’ trust in them and the lads’ devoted love of football against the boys, and did damage to thousands of lives that are only now – only partly and only tentatively – beginning to recognise and tend to it.
There are two interrelated questions to be asked whenever a documentary like this is made. Is it exploitative and is it in the public interest that we hear about it? To the first: no. Football’s Darkest Secret is an unsensational, measured look at an investigation. The participants seem to have operated of their own volition – and in Woodward’s case knowingly initiated the whole thing – and without coercion at any stage. Though the chance to talk about terrible experiences and put down the burden of secrecy is liberation of the most heartbreaking kind, the definition still stands.
Is it in the public interest that we hear their stories? The second episode, Missed Opportunities, shows what happens when we don’t. After the Jimmy Savile scandal, society became a little less likely to let abusive celebrities shelter under their fame. With this, perhaps we will become a little less willing to believe adults’ accounts over children’s, a little more able to spot enablers as well as abusers, and not always assume that if anything was wrong – truly wrong – we’d know, wouldn’t we? We’d hear? And so, maybe, in years to come, there will be fewer flailing souls, screaming in pain in the dark.
', true, TIMESTAMP '2020-08-04 07:14:28', 294, 'review', 'tv show', 38);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Philip Roth by Blake Bailey review – how a literary giant treated women', 'abs.jpeg', '“I don’t want you to rehabilitate me,” Philip Roth instructed Blake Bailey. “Just make me interesting.” The headline story can’t fail to be interesting: lower-middle-class grandson of immigrants writes scandalous bestseller about masturbation, is vilified as a self-hating Jew, has two disastrous marriages and many lovers, accumulates a stupendously diverse body of work (comic, surreal, metafictional, naturalistic), comes to be seen as the greatest English-language novelist of his day yet never, to his chagrin, wins the Nobel. But Roth wanted nuances not headlines, suggesting that Bailey call his biography “The Terrible Ambiguity of the ‘I’”. Luckily, that isn’t the title. But ambiguity is central to the story, particularly in relation to Roth’s treatment of women, in life and in fiction, which is where the issue of rehabilitation arises and, as with his peers (Saul Bellow, John Updike and Norman Mailer), can’t really be avoided, least of all now.
“Always it came back to the women,” Bailey writes, the first of them Roth’s mother Bess, who, if not as suffocating as Alex Portnoy’s mother, was so adoring that no subsequent woman in his life could match up. While sharing Bess’s devotion to Philip and his brother Sandy, her husband Herman left a mark in other ways, not least through his work ethic (12-hour days, six days a week). “He who is loved by his parents is a conquistador,” Roth liked to say. Despite the antisemitism of the period, he remembered his childhood as a haven. Newark to him was like Dublin to Joyce: a place he escaped but never left.
At college he discovered the fun of writing satire and, dropping plans to become a “lawyer for the underdog”, poured his energy into short stories. “Bibliography by day, women by night” was the idea, but at 23 he met Maggie Martinson, the first of his two marital “catastrophes”. A “hard-up loser four years my senior”, whose two kids lived with her ex-husband, Martinson was worldlier and more turbulent than any previous girlfriend. But that was the point: he saw her as a test of his maturity. By the time his first book, Goodbye, Columbus, made him famous, he’d had enough. “It isn’t fair,” Maggie said, rightly suspecting that he was sleeping with other women, “You have everything and I have nothing, and now you think you can dump me!” In a ploy to hang on to him, she persuaded a pregnant woman to urinate in a jar as part of “a scientific experiment”, used the positive result to trick Roth into thinking that she was carrying his child, then agreed to have an abortion if he promised to marry her – which he duly did.
It was three years before he discovered the truth and, furious at being conned so easily, began divorce proceedings. Arguments about alimony were still going on when Maggie was killed in a car crash. His income that year was around $800,000 (the equivalent of $6m today) and her death meant he didn’t have to split it. Though relieved that the “goyish chaos” she’d wreaked was behind him, he continued to feel vindictive towards Maggie, and took his revenge in fiction, dubbing her the Monkey because of her stubby legs and having his alter ego Zuckerman express repugnance at her “withered and discoloured” vagina. Bailey’s version of events leans on Roth’s but he tempers it with extracts from Maggie’s diary, the most plaintive of them when she realises “Philip doesn’t care for me – he’s sorry for me”.
Roth’s second catastrophe, with Claire Bloom, wasn’t so much the failure of their marriage but how she wrote about it in her memoir Leaving a Doll’s House. In the flush of first love he described her as “a great emotional soul-mate” who’d rescued him from a period of excruciating pain (a back problem which plagued him throughout his life). The domestic harmony didn’t last. He disliked Bloom’s daughter Anna living with them in London. And Bloom felt isolated at Roth’s 40-acre farmhouse in rural Connecticut, which he’d bought for $110,000 when even the paperback rights to one of his worst novels earned him four times as much (it became his own Yaddo, a place to retreat and write, undisturbed – leaving Bloom at a loose end). Among many points of contention was the pass Roth made at Anna’s friend Felicity, which outraged all three women but didn’t merit much of an apology from Roth (“What’s the point of having a pretty girl in the house if you don’t fuck her”).
Most of Roth’s other relationships were with younger women: “I was forty and she was nineteen. Perfect,” he said of one, though his ideal age gap grew as he got older (“A mature woman wouldn’t take your shit,” his analyst told him). He had a theory that sexual interest wears off after two years, but his 18-year affair with “Inge”, the model for Drenka in Sabbath’s Theater, disproved it. Among those he flirted with or knew (however briefly) as friends were Jackie Kennedy, Mia Farrow, Ava Gardner and Barbra Streisand. Other lovers here go unnamed or are given pseudonyms, though not the Playboy pin-up Alice Denham (Miss July, 1956), who called him, approvingly, “a sex fiend”, and not Ann Mudge, who was dropped because her “meek gentility had begun to bore him” (she subsequently attempted suicide).
Bailey doesn’t deny Roth’s “breathtaking tastelessness towards women”. And there were always goatish buddies happy to normalise the misogyny, from disgruntled divorcees whining that their wives had fleeced them, through the teaching colleague who “pimped” for him, to the artist RB Kitaj who would fax him “dashed-off sketches of the decorous Anita Brookner, say, giving blow jobs”.', true, TIMESTAMP '2020-02-17 09:48:38', 269, 'review', 'literature', 91);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('This Is My House – through the keyhole with Stacey Dooley', 'abs.jpeg', 'There’s a TikTok doing the rounds on Twitter (don’t worry if you don’t know what any of these words mean, they are just in the way of prelude and context) of a young man, Mr B Dylan Hollis – who has been seized by the need to create something called a chocolate potato cake from a recipe found in a cookery book dating from 1912. His incredulity builds as he goes (“Skins stay on?!” “It smells like dentures!” “I bet this recipe is just all the wrong answers on a baking test”). He tastes the finished product and begins to laugh before screaming at his plateful: “You’re not supposed to work! That’s incredible. And I’m mad about it!”
This, roughly, is the same emotional trajectory you can expect to follow while watching BBC One’s latest light entertainment offering, This Is My House.
This chocolate potato cake of a show is presented by Stacey Dooley. I love her, but – to throw another ingredient into the mix – she is something of a Marmite figure for viewers, although those who object to her often seem to do so on the grounds that she has a Luton accent and – uh – no PhD in … television presenting?
The set up is this: four people claim they own a house – a converted barn in Ashford, Kent, in this opening episode. They show us, and a panel of judges who sit in a room watching the feeds, round “their” home. The judges must decide which one is telling the truth.
I know. I know. Trailing about after people pretending a sofa belongs to them and serving up backstories about where a penis-shaped corkscrew came from? Sounds too “skins stay on?!” for words. Then Laurence Llewelyn-Bowen turns up as a guest judge and it all begins to smell a lot like dentures. All the wrong answers on a light entertainment commissioning test.
', true, TIMESTAMP '2021-01-29 06:33:33', 276, 'article', 'tv show', 15);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Six Minutes to Midnight review – Eddie Izzard miscast in strained Nazi-school yarn', 'abs.jpeg', 'Eddie Izzard, comedy genius and heroic campaigner for the European cause, is bizarrely miscast in a deadpan-serious acting role for this weird, strained, second world war spy melodrama inspired by a stranger-than-fiction true story. The transgender star switches back here to what Izzard has playfully called “boy mode” for a boy’s-own-story in the style of John Buchan or Erskine Childers, or maybe one of Michael Palin’s Ripping Yarns, though with the jokes and comic self-awareness systematically removed. It’s a muddled, unrelaxed tale from Izzard as co-writer and co-producer, whose dramatic gears keep slipping, and which is never entirely sure where our sympathies should lie.
Izzard plays Thomas Miller, a teacher of Anglo-German ancestry who in the fraught summer of 1939 takes a job at the Augusta Victoria college in Bexhill-on-Sea, a kind of genteel finishing school for expatriate German adolescent girls; he is interviewed for the job by the naively pro-German English headmistress Miss Rocholl (with Judi Dench sleepwalking through the role). This extraordinary school really did exist throughout the 1930s, with a swastika discreetly sewn into its crest next to the union jack, and it was attended by the daughters and god-daughters of some very senior Nazis. Izzard imagines what might happen if, as war loomed, this place was the centre of a Nazi intelligence plot.
', true, TIMESTAMP '2019-12-13 07:38:39', 225, 'review', 'cinema', 71);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Kate Garraway: Finding Derek – devotion and honesty in the face of Covid', 'abs.jpeg', 'A week after the UK first locked down in March 2020, Derek Draper was admitted to hospital with Covid-19. And it is there that the psychologist, former lobbyist and Labour campaign adviser remains. He has spent months in intensive care, including time in an induced coma, after his liver, kidneys and heart failed and were agonisingly restored to function by the tireless work of the ICU team.
Kate Garraway: Finding Derek (ITV) is a film fronted by his wife, the Good Morning Britain presenter, about a year of coping with this astonishing rupture to their lives, and to those of their two children Bill and Darcey. It is hard to capture how magnificent – wholly unshowily so – she is. Garraway is a strong communicator, which you might expect from someone in her line of work. But here she is stripped of studio artifice, as she chats to the director, to us, the viewers, to people online and outdoors. She gathers information about the impact of long Covid on sufferers and their families, and you are reminded that being able to hold and diffuse attention on camera, in the right proportions, is a gift. Honed by experience, for sure – but still something not everyone can do. (She even manages to survive a fantastically literal soundtrack that insists on making itself heard between her pieces to camera in case we can’t be trusted to maintain our emotional pitch. At one point, during a pocket of improvement for Draper, I would not have been surprised if D:Ream’s Things Can Only Get Better had suddenly been inflicted on us all.)
Soundtrack aside, it is a documentary that knows what it is doing and does it well. It knows what a natural asset it has in Garraway and puts her to good use. In essence, it is the simple sight of her coping. She whizzes around, picks up Lego, hangs up children’s coats and supervises the builders making adaptations to the house in preparation for Draper’s hoped-for return. Not to mention her return to work after five months’ absence (“Extra concealer today!”), talking with doctors on the phone and absorbing rather than collapsing under verdicts that must land like body blows (“We think there’s very significant [cognitive] damage”).
', false, TIMESTAMP '2021-03-11 13:01:14', 111, 'news', 'tv show', 26);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Truth About Modern Slavery by Emily Kenway review – too much hollow talk', 'abs.jpeg', 'During her time as home secretary and prime minister, Theresa May spoke repeatedly about her quest to eradicate the scourge of modern slavery. She described it as the “greatest human rights issue of our time”, and in 2013 wrote an article outlining the importance of her modern slavery bill, headlined “Modern slave drivers, I’ll end your evil trade”. When she left office, her supporters pointed to this legislation as her key legacy.
How could anyone find fault with such a cause? Everyone is against slavery; the new abolitionists include pop stars, supermodels, billionaires and philanthropists. Criticising the campaign is like saying one is against motherhood and apple pie, Emily Kenway writes, before comprehensively unpicking the hypocrisy that runs through much of the government’s work in this sector. Her powerful treatise argues that modern slavery does not really exist as a clear phenomenon, but has been seized on to divert attention from the underlying causes of labour exploitation, and to provide moral cover for tightened immigration policies.
Kenway, who worked as an adviser to the UK’s first anti-slavery commissioner (a position created by May), has spent years watching, up close, as the issue has been weaponised by politicians for their ulterior motives. The experience has made her very cynical about the new abolitionism. “The modern slavery story is adept at providing moral legitimacy for the very policies that enable severe exploitation in the first place,” she writes.
Once people-trafficking has been established as a serious problem that the Home Office needs to tackle, introducing hostile environment immigration legislation can be presented as a reasonable reaction. It is a logic used also by Donald Trump, whose response to what he described as an “invasion” by human traffickers on the US-Mexico border, is well known. “You need a physical barrier. You need a wall,” he declared. But increased border checks at Calais did not deter the people smugglers responsible for the deaths of 39 Vietnamese migrants in 2019; the extra security simply pushes people towards to embarking on ever more dangerous journeys.', true, TIMESTAMP '2020-02-06 00:01:14', 236, 'review', 'literature', 100);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Tom & Jerry The Movie review – sanitised relaunch of the cat and mouse combatants', 'abs.jpeg', 'Whoever wins, parents lose. While there’s little to truly loathe in Fantastic Four and Ride Along director Tim Story’s frantic new take on Tom & Jerry, there’s also an equal lack of anything to truly love; this is a serviceable, if entirely forgettable attempt to relaunch an old property for a new audience. Very young kids might find some enjoyment in the brightly hued, fast-paced mania of it all, but those with any real affection for the pair of violently opposed animals will leave unimpressed.
With a script that feels lazily retrofitted to revolve around the two animals rather than designed directly for them, this is basically a kids’ movie about antics in a New York hotel that pauses every so often to feature a sanitised fight between the pair. The decision to combine live action with animation often jars (every human is real, every animal is animated) and, within the realism of Manhattan, we’re then left with questions about the rules that have been haphazardly set up. (Why, for example, can some animals talk but not others? Violence seems to cause no harm to animals, so would humans also be immune?). These are questions that we perhaps wouldn’t be forced to ask if the film itself were more engaging.
', true, TIMESTAMP '2019-09-15 10:01:12', 63, 'review', 'cinema', 32);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Unforgotten series four, episode five recap – what now for Cassie?', 'abs.jpeg', 'Who saw that coming? Certainly not me, and certainly not Cassie as she carelessly pulled out without looking right just in time for an oncoming vehicle to plough into her driver’s side. If she survives, we can hope her recuperation period brings her up to 30 years on the force. If she doesn’t, Martin’s last words to her, something about her turning into an arsehole, could have been better chosen.
The investigation
It’s too bad, because the Ford Granada Four’s story is coming apart like a knockoff handbag. The Ifield landlady Monty reveals that Matthew sexually assaulted Fiona, and another pensioner surfaces with a tale of the probies carrying what looked rather like a dead body under a tarpaulin. The four must be cursing the influx of public-spirited senior citizens with epic memories.
Even better is the discovery of Dean’s remarkable backstory. Born into a family of villains, he committed the ultimate betrayal of joining the police, and got a ferocious shoeing and lifelong exile for his troubles. Equally intriguing is the weaponised fountain pen Leanne yanks out of Matthew’s skull. In a victory for literalists everywhere, the pen really is mightier than the sword.
Ram Sidhu
Anna and Ram have had the Talk about the Walsh case. They’ve had many such talks over the years, but this one feels different. With three co-conspirators, bleeding-edge forensics and a new witness surfacing every week, Ram cannot control the narrative. Even the Houdini of the tribunals has his limits, and for the first time he’s scared. Later, he just wants his dad to look at him – “then maybe I could stop all this shit – the money, the job, the lot”. It’s a curious scene and a pass-agg masterclass from the silent Sidhu patriarch, his gaze transfixed on an admittedly delicious-looking dinner. His beef with his son, though, leaves a bitter taste.
Liz Baildon
“You’re beginning to sound like a Michael Jackson song,” Eileen snarks at her daughter.
“Shut the fuck up!” Liz screams in response, apparently confusing the Bo Selecta Michael Jackson for the real thing. Liz doesn’t wanna be starting something with Eileen now he has figured out the truth about Matthew Walsh. Even so, she is frazzled enough to threaten her mother with nocturnal murder if she keeps running off at the mouth. She’s bad. You know it.
It’s not even her biggest showdown of the episode – that’s the confrontation with Cassie. The two alphas circle one another, snorting and pawing at the dirt, each sizing the other up. It’s clear from the off, though, that Cassie has the advantage. After all, she has never covered up a murder (apart from that one time she covered up three, which I wish everyone would stop bringing up). Liz leads with haughty condescension, telling Cassie “I would have expected better of you than this, DCI Stuart,” but mounting a high horse in her position is a perilous act. After catching her out in a series of lies, Cassie dismounts her opponent with “I would have expected better of you, deputy chief constable Baildon”. It’s an ice-cold riposte and, soon afterwards, a battered Liz wisely takes refuge in “no comment”.
', false, TIMESTAMP '2019-06-30 09:38:57', 128, 'review', 'tv show', 22);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Absolute Book by Elizabeth Knox review – an instant classic', 'abs.jpeg', 'Elizabeth Knox is the recipient of a multitude of literary honours in her native New Zealand, with the kind of popular following that befits the luminous quality of her writing. That international success has thus far been denied her is something of a scandal, but with her latest work the tide could be about to turn. The Absolute Book has the feel of an instant classic, a work to rank alongside other modern masterpieces of fantasy such as Philip Pullman’s His Dark Materials series or Susanna Clarke’s Jonathan Strange and Mr Norrell.
When Taryn Cornick is still a teenager, her older sister Beatrice is killed in a hit-and-run. The perpetrator, Timothy Webber, is sentenced to six years in jail; Taryn remains convinced that her sister’s death was not an accident, but murder. Soon after his release, Beatrice’s killer is found dead in a ditch not far from the site of the original accident. Someone is stalking Taryn – plaguing her with silent phone calls – and when a police detective, Jacob Berger, turns up on her doorstep asking questions about the death of Timothy Webber, Taryn suggests that Berger should stop bothering her and look for the stalker instead. But Berger senses there must be a connection between Webber’s death and Taryn’s silence, and his memories of the original crime leave him unwilling to let the matter drop.
Meanwhile, a missing witness to Beatrice’s death has finally resurfaced. His name is Shift, and he is not quite human. He explains to Taryn that the world she knows is not the only world, and that the equilibrium between human reality and the fairy realm is becoming unstable. The rupture is centred on an object, a wooden casket containing a book known as the Firestarter due to its habit of surviving disastrous and often inexplicable library fires. Shift insists that Taryn alone holds the key to its whereabouts, that a long-ago blaze in her grandfather’s library was no accident, but an attempt by the forces of darkness to smoke out the casket. As she is drawn into an adventure of trans-dimensional magnitude, Taryn comes increasingly to suspect that her sister’s death was collateral damage in a secret war for possession of the casket’s contents.
As the author of a history of book-burning, Taryn Cornick is something of an expert on the subject, and it is books, more than anything, that form the beating heart of The Absolute Book. This is a text that seethes with literary allusions: classics of ancient literature, fairy stories, crime capers, philosophical treatises and radical polemics, novels of manners and revenge, heroic quests and big books-about-books such as The Shadow of the Wind, The Da Vinci Code, Night Train to Lisbon and The Saragossa Manuscript – “arcane thrillers”, as Knox has called them.
The Absolute Book is a tongue-in-cheek homage to these overblown literary detective stories as well as a triumph of literary fantasy, and this knowing, feisty, humorous contribution to the genre is a hefty piece of work. There is a lot to keep track of here, not only in terms of characters but in terms of worlds. As Taryn, Shift and Berger duck and dive between realities they encounter demons, fairy folk, the semi-immortal hybrids known as the Taken, human souls in Purgatory and godly entities in avian form. The strands of real-world myth, folklore and fairytale from which Knox weaves the philosophical rationale behind what is in its appearance and mechanics a classic portal fantasy are as richly diverse as her characters, revealing a fluent knowledge of her predecessors as well as a solidly practical grasp of magical storytelling.
Fantastic literature is often decried for being escapist, and while the currently burgeoning epic fantasy market might stand as evidence that traditional sword-and-sorcery is alive and well, a book like Knox’s offers the assurance that a more forward-thinking, experimental strand of fantasy is possible, and thriving. The greatest fantasies have always held up a mirror to quotidian reality, and it is to this politically engaged, reality-critical, Swiftian strand that The Absolute Book belongs.
Part of the problem of derivative fantasy is the underlying sense that the stakes are disappointingly low – that because anything is possible, nothing matters. The Absolute Book, by contrast, is dark, difficult and ambiguous. While Knox is generous and playful in the worlds she creates – the gorgeously decadent invention of her fairy realm offers enough detail, delight and internal consistency to please even the most devout Tolkienite – her purpose lies in revealing the limits of enchantment and the moral danger inherent in allowing ourselves to be seduced by easy narratives of power and entitlement.
There is a genuine feeling of jeopardy, and Knox shows consummate skill in weaving together the mimetic and the fantastic; with its surveillance drones, server farms, mobile phones, police procedure and celebrity culture, The Absolute Book is a 21st-century narrative whose social and political ills (Brexit, rightwing populism, climate catastrophe) are not simply topical background but central concerns.', false, TIMESTAMP '2019-02-19 02:33:47', 158, 'review', 'literature', 47);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Names of the Women by Jeet Thayil – Bible stories reclaimed', 'abs.jpeg', 'Here’s an Easter trivia question for you. Mary Magdalene was Jesus’s companion and is mentioned a dozen times in the New Testament. But what was her line of work? If you answered “prostitution”, as I did, then I’m afraid nul points.
I was so surprised to have my assumptions overturned by Jeet Thayil’s new novel, Names of the Women, that I went to double-check. And in my annotated copy of the Bible, I found: “Occupation: We are not told, but she seems to have been wealthy.”
“Hundreds of years later, men who have never met her will call her a fallen woman,” writes Thayil. “She will be called a sinner, when her only sin is that she is from a prosperous home and she is sad.”
In Names of the Women Thayil reclaims the story of not only Mary Magdalene but of 14 other women who play different roles in the gospels. Thayil, best known for the Booker-shortlisted Narcopolis and raised among adherents of the ancient Christian community in Kerala, has read his Bible carefully. He also draws on ideas from non-canonical texts such as The Gospel of Thomas, the Acts of Pilate and a fascinating fragment that turned up in the 19th century called The Gospel of Mary.
Alongside Mary Magdalene, we meet Jesus’s sisters, Assia and Lydia; his followers Susanna and Joanna; Mary of Bethany and Martha, the sisters of Lazarus. There are female baddies too: Herodias and her daughter Salome, who call for the head of John the Baptist.
Thayil’s argument is with the systemic misogyny that has marginalized and misrepresented the female characters in the New Testament. We wrongly remember Mary Magdalene as a prostitute. Her key role in the narrative – retold here in a wonderful moment of hair-raising strangeness – is to be the first witness to the resurrection. “They will build the Church on the witness of the women,” Thayil writes, “but they will refuse to record their names.”
Where there is no extant material, he fictionalizes, naming and filling in the backstory of the adulterous woman Jesus saves from stoning, the maidservant of Caiaphas the high priest, and the wife of the penitent thief crucified alongside Jesus.
It’s fascinating to be reminded how little we properly understand one of the foundational stories of western civilization. And there are moments where the much-pondered events are reframed in a new light and suddenly acquire life and a strange fleshy vigor. Lazarus comes back from the dead emotionally scarred and turns to drink to blot out the experience. Salome’s dance to win the head of John the Baptist becomes a weird, Cirque de Soleil-like display of erotic contortion.', true, TIMESTAMP '2019-09-08 07:20:07', 214, 'news', 'literature', 41);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('System of a Down’s Serj Tankian: ’If something is true, it should be said’', 'abs.jpeg', 'Of all the nights Serj Tankian has stood on stage surveying a crowd of 50,000 faces roaring his own words back at him, there is one that the System of a Down frontman will never forget. On 23 April 2015, the metal band gave a two-and-half hour, 37-song set to a rapturous audience in Republic Square, in the heart of the Armenian capital Yerevan. For a band formed in the diaspora community of Los Angeles’ Little Armenia in 1994, the occasion could not have been more significant: they had been invited to perform in the country for the first time as part of events marking the centenary of the Armenian genocide, in which an estimated 1.5 million Armenians were killed between 1915 and 1922. “The overwhelming feeling was of belonging,” says Tankian, 53, speaking from his airy home studio in Los Angeles. “It felt like we were created 21 years earlier so we could be there that night.”
For Tankian, whose outspoken political activism often animates his songwriting, seeking international recognition of the Armenian genocide has been a lifelong and personal campaign. On stage that night in Yerevan he told the story of his grandfather Stepan Haytayan, who was just five years old when he saw his father murdered in the atrocities; he later went blind from hunger. Between songs, Tankian railed against Barack Obama’s resistance to using the term “genocide” to describe the atrocities after taking office, before turning his ire on Armenia’s authoritarian president, Serzh Sargsyan. “We’ve come a long way, Armenia, but there’s still a lot of fucking work to do,” Tankian told the audience, before calling out the “institutional injustice” of Sargsyan’s administration and demanding the introduction of an “egalitarian civil society”.
', true, TIMESTAMP '2021-02-11 14:08:59', 40, 'review', 'music', 93);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('All on Her Own Review – a curio of repressed emotion', 'abs.jpeg', 'Terence Rattigan has long been rescued from the theatrical limbo into which he was cast by Kenneth Tynan and the ironing board. Qualities that caused him to be despised – reticence, obliqueness – now often appear to be not evasions but subtleties. The Deep Blue Sea (1952) has dated better than Look Back in Anger (1956).
Yet All on Her Own, first seen on television in 1968, is more curio than treasure. This half-hour monologue features a woman returning to her Hampstead home from a party. Alastair Knights’s sumptuous production provides a rarity in streamed drama: a glimpse of more than one room, as she glides from semi-darkness into light. She is alone; she has recently been widowed. The questions that arise, with more force as she hits the whisky, are to do with victimhood. Is this a sad or a sinister woman? Was her husband’s death truly an accident or did he kill himself? Did she suck the air from their marriage by her frigidity and the frostiness of her disagreements?
This is a fine chance for Janie Dee to show her delicacy as an actor – her face is sodden with despair – and her versatility. She investigates her marriage and herself by ventriloquising her husband, mocking herself for the crudeness of her reproduction of different kinds of northern accent. Yet the cards are stacked from the beginning: she is an anxiously respectable southerner, so likely to be frigid; he is more robust, more truthful, probably sexier. She gets doubly punched: first she is pitiful because solitary; then she turns out to have brought her isolation on herself, so is blameworthy. He, of course, would have settled it with a good, straightforward row. Well, he was a builder, so perhaps Rattigan thought he kept “hammer and tongs” in his tool box.
', false, TIMESTAMP '2019-02-21 09:26:39', 12, 'article', 'theatre', 45);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Surrogate by Susan Spindler – a postmenopausal reckoning', 'abs.jpeg', 'At 54, Ruth Furnival is powerful, successful, and fast becoming invisible. Having left her working-class Cornish roots far behind to become the director of her own TV production company, along the way wedding charming barrister Adam and launching two talented daughters, she’s surprised to discover that she minds the waning of her sexual attractiveness a great deal. There’s more than a smidgen of vanity, therefore, in her decision to subject herself to monster doses of hormones and become a surrogate for her eldest daughter, Lauren, who has just suffered her seventh miscarriage.
Surrogacy stirs up a complex swirl of ethics and emotions, easily lending itself to sensationalism. It’s a trap that Spindler’s intimate, equitable debut novel dodges, even as the ramifications of Ruth’s decision predictably blow the happy Furnival family apart. Instead, this is a book that’s overly burdened by its mission to educate, meaning that, despite deft structuring, the early chapters tend to get bogged down in meticulous probing of moral and biological boundaries, often via some pretty clunky dialogue. As the plot quickens, however, the prose improves; when it comes to describing a crisis, of which there are plenty, it soars.
While the narrative shifts between viewpoints, it’s Ruth’s that dominates. The most fully realised character, she is imposing, forceful, and not always likable. (As the hormones take hold, she’s also increasingly lusty, which feels bracingly transgressive so far as the fictional representation of middle-aged women goes.)
Is becoming Lauren’s surrogate in her 50s an act of biological hubris, Ruth asks herself early on. Her motives are certainly mixed, but the pregnancy changes her in a way that carrying her own babies never did. It becomes a reckoning – not just for her postmenopausal body but also for her psyche, forcing her to question herself as a mother, wife, and colleague.
In the end, this is as much a novel about womanhood as it is about motherhood. To quote Ruth herself, “Contraception, abortion, infertility – they’re central to the physical and ethical experience of being female, but we never join up the dots and talk about them honestly”.', false, TIMESTAMP '2021-01-17 09:11:22', 218, 'review', 'literature', 63);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Falcon and the Winter Soldier episode one recap: is the world ready for a black Captain America?', 'abs.jpeg', 'Given the universal praise for WandaVision, the first small screen outing for the Marvel Cinematic Universe, it’s hard to know whether that makes things more or less difficult for The Falcon and the Winter Soldier. On one hand, fears over how the MCU would translate to the small screen have been well and truly allayed – we’re most definitely not in Iron Fist territory. On the other, the raising of that bar brings its own pressures.
Originally, The Falcon and the Winter Soldier, or TFATWS as we’ll call it from here on in, was supposed to appear on Disney+ before WandaVision, and it’s immediately clear why. WandaVision, so surreal, fantastical and high-concept, was, theoretically, a bigger ask for the casual Marvel fan (although after 22 box office-busting films and one ratings smash TV series, how many casual Marvel fans there are remains open for debate). Nevertheless, TFATWS, is much more familiar in tone, and the contrast between this series and WandaVision could not be more marked. In one, characters couldn’t leave a small town. Here, in the first episode alone, the actions flits between Tunisia, Washington, Louisiana, Switzerland, Japan and New York.
The Falcon
It opens four months after the events of Avengers: Endgame – four months after billions of people reappeared from the dust after five years away. The world is in chaos. Sam Wilson (Anthony Mackie) was among those who vanished, but he’s back, looking sad and packing up Captain America’s shield, with Steve Rogers’ words from Endgame about the shield now being his ringing in his ears.
Now aboard a US air force plane in full Falcon gear, he’s being briefed on LAF. They’re a criminal organisation with vague intent who have kidnapped a military liaison and are trying to get from Tunisia to the safety of the Libyan border, where the US military won’t be able to intervene. “This has to be subtle,” Wilson is warned by a nameless camouflaged officer. What follows is possibly only Michael Bay’s idea of subtle, as Falcon takes on the bad guys. Among them, Batroc the Leaper, played by former UFC champion Georges St-Pierre (last seen narrowly escaping the Lemurian Star after a beating from Steve Rogers in Captain America: The Winter Soldier. Welcome back Georges).
Wilson and his helpful little drone, Redwing, follow five baddies, now wearing wing suits, out of their plane and chase them at high speed through rocky ravines and trenches, blowing up a few helicopters while doing so. It’s exhilarating, and 1st Lt Torres (Joaquín Torres, by any chance?) watching from the ground below acts for all of us when he begins punching the air with excitement. All this, and only 10 minutes in.
Back on the ground, over tea in a Tunisian market, Torres introduces Wilson to the Flag Smashers, a new bunch of terrorists who believe life was better during the five-year Blip and want to see an end to international borders. Torres, though, only has one question from the conspiracy theories he’s been reading – does Steve Rogers live in a secret base on the moon?
And then to Washington, where Wilson surrenders Cap’s shield for display in a museum. There’s room for a quick Avengers cameo, with Rhodey (Don Cheadle) there for a quick chat. He tells Wilson he should be taking the Captain America mantle for himself. I couldn’t hear what he said in return, I’m afraid, I was deafened by all the foreshadowing.
And the Winter Soldier
Our other eponymous hero is living in New York and having recurring nightmares about his time as Hydra’s most deadly assassin. This flashback sees him slay at least half a dozen henchmen and one innocent student in the wrong place at the wrong time. He wakes in time to bluff his way through a counselling session – hello there, Lt Grace Billetts from Bosch (Amy Aquino) – and reveal how he’s been spending his time, making amends for his past sins and ignoring Sam’s messages.
One friend he does have is an elderly neighbour, Mr Nakajima, who puts aside mourning his son long enough to play matchmaker with the woman from the restaurant. But wait! Conveniently, the only other Asian man we’ve seen on screen, the executed student, is Mr Nakajima’s dead child, and that’s why he’s been living nearby. It’s all enough to put the 106-year-old man off his date.
I was intrigued by the significance of the lucky cat Bucky momentarily stops from rocking. It could be nothing, but it did hit me that, like the maneki-neko, Bucky, too, only has one purpose – fighting – and can’t do anything else. The cat is even left-handed.
A super-mortgage?
Down in Louisiana, Sam is reunited with his sister and nephew, where he wants to right some wrongs of his own. He sees how hard up they’ve become in the five years he was away, but despite his star status, he can’t help secure a bank loan. While the scene was way too long – all the budget went on the helicopter chase – if you’ve ever wondered how much a superhero earns, you now have an answer.
It’s clear that if WandaVision was about grief and female empowerment, TFATWS is going to put an examination of race, and what it is to be a patriotic American, front and centre – particularly given the ending which reveals the super-patriotic new Captain America is around. As we’re told throughout, Captain America is a symbol, a hero for the times. If those times are ones of division, chaos, heightened nationalism and clashing ideologies, maybe you can expect the accompanying heroes to be pretty hardline, too.
And finally to Switzerland, to Torres and the Flag Smashers. He’s beaten unconscious before he finds out too much, but the two masked terrorists we see are very strong – super soldier serum strong – and hopefully the reason Sam will try messaging Bucky one more time. Fingers crossed he answers.
', true, TIMESTAMP '2019-12-05 11:27:14', 170, 'news', 'tv show', 64);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('This week’s new tracks: Silk Sonic, No Rome, Justin Bieber', 'abs.jpeg', 'Silk Sonic
Leave the Door Open
A match made in Soul Glo heaven, Bruno Mars and Anderson .Paak do their best impressions of 70s lounge lotharios as supergroup Silk Sonic, climbing down to the audience to kiss as many swooning hands as humanly possible. This one most definitely goes out to the ladies: the styling is impeccable and the cheese is piquant, teetering just on the right side of pastiche. What’s not to love?
No Rome ft Charli XCX and the 1975
Spinning
Supergroups coming out of our ears! Spinning sounds exactly as you think it would from the sum of its named parts, which means to say that it’s a Polly Pocket-sized clamshell of 90s school disco fun, high on a shared language of glitchy hyperpop. It’s nobody’s creative peak, but is a welcome mid-era bop from all three.
Justin Bieber
Hold On
Justin Bieber’s compassionate cameo in the Billie Eilish doc has earned him new space in my heart, and I am choosing to remember that feeling of goodwill as I try to imagine what on earth he was thinking when he decided to team such a hammy attempt at a poignant music video with that tonally mismatched Gotye chorus. Still, the 80s drums suit him, as does his renewed message of resilient hope.
Cleopatrick
The Drake
Less Hotline Bling than The Call Is Coming from Inside the House, The Drake sees newcomer duo Cleopatrick wrestling Royal Blood dramatics back into a gloomy basement, crafting an intriguing labyrinth of lyrical Easter eggs and mouth-full-of-marbles drawl. We’ll be watching them, if they’re not watching us first …
', false, TIMESTAMP '2019-11-01 06:19:55', 93, 'news', 'music', 1);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Nancy Campbell’s playlist: 10 songs from my travels', 'abs.jpeg', 'Lastu Lainehilla (Driftwood) by Jean Sibelius
I never travel without a necklace that has a tiny bronze figure from the Finnish epic Kalevala. This talisman was given me by Anna-Kaisa, a teenage music prodigy, on a summer exchange when I was 15, which launched my love of all things Nordic. That summer I had my first sip of cloudberry vodka, took my first sauna, and learned to row a boat: all revolutionary for a kid from a family that had never taken holidays abroad. Anna-Kaisa and I became close friends, and I often returned to Helsinki for more saunas and vodka, and to hear her accompany the beguiling soprano Karita Mattila at the opera house.

Love Among the Sailors by Laurie Anderson
Fierce storms, continuous night and mercurial ice: winter is a challenging time to travel between settlements in Greenland, where I lived for three months in 2010 on an arts scholarship. I immersed myself in life on the island of Upernavik and set to work getting to know this welcoming community in depth.
I learned about the wider archipelago from hunters who knew the waters of the north-west coast intimately, and shared sober conversations about sea ice conditions over coffee or a mug of seal stew. As the weeks progressed, sometimes it seemed I would never leave the island. This ballad – written by Anderson at the height of the Aids epidemic – brings back all the loneliness and menace of the polar darkness.
', true, TIMESTAMP '2020-05-19 13:19:08', 279, 'news', 'music', 32);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The best recent thrillers', 'abs.jpeg', 'The Last House on Needless Street
Catriona Ward
Catriona Ward’s The Last House on Needless Street, which opens 11 years after a little girl vanishes on a family trip to a lake, comes emblazoned with glowing – and much-deserved – praise from her fellow authors: Stephen King, no less, calls it the most exciting novel since Gone Girl, and “a true nerve-shredder”. It is the story of a child whose life was stolen, of Ted, the man who may or may not have done it, and of Dee, the sister out for revenge. That might make The Last House on Needless Street sound straightforward – it’s not. This is the most gloriously complex, shifting story, deeply disturbing yet also, somehow, heartwarming. Ted lives in a boarded-up house on Needless Street on the edge of the forest, with his daughter Lauren (who sometimes has to go away) and his cat Olivia; he is confused, childlike, flipping in and out of the present and the past as he remembers being questioned by the police years earlier over the disappearance of “Little Girl With Popsicle”, and as he thinks of his mother, who was “born far away… under a dark star”. Dee’s family and life have fallen apart after the disappearance of her sister Lulu. She “feels like a big, dark, empty room” and is fixed on finding whoever took Lulu. Ward has created something exceptionally unsettling here, as many-layered and sinister as the Russian doll that sits on Ted’s mantelpiece. Olivia, Ted’s cat, given wonderfully vain voice by Ward, imagines them “all screaming in the dark, unable to move or speak”, as the outer sits “broad and blankly smiling”.
Later
Stephen King
Stephen King sets out his stall early in Later: “Like I said,” narrator Jamie Conklin tells us, “this is a horror story.” Jamie is a normal boy growing up in New York, the son of Tia, a single mother and literary agent who tells him pleasingly self-referential things such as “most writers are as weird as turds that glow in the dark”. Normal except Jamie can see dead people, for just a few days after they die (“It’s not like in that movie with Bruce Willis,” he assures us). It’s a talent that his mother largely wants to ignore, until her top client Regis Thomas dies with the final novel in his long-running (and joyfully terrible) series unfinished. You can guess where this is going: Jamie is called in to help. But when his mother’s police detective lover also learns about Jamie’s abilities, she draws him into the case of a notorious serial killer, with terrible consequences. King is having a great deal of fun here, whether he’s sounding off about Thomas’s blockbusters, which are steamily filled with “a big hot helping of good old S-E-X” performed by “strong men with fair hair and laughing eyes, untrustworthy men with shifty eyes… and gorgeous women with firm, high breasts”, or piling on the good old-fashioned scares. Later is a horror story, but it’s also a proper thriller, told by a master of his craft.
The Eighth Girl
Maxine Mei-Fung Chung
The Eighth Girl is the first novel from psychoanalytic psychotherapist and clinical supervisor Maxine Mei-Fung Chung. It is the story of Alexa Wú, a brilliant young photographer who hides the fact she has been diagnosed with dissociative identity disorder, previously known as multiple personality disorder, from everyone except her best friend Ella, her therapist Daniel and her stepmother Anna. One of the causes of the disorder is trauma in childhood, and it soon becomes clear that Alexa’s childhood was horribly disturbed. She mostly manages her competing personalities – the “Flock”, as she calls them – well as an adult, letting various identities take “the Light” and seize control of “the Body” when it suits. There’s Dolly, forever nine, Oneiroi, dreamy and kind, fierce Runner, who comes out when Alexa needs protection, and the Fouls, who arrived shortly after Alexa’s mother killed herself. The truth of who Alexa is, and how she feels, is “safely masked and protected by all the personalities I’d hidden inside”. But then Ella gets a job at a strip club, and the pair stumble into a dangerous world of abuse and sex-trafficking in the underbelly of London. The second I finished this extremely impressive debut, I went back to the beginning and read it again: I defy anyone else to do otherwise.
Not Dark Yet
Peter Robinson
Detective superintendent Alan Banks is, incredibly, on his 27th outing in Not Dark Yet, and he has a lot to deal with this time round, from a double murder (of a crooked property developer and his aid at a luxury mansion) to his friend Zelda’s decision to find the men who abducted, raped and trafficked her in Moldova years earlier. There is a particularly poignant moment, early on, as Zelda walks the streets of her childhood, from which she was stolen as an orphan, and Banks watches his daughter Tracy get married in the Yorkshire Dales town of Eastvale: both of them looking back on their pasts, from such different places. As Banks and his team discover spy-cam videos showing a vicious rape in the home of the property developer, Zelda is out for revenge, fearful that, without it, the “past would keep growing, like a cancer inside her, consuming or blotting out all that was good in her life”. This series continues to be as thoughtful and intelligent as ever, with the usual bonus of the magnificent Dales, all “rolling hills, drystone walls, grazing sheep and flimsy white clouds snaking across a clear blue sky”. At one point, Banks’s son Brian asks him why he isn’t considering retirement – an allotment; puttering in the garden; watching too much TV – rather than the “copper’s life”. “But what else would I do?” he responds. Long may it continue.', false, TIMESTAMP '2021-01-23 01:03:40', 220, 'article', 'literature', 20);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Francesco – a baffling papal love-in', 'abs.jpeg', 'Pope Francis was recently bathed in movie love, courtesy of Fernando Meirelles’s The Two Popes, with its excellent performances from Jonathan Pryce as Pope Francis, and Anthony Hopkins as the now emeritus Pope Benedict XVI; this film sentimentally imagined a pontiff bromance between the outgoing conservative and incoming liberal. The truth might be more complicated. Before that, there was Wim Wenders’s deeply respectful documentary Pope Francis: A Man of His Word, which paid tribute to Francis’s new engagement with issues such as the climate crisis, refugees and inequality.
Now there is another docu-celebration, from the Oscar-nominated director Evgeny Afineevsky (Winter on Fire), who perhaps has had direct interview access with his subject, though it isn’t clear; there is some bland material of Francis talking to someone off-camera. As ever, the pope’s forthright and unselfconscious discussion of global issues such as poverty is impressive – he is the only world leader doing so – but, like the Wenders film, this is another baffling act of complete submission, a glossy promo video for His Holiness, with innumerable drone shots of cities worldwide, loads of Hello!-mag-style interviews with supportive friends and colleagues (but no critics), and regular screenshots of His Holiness’s tweets, including one on pollution in 2015: “The earth, our home, is beginning to look more and more like an immense pile of filth.” A somewhat unfortunately phrased or translated remark, which you can imagine some of his predecessors making in many different contexts.
', true, TIMESTAMP '2021-03-23 09:40:27', 86, 'news', 'cinema', 86);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('WandaVision finale: the Scarlet Witch arrives, will the MCU survive?', 'abs.jpeg', '‘Save Westview or save your family’
In the end it had to go this way. The marriage to Vision, the babies that arrived in episode three – Wanda could only keep these things if she was willing to maintain the lie at the cost of innocent lives. Or at least their sanity and free will.
It should come as little surprise that a show as clearly in control of its message as WandaVision makes sure to see those ideas through to the last minute, with Wanda still refusing to be pushed into any more boxes. As she fights Agatha for the Scarlet Witch power, Wanda continues to refute the idea that someone else gets to define who she is and what she should be: “I don’t need you to tell me who I am.”
Still, by the post-credits ending Wanda’s got the red headgear, the outfit (a neat reworking of the cheesecake stylings of the comics original – thankfully rejecting the emphasis on cleavage and crotch) and is leafing through magical tome The Darkhold. Agatha’s magic book is under new management, but one suspects Wanda’s not done with the conflict of “who she is” versus “what she is”. Good. More Wanda for us.
Timebomb town
WestView is free, and Wanda finally has to face up to the pain she has caused. “When you let us sleep we have your nightmares,” Dottie insists, chilling Wanda to the bone and making an uncomfortable mirror for the “controller-bully of WestView” Dottie she had been in episode two.
We had come to love this cast – sitcoms are great for making you like characters quickly, because we warm to anyone who makes us laugh – so the emotion hits. But even as townsfolk ask to “let us die” there’s a sense that everything is on fast-forward. That the finale is having to cram all its overdue business into one episode. Imagine doing this reveal two episodes ago, at the end of the Halloween story, and letting Wanda’s upset in her Modern Family episode be this much deeper and more angst-filled.
', true, TIMESTAMP '2019-03-20 19:40:03', 79, 'article', 'tv show', 63);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Band Plays On review – a celebration of songs forged in Sheffield', 'abs.jpeg', 'It begins, as a show about Sheffield only could, with I Bet You Look Good on the Dancefloor. Less frenetic than the Arctic Monkeys original, it nonetheless has its own soulful swagger and, complete with swinging Top of the Pops camera angles and rock’n’roll lighting, kicks off Chris Bush’s play with a rush of celebratory energy.
Sheffield-forged songs by Def Leppard, Moloko and Slow Club follow. Under the music supervision of Will Stuart, they borrow American styles from funk to country and are given forceful renditions by Anna-Jane Casey, Maimuna Memon, Sandra Marvin, Jocasta Almgill and Jodie Prenger. After hearing them soar their way through Don’t Let Him Waste Your Time, you could believe Jarvis Cocker was a master of the sultry soul ballad.
As every reader of John McGrath’s A Good Night Out knows, you can’t beat a rousing song to sweeten a bitter political pill. Here, the music serves to raise the temperature in between a series of monologues that sink deep into Sheffield’s industrial past.
Through the imagined voices of modern-day residents, Bush references everything from the nuclear nightmare of Barry Hines’s Threads to the election of David Blunkett. We get the Hillsborough disaster and the people’s republic of South Yorkshire. She recalls pioneers such as the Sheffield Female Political Association, the UK’s first women’s suffrage body, and Sheffield FC, the world’s first football club.
Directed by Robert Hastie and Anthony Lau, the stories become testaments to resilience, survival and change. In her family histories, Bush shows each generation being shaped by its environment, be that the paranoia of the cold war, the liberalism of Nick Clegg or the divisions of Brexit. However contradictory, these are the strands that make up a community.
What a shame then that the one thing absent is the audience. In a necessarily empty Crucible theatre, The Band Plays On is a community play in search of a community. There’s nobody there to square the circle between stage and auditorium, to acknowledge the joy of being together, of sharing a common space. It’s not just the lack of laughter for Bush’s jokes and the eerie silence at the curtain call, it’s that a play about civic identity needs people to make it complete.
', false, TIMESTAMP '2020-06-26 16:11:41', 195, 'news', 'theatre', 51);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('A Week Away – out-of-touch Netflix play for Christian audience', 'abs.jpeg', 'A Week Away, Netflix’s High School Musical-style play for the contemporary Christian teen market, feels strangely unrooted from our timeline. The musical about a week at a Christian summer camp, directed by Roman White, is ostensibly set in the present yet transparently derives its musical and choreography cues from mid-2000s Disney projects like the aforementioned series and Camp Rock, and lead Kevin Quinn looks eerily like Zac Efron circa 2009. It’s a coming-of-age (and faith) movie in which there are barely any phones to be found.
The film opens with a premise too pat and aloof to suspend one’s disbelief: wayward orphan Will Hawkins (Quinn) has stolen a cop car, among a slew of petty crimes, and the consequence? After polite arrest for running from an officer with guitar case in hand, a polite admonishment from Children and Family Services about the threat of juvie (yes, this teen is white; no, this film does not seem at all cognizant of how this plays after last summer’s protests against anti-black police brutality, or of race at all). Luckily for Will, he’s swiftly fostered by a black mother, Kristin (Sherri Shepherd), and her son George (Jahbril Cook) on the condition that he spend a week at the Christian summer camp where Kristin works.
I have no idea how such conditional fostering would work legally, but that’s beside the point in this ludicrous, grating ploy for tacitly conservative audiences. The teen fare of the Disney Channel on which it’s modeled has often required a laughable suspension of reality belief, but A Week Away, arriving a decade-plus after the High School Musical heyday, feels all the more obtuse for it. The film, written by producer Adam Powell and Gabe Vasquez, is like Camp Rock in eager, evangelical overdrive: immediately after Will agrees to attend a week of camp rather than state institutionalization, Kristin breaks into song about God’s grace and the group “follows our leader” to Camp Aweegaway (pronounced like a slurred “a week away”).
', true, TIMESTAMP '2019-11-21 07:25:18', 71, 'news', 'cinema', 74);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Picture of Dorian Gray review – the ugly face of social media', 'abs.jpeg', 'If Dorian Gray were reborn in our age, it seems entirely fitting that he would be a social media star obsessing over his image. So it makes great intuitive sense for this adaptation of Oscar Wilde’s novel to situate its protagonist in the centre of the digital whirl of 2021.
There is now no physical painting: the deal made with Basil Hallward allows Dorian eternal youth and beauty online, but age marks him in the real world, his face becoming etched with the ugliness of his accumulating misdeeds (snorting coke, catfishing and late night hookups). The pandemic is incorporated into the drama and enhances the storyline as Dorian wears his mask to cover his ageing face.
The inversion is an intelligent way to bring new resonances to the Victorian notion of the split self in Wilde’s novel; here, the fracture is between the real versus the digital self rather than the Christian notion of the good and bad, even though Fionn Whitehead’s Dorian – guileless but a little too grounded to buy into the bargain with Basil (Russell Tovey) – sells his soul too quickly.
This production is created by the team behind the recent adaptation of Jonathan Coe’s What a Carve Up!, which was a highlight of the lockdown last year, and it contains some of the same ingenious techniques in reimagining theatre on screen. The effects are not quite as exhilarating, and the pace is slower, though the story is full of imagination. A co-production between five theatres (the Barn, Lawrence Batley, New Wolsey, Oxford Playhouse and Theatr Clwyd), the quality of the production is as slick and refined as a Netflix drama, and it feels much more straightforwardly like a film than theatre-on-film.
', false, TIMESTAMP '2019-03-24 10:35:26', 204, 'article', 'theatre', 10);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Spiral recap: season eight, episodes nine and 10 – the finale', 'abs.jpeg', 'The laundromat murder
The central conflict is clear early. While CID spend most of their time trying to keep Gilou out of prison, he is equally determined to land himself back there. Every crime he commits this week (and it’s an impressive list) he does as a private citizen, without official sanction, thanks to the squirrelly Judge Vargas. Souleymane’s body showing up raises the stakes for everyone, and, when the heist is moved forward a week with Gilou promoted from wheelman to gunman, a chaotic dash to the hotel ensues. A riotous cops-and-robbers shootout leaves François dead, and Titi and Ahmed in custody, while Cisco takes Gilou for some unscheduled R&R at Titi’s foster home. He’s had better getaways.
From then on, CID really come into their own. Their genius for calling in favours, greasing legal gears and witness intimidation – finely honed over 15 years – shines like a bag of conflict diamonds. Ahmed, safely in custody, is ready to sing like a canary about the crooked cop Escoffier, so instrumental to the caper. Laure and Ali have a counter-offer: keep Gilou’s name out of your filthy mouth and we won’t charge you with child murder. Ahmed’s singing career comes to an abrupt halt. There are stunning assists from Edelman and Lucie, who run interference on Vargas, appealing to his naked careerism. Monsieur le Juge passes the case on to the Cergy prosecutors – et voilà! – Gilou is in the clear. If the system seems bent that’s because it’s so flexible.
From there, they just have to find and extract the errant Escoffier. Laure tricks Bilal into giving up Titi and the foster home address, then risks everything to go there ahead of the armed strike team to give him the heads-up. Although she is briefly taken hostage by Cisco, it winds up with him dead and Gilou free to scarper on foot before some non-corrupt police arrive. Titi is on the hook for the two child murders – Souleymane and Amin. In the end, they got their man. They usually do.
', true, TIMESTAMP '2019-10-17 16:02:29', 36, 'article', 'tv show', 59);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Ammonite – Kate Winslet and Saoirse Ronan find love among the fossils', 'abs.jpeg', 'The open secret of Victorian sexuality is rediscovered by film-maker Francis Lee in this fine, intimate, intelligently acted movie about forbidden love in 1840s Lyme Regis. But it isn’t exactly a tale of two French Lieutenant’s Women, despite the inevitably tense walk up the fabled Cobb, filmed in thoughtful longshot. The complicated power balance between the principals makes the comparison incorrect. Actually, the film that swam into my head afterwards was Jane Campion’s The Piano.
Ammonite is an absorbing drama that sensationally brings together two superlative performers: Saoirse Ronan and Kate Winslet. Combining these alpha players doubles or actually quadruples the screen voltage, and their passion co-exists with the cool, calm subtlety with which Lee inspects the domestic circumstances in which their paths crossed. It is a film about a real-life relationship speculatively reimagined with some artistic licence. But I have to say that – paradoxically – the figures of this bodiced and bonneted movie, despite being based on real life, seemed a tiny bit less real than the fictional figures of his previous film, God’s Own Country. Yet they’re just as passionate.
The heroine is Mary Anning, a pioneering 19th-century palaeontologist whose ideas and extraordinary fossil finds in Lyme Regis were coolly appropriated by the male scientific establishment from whose societies and clubs she was excluded, and probably had to put up with mediocre, mutton-chopped ninnies treating her as an eccentric amateur. The real Anning took comfort in her close friendship with fellow geologist Charlotte Murchison, whose own expertise seems to have equalled and predated her husband’s.
', true, TIMESTAMP '2019-02-15 15:12:09', 189, 'article', 'cinema', 5);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Oh Woman! review – much-needed tribute to six extraordinary women', 'abs.jpeg', 'This year, the week of International Women’s Day has coincided with an urgent renewal of rage against misogyny, violence and intimidation. We need this rage. We need space for women to share their stories of harassment and assault, and to push for action against gender-based violence. But we also need spaces for joy, celebration and love. The Royal Exchange theatre’s new series of short online audio works, paying tribute to ordinary and extraordinary women, seeks to create this sort of space.
“Who decides who deserves to be seen?” This is one of the many questions posed in Channique Sterling-Brown’s The Lady with the Spark, a tribute to the remarkable life and work of British-Jamaican nurse Mary Seacole. In each of the six pieces that make up Oh Woman!, the commissioned artists make visible – or should that be audible? – female figures who have been forgotten, marginalised or unsung. Some of these are quiet, everyday heroes: mums, sisters, grandmothers. Others are women from history who, like Seacole, have been minimised in or erased from official tellings.
Across all these bite-sized audio celebrations, there is a sense of conversation. Rebecca Swarray’s contribution is just that: a lively chat with Manchester-based queer activist Chloe Cousins, framed by the inspirational voices of Audre Lorde and Jackie Kay. Other artists speak across time and over the chasm between life and death. Becky Wilkie addresses 19th-century poet and painter Elizabeth Siddal, reclaiming her as an artist as well as a muse, while Gemma Langford’s The Last Cunning Woman of Timperley conjures up her beloved nan. In Sterling-Brown’s multilayered performance, Seacole speaks back, offering strength for current fights to end structural inequality and recognise the undervalued heroes of past and present.
', false, TIMESTAMP '2021-02-08 19:38:45', 89, 'review', 'theatre', 5);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Plain Bad Heroines by Emily M Danforth – an American horror story', 'abs.jpeg', '“I wish some one would write a book about a plain, bad heroine so that I might feel in real sympathy with her,” wrote the North American memoirist Mary MacLane in 1902. Plain Bad Heroines wears its debt to MacLane on its sleeve, starting with an excerpt from her teenage confessional The Story of Mary MacLane, and then repaying that debt with not one, not two “plain bad heroines”, but a whole cast of them, scattered across the 20th and 21st centuries, doing their bad deeds from Rhode Island to California and back again.
Why those places? Because they’re the twin capitals of American horror, birthplaces respectively of HP Lovecraft and his nightmare derangements (one of Danforth’s chatty footnotes points out that the inscription on Lovecraft’s gravestone is “I am Providence”, Rhode Island’s state capital), and the slasher movie. And Plain Bad Heroines is a horror novel, a proper one: a big fat doorstep of super-queer terror that never runs out of ways to keep you deliciously disturbed.
In the early 19th century, MacLane’s (real) book reaches Rhode Island’s (fictional) Brookhants School for Girls, where its scandalous mix of sapphism and ego inspires the formation of a Plain Bad Heroines Society. But then two of the club’s members are killed by a freak swarm of yellowjacket wasps, one of their admirers dies strangely, and after that things get weirder still at Brookhants (pronounced “Brook-haunts”, a pun which the narrator disowns with winning chutzpah: “I cannot help that the school’s name is Brookhants and that it’s said to be haunted”). The relationship between principal Libbie Brookhants and her dear companion Alexandra Trills is tested beyond natural limits.
Those events entangle three more Plain Bad Heroines in the present day. There’s Merritt Emmons, a one-time wunderkind who wrote a dazzlingly successful book called The Happenings at Brookhants when she was 16, and has entered her early 20s with nothing more to show but writer’s block. (She’s been toying, futilely, with a continuation of Truman Capote’s unfinished novel Answered Prayers.) Happenings is now being turned into a film, produced by and starring the world’s hottest “celesbian” Harper Harper (her name is explained but I won’t spoil that here); the descriptions of Hollywood presumably draw on the adaptation of Danforth’s 2012 bestselling YA debut The Miseducation of Cameron Post.
And cast alongside Harper, there’s Audrey Hall, a young actor following unsteadily in the footsteps of her scream queen horror-star mother. Happenings is Audrey’s chance for a big break, so when the director explains that he wants her to conspire in creating a behind-the-scenes found-footage movie in which Merritt and Harper will be unwitting co-stars, she reluctantly agrees.
That brings our trio to Brookhants, and this is where things start to get really creepy. Which events are being orchestrated by the director, and which are legitimately supernatural? Could there really be a curse on Brookhants, and if so, when did it begin? With the deaths of the girls, with the tensions between Libbie and Alex, or with MacLane’s book, which seems to trail destructive passions wherever it’s found? Perhaps the trouble started earlier, when the Brookhants family home was built around an old folly known locally as “Spite Tower”, after a legend that it was erected to settle a score between two brothers by blocking a favoured view.
Danforth braids the layers of narrative together with expertise. She’s clearly a horror buff: besides Lovecraft, there are explicit nods to Blair Witch, Peter Straub, Berberian Sound Studio, M Night Shyamalan, The Omen and innumerable others. Another writer might have let the metatext choke the dread, but Danforth uses it to thrillingly corrode the reader’s own sense of reality: a recurring nightmare theme has the characters discover, or maybe hallucinate, that solid objects are made of the wood-pulp substance of the yellowjackets’ nest. Made of paper, in fact.
MacLane aside, there’s perhaps no writer with a stronger presence in Plain Bad Heroines than Shirley Jackson. Malevolent tower in sinister mansion? Fraught intimacies between women? Hello, The Haunting of Hill House. But while horror has historically drawn its evil life from repressed sexuality, Danforth wants more than frustration for her heroines. Merritt laughs at Harper for suggesting Brookhants was “planet lady love” – these girls, explains Merritt, got a brief season of fooling around before being forced into straight society as wives.
What if that wasn’t inevitable? Death and misery were once the only imaginable outcomes for a lesbian or bi woman in fiction, but that isn’t so today. What if she could create her own world? Plain Bad Heroines is that creation: in this novel, everything that happens, happens between women. I’m not even sure there’s one conversation between two male characters – whatever the reverse of the Bechdel test is, Danforth defiantly flunks it. Her novel is beguilingly clever, very sexy and seriously frightening.', true, TIMESTAMP '2019-10-06 15:31:36', 78, 'article', 'literature', 83);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Doctor Who new year special recap – Revolution of the Daleks', 'abs.jpeg', '“I’d rather not have met her. Because having met her, and then being without her, that’s worse”
Let’s get the Judoon in the room out of the way. That episode was no Robot of Sherwood, Jo Patterson was no Harriet Jones, and I’m no Dan Martin. All of us at the Guardian were devastated to lose Dan in 2020, but we didn’t want the festive special of Doctor Who to pass without giving you a chance to pay a tribute to him, or to discuss a New Year’s Day special that was … well … uneven at best.
The episode followed far more directly from Resolution than anticipated, but it was an extremely long slow burn of a setup before it got going. Harriet Walter played Prime Minister Patterson as cold and calculating, but nevertheless ended up the second British PM exterminated by the Daleks in recent years. It’s becoming quite the occupational hazard if you’ve been in No 10.
As Leo Rugazzi, Nathan Stewart-Jarrett played the latest in a long line of misguided scientists and geniuses in Doctor Who who end up duped and controlled by the alien technology they are messing with.
I think we all expected it would be Captain Jack who rescued the Doctor from space prison. I’m not sure anybody had “and then they zorb their way out” on their bingo card, though. John Barrowman was charming and good value as ever, with precious little explanation of what he’d been up to in the years since we last saw him, but some lovely throwback gadgets. Someone should give him his own series, eh?
“If you’re dealing with Daleks, you are way out of your depth”
Having said that, while the pre-publicity may have focused on the return of Barrowman, for me it was Chris Noth’s business monster, Jack Robertson, who stole the show.
Criticised as being a too-thinly concealed Donald Trump cipher in his first appearance, here he got more depth – even if still a cynical manipulator of events happy to sell the human race out to the Daleks.
His timely deadpan of “This is why people don’t like experts” raised a genuine laugh, and the episode’s conclusion, where despite everything he managed to position himself as a saviour of the planet heading back for the political big time, seemed frustratingly familiar to the consequence-free behaviour of certain real-world politicians.
', false, TIMESTAMP '2020-07-23 00:09:12', 51, 'article', 'tv show', 14);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Memories of My Father review – deeply felt memoir of Medellín’s public-health champion', 'abs.jpeg', 'Javier Cámara is the Spanish actor with the gentle, open, everyman face who has been a stalwart repertory player for Pedro Almodóvar for around 20 years, particularly in the mysterious and beautiful 2002 film Talk to Her; Cámara unforgettably played Benigno, the nurse tending to a young woman in a coma, believing that he must always talk to her. Now he gives a wonderful richness and warmth to this very affecting movie, directed by Fernando Trueba; it is based on the true story of Héctor Abad Gómez, the Colombian public-health activist and prominent government critic who in 1987 was shot dead in Medellín by far-right paramilitaries. It is adapted from the 2005 memoir of Gómez by his son, the now prominent Colombian author Héctor Abad Faciolince, entitled El Olvido Que Seremos (which is the movie’s original Spanish title), meaning Forgotten We’ll Be. (It is taken from the Borges poem, The Epitaph: “Already we are the oblivion we shall be.”)
Cámara plays Gómez, the professor, husband and father to a lively and talented family of mostly girls, and one somewhat pampered son: Hector, played by Nicolás Reyes Cano as a moon-faced boy and then by Juan Pablo Urrego as an earnest, bespectacled literature student. Gómez is adored by his family, by his students and by the local community in Medellín, in whose streets he is an inspiring figure, striding around proselytising for what he calls the five basic human rights: air, water, food, shelter and affection. But he is continuously harassed by the authorities for these progressive views, and forced to take an evasive sabbatical abroad at one stage and finally early retirement. The movie has “present-tense” scenes in the 1980s, shot in black and white, but Hector’s ecstatically remembered 1970s childhood is shot in sunlit colour.
', true, TIMESTAMP '2020-07-23 00:09:12', 282, 'review', 'cinema', 18);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The best recent crime and thrillers', 'abs.jpeg', 'The titular dwelling in Melissa Ginsburg’s second novel, The House Uptown (Faber, £12.99), is the New Orleans home of boho artist Lane. Her slow drift into dementia on skeins of marijuana smoke is interrupted by the arrival of her granddaughter Ava, whose mother, Lane’s daughter Louise, has just died. The resourceful 14-year-old soon begins to wonder not only about the cause of the long estrangement between her mother and grandmother, but also about the behaviour of Lane’s assistant, the apparently loyal Oliver. Told as a time-slip – the roots of the alienation date back to 1997, when teenage Louise witnesses the 2.30am arrival of Lane’s local politician lover, blood-covered teenage son in tow – this is a superbly written, intriguing character study of how the past impacts on the present.
Smirnoff’
The sins of the fathers are visited appallingly on the children in the first book of Karin Smirnoff’s Jana Kippo trilogy, My Brother (Pushkin, £12.99, translated by Anna Paterson). When Jana returns to her childhood home, a grim village in northern Sweden, she finds her twin brother Bror in the process of drinking himself into an early grave. It’s hardly surprising: their father beat his family and raped his daughter, and their devoutly religious mother accepted their collective fate as the will of God, and relieved her feelings embroidering doomy biblical messages, while the neighbours looked on and did nothing. Jana’s lover John may have killed his wife, and the majority of the villagers seem as harsh and merciless as the weather, harbouring long-held grudges but essentially helpless in the face of each other’s cruelty and betrayal. There’s no conventional investigation here, but chinks of light appear as secrets are revealed and Jana begins to come to terms with the past. My Brother is challenging, certainly, and not for the squeamish, but the fragile, sardonic Jana is a distinctive narrator, and if you can relax into the writing style (no capital letters except at the beginnings of sentences and the constant running together of words), it’s well worth the read.
Dangerous Women
There’s more embroidery, this time a neatly sewn death threat, in Dangerous Women (Michael Joseph, £14.99). Author Hope Adams has skilfully patched a murder mystery into a historical event – the 1841 voyage of the convict ship Rajah from London to Van Diemen’s Land (now Tasmania), during which the cargo of female prisoners created a quilt for the governor of their new home. The narrative tacks between past and present as we learn about the lives of the (fictional) transportees, the majority of whose crimes have been committed out of dire necessity, and of the (real) matron, idealistic young Kezia Hayter, who presides over the sewing and, when one of the women is stabbed, helps to find the culprit. Masterful plotting, well-drawn characters, and a plausible balance of despair for what was left behind and optimism for what lies ahead add up to an immensely satisfying read.
A Fine Madness
Alan Judd’s latest novel, A Fine Madness (Simon & Schuster, £14.99), is another well-researched splice of fiction and historical fact, focusing on playwright Christopher Marlowe, whose death in 1593 – a fatal stabbing in a Deptford tavern – has been the cause of much speculation, as has the extent of his work for Elizabeth I’s spymaster, Francis Walsingham. Here, Thomas Phelippes, a real codebreaker and sometime right-hand man to Walsingham, is languishing in prison some 30 years later when he puts quill to parchment at the request of King James, who – for reasons unknown to Phelippes – has asked for an account of the dead man. There follows a vivid and credible tale of espionage, dissent and intellectual discourse, with the past brought to teeming, pungent life at a time when religion loomed large and the threat of death, from both human and nature, was ever present.
Lie Beside Me
Gytha Lodge’s third DCI Jonah Sheens novel, Lie Beside Me (Michael Joseph, £12.99), kicks off with what has to be the blackout drunk’s worst nightmare: waking to find a stranger’s corpse in your bed. Louise Reakes remembers going to a club, but most of the evening has fallen through a trapdoor in her memory; now she has a blood-soaked mattress and an unknown dead man on her hands as well as a thumping hangover. By the time Sheens and his team arrive, the body has been relocated to the front garden, but although Louise is the prime suspect, it soon becomes clear that both her best friend Amber and her husband Niall have things to hide, and the dead man isn’t quite what he seems, either … Secrets and self-sabotage abound in this gripping psychological thriller.
A Rage in Harlem
Lastly, Penguin Modern Classics is reissuing five novels by black American writer Chester Himes (1909-84) featuring hard-boiled detectives Coffin Ed Johnson and Grave Digger Jones. Starting with A Rage in Harlem (£9.99, originally published in 1957), these wholly original, occasionally disorienting and sometimes surreal books are a must for all crime fiction aficionados.', true, TIMESTAMP '2020-10-18 02:21:02', 240, 'news', 'literature', 90);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Aisha (the black album); Putting a Face On review – more pointed monologues', 'abs.jpeg', 'The Old Vic has been acute with its monologues: not too musey, all pointed. Taken together, these two new pieces of writing, commissioned for International Women’s Day, last barely half an hour, but they deliver resonant stories. They are also a nudge towards the slowly changing face of theatre: at last it is being taken for granted that an authoritative voice, an everyman, may be a woman of colour.
Regina Taylor’s Aisha (the black album), directed by Tinuke Craig, is a sprint drawing on a long history. In jeans and leather jacket, Jade Anouka, one of the most fiery and dancing of actors, whips through horrific scenes of American life, from lynching to the storming of the Capitol, telling of “a systemic poisoning of marrow and mind”.
Kiri Pritchard-McLean’s production of her own Putting a Face On unwinds with subtlety. Susan Wokoma is making up her face – makeup is a good theatrical device as it is what the stage does. She chirrups about her new tiger-faced bathmat, which her boyfriend doesn’t like: “He’s right – it does look boss-eyed.” In a clever piece of self-reflection, she chats about a woman she has watched online discussing grisly murders while demonstrating makeup; she reports that her boyfriend has depression and thinks she is one of the causes. She may be applying concealer to her cheekbones, but slowly the truth of what is happening to her seeps out.
', false, TIMESTAMP '2020-01-04 20:08:50', 175, 'review', 'theatre', 74);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Mandalorian recap: season two, episode eight – not your average finale', 'abs.jpeg', 'Hidden deep within a distant subreddit, someone will have predicted precisely what happened in this episode. But it certainly caught me by surprise. A superbly paced and structured finale culminated in the biggest cameo of the series to date as Luke Skywalker slashed his way through a platoon of Darktroopers to reach Grogu and take him under his wing.
The final image of the season is of the door closing on Luke, Grogu and a cheery R2D2 as they head off into deep space to party with some Porgs. Our current hero, meanwhile, is left with nothing. Din Djarin’s whole reason for doing, for getting into his armour in the morning, has been taken away. He wants to keep hold of his kid (“He doesn’t want to go with you”, Mando says, trying it on with Luke), but he can’t.
This is not how a season usually ends. You tee up the next adventure, tease the return of a villain or an extra unexpected complexity, something like that. But in a display of confidence from the show’s creator, Jon Favreau, who wrote this episode, The Mandalorian offers nothing of the sort. There’s a half-commitment to fighting a civil war on Mandalore, a potential feigned duel for the darksaber, but that’s it. It’s all a bit of a downer.
When Din Djarin removes his helmet to show Grogu his face before they say goodbye, he looks beaten, haggard almost. Compare that with the retrofitted clean cheekbones of the Skywalker (CGI can truly take years off you) and you are reminded that our hero is an everyman. An everyman with exceptional fighting ability and a strong moral code, but still. He’s not a chosen one like Skywalker, or Grogu or even Bo-Katan. His job is to complete tasks to allow others to flourish. Without a task, what is he?
Anyway that’s probably a bit chinstrokey, but I wanted to get it down. To get to my next point I must quickly return to conventional recapping, reminding you all that this episode begins with a cleverly faked space chase that allows Mando and a team of female enforcers to crash a landing shuttle right down Moff Gideon’s launch tube.
The mission from then on is straightforward: the women will blast their way through a metric tonne of stormtroopers as a distraction, while Mando goes to deactivate the darktroopers and rescue the kid. He thinks he has achieved the first bit when he boots the robots out of an airlock and, after a brief battle with old man Moff (beskar lance v darksaber is a fair fight, it turns out), he unlocks the second achievement too. All done and dusted. With ... er ... 20 minutes still to go.
I loved this pause in the story. We’re all used to watching a drama, thinking it has been resolved but suspicious that it has not been. But in this moment of calm my brain began to spin as I tried to guess what would happen next (and it had to be something, there was so long left). I thought Moff had a plan up his sleeve, but actually he was the rather ineffectual villain that his fight with Mando had exposed him to be. Then the darktroopers turned up again and I thought OK, this is a fight but one that our team will win. As the troopers then got into formation and slowly, slowly pounded their way through the door of the deck, I started to reconsider my opinion.
And just as I did that, the X-wing starfighter arrived. What a brilliant moment. A plot twist just as you’re on tenterhooks waiting for another part of the story to be resolved. After that, a minute of craning at the screen, trying to look behind the lightsaber flashes to see who it might be (I guess the colour gave it away, but not definitively). Finally, a sweetly choreographed slash-a-thon.
That’s how you do it. Just to take the edge off, the next requirement was that you watch an animated, rejuvenated Luke struggle to sync his lips with his dialogue. But heck – you can’t have everything. Luke’s aura is enough to communicate a strong message to our crew – you are heroes, but I’m the icon. And soon enough, he was gone.
EASTER EGG NEWS Written after the final whistle and at the request of you the reader, a quick nod to the fact that we get a little advert for something called ‘the Book of Boba Fett’ after the episode’s closing credits. In the clip we see Boba and Fennec Shand enter the palace (read: dirty hovel) of Jabba the Hutt once more. In Jabba’s throne sits his former second-in-command Bib Fortuna, now holding his own slaves and planning his own nefarious deeds. Or at least he was doing that, because Shand frees the slave and Boba blasts Bib dead before taking his seat. Say hello to our little friend Boba, crime lord? We shall find out at the end of next year.
', true, TIMESTAMP '2019-11-06 18:16:30', 184, 'review', 'tv show', 3);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Gurrumul, Omar Souleyman, 9Bach and DakhaBrakha: the best global artists the Grammys forgot', 'abs.jpeg', 'This week I wrote about the glaring lack of international inclusivity in the Grammys’ newly redubbed global music (formerly world music) category.
In the category’s 38-year history, almost 80% of African nations have never had an artist nominated; no Middle Eastern or eastern European musician has ever won; every winner in the past eight years has been a repeat winner; and nearly two-thirds of the nominations have come from just six countries (the US, the UK, Brazil, Mali, South Africa, India). The situation shows little signs of improving.
Over the past decade, I’ve produced more than 30 albums from overlooked regions, languages and persecuted populations; one won a Grammy (Tinariwen), and three others have been nominated. My two latest books (How Music Dies, Silenced by Sound) detail inequity in the global music industry, and the vast numbers of people around the world who have been overlooked, despite being every bit as, if not more, talented than the stars who dominate the global mainstream.
Below are 14 of them, all from nations or regions that have never had a single artist receive a nomination in the Grammys’ global category, an award whose stated aim is to celebrate “excellence” in music versus sales or popularity. Many of these artists are legends in their home countries. That two have now died, and many others are of advanced age, speaks to the urgency of the matter.
', false, TIMESTAMP '2019-06-25 16:25:20', 269, 'review', 'music', 28);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Bright Burning Things by Lisa Harding – gripping quest for self-knowledge', 'abs.jpeg', 'Like Masha in The Seagull, Sonya, the heroine of Lisa Harding’s intense and unnerving second novel, is in mourning for her life. Her Chekhovian name seems apt when we learn that “failed actress, failed mother” Sonya once triumphed in productions of Chekhov and Ibsen on the London stage, before finding herself singlehandedly bringing up her four-year-old son Tommy in the Dublin suburbs, battling alcohol dependency. There’s a lot to lament, and even more to rail against, in a novel that becomes a ferocious jeremiad against life’s suffocating forces.
After an eye-watering opening scene in which Sonya leaves her son on Sandymount strand while she takes a swim in her underwear, then returns home to sink a bottle of white wine before blacking out while cooking fish fingers, her father stages an intervention. The result is a stay in rehab, during which she suffers a heart-wrenching separation from Tommy, with no guarantee she’ll regain custody. While resisting the 12-step program, she’s forced to reflect on how complicit she’s been in her own catastrophe: “I think of all the tall tales I spun in school … Was I, even then, destined for this?” Later, there’s the poignant admission: “I just wish I could do life, in the ordinary sense.”
Only the appearance of David, a solicitor, trained counsellor and former addict, offers Sonya any hope of rising from the ashes of her life into a future that might contain love and family. Yet she’s only too aware, to use Larkin’s phrase, that man hands on misery to man. Observing her fellow recovering addicts, she notes with a shiver: “These men, their lives seemed inevitable, their destinies charted from the moment they were born to their crackhead fathers, criminal mothers, junkies, alcos, selfish, stunted, addled parents. Like me. These men were born to mothers like me.”
It’s moments of sobering clarity such as this, and their promise of a redemptive ending, that carry the reader through so many harrowing pages of self-evisceration. While comparisons have been made between Sonya and Agnes, the alcoholic mother in Douglas Stuart’s Booker-winning Shuggie Bain, Harding’s protagonist is a singular creation: complex, contrary, drily funny in a characteristically Irish fashion. Written with great energy and generosity, Bright Burning Things is the raw and emotional story of a woman’s search for self-knowledge; one that grips from the beginning.', true, TIMESTAMP '2019-09-06 23:56:52', 63, 'article', 'literature', 3);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('This week’s new tracks: Willi Carlisle, Greentea Peng, Jorja Smith', 'abs.jpeg', 'Willi Carlisle - The Grand Design
The Grand Design is not a tribute to the barely masked eye-rolls of Kevin McCloud as a middle manager from Exeter tells him they’re going to project-manage their own build, but a plaintive banjo ballad from the greatest Americana artist you’ve never heard of. A storytelling titan in triple denim, Arkansas native Carlisle delivers this razor-sharp musing on mortality with heart, guts and spirit. Proof that there’s much more to the Ozarks than a daft Netflix series.

Greentea Peng - Nah It Ain’t the Same
The immaculate video for Nah It Ain’t the Same is proof that Greentea Peng is living the Gen Z dream. It’s all there: the face tats, a proliferation of house plants, a perfectly angled cowboy hat and a massive spliff. Peng’s trip-hop-infused bullshit detector of a tune also fits the zoomer bill, placing her at a knowingly retro sweet spot somewhere between Neneh Cherry and Chet Baker.

Jorja Smith - Addicted
Making a breakup seem like the most enthralling thing in the world is just one of Jorja Smith’s many powers. A blissed-out dive into the knotty weeds of a toxic relationship, this is manuka honey for the soul. In other words, it feels impressively expensive, is just about sugary enough and will, when applied liberally to your bad bits, allegedly cure all ills.
', true, TIMESTAMP '2021-02-04 06:20:20', 78, 'news', 'music', 49);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Bafta diversity scheme participant says casting director made racist comments', 'abs.jpeg', 'A scheme set up by Bafta with the aim of improving diversity in the film and TV industry has come under fire from one of its former participants, who said she had experienced racist comments and a lack of promised disability support.
India Eva Rae, who joined Bafta’s Elevate programme in 2019, told the BBC that a casting director told her she was an “exotic talent”, and that they “can’t understand the English coming out your mouth”. Rae also said that she had been told not to report the incident by a “mentor” on the scheme: “This mentor told me and other members of the group that we will never work again if we speak up.”
Bafta CEO Amanda Berry said in response that the organisation “was aware that [Rae] had had a negative experience with a casting director, as they mentioned it in passing … but we are not aware that this happened as part of the Elevate programme.” The BBC also report that Bafta said it had not received any complaints about either incident, but that if it had, they would have been taken extremely seriously.
Rae also said she had difficulties accessing disability support.
Rae was selected in 2019 for Bafta’s Elevate programme after featuring in the Channel 4 anthology series On the Edge. Elevate was set up in 2017 and is described by Bafta as “a new bespoke annual programme that aims to elevate individuals from under-represented groups to the next stage of their career”. It was one of a set of initiatives introduced by Bafta to increase diversity in the film and TV industry, alongside changes to eligibility for its awards and membership process. Bafta recently joined the the BFI to relaunch a programme to combat bullying, harassment and racism in the screen industries.
Berry added: “It is a matter of great sadness and regret for me that anyone would feel this way, and our door remains completely open to find a solution, and to ensure that every participant benefits from the scheme.”
“I know that other participants have found this to be a truly fantastic opportunity.”
In a statement to Deadline, Bafta said: “Bafta condemns bullying, harassment, racism and discrimination of any kind and we take allegations of this nature incredibly seriously and will investigate urgently. We go to great lengths to ensure our programmes are as inclusive and accessible as possible for everyone who takes part, whatever their specific support needs are, and have responded to and want to resolve the participant’s requests in this area.”
', false, TIMESTAMP '2019-04-02 17:14:07', 298, 'news', 'cinema', 83);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Lovecraft Country recap: season one, episode nine – the Tulsa massacre sets stage for gripping finale', 'abs.jpeg', 'You often get the sense, watching Lovecraft Country, of a show that knows tomorrow is never guaranteed and a second season is even less bankable. These guys are determined to give it their all in whatever time remains. To that end, we have had a haunted house episode, an Indiana Jones-esque episode, body-swapping, erotic K-horror and afrofuturism meets The Jetsons. This week, though, it was time to go back to the future in Hiram’s time machine. Sorry, make that “multiverse machine”. We stand corrected, Hippolyta.
Yes, Hippolyta (Aunjanue Ellis) was back. How could she remain absent when her daughter Dee (Jada Harris) was at death’s door following last week’s run-in with that Capt Lancaster-conjured Topsy. We didn’t find out where she had been all this time and my hunch is we probably won’t. There is already so much to catch each other up on. At least Hippolyta didn’t require any long-winded exposition, because, after her mind-expanding interdimensional voyage, she knows it all already. (Didn’t I say waaaaay back in the episode four recap that they were foolish for underestimating this woman?)
Still, Hippolyta’s return didn’t come soon enough to save Tic from discovering the truth about his parentage. When Christina (Abbey Lee) instructed them to use the blood of Dee’s closest relative in the restoration spell, Montrose was forced to confess that Tic might actually be Dee’s half-brother and not her cousin; that is, George’s biological son and not his.
Meanwhile, the hunt for the Book of Names was on – it was the only way to permanently save Dee – and with Capt Lancaster dead and his pages destroyed following last week’s shoggoth attack, the only route to securing it was to go back in time to the book’s last known whereabouts: Tulsa, Oklahoma, 1921 (I have lost interest in Christina’s revenge plot on Lancaster, suffice to say that, first, it worked and, second, performing transplant surgery without proper sterilisation is a terrible idea).
Now, you may wonder why it was necessary to go back to the exact date of the Tulsa race massacre, a real historical event in which hundreds died and an estimated $32m-worth of mostly black-owned property was destroyed? Why not a few days before, when the Book of Names would still have been in the same place and it might have been less dangerous to retrieve it? A reasonable query, but who dares question the wisdom of Hippolyta? As she herself said: “It was on Earth 504 and I was there the equivalent of 200 years on this Earth. I could name myself anything, infinite possibilities, that came with infinite wisdom and I’m gonna use of all of it to save my daughter. Now get in the fucking car.” Personally, I had my seatbelt on before she had got halfway through the first sentence.
Speaking of powerful women, what are we thinking regarding Christina? Ruby “daughter of a hustler” Baptiste (Wunmi Mosaku) seems to trust her, even urging her sister, Leti, to do the same, but I am not buying it. Tulisa’s 2012 album The Female Boss had a more coherent feminist philosophy and openly planning to murder Tic in order to secure her immortality seems like a red flag, no? Ruby, once again, I am asking you to reconsider your terrible taste in women.
', false, TIMESTAMP '2019-04-01 03:51:44', 62, 'news', 'tv show', 41);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('RuPaul’s Drag Race recap: season 12 finale – she’s a winner baby!', 'abs.jpeg', 'This has certainly been one of the most interesting and unique seasons of Drag Race ever. Not since the heady days of Willam proudly vomiting off the runway have we had such a memorable ride. The guest judge calibre has been higher than ever (“he’s a dinosaur doctor!”) the contestants have been possibly the most talented crop and, in terms of the general progression of the show, things have been messier than ever.
As if Sherry Pie-gate weren’t enough, the “cursed” 12th season has now been hit by the shadiest queen ever to grace our world stage, Miss Rona. But they haven’t let this stop them. In true 2020 style, this week’s final has been put together via a wifi-defying combination of video chat, special effects and lots of clever editing. Our three finalists are Jaida Essence Hall, who’s natural destiny in life is to wear ballgowns and be fanned by men holding palm fronds while eating grapes; Gigi Goode, the devil in an a-cup, robotic glamour personified; and Crystal Methyd, somewhere between club kid elegance and an extra from Luc Besson’s Fifth Element. So let’s go!
Bring back. My girls.
First, we get a recap of all the girls from season 12. Dahlia Sin’s on a roof! Careful, Dahlia. Aiden Zhane’s looking great but her back garden needs a trim. No, that’s not a euphemism. We think Aiden’s actually going to do very well out of this. She’s got the kind of kooky outsider vibe Drag Race fans love. Meet and greets with lots of tattooed people in polka dot dresses. Opening for Rob Zombie at Download Festival. We can see it now.
Next we go to the three finalists and Crystal Methyd is wearing possibly the most avant-garde outfit ever to be seen on Drag Race. An actual, fully-functioning pinata, reminding us of one of our favourite Drag Race drinking games; is it cultural appropriation, or is it just high concept?! Either way, she’s half Mexican so she’s allowed. God, we’re tired.
Gigi Goode is stunning as always in a crushed blue velvet Madonna homage. Speaking of Madonna – we’d like to address her directly. Madge. Have you heard Lady Gaga’s “Babylon” yet? If you haven’t, don’t listen. It’s just not worth the aggro. Stick on Schitt’s Creek and have a Twix instead.
Jaidia Essence Hall is here, and she’s ALREADY wearing a crown. The audacity is palpable, but Jaida has always been audacious and that’s why we love her. Next, “almost live, from his panic room in the Hollywood Hills”, it’s RuPaul! And he’s ... not ... in ... drag. He wasn’t last week either. We have a controversial theory about this. Social distancing of course means that he can’t have his usual hair and makeup squad flitting around him. Maybe ... he’s ... FORGOTTEN HOW TO DO HIS OWN MAKEUP? That’s pure conjecture of course. Please don’t sue the Guardian, RuPaul.
He reveals that this episode will entail three competitive lipsyncs. First, a three-way close-up lipsync where it’s, presumably, all about the lips and getting the lyrics right. Then, a lipsync from home, with each queen choosing a song they feel represents them, complete with homemade backgrounds (this is a great idea) and finally, the top two queens lipsyncing against each other. We head to Carson, Ross and Michelle – Carson’s home is gorgeous. Books, pianos and drinks everywhere!
Next we get some video chat from Whoopi Goldberg and she says “as an entertainer, there are times when we are really necessary ... where no-one can do it better than we can. I think this is one of those times.” Whoopi is right. What entertainers do cannot be replicated. They are having a very tough time during the pandemic. Nightlife and theatre culture have been decimated, it’s impossible for performers to work right now, and performers need to work to survive, not just economically but mentally.
Have a think of all the times you’ve yelled with joy and laughed until your sides hurt, while someone fabulous has been on stage in front of you. Much of our culture wouldn’t exist without performers. Drag Race wouldn’t exist without performers. This column wouldn’t exist without performers. If you know any performers, drag or otherwise, show them as much love as you can right now. That’s all.
Crystal Methyd
Not for the first time this season, we’ve entered unprecedentedly surreal territory for Drag Race. RuPaul is inside a giant eyeball, videocalling Crystal, who’s painted completely pink. If you pause it, it looks like a student art project (second year). We get a cute video message from Crystal’s parents. Her dad says her non-english-speaking grandma records the show and gets the family to translate what she’s saying. We’re not crying, YOU’RE CRYING! (Btw Crystal’s grandma, if you watch it on Netflix you can have subtitles, less of a faff, just saying).
', true, TIMESTAMP '2019-10-29 07:27:12', 294, 'review', 'tv show', 90);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Kitchenly 434 by Alan Warner – a 1970s rock Gormenghast', 'abs.jpeg', 'Kitchenly Mill is the idyllic East Sussex retreat of Marko Morrell, guitar hero with 70s rock band Fear Taker. It is a seriously moated Elizabethan mansion, with Arts and Crafts restorations and contemporary architectural additions – “air bridges” that connect the main house to its outliers. It’s a work of love, and clearly an object of love for Morrell’s pre-fame sidekick, Crofton Clark, who narrates. Alan Warner’s ninth novel, like his earlier work in Morvern Callar or The Sopranos, layers together music, culture and individual psychology so they seem to become a single, composite material; and it does so under a biblical epigraph – Luke 16.2: “Give an account of thy stewardship.”
If Clark loves Kitchenly, he worships Morrell, whose Fender Strat makes the “mighty noise of consequence and of economic empowerment”. He’s been around Fear Taker in one capacity or another since the beginning, deriving his entire identity from the association. Just what his place in the Kitchenly world might be these days – well, that’s the meat of a novel that begins in a kind of English uncanny valley, moves through an unforgiving comedy of errors, and culminates in fierce acts of realism. It’s 1979: record sales have dropped. Marko, less a deity now than a beleaguered company director, is rarely seen at Kitchenly, driving the Ferrari Dino or hosting the great signature parties of the past. Punk has already come and gone, new wave is everywhere. The mid-teen Gary Numan fans on the local estate have never heard of Fear Taker. Accountants and record company suits hover like exterminating angels over the wreckage of the rock project. Even Mrs H the housekeeper senses that the future has arrived.
Crofton is the only one who doesn’t get it. He trudges around the house and grounds, opening and closing miles of curtains, swapping out broken lightbulbs, pursuing his covert feud with the gardener, stiltedly laying out his days for us in a mixed language deriving from architectural heritage journalism and music-mag hagiography. (“Like a leaking nuclear power station,” he tells us at one point, “the radiation of Marko’s vast talent, his mystique, settled and shimmered like dusk on the tops of telephone wires ...”) He’s obsessed with boundaries and trespass, and a silent intruder he keeps glimpsing in the grounds. He senses something out of joint, but at night, when his rounds are done, he’ll put on his Magic Roundabout slippers as usual, set his Mickey Mouse alarm clock, reread his collection of Creem magazines. He’ll play the more difficult-to-come-by albums of forgotten early 70s bands.
By the time you’ve heard all this you are beginning to tire of his odd-job life, his misogynistic, unproductive fantasies about women and his comically failed outings in His Master’s Ferrari, with its deliciously “curved, bulbous rear”. He has too many memories of triumphs not his own, while all you want to know is what – if anything – is going to happen next. How will his confinement be broken open? What new form of life might emerge? But Warner is a merciless jailer and Kitchenly 434 a gleeful satire about owning and being owned – by places, people, ideas and economic systems. Crofton, we sense, must serve his full sentence before the author, with visible reluctance, releases him.
Meanwhile, perhaps not content to be seen solely as the metaphor of Marko Morell’s waning cultural influence, Kitchenly Mill develops a rich character of its own. Warner’s quiet parodies of heritage writing are abetted by Mark Edward Geyer’s illustrations of the building and its environs, and include an extended “quote” from Nikolaus Pevsner himself, that obsessive recorder of the English country house. On a visit during the 1950s, we’re told, Pevsner praised the “strange clerestory of the roof atrium” at Kitchenly, the “horizontal parades of lattice window screens” that “flood the interiors with a generous light”; going on, in his classic Buildings of England, to describe the house as “a summation of England’s history in solid form”. In the end, Kitchenly Mill is almost exactly that – a late-1970s version of Mervyn Peake’s Gormenghast, a sardonic mirror of the historical entrapment of its inhabitants in which the character of Flay the Butler has been reimagined by a team including Jonathan Meades and Will Self.
This is a gristly, enjoyably intractable book, which concentrates 20 years of cultural change. As well as drugs and rock’n’roll – and, perhaps more importantly, money’n’status – it covers everything from sexual politics to the curious asexual male-groupie syndrome that reached its peak in the figure of the 70s roadie. If you want to know anything, indeed everything, about the general history of the music, Kitchenly 434 is your manual. But one of its most interesting features is the way in which Warner uses the image of the house itself as an air bridge between the cultural hollowness of the pre-Thatcherian interlude and the retrofitted fantasy of England that would soon emerge: Albion as a sort of giant walled garden littered with unachieved futures and the beautiful houses of the past.',
                                                                                                               true, TIMESTAMP '2020-01-06 07:53:25', 139, 'news', 'literature', 77);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Harvest by Georgina Harding – unearthing the secrets of the past', 'abs.jpeg', 'Since her debut novel, The Solitude of Thomas Cave, in 2007, Georgina Harding’s fiction has ranged widely, from a 17th-century whaling boat in the Arctic to communist Romania in the 1950s. For all their differences, her books are profoundly connected, each one in its own way a meditation on survival and the aftershocks of trauma. Again and again they return to the implacability of memory, the intolerable weight of bearing witness, the struggle to build – or rebuild – a present-tense self on the ruins of the past. Like memory, they unspool in loops, the clouded silences of the present parting briefly to expose glimpses of secrets that can never be spoken, that can barely even be thought.
Harvest is the third in Harding’s cycle of novels about the Ashe family. Their very name summons aftermath, something irrevocably lost. The first, The Gun Room, tells the story of Jonathan Ashe, a young photojournalist responsible for one of the defining images of the Vietnam war. He moves to Tokyo, seeking refuge in the city’s anonymity. Instead a much older trauma begins to surface. The second, The Land of the Living, steps back 30 years to Jonathan’s father Charlie’s shattering experiences in the remote jungles of Assam during the second world war, and his struggle, as a newly married farmer after the war, to unshackle himself from their horror. In both novels place is vividly, viscerally evoked, the exotic strangeness of the Asian landscapes contrasting sharply with the windswept fields and flat wide skies of Norfolk. But while the latter is profoundly familiar to both men, that familiarity does not bring safety or peace.
Harvest takes us back to the 70s, picking up Jonathan’s story as he returns to Norfolk from Japan. Little has changed since he left. His brother Richard still lives with their mother Claire in their childhood home. Richard runs the family farm; Claire tends her garden. No one talks about Charlie’s violent death 20 years earlier. When Jonathan’s Japanese girlfriend Kumiko joins him on an extended visit, Claire walks with her outside, showing her the roses. It is a perfect summer’s day, perhaps the one day in the year, Claire said, “when the garden was at its best. And Kumiko said then that she was lucky to be there.”',
                                                                                                               true, TIMESTAMP '2019-01-10 22:43:55', 136, 'news', 'literature', 7);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Spooks watch along, series one finale: bombs, barneys and a wicked cliffhanger', 'abs.jpeg', 'Hello and welcome to the final watchalong episode of the first series of Spooks.
My apologies for missing so much due to health reasons; thanks again to Jack Seale for doing such a fantastic job standing in for me.
This is the one in which the personal really does become political as Tom moves into Ellie’s house, bringing all manner of trouble with him – we all knew that IT cover was going to collapse sometime …
We are also back in old-school terrorism mode: Lorcan Cranitch guest stars as the leader of an IRA splinter group with some interesting information.
Given all that, and the fact it is a season finale, what could possibly go wrong? Join me in the comments below to find out and remember: all speculation is welcome, but no spoilers.
', true, TIMESTAMP '2020-11-01 09:18:03', 245, 'news', 'tv show', 68);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Silence Is a Sense by Layla AlAmmar review – a refugee’s story', 'abs.jpeg', 'The unnamed narrator of Silence Is a Sense is a Syrian refugee who has been so traumatized by conflict and her perilous journey across Europe that she no longer speaks. Living in a nameless English city, she spends her days watching the residents of the estate she has come to call home through her window, and writing columns for a news magazine from a “refugee perspective” under the pseudonym “the Voiceless”. Her editor keeps pushing her for more memories, but she is unable to provide them: “We try to construct narratives – what happened before the blood came? … to stitch it all together into a coherent pattern.”
Layla AlAmmar is a writer who understands trauma, how it fragments the memory and turns people into startled animals. The narrator recognizes these behaviors in those around her: “the guy in the shop holding himself a little too rigidly … the young mother whose eyes are constantly scanning the street”. Trauma rejects conventional narratives, a fact that Home Office interviewers still fail to understand. In order to be granted asylum, migrants have to be prepared to unfurl their horrors for inspection; like our narrator, many refugees find themselves unable to stitch it into a coherent pattern.
At times, the reader shares the editor’s feelings of frustration: just tell us what happened, you want to say. This is cleverly deployed; are we being unreasonable in demanding an organized narrative? AlAmmar offers trickles of information that are just enough to hint at the terrors of war (“The smell of meat and burning is strong in the air, but nothing is cooking”) woven in with shrewd observations about Britain and immigration. Some people respond to the narrator with kindness, including the bookshop owner who lets her take books for free. Others are racist and aggressive. She feels the pressure to be a “good” immigrant. “Everyone here wants a story,” she says, “a nice little packet of memories.”
AlAmmar is pursuing a PhD on “the intersection of Arab women’s fiction and literary trauma theory”. If you know about literary trauma theory, you’ll know that it examines how psychological trauma challenges the limits of language. This and other theoretical threads (collective experience, disassociation and fragmentation) can be traced through the novel, meaning that at times it feels like a work constructed to respond to the theory of trauma, rather than trauma itself. To readers, this choice may manifest in a certain failure of characterization. The picture of this woman, like her memories, is cloudy.
Despite this, the use of several cliches and some dialogue that doesn’t ring true, I admire this book. It is an intelligent, insightful novel that asks vital questions about how we can begin to express trauma, and in what form. It faces up to its linguistic challenges. It doesn’t quite meet them, but perhaps no words, however they are deployed, truly can. That, after all, is the nature of trauma.',
                                                                                                               false, TIMESTAMP '2020-08-25 15:11:12', 237, 'review', 'literature', 47);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Jessica Walter, star of Arrested Development, dies aged 80', 'abs.jpeg', 'Actor Jessica Walter has died at the age of 80.
Walter, best known for her Emmy-winning role as Lucille Bluth in Arrested Development, died in her sleep at her New York home.
“It is with a heavy heart that I confirm the passing of my beloved mom Jessica,” said daughter Brooke Bowman in a statement. “A working actor for over six decades, her greatest pleasure was bringing joy to others through her storytelling both on screen and off. While her legacy will live on through her body of work, she will also be remembered by many for her wit, class and overall joie de vivre.”
The actor had won an Emmy in 1975 for the series Amy Prentiss and received three nominations for her performance as the sarcastic matriarch in the hit comedy show. Walter was also known for her voice work in the animated series Archer, playing Malory Archer, the former CEO of the International Secret Intelligence Service.
Her most notable big-screen role was in Clint Eastwood’s 1971 thriller Play Misty For Me, as a woman scorned, a film many saw as a vital inspiration for Fatal Attraction. Her other big-screen turns included John Frankenheimer’s Grand Prix and Sidney Lumet’s The Group, both released in 1966.
“I lost more parts than I’ve ever had, but you realize quick that you have to be like a terrier with a bone,” she said to Elle in 2019. “So I did the circuit. My God, I did the circuit. If it’s a good role, I don’t care what the medium is, I take it.”
', true, TIMESTAMP '2020-08-01 11:37:32', 35, 'article', 'tv show', 77);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Made in Italy review – autobiographical poignancy from Liam Neeson and son', 'abs.jpeg', 'The big, unique selling point of this somewhat sappy but quite watchable feature is that the two main roles – a charismatic, widowed artist named Robert and his handsome but still finding-his-feet-careerwise son Jack – are played by Liam Neeson and his real-life son, up-and-coming actor Micheál Richardson. In the film, Robert’s wife/Jack’s mother died tragically young in a car accident. This, of course, parallels the death of Neeson’s real-life wife/Richardson’s mother, Natasha, from injuries incurred during a skiing accident when her sons were still in their teens.
Knowing all this adds a certain frisson to the climactic scene where father and son have it out about the different ways they handled the late woman’s death. But the lack of finesse, in scriptwriting terms, with which the emotional punch is landed robs the scene of the impact it deserves. Elsewhere, the yarn is more entertaining as an uber-bougie slice of property porn about the two men bonding as they fix up, with ludicrously obvious symbolism, the palatial Tuscan house they inherited from Jack’s late mother. Jack, it transpires, wants to sell the place so he can buy an art gallery he ran for his own ex-wife’s family.
', false, TIMESTAMP '2020-07-12 20:16:04', 74, 'review', 'cinema', 84);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('In brief: Unsettled Ground; Genesis; Inferno – reviews', 'abs.jpeg', 'Unsettled Ground
Claire Fuller
Fig Tree, £14.99, pp304
Fifty-one-year-old twins Julius and Jeanie still live with their mother, Dot, in a ramshackle rural cottage. Their father died years earlier in a tractor accident for which the twins blame local landowner Spencer Rawson. When Dot dies, they begin to unravel their family history as they struggle to lead independent lives. Fuller explores the painful realities of poverty and social isolation with immense sensitivity in this multilayered and emotionally astute novel.
Genesis: The Story of How Everything Began
Guido Tonelli
Profile Books, £16.99, pp240
Particle physicist Tonelli was one of the leading scientists in the discovery of the Higgs boson. In Genesis, he explores the origins of the universe, producing an accessible and highly engaging account of the latest theories and discoveries. In seven chapters, mimicking the biblical creation story, he takes us on a journey from the big bang to the evolution of humans, blending Greek mythology with scientific exploration in a narrative that’s lyrical and exhilarating in equal measure.
Inferno: A Memoir of Motherhood and Madness
Catherine Cho
Bloomsbury, £9.99, pp272
When Cho’s son was three months old, she and her husband James travelled from London to the US to introduce their baby to family and friends. There, relatives questioned Cho’s decision not to observe Korean traditions about newborns, compounding the anxiety and insecurity of her early motherhood. What followed was a period of postpartum psychosis, including a 12-day stay on a psychiatric ward. Cho weaves fractured memoir with Korean history and culture in a raw exploration of mental illness.' ,
                                                                                                               false, TIMESTAMP '2020-08-18 22:30:30', 248, 'review', 'literature', 97);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Dropbear by Evelyn Araluen – a stunning scalpel wielded through Australian myths', 'abs.jpeg', 'Some 200 years after invasion, in 1991, a vision of Australia was offered by poetry: Robert Gray and Geoffrey Lehmann’s Australian Poetry in the Twentieth Century.
The anthology was typified not only by the complete absence of Black poets, but the glowing approval of Les Murray on the cover and dutiful inclusion of Barry Humphries’ smiling zinc cream kitsch in Edna’s Hymn, whose balancing act of “mockery and affectionate nostalgia” (“All things bright and beautiful – Pavlovas that we bake,/All things wise and wonderful – Australia takes the cake”) apparently meant no room could be found for Oodgeroo Noonuccal or Lionel Fogarty.
In Dropbear, her debut collection of poetry, Evelyn Araluen wields a scalpel through twinkly visions and phantasma that treat the Australian landscape as empty necropolis: the Peters ice-cream white suburbs and grey-lapel metropolises; the interior as vacant object of “sunburnt” affection; women quietly tending logpiles at the homestead while men trek across the frontier and sheep and rabbits destroy the topsoil.
To these, Araluen says: “Straya is a man’s country/and you’re here to die lovely against the rock/to fold linenly into horizon/and sweat beautiful blonde on the beach”.
She incorporates lyric meditations, memoir and pastiche with equal facility. In this she has been compared to Alison Whittaker; I would suggest, however, that both authors are part of a broader First Nations practice. From Leanne Betasamosake Simpson in Canada and Esther G Belin and Michael Wasson in Turtle Island to Walis Norgan and Adaw Palaf in Taiwan, it is not uncommon to see various modes and forms incorporated into the poetics of First Nations.
In poems like PYRO, Breath, and Bastards from the Bar, bristling with hard-bitten tenderness (“For what/they did to the women, and what they never did for us, it’s/worth growing older”), Araluen writes something akin to prose poetry. She is attuned to that form’s particular mode of consciousness wending its way through memories: of bushfire, familial love, even “A SNEAK PEEK PRE-COLLECTION OF ORGANIC COTTON WOMENSWEAR IN WHICH THE THIN WHITE MODEL LEANS DOUR AGAINST A FIRETRUCK IN THE THRICE-BURNT CHAR OF A HOMELAND”. Her work asks what it is we wish to keep, in this “relic-making” of the “half-finished” “Anthropocene display”. What is the point in chiselling the clay of language, if all that eventuates is another object to be placed amid the dead and dying “in a museum of extinct things”?
Araluen’s clever repurposing of Biblical themes, Australiana kitsch, and settler-colonial tropes (see the glorious frontier pastiche of The Last Endeavour) speaks back to a long history of Australian myth-making, from Patrick White’s Voss and Harold Lasseter to John Oxley and Madeleine Watts’ recently published debut. In one very fine piece, THE INLAND SEA, Araluen remixes Peter Carey’s Oscar and Lucinda with shades of Corinthians (“how many churches carried up the creek, how much glass for that dark little light”), building toward a stunning image of apocalyptic decay.
', false, TIMESTAMP '2019-05-07 03:52:41', 73, 'article', 'literature', 6);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Retaliation – Orlando Bloom gives it his all in lacerating sexual-abuse drama', 'abs.jpeg', 'Orlando Bloom has often looked perfectly happy with a Hollywood career, starring in movies as opposed to necessarily acting in them. But he outdoes himself in this British indie drama playing a man traumatised by childhood sexual abuse at the hands of a Catholic priest. There’s a kind of blunt brute force to his performance – and he looks almost unrecognisable, as if he’s using certain muscles in his face for the first time.
The film is a horror story: a disturbing, hard-to-watch ordeal with a lacerating script by Geoff Thompson, a sexual-abuse survivor who has written courageously about his own experience. Bloom is Malcolm, known to everyone as Malky, a nickname that doesn’t remotely suit him. He swaggers about full of rage, flying into a temper if anyone so much as looks at him funny. Malcolm works in the macho world of demolition, stripping old churches of fixtures and fittings before the bulldozers move in. Just in case you miss the point, his mum says over tea: “There’s a lot of churches. You won’t be able to knock them all down.” There’s a good deal of this sort of heavy symbolism, giving the whole thing an overcooked, oppressive feel.
', true, TIMESTAMP '2020-01-20 20:43:47', 131, 'article', 'cinema', 7);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Westworld recap: season 3 finale – a ridiculous, stupid, thrilling end', 'abs.jpeg', 'Dolores is dead. Serac is dead. The Rohohohoboam got switched off. Stubbs is bleeding out in a tub drinking rubbish booze, while William survives till the credits but not beyond. Giggles got shot. Lawrence is a cop. Bernard has ascended to the sublime. Hale is a hologram and Caleb got his hair mussed. Did I miss anyone out?
Oh yes, Maeve. The undisputed champion of the new normal, in which buildings are blowing up and everyone is rioting, but at least they did it of their own free will. Having begun this finale knocked out on the floor of a hangar, she ends it surveying chaos, but she seems pretty happy about it. “This is the new world,” she tells Caleb, “and in this world you can be whoever the fuck you want.”
She really is one for the swearing, our Maeve, but after all she’s been through, I’ll allow it. After dispatching one Dolores in last week’s battle, she finds herself face to face with another almost immediately. Caleb has used one last control unit to build a new, battle-ready Dolores that is not made from milk and doesn’t have any blood. You may be asking yourself why anyone would bother with that palaver when this new Dolores just pulls on her skin like a glove and is ready to fight, but, viewer, we have no time. Instead we have to cut straight to Maeve coming at Dolores with her katana and, this time, getting her ass kicked.
New Dolores is rough, tough and great with a windmill kick. She has Maeve on the floor and could finish her should she choose to, but no – choice is the whole point. She gets up, leaves Maeve to find her own path – and is immediately floored by herself.
When I say “herself”, I mean Hale, who got sizzled like a sausage in an exploding car the other week, but is back in hologram form. Hale is, of course, Dolores, but also a bit Hale, which is why she is pissed off with Dolores, who kind of left Hale in the lurch when it came to the whole Delos takeover thing. Got it? Good, because the fact that Hale is Hale but also Dolores means she has the power to tighten Dolores’s neck nut remotely, or something, making the Abernathy gal slump to the floor. In a jot, Maeve is over to scoop her up and take her straight to Serac.
', false, TIMESTAMP '2019-07-11 23:37:06', 9, 'article', 'tv show', 13);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Notorious BIG: his 20 greatest tracks – ranked!', 'abs.jpeg', '20. One More Chance/Stay With Me (1994)
In its original version a nasty sex rhyme – “I got the cleanest, meanest penis” etc – the remix tones down the lyrics and smooths the music by way of DeBarge’s 1983 hit Stay With Me, drafting in a vocal from Biggie’s wife, Faith Evans, to spectacular effect. End result: a beautifully languid slow jam.
19. Warning (1994)
A beautifully concise bit of storytelling, complete with an impressively naturalistic conversational interlude during which Biggie, in character as a friend, informs himself that someone has taken a hit out on him. The rapper elects to lie in wait: needless to say, it doesn’t end well for his would-be assailants.
18. Sky’s the Limit (1997)
One of several tracks that took on a different hue after Biggie’s death in 1997, aged 24, Sky’s the Limit was initially Life After Death’s equivalent of his breakthrough hit Juicy, an alternately wistful and dark account of his rise. Posthumously, it sounded like a self-penned eulogy, complete with epitaph: “Live the phrase ‘Sky’s the limit’”.
17. Craig Mack – Flava in Ya Ear (remix feat Notorious BIG, LL Cool J, Rampage & Busta Rhymes) (1994)
Both an incredible single and an object lesson in the perils of getting Biggie Smalls to guest on your track; despite the stellar company, his verse turns the song into his show. Craig Mack’s debut album was duly eclipsed by the release of Ready to Die a week beforehand.
16. Funkmaster Flex – Biggie/Tupac Live Freestyle (1999) / Come On (feat Sadat X) (1999)
Your choice as to how you want to hear one of Biggie’s most iconic verses: the studio take is grimily exciting, with a great turn by Brand Nubian’s Sadat X; the 1993 live version is lo-fi, utterly electric from the opening bellow of “Where’s Brooklyn at?” and captures his soon-to-sour friendship with Tupac on tape.
15. Gimme the Loot (1994)
By modern standards, the guest list on Ready to Die is minimal, but you don’t need star features if you can duet with yourself as grippingly as Biggie does here. His voice is sped up to suggest he’s talking to his younger self, depicting a series of robberies in grim detail.
14. Big Poppa (1994)
By most accounts, the making of Biggie’s debut album was a struggle between the rapper’s street instincts and Sean “Puffy” Combs’s commerciality. On this slow jam, the latter won. Note the original lyrical twists – no how’s-your-father until Biggie has had his dinner! – and period detail: a pre-Auto-Tune, wildly off-key vocal on the hook.
13. Junior Mafia – Get Money (feat the Notorious BIG) (1996)
Take your pick from the Sylvia Striplin-sampling original, or the remix based on Dennis Edwards’ Don’t Look Any Further, it’s all about the sparring between Biggie and Lil’ Kim, who trade different verses on each version. If you believe the rumours, they sound evenly matched because Biggie had a hand in writing her rhymes.
12. What’s Beef? (1997)
Notorious BIG at his most chilling, delivering a litany of horror – his threats cover everything from raping and murdering children to arson and castration – in a disturbingly blase tone, the mood heightened by the track’s eerie strings, excerpted from, of all things, a luxuriant 70s cover of Bacharach and David’s Close to You.
11. Jay-Z – Brooklyn’s Finest (feat the Notorious BIG) (1996)
After Biggie’s death, Brooklyn’s Finest took on the poignant sense of one era passing and another beginning; had he lived, it would have sounded like an up-and-coming MC gamely attempting to take on a star who insouciantly proves his worth. Either way, the pair trading verses is completely gripping.
10. Notorious Thugs (feat Bone Thugs-n-Harmony) (1997)
Recorded months before his death, Notorious Thugs isn’t a song so much as a challenge: can the relatively laconic Notorious BIG speed up and keep up with the trademark hyper-speed flow of guests Bone Thugs-n-Harmony? The answer: yes, in particularly thrilling style, complete with complex internal rhyme schemes and a whip-smart reference to Eddie Murphy.
9. I Got a Story to Tell (1997)
The track that lent its name to Netflix’s new Notorious BIG documentary offers perfect evidence of how he melded a fresh approach with his devastating lyrical flow: daringly, he twice relates the (allegedly true) saga of outwitting a jealous boyfriend, first as a straight rap, then as a conversational anecdote.
8. Kick in the Door (1997)
Over a sample of Screamin’ Jay Hawkins’ I Put a Spell on You, the Notorious BIG proclaims himself the king of New York hip-hop, a distinct up yours to Nas, who had claimed the title for himself. It’s Biggie at his hardest-hitting, bellicose threats spiked with wit (“I drop unexpectedly, like bird shit”) – an extremely convincing case.
7. Things Done Changed (1994)
A lyric that ended up being included in a 2004 anthology of African American literature, Ready to Die’s opening track offered an unsparing depiction of the havoc wrought on poor black neighbourhoods by the influx of crack: “Our parents used to take care of us / Look at them now, they’re even fuckin’ scared of us”.

6. Who Shot Ya? (1994)
You can view Who Shot Ya? as a fatal mistake: whether it was about Tupac or not, it acted as the spark in the beef that may have claimed Biggie’s life. But it’s a fantastic track, menacing, darkly funny – “I feel for you, like Chaka Khan” – with an oddly hallucinatory sound, a bad dream captured on tape.
5. Ten Crack Commandments (1997)
Later transformed into the musical Hamilton’s Ten Duel Commandments, Biggie’s witty, acerbic advice to potential dealers – “That goddam credit? Dead it! You think a crackhead paying you back? Shit, forget it!” – rides a superb, minimal DJ Premier beat, where scattered electronic beeps meet a fierce sample of Public Enemy’s Chuck D.
4. Mo’ Money Mo’ Problems (1997)
Life After Death’s big hit found Biggie’s lyrical skills and Combs’s pop smarts in perfect harmony: the latter’s use of Diana Ross’s I’m Coming Out is inspired; the former’s verse shifts from celebrating his own success to suggesting, with a certain grim irony, that he’s interested only in music, not internecine hip-hop wars: “Bruise too much, I lose too much”.
3. Suicidal Thoughts (1994)
Ready to Die ended with the negative image of its swaggering big hits: one verse, no hook, self-loathing poured out over an austere beat. There’s shock value, but its real power comes from detail: the regret over stealing from his mother’s purse, the bleak image of “people frontin’ at my funeral like they miss me”.
2. Hypnotize (1997)
The track Biggie was in LA to record a video for when he was murdered and a posthumous US No 1, Hypnotize is a fabulous single. He sounds imperious, the Herb Alpert-sampling production is starkly funky, while the chorus nods to Slick Rick and Doug E Fresh’s old-school classic La-Di-Da-Di.
1. Juicy (1994)
In 2019, Juicy was voted not just the greatest Notorious BIG track, but the greatest hip-hop track of all time in a BBC poll. That’s obviously a debatable point, but you can see why it won. As the rapper Common pointed out, the lyrics “define the American dream”, refracted through a hip-hop lens. It’s a classic, intimate rags-to-riches saga in which the bragging feels joyful rather than obnoxious, thanks to a plethora of beautifully turned lines (“no heat, wonder why Christmas missed us”) and references to old-school rap fandom from Lovebug Starski and the long-lost US black teen magazine Word Up! to the John Wayne-themed 1984 novelty track Rappin’ Duke. The sample from Mtume’s Juicy Fruit – which Biggie initially baulked at as too pop – is also irresistible.
', true, TIMESTAMP '2020-08-31 11:37:47', 15, 'article', 'music', 60);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Violation – a torrent of suppressed rage', 'abs.jpeg', 'In Violation’s closing stretch, Miriam (Madeleine Sims-Fewer) sits numbly in a rain-lashed car and watches a man harangue his wife in an eastern European language. Miriam has just done something unspeakable, in reaction to something unforgivable; preparing to finish the job at an anonymous motel, it is as if she has crossed a border into a foreign country. But the couple in front of her show the inescapable constant: male violence. Building to a remorseless climax, Sims-Fewer and co-writer/director Dusty Mancinelli brilliantly, and times almost unwatchably, overhaul the rape-revenge movie as something far more realistic, traumatised and noxious.
Miriam has come from London to visit her sister Greta (Anna Maguire) in the Canadian forest idyll she shares with husband Dylan (Jesse LaVercombe). But tension is in the air: in Miriam’s faltering marriage with Caleb (Obi Abili), in her jealousy of her sister, even in the disturbing flashes of nature – pond lice seething on the lake – that open the film. Able only to unburden herself to the seemingly matey Dylan, Miriam stupidly kisses him by the campfire; then when she is sleeping, he rapes her. Sims-Fewer and Mancinelli don’t show this event immediately, opting for non-linear disorientation that cuts between that night and a later hook-up in a log cabin in which Miriam ties Dylan naked to a chair, and asks for his side of the story.
', false, TIMESTAMP '2020-02-08 16:43:56', 49, 'news', 'cinema', 77);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Yellow review – a gripping epic about fascism in Belgium', 'abs.jpeg', 'Director Luk Perceval’s Sorrows of Belgium trilogy charts three dark chapters in the nation’s history, starting with colonial oppressions in the Congo in Black (produced by NTGent in 2019) and ending with the Brussels terrorist attacks of 2016 in Red (yet to be staged). The second instalment, Yellow, dramatises the rise of the fascist party Rex, which led to collaboration with Nazi occupiers.
What is immediately arresting in NTGent’s live-stream, with English subtitles, is the cinematic quality of the production. It is exquisitely filmed by Daniel Demoustier in the theatre, though not always on the stage. Shot almost entirely in black and white with some intermittent hues of yellow, it seems variously like a dance and a series of sorrowful tableaux of human suffering and collective delusion. Camera angles draw us into the roused faces of Belgian fascists, circling them dizzily as they spit out their rhetoric, and then drawing away to show them as a choreographed ensemble. Annette Kurz’s set design seems more like a moving painting, with the actors often performing on or around a table that serves as a miniature stage.
The full cycle of the war is shown, from the rise of the Rex party (“Hitler will not forget about the Flemish,” says one character) to the eastern front and finally the bursting of the fascist bubble back at home. It is history told through family members and everymen, from the bookish and absent Jef, who is pushed into enlisting for war, to his father (Peter Seynaeve), mother (Chris Thys) and sister, Mie (Lien Wildemeersch). Their testimonies are combined with narrated letters written by Jef from the frontline, and there is a Jewish woman, Channa (Maria Shulga), who appears occasionally to tell her own story of persecution and escape – though frustratingly, not enough of it.
', false, TIMESTAMP '2020-10-16 03:14:41', 113, 'article', 'theatre', 72);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('This week’s new tracks: Francis Lung, Dua Lipa, Slowthai', 'abs.jpeg', 'Francis Lung
Bad Hair Day
Back in his Wu Lyf days, we were barely allowed a glimpse of Francis Lung, the band’s press shots resembling a teargas attack on The Masked Singer. These days, though, he’s so laid bare we can even see his frazzled roots. Verse courtesy of Elliott Smith, chorus basically Queen playing Teenage Fanclub’s The Concept, this makes hangovers sound heroic.
Dua Lipa
We’re Good
Are you the “sleeping” in your relationship? Or are you – be honest now – the “cocaine”? For such is the level of incompatibility our Dua cites as she breaks up with some schmuck on this sumptuous slice of pop tropicália, having presumably rejected a selection of other metaphor-based dumpings: “You’re the Morrissey to my lamb shank,” say. Or: “I’m competently managed public funds. You’re Chris Grayling.”
Slowthai ft Skepta
Cancelled
Maintaining his record deal, supported by grime royalty and interviewed media-wide, it’s a bit rich of Slowthai to paint himself as the defiant victim of the cancel culture “cult” following his sexist behaviour at 2020’s NME awards. This unremarkable slasher-flick rap should really be titled Scot Free.
', true, TIMESTAMP '2020-11-30 03:00:10', 190, 'review', 'music', 81);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Nemesis – geezer cliche compilation with a charisma bypass', 'abs.jpeg', 'If Towie put out a crime special it might look a bit like this shoddy London thriller about an ageing gangster whose plans for a peaceful retirement go south. The characters have that same style of stiff, awkward delivery, as if they’re speaking lines to each other over a dodgy Zoom link.
The star is TV mainstay Billy Murray (The Bill and EastEnders) who plays John Morgan, a gang boss with the telltale mahogany suntan of a cockney hardman done good. Morgan, semi-retired in Turkey, flies into London on a private jet for a charity fundraiser. But on the night there’s a spot of bovver with an old foe, alcoholic detective Frank Conway (Nick Moran). Morgan and his wife Sadie (Jeanine Nerissa Sothcott) have also arranged a dinner to meet their Instagram influencer daughter’s new girlfriend – and there’s a horrifically sleazy scene when the girlfriend arrives early to find Sadie wearing only knickers.
', false, TIMESTAMP '2019-10-07 07:00:52', 49, 'news', 'cinema', 88);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Take Back – dusty martial arts thriller looks cramped', 'abs.jpeg', 'Clearly intended as a leg-up in the ranks of the female action star for Gillian White, this smalltown revenge thriller starts off well but takes a fatally long time to gather momentum. White plays Zara, a successful lawyer in a desert town whose martial arts skills, courtesy of lethal-but-sensitive husband and dojo partner Brian (Michael Jai White, her real-life husband/trainer), make her a social media hit after she disarms a goon threatening a coffee-shop assistant. This lowlife is in fact part of a local human-trafficking ring, masterminded by chihuahua-loving hoodlum Patrick (Mickey Rourke), with links to Zara’s secret past.
Any B-movie thriller worth its salt should get to its inciting incident within the first 20 minutes. Here, it’s the kidnapping of Zara and Brian’s daughter, and it takes nearly 50 minutes to arrive. The plot is jammed instead with portentous run-ins with Patrick’s thugs, leaden teasing-out of Zara’s history that hovers close to matinee melodrama, and only the sporadic justice-servings we are really here for.
', true, TIMESTAMP '2020-05-17 15:19:34', 56, 'news', 'cinema', 67);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Duchess! Duchess! Duchess! review – Meghan inspires explosive drama', 'abs.jpeg', 'It is tempting to assume that an American drama about black women caught in the cold, hard machinery of Britain’s monarchy is a direct response to Meghan’s revelations to Oprah Winfrey earlier this week.
But theatre cannot move quite this fast and even though Vivian JO Barnes’ two-hander was inspired by the duchesses of Sussex and Cambridge, she conceived it in 2018 and it was filmed by Steppenwolf theatre at the end of last year.
The marketing gods, however, could not have aligned the stars for a greater impact for the digital premiere of a play billed as “a darker version of what might have happened if Meghan Markle had stayed”. That line gestures towards the surreal, satirical and incrementally creepy tone of this 35-minute dualogue.
Staged as a teatime meeting between The Duchess (Sydney Charles) and The Soon-to-be-Duchess (Celeste M Cooper), and directed by Weyni Mengesha, the couple’s exchanges seem deliberately wooden and gather sinister undertones that climax in the grotesque act of the final moments. The Duchess is already grounded in the ways of the institution and performing royal duties and has recently given birth (“I’m leaking”). She is meeting the Soon-to-be-Duchess in order to educate her in palace protocols for women – and black women – entering into royalty.
', true, TIMESTAMP '2021-03-19 04:01:11', 212, 'news', 'theatre', 30);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('In brief: The Crichel Boys; Redder Days; Miss Benson’s Beetle – reviews', 'abs.jpeg', 'The Crichel Boys
Simon Fenwick
Constable, £25, pp354
Long Crichel House has never ranked with Charleston in terms of the panoply of literary and artistic salons, but in this absorbing new history, Simon Fenwick makes a convincing case for its importance and relevance. Host to “hyphenated gentleman-aesthetes”, Long Crichel attracted a colourful range of characters including Vita Sackville-West and Patrick Leigh Fermor. Fenwick skilfully brings them to life with a well-judged mixture of gossipy anecdotes and, when called for, a sober look at the legacy of “the buggery house at Crichel”, as Evelyn Waugh sardonically called it.
Redder Days
Sue Rainsford
Doubleday, £14.99, pp260
Sue Rainsford’s second novel has chilling topical resonance in its depiction of a dystopian future in which the world, wracked by climate change, heads towards its end. Yet its protagonists, twins Anna and Adam, are menaced by a threat closer to home as they squeeze out existence in an abandoned commune. There are echoes here of Poe’s The Masque of the Red Death, and Rainsford’s spare, haunting style and willingness to tread into dark and thought-provoking areas make this an accomplished and disturbing read.
Miss Benson’s Beetle
Rachel Joyce
Penguin, £16.99, pp400
Rachel Joyce is a great chronicler of journeys and quests, and the one that her protagonist Margery Benson undergoes here, travelling to New Caledonia in order to discover a hitherto unknown species of golden beetle, is as delicately and exquisitely portrayed as in her other books. Joyce takes Benson and her pink-suited friend Enid Pretty on an adventure that both amuses and stirs, and the 50s setting allows her to leaven the humour with a vein of melancholy about how the after-effects of war did not produce the emancipation many women hoped for.',
                                                                                                               true, TIMESTAMP '2020-08-07 06:55:11', 258, 'review', 'literature', 74);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Children’s books roundup – the best new picture books and novels', 'abs.jpeg', 'World Book Day tie-in titles are especially strong this year, from Katherine Rundell’s Skysteppers (Bloomsbury), a nail-biting scramble across the skyline of Paris (and prequel to the bestselling Rooftoppers), to the crazed fun of Humza Arshad and Henry White’s Little Badman and the Radioactive Samosa (Puffin), illustrated by Aleksei Bitskoff, in which a box of irradiated triangular treats confers superpowers on a trio of kids.
Other brilliant books for eight-year-olds and up this month include Show Us Who You Are (Knights Of) by Elle McNicoll. Cora, who is autistic, loves hanging out with Adrien, son of the CEO of Pomegranate Technologies – until an accident leaves Adrien in a coma. Pomegranate makes holograms of people, preserving memories for grieving families. But what modifications might be made to the holograms in a spurious quest for “perfection”? This is a startlingly original speculative novel, and a moving, passionate interrogation of prejudice against neurodiversity.
Two Sisters: A Story of Freedom (Scholastic) by Kereen Getten features inseparable 18th-century half-sisters Ruth and Anna, who are sent on a voyage from Jamaica to England. Anna’s almost white skin means she is always treated differently, while Ruth must fight for what should be hers. Told from both girls’ perspectives, this is a hard-hitting, gripping read, full of fierce courage in the face of injustice.
Meanwhile, Mort the Meek and the Ravens’ Revenge (Stripes) by Rachel Delahaye, illustrated by George Ermos, is the tale of hapless Mort, the only pacifist in a distinctly brutal kingdom, who’s just been made Royal Executioner – and told to bump off his best friend. Crammed with wisecracking corvids and outrageous wordplay, it’s engagingly light-hearted, Pratchettesque comic fantasy.',
                                                                                                               true, TIMESTAMP '2020-11-09 03:02:30', 286, 'article', 'literature', 61);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Tracks of the week reviewed: Cardi B, Finneas, and Foo Fighters', 'abs.jpeg', 'Cardi B - Up
It is an oft-quoted “fact” that Inuit people have more than 50 words for snow, but Cardi B has 5,000 ways to describe sex, and all of them are horrifically filthy. Up is Cardi’s follow-up to her mega-smut smash WAP, and is basically a list of sex acts and reasons you’d want to shag her, rapped over a trap beat, with Cardi insisting “if it’s up then it’s stuck”. Should we call an ambulance, hun? That doesn’t sound right.
Finneas - American Cliche
It’s probably really hard to carve out your own musical niche when your sibling and co-writer is superstar goth Billie Eilish but, honestly, Finneas must have given his sister all the good songs, because American Cliche is big-band mum-pop that sounds like Michael Bublé fronting the Strictly house band in an episode of Glee.
Hayley Williams - My Limb
Why bother releasing music via the normal routes when you can personally hand-deliver a CD to a fan and give them “permission” to leak the song to celebrate the Wolf Moon? Which is how Hayley Williams released My Limb, a creeping, emo-tinged banger, worth the risk of giving a CD to someone under 25 and expecting them to know what it is.
Foo Fighters - Making a Fire
Dave Grohl has recently talked about being influenced by Abba and the Bee Gees, and how his band’s new record Medicine at Midnight is a “dance” album, but Making a Fire just sounds like every other Foo Fighters song that has gone before it: safe, fun, reliable, accessible stadium rock.
', false, TIMESTAMP '2019-05-14 07:56:51', 271, 'review', 'music', 11);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Classical home listening: Natalie Dessay; Leo Chadburn; the House of Bedlam and Birdgirl', 'abs.jpeg', 'The French singer and actor Natalie Dessay has stepped away from the operatic stage, alas, but stands out as one of the greatest coloratura sopranos of recent times, especially in the 1990s and 2000s. À l’opéra (Erato) is a three-CD set from across her career, with different companies from the Royal Opera House to Les Arts Florissants to Le Concert d’Astrée. One disc is of French repertoire (Gounod, Meyerbeer, Offenbach), one Italian (Bellini, Verdi, Donizetti) and the last is the rest: including Mozart, Richard Strauss and Stravinsky.
Distinguished by a bright, gleaming tone, fiery energy, nimble ornamentation and crisp, verbal dexterity, Dessay excels especially in the three Cleopatra arias from Handel’s Giulio Cesare. Her Chanson d’Olympia from Les contes d’Hoffmann, recorded in 1996, remains a showstopper, as does Caro nome from Rigoletto. The final track is Cunegonde’s Glitter and Be Gay from Bernstein’s Candide. If there’s a sadness in having to accept Dessay’s absence from the stage, her sparkling humour, captured here, more than compensates.
Leo Chadburn, composer, speaker, pianist, defies category, which is all to the good. He’s been on BBC Radio 1, Radio 3, 6 Music and many remoter places. His new album Slower/Talker (Library of Nothing Records), with Quatuor Bozzini, Apartment House and actor Gemma Saunders, opens with The Indistinguishables: the names of 70 species of moth sighted in the UK are recited over sensuous string quartet chords. Vapour Descriptors, for pianos and voices, celebrates the language of scent: spicy, musky, grassy, powdery. The Halogens is a stream of consciousness on the properties of chemical elements.
Hypnotic and vivid, Chadburn’s work asks you to listen, think and imagine. It also has a wry quality that makes you take it seriously. In a related vein, try Enclosure (NMC) by the House of Bedlam, an engagingly unquantifiable collective founded by the composer-performer Larry Goves. The album’s focus is playing together, playing apart, which might be a maxim for all musicians this past year.
Get Birding is a new podcast presented by 19-year-old “Birdgirl” Mya-Rose Craig, combining birdwatching with music. Through guests who are naturalists and musicians, or at times both, she looks at the relationship between birdsong in nature and in art.
', false, TIMESTAMP '2020-04-17 04:40:30', 35, 'news', 'music', 56);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Shortlist for Carnegie medal offers locked-down children ’hope and escapism’', 'abs.jpeg', 'Run simultaneously with the Kate Greenaway medal for illustration, judges say this year’s finalists should inspire and empower their young readers.
From a picture book about a father and son’s hike into the mountains, to the story of an exhausted lion that captures the majesty of nature, the books in the running for the UK’s oldest children’s book awards this year have been praised for “offering hope and escapism during lockdown”.
The Cilip Carnegie medal, for the best children’s novel, and the Kate Greenaway medal, for the best children’s illustrator, have been running since 1936 and 1955 respectively. Judged by children’s librarians, previous winners of the Carnegie range from Arthur Ransome to Philip Pullman, while the Kate Greenaway has gone to some of the UK’s best-loved illustrators, from Shirley Hughes to Quentin Blake.
Eight titles have been shortlisted for the Kate Greenaway medal. Previous winner Catherine Rayner is nominated for Arlo the Lion Who Couldn’t Sleep, alongside Pete Oswald’s Hike; Poonam Mistry’s How The Stars Came to Be, a tale about the formation of the night sky; and Sharon King-Cha’s Starbird, a fable about freedom and love, that is packed with images of nature, as are many of the shortlisted titles.
“With themes of freedom, the great outdoors and journeys through the natural world, we hope the outstanding books on this year’s shortlists will inspire and empower young readers, offering hope and escapism during lockdown,” said chair of judges Ellen Krajewski.
', true, TIMESTAMP '2019-10-17 00:38:08', 3, 'review', 'literature', 50);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Sarah Moule: Stormy Emotions – an unerring tribute to Fran Landesman', 'abs.jpeg', 'The lyrics here are by Fran Landesman. If you’ve encountered any of hers before, you’ll know that although they’re entirely at home in jazz, and mainly concern love, they can’t be tossed about like any old standard. They’re wary, suspicious, suggesting that the singer has been around the block too many times to fall for the usual line of chat. Occasionally there’s a secretive backward glance to lost innocence, hastily suppressed. That’s a lot of nuance for a composer to take on board and for a singer to convey. Landesman declared that she’d got lucky when she met Simon Wallace, her songwriting partner for 18 years until her death in 2011, and had collected a bonus when he married the singer Sarah Moule.
Listening to these 12 tracks, 10 of them previously unrecorded, you can hear what Landesman meant. Moule catches the shifting moods, touchingly in A Magician’s Confession, candidly in Are We Just Having Fun?, and always unerringly. Wallace’s music catches the spirit of each lyric, brilliantly played by his small band. The prize there goes to Mark Lockheart’s soprano saxophone throughout Close to Tears, moving from dialogue with the voice to solo and back again.
', false, TIMESTAMP '2019-11-25 14:17:09', 264, 'news', 'music', 4);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Honeydew – flame-grilled rural horror', 'abs.jpeg', 'A first feature from director of short films Devereux Milburn, co-written by Milburn and the film’s cinematographer-producer Dan Kennedy, this is a stylised, unsettling horror jaunt that plays interesting variations on an all-too-familiar plot premise. Sam and Riley, a good-looking couple in their 20s, played respectively by Sawyer Spielberg (yes, son of Steven Spielberg) and Malin Barr, takes the always foolish decision to leave the safety of the city for a camping trip. In this case, they elect to pitch their tent somewhere in rural New England because Riley is working on a doctoral thesis about a (fictitious) fungal infection in wheat that causes gangrene and madness in cows and people.
However, they soon get run off their campsite by the local farmer (Stephen D’Ambrose), and a flat car battery forces them to seek help at the cluttered homestead of elderly Karen (Barbara Kingsley), a keen baker and cooker of meaty steaks, and her mute, brain-damaged son (Jamie Bradley). The city slickers soon find themselves at the mercy of ravenous desires; but on the plus side, all the TV sets seem to be perpetually tuned to the last station in the world showing nothing but old black and white Popeye and Betty Boop cartoons from the Inkwell Studios’ heyday in the early 1930s, a glorious period in animation, and a good match for the body horror that’s about to be revealed here.
', true, TIMESTAMP '2019-12-17 13:18:41', 248, 'article', 'cinema', 72);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Succession recap: season two finale – it’s a killer all right', 'abs.jpeg', '‘You’re not a killer. You have to be a killer’
Well this is a killer all right. A finale that seems to be tapering towards a sombre, inevitable conclusion only to lash you round the face with the sting in its tail and set us up for the already-commissioned third season.
With Logan making his curdling promise of a “blood sacrifice” last week, the emphasis shifted from which sibling will take over from Logan to who will be thrown out as red meat and bones to shareholders. They are getting restless at the inquiry into historical wrongdoing; one even suggests to Logan that he himself take the fall. He notes the suggestion.
The clan are gathered for a mini-break in Venice aboard a huge, overbearing ship that passes through the water like a giant black shark. It ought to be fun; Roman has been sprung from his Turkish captivity, an experience that has subdued him and taken the edge off his customary caustic wit. There is a scene of almost affectionate lightheartedness between the siblings as they soak up the sun together. But as Logan arrives in his black helicopter, the mood darkens, lowering all their spirits.
', false, TIMESTAMP '2020-10-10 14:00:04', 226, 'article', 'tv show', 41);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Ballaké Sissoko: Djourou – dreamy and adventurous', 'abs.jpeg', 'It says much for Malian music that two of its greatest players, kora masters Toumani Diabaté and Ballaké Sissoko, are among its most determined innovators. Not content with weighty family legacies (the two are cousins), they have won international recognition for their instrument, the 21-string west African harp, in part through cross-culture collaborations. Diabaté’s latest, with the London Symphony Orchestra, is imminent, while here Sissoko has sought out an assortment of guests. Among them is cellist Vincent Ségal, with whom he has already cut two sublime albums, and who joins clarinet player Patrick Messina for a sprightly take on Berlioz’s Symphonie Fantastique.
Dreamy, hypnotic moods are default for kora, and Djourou provides several variations. The title track features Gambia’s Sona Jobarteh, who adds haunted vocal wails to their duet, while Parisian popster Camille whispers breathlessly in praise of Sissoko’s instrument on Kora. There’s a nostalgic cast to Kadidja, a slow meditation from Anglo-Italian singer and label mate Piers Faccini (who has a fine album of his own out in April), some grit from rapper Oxmo Puccino on Frotter Les Mains (Rub Hands) and nine meandering minutes with rock band Feu! Chatterton on Un Vêtement Pour La Lune (Moon Wear). Engaging and adventurous.
', false, TIMESTAMP '2019-09-01 20:20:26', 78, 'news', 'music', 46);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Bertrand Tavernier: a flesh-and-blood lion of French cinema', 'abs.jpeg', 'If any film-maker was a living, breathing, flesh-and-blood icon of French cinema, it was Bertrand Tavernier, the legendary, prolific director and a proud son of Lyon – which was itself arguably the historical epicentre of cinema, as the city where Auguste and Louis Lumière set up business. In 2017, I went to the Lumière festival in that city, and was briefly introduced to him there. Tavernier’s presence was indispensable: I have a photograph of a raucous dinner hosted by Thierry Frémaux with Benicio del Toro and Alfonso Cuarón, and Tavernier is an impish, grinning figure to be glimpsed in the mirror, loved by everyone there, a sprightly tutelary deity.
His movies ranged from satire to period drama, social realism, jazz, hardboiled crime, sci-fi and fierce anatomies of the French experience of the second world war. He started as a movie-mad youth after the war, working as a publicist and assistant director, branching out into screenwriting and then into directing itself. But his body of work was not just an embrace of the New Wave but also a continuation from it, and perhaps also a reconciliation with the more stately cinéma du papa which the young turks had rejected. Specifically, Tavernier worked with two screenwriters, Jean Aurenche and Pierre Bost, who had actually been singled out for attack by François Truffaut in his essay Une Certaine Tendance du Cinema Français, for being at the heart of the cinema’s decline in France.
', false, TIMESTAMP '2021-02-02 03:00:00', 156, 'review', 'cinema', 52);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Fiction for older children', 'abs.jpeg', 'Saving a bear, saving a mother – or others like you, or the world: children’s literature would be bereft without quest narratives. In her middle years fiction debut, journalist Amy Raphael plunges the reader into the fraught mid-17th century, where the soft warmth of horses and the tang of Scottish religious intolerance figure heavily.
Soldiers are rounding up medicine women, accusing them of witchcraft. When Art Flynt’s mother is hauled away, she grabs her herbal recipe book and heads south to free her from the witchfinder general before the executions on midsummer eve. The Forest of Moon and Sword (Orion, £7.99) is a fast-paced and single-minded adventure, featuring plant lore as well as a cast of unexpected allies, human and animal; female bravery is a given.
Elle McNicoll’s first book, A Kind of Spark, wondered how many non-neurotypical women were swept up in those Scottish witch purges. Her second outing is even more imaginative and assured. A London tech startup called Pomegranate is perfecting interactive hologram-avatars of people – to comfort the bereaved, they say.
Cora, 12, is on the autism spectrum, and the company is keen to interview her to better understand psychological diversity. Cora’s new buddy Adrien isn’t so sure. Show Us Who You Are (Knights Of, £6.99) is just terrific, an upper-middle-years thriller whose plot never sacrifices nuance. “I’ve never met a grownup who really has been able to sell adulthood to me,” muses Cora, wisely, at one point.
Amari Peters, hero of US author BB Alston’s debut, Amari and the Night Brothers (Egmont, £12.99 hardback), is another girl forced far outside her comfort zone to rescue someone she cares about. Fans of Harry Potter may recognise the scenario: previously unaware of the supernatural world, Amari ends up at magical summer camp, where the others are wary of her.
There are trials to pass; an evil magician is sowing fear and chaos. What’s new here is that Amari is a clever girl from a BAME neighbourhood, continually having to convince the rich racists at her fancy school that she deserves her scholarship. So tackling the prejudice of the magical world, sorting friend from foe – and rescuing her beloved brother – is all in a summer’s work in this beguiling debut.
', true, TIMESTAMP '2020-01-31 12:30:58', 132, 'article', 'literature', 85);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Comfort food: the Oscars nominations are not nearly as radical as they think they are', 'abs.jpeg', 'As ever when the Oscar nominations are announced, there is a sense of mystery about the industry’s revealed groupthink, that consensus which is unveiled as solemnly as the half-time score at the Super Bowl. This is an interesting and lively Oscar nomination list, but is there something a bit retrograde and nostalgic about the frontrunner – however brilliant it assuredly is? Will the 2021 Oscars reflect modern America and contemporary issues in the way increasingly demanded of awards ceremonies? I’m not sure.
David Fincher’s Mank is a gorgeously rendered monochrome fantasy about the genesis of Orson Welles’s classic 1941 movie Citizen Kane, and the role played by its co-writer Herman Mankiewicz, played by Gary Oldman; it is now the frontrunner, surging ahead with 10 nominations, notably in front of Chloé Zhao’s stunning docu-fictional road movie Nomadland, Sound of Metal, with Riz Ahmed as the drummer losing his hearing, Shaka King’s Judas and the Black Messiah, about the FBI’s killing of Black Panther leader Fred Hampton, the dementia drama The Father, with a heartwrenching performance from Anthony Hopkins, Lee Isaac Chung’s Minari, an exceptional tale of Korean immigrant farmers in Reagan’s America, and Aaron Sorkin’s egregious liberal-patriot drama The Trial of the Chicago 7 – all with six.
But as for Kelly Reichardt’s First Cow, her wonderful and resonant tale of the old west and one of the very best American films of the year – zilch. Or how about Kitty Green’s stunning sexual politics drama The Assistant? No movie could possibly have confronted with more ferocity and candour the issue of Weinsteinian abuse — something that so recently was convulsing the entire industry. But no nominations there. Those films were comprehensively bested by efforts like News of the World, a very moderate, stolidly unexciting western starring Tom Hanks (with four nominations) or indeed Ron Howard’s ropey and muddled family drama Hillbilly Elegy (with two nominations, including one for Glenn Close for best supporting actress, in the borderline absurd role of the frizzy-haired backwoods grandma.)
', false, TIMESTAMP '2019-06-10 18:26:42', 25, 'review', 'cinema', 93);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Peaky Blinders recap: series five finale – is it curtains for Tommy Shelby?', 'abs.jpeg', 'Poor Tommy Shelby; the one man he can’t defeat is himself. An episode that began with him accepting pep talks from Winston Churchill ended in a full-blown existential crisis.
But while the show’s protagonist almost certainly won’t kill himself between series – my money is on time on the road taking Charlie’s gypsy walking cure – I did genuinely enjoy this gloomier-than-usual finale and how the storyline ultimately played out.
That’s largely because there was something refreshing about the fact that Tommy didn’t get it right, that he was undone, that his ever-ticking mind began to falter.
This hasn’t been a perfect series (although I have personally enjoyed it) but one thing that has been beautifully handled has been Tommy’s impending breakdown. The crisis has been coming since the opening episode and when it finally arrived, with Tommy genuinely unclear how he had lost and Mosley won, it rang absolutely true.
That said, while I generally prefer the more talky episodes of Peaky and downbeat series endings, I’m sure more than one viewer will have felt this conclusion set up more questions than it gave answers, as well as going round in circles (particularly where Arthur’s story was concerned) just when it needed to build impetus the most.
I did also wonder if Peaky Blinders increasingly needs more time to tell its story. Would another couple of episodes have allowed us to learn more about Gina or the Chinese, to spend more time with Polly and Aberama, to see a bit more of Jessie Eden or feel the gut-punch of poor Finn’s mistake more clearly?
', true, TIMESTAMP '2019-08-15 20:10:32', 186, 'news', 'tv show', 66);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Handmaid’s Tale recap: season three finale – June is unstoppable!', 'abs.jpeg', 'When Mayday was introduced in season one, it was a shady resistance June wanted to turn to for help. We glimpsed only the skinniest branches of the organisation and assumed that there was some central hub somewhere, a powerful figure running the show. But in this season three finale, we learn that Mayday isn’t some grand plan or a hierarchy of rebels – it’s anyone who wants to damage Gilead. Right now, Mayday is a handmaid and two Marthas in Commander Lawrence’s kitchen. June has become Mayday – and suddenly the show’s decision to name ‘Offred’ June feels a wee bit on the nose.
Within moments, June has resorted to keeping her plan to rescue 52 children on track with the gun that’s been waiting patiently to become a plot point since episode 11. She’s convinced that ruthlessness is how the men of Gilead won, and that victory goes not to who is right, but to whoever has the hardest heart. These days June’s heart is hard enough to threaten a frightened child with a gun, and stand firm against Lawrence’s final spasms of fragile masculinity (“You’re still in my house, young lady!”). She still believes all her suffering and all her crimes must amount to something, even if Lawrence insists that “the universe doesn’t have a balance sheet”. She’s going to rescue those kids if it kills her and everyone else involved in the plan – including Rita and Janine.', true, TIMESTAMP '2019-06-21 22:48:48', 275, 'news', 'tv show', 84);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Christopher Boy’s Communion review – Mamet’s warped drama of motherhood and murder', 'abs.jpeg', 'It is peculiarly low-key for a playwright of David Mamet’s stature to have the UK premiere of his new drama in a weekday afternoon slot on BBC Radio 4. His last play, Bitter Wheat, came to the West End with all the usual fanfare and drum-rolls, although it then received a critical drubbing. It has been suggested that this is why The Christopher Boy’s Communion was staged in such a muted way in Los Angeles last February for a mere two-week run.
Now, the play has been adapted as an audio drama and it is, thankfully, a very different beast from Bitter Wheat – although it still circles around the subjects of male violence, the nature of evil and warped moralities. These themes are refracted through the central, indomitable figure of a Manhattan mother, Joan, whose son, Michael, is in jail after killing and mutilating his Jewish girlfriend.
Directed by Mamet’s long-time collaborator, Martin Jarvis, it has the forward propulsion of a thriller but is essentially a play of ideas over action and sits naturally in its audio form. The dialogue bears Mamet’s signature to-and-fro: one character drops the ball as the other gains the advantage and this tennis match rhythm again translates well into audio.
Joan, played by Mamet’s wife, Rebecca Pidgeon, is both arch-matriarch, willing to sacrifice everything to save her son, and conniving, amoral villain, attempting to persuade and manipulate the forces around her into freeing Michael from jail, including her husband (Clark Gregg), their lawyer (David Paymer) and her priest (John Pirruccello).
', true, TIMESTAMP '2019-04-15 06:18:32', 23, 'review', 'theatre', 69);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Floating Points, Pharoah Sanders, LSO: Promises review – extraordinary', 'abs.jpeg', 'Not strictly classical, jazz or ambient electronica, this one-track, nine-movement album embodies the highest, most etiolated aspects of all three disciplines. British artist Sam “Floating Points” Shepherd is the anchor here, an electronic free thinker with a neuroscience doctorate. He supplies recurring leitmotifs and Promises’s sense of gossamer, largely peaceable inquiry. Jazz legend Pharoah Sanders should need no introduction; in his first recordings for more than 10 years, the saxophonist mostly holds off the free skronk of some of his most famous recordings in favour of his other mode: deeply felt spiritual jazz interventions. (Sanders’s wordless vocals also add to the promise of Promises.) Halfway through, the forward-thinking London Symphony Orchestra strings turn up and the dappled otherworldliness enters a more cinematic and canonical phase, but hardly to the detriment of the piece overall, instead adding depth and weight. There is room here too for a highly sophisticated iteration of cosmic psychedelia, for drones and tiny rustles, for electronic birdsong and the audible thud of fingers on keys as the mood swings from succour to awe and back again many times. Recorded over the course of five years, this extraordinary collaboration deserves excellent speakers and a soft couch to catch the swooning listener.', true, TIMESTAMP '2020-01-31 08:44:46', 212, 'review', 'music', 55);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Poldark recap: a big finale that was maddening, stressful … and joyous', 'abs.jpeg', 'Ah, ’Darkers. Here ’twas. The end of an era. And so ’tis only right that there be many fireworks. “I may have used a little too much powder,” grinned Zacky. “Proper job!” And so ended our life in Nampara. Not so much with a bang or a whimper but with a series of bangs that left us with a bit of a headache. (I wish. Let’s not dwell on that metaphor.)
What a great deal of powder indeed was used for this episode! Was it too much powder? Or simply what was needed for a proper job? It’s hard to say. But I think a fair assessment is that there was enough going on here to last us another few years of Poldark, so it was kind of annoying that it had to end this way, wrapped up so abruptly, almost with the action on fast-forward to get through it all in time.
In the end it was pretty great television. There was just too much of everything. “The agony of never just a moment’s peace! It’s my faith that’s broken. It can’t be remade.” Well, we know how you feel Demelza. The first 27 minutes of this were agony, us not entirely knowing whether Ross had gone bad or whether he was just doing his James Bond act. It became extremely confusing knowing who was on what side and extremely stressful worrying about whether Sir Evil George and the slave traders would foil everything.
', true, TIMESTAMP '2019-03-04 17:09:00', 52, 'news', 'tv show', 54);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Michael Sheen to star in Under Milk Wood at the National Theatre', 'abs.jpeg', 'The National Theatre in London is set to reopen in June with a new version of Dylan Thomas’s “play for voices” Under Milk Wood, starring Michael Sheen and Siân Phillips. The production, announced on Thursday, will be performed in-the-round in the Olivier theatre, which was reconfigured last year to accommodate socially distanced audiences for Death of England: Delroy and the panto Dick Whittington.
The National will also reopen its smaller stage, the Dorfman theatre, for the first time since the pandemic caused theatres to close last March. It will present Jack Thorne’s adaptation of the Japanese film After Life, a metaphysical comedy directed by Hirokazu Kore-eda that was released in 1999. The Olivier theatre will hold a capacity of approximately 500 and the Dorfman will be capped at audiences of 120.
Rufus Norris, director of the National Theatre, said it had been an “incredibly difficult year” for the industry but that he looked forward with “cautious optimism” to welcoming back larger audiences soon. He acknowledged that the National’s popular lockdown streams had reached millions around the world but added that “the magic of live theatre is what we can now begin to look towards: to creating work with our freelance artists and colleagues, to supporting young people’s creativity, and to bringing joy to audiences and communities through imaginative and inspiring live performance”.
', true, TIMESTAMP '2020-06-18 05:45:37', 244, 'news', 'theatre', 98);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Children’s books roundup: the best new picture books and novels', 'abs.jpeg', 'There’s a bumper crop of brilliant books for those aged eight and above this month, including Vi Spy, Licence to Chill (Chicken House), first in a new series by Who Let the Gods Out? author Maz Evans. Valentine “Vi” Day has an unusual family; her dad was a supervillain, her mum is an ex-spy and just about to marry Vi’s teacher. Now Vi herself is determined to win a place at spy school by carrying out a dangerous mission, with the help of her indomitable Nan, her shy almost-stepbrother, and a supporting cast of geriatric secret agents and semi-retired rogues. Wildly hilarious, full of bum jokes and acutely observed family dynamics, and with illustrations by Jez Tuya, it’s riotous escapist fun.
More complex family interactions lie at the heart of Proud of Me (Usborne) by Sarah Hagger-Holt. Josh and Becky were born to their two mums only eight days apart. As the siblings hit their teens, Becky begins to wonder whether she might be gay herself – and Josh is increasingly desperate to discover more about their donor … Warm, sweet, funny and believable, this gentle coming-of-age story is thought-provoking without ever sacrificing plot to “issues”.
Also from Usborne, Andy Prentice and Eddie Reynolds’s Climate Crisis for Beginners, illustrated by El Primo Ramon, is a clear, comprehensive guide to something that often feels too huge to be understood or coped with. Demystifying complex issues of ethics and science, its calm, straightforward tone confers a sense of much-needed agency on readers from eight to adult.
', true, TIMESTAMP '2019-07-03 11:49:40', 69, 'article', 'literature', 60);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The naked protest at this year’s César awards looked radical. In fact, it was a national embarrassment', 'abs.jpeg', 'Another year, another happening at the Césars ceremony, France’s film awards, which took place on Friday night. This year, amid the scatological jokes, sanctimonious, badly written speeches, and recriminations, an actor known for her fiery politics stood out. She appeared naked, covered in (probably fake) blood, and wearing dripping wet tampons as earrings. Nobody batted an eyelid in the audience, since the actor, Corinne Masiero, is a well-known face on French television, involved in all sorts of political agitprop. People in front of their TVs at home were less blase. Perhaps because some of them still look up to artists and regard cinema as an art form. Many of them felt terribly let down.
Masiero had a message for the French government. She had painted it on her breasts: “No culture, no futur” in English. “We are dying, we can’t breathe,” she later claimed. If many people question the current closure of cinemas and theatres, which could arguably reopen under strict sanitary rules, Masiero sounded more preoccupied by the financial plight of French artists. The only thing is, as many vented on Twitter, France has one of the world’s most generous artist benefit schemes. I know it well, since I was lucky enough to use it for a few years.
Created in 1936, the Intermittents du Spectacle system was first designed for the film industry’s artists and technicians whose activity is by nature irregular. It now protects 250,000 beneficiaries across cultural sectors including theatre, dance and music. All you need is to clock 507 hours of paid work in order to benefit from monthly state support for a whole year. The system allows artists between jobs to pay their bills, train or perfect their art, or look for the next project. In other words, it enables them to live from their art. You could call it a luxury, a privilege even, but it is an essential one, which French artists have repeatedly and rightly fought to keep. If they have managed to preserve this generous system through the years, despite successive governments intent on making it less liberal, it is because, as President Macron said, “Culture in France is absolutely essential to our lives as citizens.” And this is precisely the reason why, as early as last summer, the French government announced that unemployment benefits for artists would be guaranteed until 1 September 2021.
Knowing this, many French viewers thought Masiero’s intervention rang self-obsessed and hollow, if not plain grotesque: a bourgeois playing the radical. How typically French. If only Masiero’s jeremiad had been a show of solidarity for her fellow artists in the world, genuinely deprived of state aid, her words would have rung truer. In Britain, for instance, Brexit and Covid have crucified the cultural industries and their workers, many of whom have had to abandon their art and retrain as, for instance, drivers or couriers in order to survive. How much British artistic talent will have been lost to the world? I fear that the answer is a lot. Wouldn’t this be worth a few minutes of French spoiled brats’ precious anger?
', true, TIMESTAMP '2019-02-09 13:35:34', 98, 'article', 'cinema', 96);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('As a Black Lord of the Rings fan, I felt left out of fantasy worlds. So I created my own', 'abs.jpeg', 'When I was a child, I was what you would call a JRR Tolkien fangirl. I read The Lord of the Rings over and over. I traipsed around the countryside, imagining it was Middle-earth. With just a flight of imagination, I could be snug in the Shire, exploring the mines of Moria, or even flitting through the woods of Lothlórien.
When the first Lord of the Rings movie was finally released, I was 14 and so excited to see it. But immediately, I noticed something distressing: no one on screen looked like me. The darkest characters on screen, the orcs, were all male. Even as a monster, it seemed, there was no place for people who looked like me in Tolkien’s world.
Thankfully, I had my own to work with. I grew up in Sierra Leone, a place I consider the most fantastical in the world. Magic was everywhere I looked. It was in my family’s massive library, where there were so many books that I would make fortresses of them and crawl inside. It was in the ocean just beyond my veranda, where, if I squinted hard enough, I would sometimes see whales breaching. It was in the trees, the people, the land itself. It was always there.
Fantasy was a lifesaver. When I was born, in the late 1980s, Sierra Leone was on the brink of civil war. The country was in chaos; people were suffering and dying. To distract me, my father and grandmother would tell me stories about the magic of Africa, some of them rooted in real history. Mami Wata, the goddess of all waters, slept in the salt marsh beyond our house that fed into the Atlantic ocean. In the Dahomey kingdom (now Benin), an all-female military force called the N’Nonmiton, or Dahomey Amazons, hunted elephants for their king. The Dogon tribe of Mali, our ancestral home, had mapped the stars without telescopes.
When I moved to the US in 1996, war was suddenly no longer a part of my life. But neither was the magic. Instead of goddesses and Amazons, there was now the legacy of slavery, civil rights and racial struggle. I was told that I was a Black person, and that Blackness came with a particular history and set of expectations, most of which I’d never heard of before. I’d only ever been Temne, my tribe in Sierra Leone. How was I supposed to understand this new identity?
Worse, there were no more epics. Growing up, my father had explained to me that epics – especially fantasy epics – are the mythos of a culture: they determine how a people see themselves. But in the US, it seemed Black people weren’t afforded the privilege of crafting our own narrative in the fantastical sense. In every book, every film, every advertisement, Black people struggled. We were poor, we were uneducated, on drugs or the drug dealers. We were baby mamas, gangsters and prisoners. We were perpetual victims or perpetual predators, lurking on the fringes of society.
But this didn’t make any sense to me. I knew my history. Yes, some Black people had been slaves, but others had been queens, kings, adventurers, tricksters, country folk. Yes, there were huts and slave cabins, but there were also castles in Ethiopia, towering walls and streetlights in Benin, libraries in Timbuktu and fortresses in Great Zimbabwe. The richest man to ever exist, Mansa Musa, was African. The N’Nonmiton, the female warriors my father and grandmother had told me tales about when I was young, were African. There was more to Blackness than struggle.
But in every Black book that won a medal, or every Black film that won an Oscar, there was always a Black person struggling against racial oppression. There are consequences to only lauding such portrayals. Perpetually tying the narrative of Black people and Blackness to slavery, colonisation and oppression meant that Black people – Black children especially – were denied the chance to see ourselves as heroes with agency over our worlds. And non-Black people were denied the chance to root for us, only feeling pity and, of course, relief that they were not Black.
', true, TIMESTAMP '2019-10-11 10:29:40', 249, 'news', 'literature', 97);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Lana Del Rey: Chemtrails Over the Country Club review – the same old love story', 'abs.jpeg', 'There is boldly talking your new album up, and then there is the approach taken by Lana Del Rey prior to the release of Chemtrails Over the Country Club. “I am literally changing the world by putting my life and thoughts and love out there on the table 24 seven,” she wrote during a social media exchange about her eighth solo album’s cover art. “Respect it.”
Clearly, here were rich pickings for connoisseurs of the point where a pop star says something so self-regarding it makes your head hurt, but Del Ray may be forgiven for getting carried away. An artist given an unfairly rough ride on arrival, she finds herself, a decade on, not merely vastly commercially successful, but hugely influential, the inspiration behind a wave of melancholy bedroom pop that loops disconsolately in the background of TikTok videos. Moreover, her last album, 2019’s Norman Fucking Rockwell!, topped critical end of year lists (including in the Guardian) and was hailed as the work of “simply one of the best songwriters in the country” by Bruce Springsteen. She was recently featured on the front of a heritage rock magazine that doesn’t ordinarily put photographs of thirtysomething singer-songwriters on its cover unless they were taken in 1972. “Joan Baez advocates her acceptance in the pantheon,” it wrote, reassuring its more conservative readers.
', true, TIMESTAMP '2020-01-06 00:20:07', 2, 'news', 'music', 95);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Rocks on! The Baftas’ diversity push has been brilliantly vindicated', 'abs.jpeg', 'The Bafta nominations seem this year to have answered two perennial objections: that they are not diverse enough and – perhaps paradoxically – not British enough. Four out of the six best director nominees are women: Chloé Zhao for the docufictional road movie Nomadland, Sarah Gavron for the explosively energetic social-realist Rocks, Jasmila Žbanić for Quo Vadis, Aida?, a gruelling reconstruction of the Srebrenica massacre during the Bosnian war, and Shannon Murphy for her family dysfunction drama Babyteeth.
Bafta has also expanded the outstanding British film category to 10 entries, apparently in honour of the entrants’ strength (although this is arguably an artificial bit of goalpost moving). The star of this category is Rocks, which jointly leads the pack with a handsome seven nods, level with Nomadland; Florian Zeller’s harrowing dementia drama The Father gets six, along with Emerald Fennell’s brilliant rape-revenge satire Promising Young Woman. The outstanding British debut section – long considered the beating heart of the Baftas, and the category where a nomination can launch a career – has a lot of duplications with outstanding British film, and it’s great to see double-nods for Ben Sharrock’s wonderful refugee movie Limbo and Rose Glass’s outstanding horror Saint Maud.
As for snubs, I’m sorry to see Bafta pretty much turn its nose up at Christopher Nolan’s colossal metaphysical thriller Tenet (a single nomination). The foreign-language category is a terrific list with Andrei Konchalovsky’s Dear Comrades!, Lee Isaac Chung’s Minari, Žbanić for Quo Vadis, Aida? and Ladj Ly’s Les Misérables – but I’m a bit mystified at the reverential adulation for Thomas Vinterberg’s amusing but facetious and directionless booze comedy Another Round, when there were better films like Alejandra Márquez Abella’s The Good Girls, Shahrbanoo Sadat’s The Orphanage and Roy Andersson’s About Endlessness.
But Rocks really has scored a resounding success with its seven nominations: the Brit social-realist adventure written by Theresa Ikoko and Claire Wilson, directed by Sarah Gavron, and starring newcomer Bukky Bakray as “Rocks” – a Nigerian-British girl in east London who has to look after her brother Emmanuel when her mum vanishes. It’s a film fizzing with energy, creativity, love and fun and it would be great to see this film triumph on the night. As for Nomadland, Chloé Zhao’s inspired generic hybrid film stars Frances McDormand playing a fictional “nomad”, one of the formerly prosperous US retirees financially stricken by the 2008 crash and forced to sell up and go on the road in their vans and RVs – McDormand plays opposite real nomads and Zhao’s mix of real and imagined is masterly.
The massive reputation of Anthony Hopkins and Olivia Colman has clearly spread the word about The Father to Bafta voters well in advance of its planned June release date – its six nominations include best actor for Hopkins in the unforgettably harrowing role of “Anthony”, an ageing man succumbing to dementia and finding that his whole world is beginning to unravel into meaninglessness, to the horror of his daughter, played by Colman.
', true, TIMESTAMP '2020-10-01 07:31:51', 91, 'article', 'cinema', 42);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Redwall is coming to Netflix: where to start for kids (and adults)', 'abs.jpeg', 'If, like me, you are a fan of Brian Jacques, then the news that Netflix is working on an adaptation of Redwall will have you setting the abbey bells a-ringing in joy. Jacques’ bestselling stories of talking mice, squirrels and otters (the goodies) and rats, foxes and wildcats (the baddies) gave me so much happiness as a child. The first novel, 1986’s Redwall, was my introduction to fantasy: Matthias, a young orphan mouse, seeks a lost sword to see off an evil rat army led by Cluny the Scourge. (“Cluny was a God of War! Cluny was coming nearer!”) Heroism and sacrifice, comedy and evil – all of life is contained in Jacques’ anthropomorphic world.
After Redwall, Jacques told the story of how Redwall Abbey came to be, in the sequel Mossflower, as Martin the Warrior (another mouse, of course) arrives to save the creatures of the forest from the grip of the wildcats (Tsarmina Greeneyes is a particularly wonderful villain). Mattimeo continued the saga, following Matthias’s son as he is kidnapped by the slaver fox Slagar the Cruel (another excellent baddie; Jacques does villainous animals very well).
Born in 1939, Jacques’ books were informed by the second world war, and his memories of rationing. Even the word “feast” transports me to his depictions of groaning tables laden with deeper’n’ever pies, Goody Stickle’s new yellow cheese, “bulrush and water-shrimp soup provided by the otters; a large flagon of Skipper’s famous hot root punch”.
The whole saga continues for some two dozen books; for my money, the first three are the best, and Redwall is definitely one for kids who love the talking animals of Dick King-Smith. There is darkness in Jacques’ world, but it is less terrifying – and far less adult – than Watership Down. There is humour, but less wordiness than The Wind in the Willows. This is something for children to read alone and have fun with, chunky slices of adventure they can lose themselves in. It has been a delight to see my daughters enjoying the books as I did, weeping inconsolably at the deaths of Methuselah and Warbeak, as I did. “Finally!” the eldest just told me, at the news of the forthcoming adaptation.
Patrick McHale, creator of the Netflix animation Over the Garden Wall, will be writing the feature film, which will be based on the first book in the series, Variety reports. This will be the first time a feature film of any of Jacques’ works has been made, although there was a cartoon series in the late 90s. Netflix is also developing a series based on Martin the Warrior.
“Brian often travelled the globe to tell his Redwall stories to young audiences, more often than not at their schools,” Alan Ingram, representative of the Redwall Abbey Company, which has owned Jacques’ intellectual property since his death in 2011, told Deadline. “Brian would have been very happy to see that Netflix shares his joy and desire to bring his stories to life as a new universe of films, series and potentially much more for audiences of all ages to enjoy.”
', true, TIMESTAMP '2019-08-18 08:17:05', 38, 'review', 'literature', 37);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Coming 2 America is an unfunny disaster for representation', 'abs.jpeg', 'The shortcomings of the much-anticipated comedy sequel Coming 2 America are too many to list. But they all begin and end with the unfortunate yet predictable truth that the film simply didn’t need to be made. Inundated with tired tropes and stereotypes of black people on both sides of the vast Atlantic, it is difficult to grasp the objectives of the movie, parse through its dubious humour and imagine who its intended audience is.
The writers (Kenya Barris, Barry W Blaustein, David Sheffield) are self-aware enough of fans’ preconceived skepticism concerning the project, to insert a dialogue in which newly introduced characters absent in the film’s prequel, Coming to America, confess this follow-up’s lack of purpose. Lavelle (Jermaine Fowler) – who plays the long-lost son of the prince-turned-King Akeem (Eddie Murphy) – points out to his bona fide Zamunda romantic interest, Mirembe (Nomzamo Mbatha), that her love of American movies ignores that American cinema now includes remakes nobody asked for. It’s a warranted self-deprecating quip. It’s also a rare moment in the film that is actually funny, which is a far cry from its 1988 predecessor.
', false, TIMESTAMP '2019-08-05 06:02:36', 104, 'review', 'cinema', 26);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Allen v Farrow is pure PR. Why else would it omit so much?', 'abs.jpeg', '“HBO Doc About Woody Allen & Mia Farrow Ignores Mia’s 3 Dead Kids, Her Child Molester Brother, Other Family Tragedies” was the headline on one US showbiz site, above its review of the four-part documentary, Allen v Farrow, about the continuing battle between Woody Allen and Mia Farrow, now entering its fourth decade. But this review was very much an outlier. In the vast main, reaction to the strongly anti-Allen series has been overwhelmingly positive, with Buzzfeed describing it as a “nuanced reckoning” and Entertainment Weekly comparing it to the recent documentaries about Michael Jackson and Jeffrey Epstein. This reaction is more of a reflection of the public’s feelings towards Allen – particularly in the US – than of the documentary, which sets itself up as an investigation but much more resembles PR, as biased and partial as a political candidate’s advert vilifying an opponent in election season.
A recap for those who have managed to stay ignorant of this enduring family drama or, more likely, forgotten the details over time, something the documentary is heavily counting on. Back in 1992, Allen, then 57, admitted he was having an affair with Soon-Yi Previn, 21, the adopted daughter of his longterm partner, Farrow, with whom he had two adopted children – Dylan and Moses – and one biological child, Ronan (known then as Satchel). Several months after that, at the height of their viciously acrimonious break up, Farrow accused Allen of molesting Dylan, who was then seven, one afternoon while she was out of the house. Doctors examined Dylan and found no evidence of abuse. Allen was investigated by the Yale New Haven Hospital’s sexual abuse clinic which concluded: “It is our opinion that Dylan was not sexually molested by Mr Allen.” He was also investigated by New York State’s Department of Social Services, which wrote: “No credible evidence was found that the child named in this report has been abused or maltreated.”
In Allen v Farrow, directors Amy Ziering and Kirby Dick play on two strong currents in today’s popular culture: first, the enormous appetite for true crime documentaries, and second, a re-evaluation of past wrongs, looking back at a distant time when people were insufficiently evolved to understand social justice. These two elements struggle to work together because unless a true crime documentary has a smoking gun – such as Robert Durst’s confession in The Jinx – the appeal of the genre lies in its ambiguity, allowing the audience to play detective, such as with the podcast Serial, or Netflix’s Making a Murderer.
', false, TIMESTAMP '2019-02-17 11:16:33', 118, 'news', 'cinema', 91);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('‘My portal to the outside world’: a year of living vicariously through TV', 'abs.jpeg', 'I found myself so stressed watching Netflix’s psychological thriller Behind Her Eyes that there were little red marks on my face from where I was pulling at my cheeks. “Is she doing it? Is she doing it?” I screamed as Louise went into her boss’s office and started rummaging through his papers, my mum narrating the scene because I was too tense to watch it. Minutes later, I was digging my nails into my palms as Louise headed off for another gym date with that rich woman who holds eye contact for a suspiciously long time.
Normally only Dogs Trust adverts affect me like this. But since the pandemic started, I have been significantly more emotionally invested in TV than ever before. In the past month, I have cried more than that judge on The Great Pottery Throwdown who tears up every time someone makes a nice vase. That is if I am watching what is on the screen – mostly I am so concerned for characters that I am hiding behind a large sofa cushion.
When I talked to a friend about my fragile state, she snorted: “Relax, they’re just actors.” Of course, she is right – after they filmed that Behind Her Eyes scene, someone in the real world shouted “cut” and the cast went off to get a coffee and moan about the catering, or something. But knowing that doesn’t really help. In fact, her comment annoyed me, because even if it isn’t real, it feels real.
Coronavirus has meant that the life I used to lead – long evenings at the pub and overordering at restaurants – has been taken away. Now, all I do is clip my toenails and stare into the mirror for hours at a time wondering what surgery I would get done if I were to get surgery. TV is no longer just a reflection of reality; it is the only reality to which I have access. It has become my portal to the outside world, a world in which I can no longer actualise myself.
', false, TIMESTAMP '2020-07-07 18:59:14', 231, 'review', 'tv show', 5);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The RSC at 60: the glorious past and vital future of a theatrical revolution', 'abs.jpeg', 'What’s in a name? Quite a lot, as it happens. In 1960 Peter Hall created a theatrical revolution. He turned a summer Shakespeare festival in Stratford-on-Avon into a year-round enterprise based on a permanent ensemble, a second home in London and a mix of classical and contemporary work. But it wasn’t until 20 March 1961 that the whole enterprise was given the name we know today: the Royal Shakespeare Company. As the director William Gaskill cynically remarked of the new title: “It has everything in it except God.”
Sixty years on, even as we celebrate the RSC’s survival, new questions arise. What is it really for? How does it adapt to a changing world? Do we still believe in large theatrical institutions? What is fascinating, as you look back over the RSC’s history, is how it faced challenges right from the start. West End producers, led by the all-powerful Hugh Beaumont at HM Tennent, felt threatened by its presence in London. The Arts Council, committed to the establishment of a National Theatre, was slow to subsidise the enterprise and always ensured it was treated as the poor relation. Even the grand vision of permanent companies soon lost its idealistic sheen. As early as 1973, Hall, confronting a hostile Arts Council Drama Panel as he took over at the National Theatre, noted how “the radical dreams of yesterday become the institutions of today to be fought and despised”.
', false, TIMESTAMP '2020-06-15 02:29:27', 206, 'news', 'theatre', 20);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Justin Bieber: Justice review – hot goings-on, not What’s Going On', 'abs.jpeg', 'Justin Bieber’s sixth studio album comes accompanied by a personal statement. “In a time when there’s so much wrong with this broken planet, we all crave healing – and justice – for humanity,” it says. “This is me doing a small part. My part. I want to continue the conversation of what justice looks like so we can continue to heal.”
You can certainly see why he has done this. We’re living through an era when it’s held to be important that pop music tackles – or at least is seen to be tackling – serious issues. It’s not unlike that point in the 80s when even Duran Duran felt obliged to mention nuclear war, lest anyone think that they weren’t agonising over the prospect of mutually assured destruction when not cavorting with models on yachts.
Perhaps the Serious Issues imperative currently weighs heavy on Bieber. His last album came trailed by Yummy, not so much a single as a jingle, its chorus patently designed for kids to play in their TikTok videos, the latterday equivalent of trying to spark a novelty dance craze. There was a distinct note of avaricious desperation about the way Yummy was promoted. Better to appear concerned with healing and justice for humanity than with gaming the streaming figures by telling your Instagram followers to play your new single non-stop while they sleep.
And you can see how the theme of “continuing the conversation of what justice looks like” fits with the interlude that bisects the album, an excerpt from a 1967 sermon given by Martin Luther King during which he described the biblical story of Shadrach, Meshach and Abednego as an act of civil disobedience: “If you have never found something so dear and so precious to you that you will die for it then you ain’t fit to live.” The recording is intense, stirring and completely at odds with the songs that surround it.
Aside from Lonely, a wracked and genuinely moving confessional about Bieber’s fall from grace – “everybody saw me sick, it felt like no one gave a shit” – these stick fast to the subject of how much he loves his wife. You feel a little churlish saying it – the poor bloke’s clearly been through the special kind of hell reserved for anyone unfortunate enough to become famous at a young age, and it’s lovely that he has found happiness and peace – but this is a topic that tends to pall fairly quickly, even in the most skilful hands, as the early 70s oeuvre of Paul McCartney attests. Here, its predominance leads the listener to develop a kind of frantic desperation to hear something that isn’t about how great Bieber’s wife is. The title of Off My Face looks promising, but that turns out to be about his wife as well: “One touch and you got me stoned.”
', true, TIMESTAMP '2019-03-27 16:59:45', 45, 'review', 'music', 6);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Golden Globes 2021: a night of fine choices capped by Chloé Zhao making history', 'abs.jpeg', 'The Hollywood Foreign Press Association, which decides on the Golden Globes, had this year been in trouble – as so often before – for its rackety and questionable procedures: this time for the #GlobesSoWhite makeup of its voting constituency. (Presenter Ricky Gervais had last year joked that it was just “very, very racist”.)
And yet, with the arguable exception of the snub to Michaela Coel in the TV category, the Globes’ awards this year have not been obviously different from high-minded critics’ choices and there has been diversity: from the spectacular triumph for Chloé Zhao’s docu-fiction Nomadland getting both best director and best film (drama), to Chadwick Boseman’s posthumous award for best actor (drama) for his brilliant, livewire performance as the troubled jazz trumpeter Levee in Ma Rainey’s Black Bottom.
There was also resounding success for Sacha Baron Cohen’s Borat Subsequent Moviefilm, getting best film (musical or comedy) and best actor (musical or comedy), for Cohen himself as the egregious Borat. Daniel Kaluuya was best supporting actor for his portrayal of Black Panther Party leader Fred Hampton in Judas and the Black Messiah, and Andra Day was best actress (drama) for her performance as Billie Holiday in The United States vs Billie Holiday. Two of the year’s very best films are on the list, too: Pixar’s wonderful movie Soul from directors Pete Docter and Kemp Powers won best animation (though it should have got a best film nomination, too) and Lee Isaac Chung’s Minari was best foreign film, about a Korean family trying to start a farm in the 1980s Reagan heartland. That, too, should have been brought more centrally into the fold, although it is great to see it rewarded.
', true, TIMESTAMP '2020-04-23 02:03:14', 168, 'article', 'cinema', 85);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Picture books for children', 'abs.jpeg', 'The acclaimed children’s author Tom Percival grew up in a caravan in Shropshire with no electricity or heating. Drinking water came from a spring in the garden and on cold mornings, he says, ice sparkled on the bedposts. While his latest book, The Invisible (Simon & Schuster), isn’t a memoir, his own experiences of being poor are clearly etched throughout this tale about a child whose parents can’t pay the bills – from the beautifully observed frost patterns on the opening pages to the way the pictures glow when the family are together.
Relocated to a grey, depressing neighbourhood after her family have to give up their home, Isabel notices that people look through her. She starts to fade away. But upon encountering others left behind by society – whether old, homeless or refugees – she starts invigorating the community from within, and colour begins to seep back into the washed-out illustrations. In the endnote, Percival says of his own childhood: “there were two things that I had plenty of – love and books”, and while Isabel’s story is a valuable look at the heartbreakingly relevant issue of poverty today, its focus is also on love, family and society.
', true, TIMESTAMP '2021-01-03 23:44:59', 94, 'news', 'literature', 43);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Esther Rantzen: ‘I’ve become one of the funny old ladies I used to talk to in the street', 'abs.jpeg', 'Awhile into my Zoom interview with Esther Rantzen, her phone rings. She apologises, says she must switch it off, answers it. “Hello,” she says. “Ah… Ah!” And she breaks into a big, familiar, toothy smile; a smile that, if you are of a certain age, will have been part of your television experience growing up. “Are you my second jab?”
The voice on the other end confirms that, yes, this is indeed her second jab. Next week, same place as the first, Milford on Sea. Fabulous news. Esther tells me she’ll take her daughter Miriam along with her in case they have any spare vaccine at the end of the day, she’s heard people have done this. Miriam who’s in her 40s (Esther forgets exactly how far into them) has myalgic encephalomyelitis, ME, but hasn’t been vaccinated. “It’s not considered an underlying health issue in spite of the fact that we know every time she gets a virus of any kind it produces a very serious relapse.”
They hope that Covid – in particular long Covid, with its similarities and links to ME, which is also known as chronic fatigue syndrome – might lead to the condition getting the attention and funding it does in America.
As well as gladly giving her second dose to her own daughter, Esther would donate it to a teacher or a supermarket worker if she could, “people who unlike me have to work in jobs that bring them into contact with people who may be infectious”.
', true, TIMESTAMP '2020-06-12 03:37:37', 233, 'article', 'tv show', 84);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Lockdown one year on: Hiran Abeysekera on how Covid nixed his West End debut', 'abs.jpeg', '“I was scared that I might not be able to do Pi again,” says Hiran Abeysekera, who was preparing to transfer his rapturously received 2019 performance in Life of Pi to the West End when the pandemic hit. “We were joking that when theatres finally reopened, I’d have grey hair and a walking stick. People would go: ‘Hiran, do you still want to do Pi?’ And I’d be like: ‘I can’t do it any more, man, I’m too old!’”
Abeysekera, who is a very youthful and ebullient 35, graduated from Rada in 2011. His credits include The Taming of the Shrew at the RSC and Peter Pan at Regent’s Park, and he played Puck in a spirited BBC adaptation, by Russell T Davies, of A Midsummer Night’s Dream in 2016. But Life of Pi in the West End was an obvious breakthrough moment. Lolita Chakrabarti’s stage adaptation of the Booker prize-winning novel by Yann Martel received five-star reviews when it opened at the Sheffield Crucible, and Abeysekera’s performance as Piscine “Pi” Patel – shipwrecked with various zoo animals, including a ravenous tiger – was hailed as star-making. The Guardian called it “superb”, noting that “the actor has the charm, wit and seriousness to make him a compelling narrator of his own magical-realist tale”. Our own reviewer described Abeysekera’s performance as “unbelievably credible”.
If things had gone to plan, Life of Pi would have opened at Wyndham’s theatre last June, giving Abeysekera his first lead role in the West End. Instead, when theatres were forced to close in March 2020, he retreated to a friend’s house in Dorset to wait out the lockdown, his breakthrough moment cast into uncertainty.
', false, TIMESTAMP '2021-03-11 05:25:36', 12, 'review', 'theatre', 29);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Daddy issues: how Nick Broomfield challenges his father’s legacy', 'abs.jpeg', 'Some documentaries are so vivid, so heartfelt, that you almost feel you’re somehow involved yourself. And for a very interesting reason, this is how I felt watching My Father and Me, the new BBC Two film from the Bafta-winning director Nick Broomfield, whose past work includes Kurt & Courtney, Whitney: Can I Be Me and Aileen: Life and Death of a Serial Killer, the piercingly intimate death-row study of Aileen Wuornos, which inspired the Hollywood feature Monster, starring Charlize Theron.
Broomfield’s new film is, to paraphrase John Mortimer, a voyage round his father, the photographer Maurice Broomfield, who died 10 years ago at the age of 94.
Maurice Broomfield’s beautiful, dreamlike and utterly unique images captured British industry in its postwar heyday. His images have come to be treasured even more now that the factories he shot have largely vanished. Broomfield would take stunningly composed pictures of factory floors, industrial buildings, nuclear cooling towers and production lines, with their smartly alert human attendants picked out with painterly care and detail. He would often curate and even fabricate his images like a cinematographer or production designer on a movie set, with fierce key lighting, and often demanded the entire space was repainted and reorganised to his specifications to create the dramatic effect he wanted – to show the spiritual truth behind the literal truth, perhaps: the dignity of labour and the heroism of industry.
', true, TIMESTAMP '2019-02-19 16:27:29', 29, 'article', 'tv show', 51);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('‘I’m immune to success’: Henry Lloyd-Hughes on fame, family and playing Sherlock Holmes', 'abs.jpeg', 'Henry Lloyd-Hughes’s Twitter bio states that he is “the most famous actor you’ve never heard of”. It is a line that appeared in a magazine profile of him last year. There is another profile, from five years earlier, that says roughly the same thing. He is a fantastic actor with a near flawless CV; if only he could somehow land that career-defining role that would push him over the top.
“It’s remarkable,” laughs Lloyd-Hughes, 35. “The false dawns I’ve had. I’m like the Teflon Don. You can put success near me, you can put me in the biggest-grossing British sitcom of all time, but it doesn’t touch me. It just runs off me. Fame can come this close to me and yet it leaves no trace. I’m immune to success.”
He certainly doesn’t behave much like a celebrity. In a world where the video-call interview has been finessed into something approaching high art, he bumbles into ours a couple of minutes late, plonking himself in a shed strewn with cricket paraphernalia, on what appears to be his mum’s account. “Perfect,” he mutters to himself as his chat window announces him as “Lucy”. “Every time …”
I don’t wish to add to the growing collection of articles promising that Lloyd-Hughes will be the next big thing, but he is about to unveil his most storied character yet. Because, in the Netflix series The Irregulars, he plays Sherlock Holmes. While Holmes fatigue is real – the Guinness World Records lists him as the most portrayed literary human character in film and television history, played in the past 15 years alone by Benedict Cumberbatch, Robert Downey Jr, Will Ferrell, Henry Cavill, Ian McKellen, Ewen Bremner, Jonny Lee Miller and Johnny Depp – this is not a take on the character you will have seen before.
', true, TIMESTAMP '2020-05-31 08:42:30', 31, 'article', 'tv show', 64);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Children’s books roundup – the best new picture books and novels', 'abs.jpeg', 'The year may be off to a dismal start, but January’s best books for children are filled with adventurous magic. For readers of nine-plus, BB Alston’s Amari and the Night Brothers (Egmont) is a Chosen One fantasy with a fabulous protagonist: a whip-smart black girl from the projects. Amari is convinced her brilliant brother Quinton isn’t dead, but the police have given up investigating his disappearance. Stumbling across a mysterious briefcase and an invitation to try out for the Bureau of Supernatural Affairs, Amari discovers the everyday world’s occult underbelly – and her own powerful magical gift. A splendidly imaginative debut, ideal for fans of the Percy Jackson or Nevermoor series.
Another debut, Lesley Parr’s The Valley of Lost Secrets (Bloomsbury), follows Jimmy in wartime, evacuated with his brother to a Welsh mining village, as he slowly acclimatises to his new surroundings. But when Jimmy finds a hidden skull, he unearths a secret that has haunted the community for years. Atmospheric, direct and gripping, with a superbly assured narrative voice, this book is woven through with powerful themes: grief, belonging and making peace with the past.
Liz Kessler’s When the World Was Ours (Simon & Schuster) is a more challenging second world war story, for readers who can handle history’s most painful truths. Told from the perspectives of three children – Leo and Elsa, both Jewish, and misfit Max, their friend – it begins on a perfect day of celebration in Vienna. As Hitler rises to power, the children are wrenched apart; and as they travel to England, Czechoslovakia and Germany, they are changed by what they endure. Vital glimmers of hope enlighten this profoundly poignant book, chronicling just how easily the unthinkable becomes the everyday.
', true, TIMESTAMP '2019-05-21 20:06:15', 269, 'review', 'literature', 62);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Raymond Antrobus: ’Deafness is an experience, not a trauma’', 'abs.jpeg', 'There’s a story that Raymond Antrobus often tells, from the time before his deafness was diagnosed when he was six: when his father read him a picture book, Antrobus would nestle into his father’s chest, and feel the story he could not hear through the vibrations of his body. The book was often his favourite, Happy Birthday Moon; both the memory and the book would, decades later, give him the name of a poem in his prize-winning debut The Perseverance. “I’d like to be the Moon, the bear, even the rain. / Dad makes the Moon say something new every night / and we hear each other, really hear each other. / As Dad reads aloud, I follow his finger across the page.”
Now the memory has also inspired his first picture book, Can Bears Ski? Antrobus finally became the bear: the book follows his cuddly little protagonist, who hears the book’s title when adults ask, “Can you hear me?”, until his deafness is finally recognised.
Antrobus, 34, originally declined to write a children’s book when he caught the eye of publishers while reading Happy Birthday Moon at a literary festival. “I told this story all the time but I never thought of it as a kids’ book. The thing is, I still very much see myself as a poet,” he says. “Poetry is the thing I live for. But I’ve realised that a lot of my worry has been ego. A lot of poets I love also write for children. I think it’s just snobbery. In the poetry world, if I am honest, there’s just so much mean-spirited snobbery. And maybe I’ve just been in it for too long and that’s why I didn’t want to write a kids’ book. But I feel fine about this book now. I am so, so proud of it.”
', false, TIMESTAMP '2019-04-04 05:08:47', 187, 'article', 'literature', 36);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('‘Grange Hill was bigger than Love Island’: the rise of nostalgia TV', 'abs.jpeg', 'When lockdown 1.0 arrived in Britain nearly 12 months ago, the nation dived headfirst into an ocean of on-demand television as a distraction. We were blessed with a flow of meme-worthy content, from Tiger King’s bizarre cast of characters, to Connell’s chain in Normal People and the revived debate about the “coughing major” after three nights watching Quiz. But as the days turned to weeks, then months, millions of us turned to more familiar comforts. Netflix might still be churning out a couple of new series every week, but the popularity of archive content has never been higher. A recent Radio Times survey of readers’ viewing habits found that 64% have rewatched a series in lockdown, while 43% have turned to nostalgic shows for comfort. So what have we been watching, and what do our choices say about the nation’s psyche?
Subscriptions to BritBox – the streaming platform set up by the BBC and ITV to house the broadcasters’ vast archive – have boomed, with new sign-ups surpassing those of Now TV and Apple TV+ in December. “People are really enjoying this treasure trove of archive content,” managing director Will Harrison tells me (although he is keen to stress that BritBox also screens new programming). “Half the reason people are watching so much is that there’s more available now than there ever has been.”
In common with all its competitors, BritBox is cagey about its subscriber numbers and viewing figures for commercial reasons (although all platforms seem happy to tout big numbers when a show is a success). Yet the quick growth of a service made up almost entirely of old shows illustrates a turn to the past in our viewing habits. Harrison believes there are five reasons for that: “The first is pure nostalgia – wanting to revisit something that we’ve loved. The week we launched Grange Hill, it was more popular than classic Love Island, usually one of our most-watched shows on the service. Second is the binge factor: if you’re a fan of, say, Doctor Who, you can go to season one, episode one, and go the whole way through… a kind of completist thing for the real fans.
The third is a reawakened interest in an old show because of something else going on – for example, you might be watching It’s A Sin on Channel 4, then come to BritBox and discover Queer As Folk [both written by Russell T Davies]. The fourth reason is what I call the bucket list: the classic TV you know you should have watched but haven’t got round to.”
', true, TIMESTAMP '2020-04-30 19:41:20', 130, 'news', 'tv show', 87);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Black Honey: Written & Directed review – hook-filled pop-rock that stings', 'abs.jpeg', '“I feel like there aren’t any bands any more” moaned Maroon 5’s Adam Levine recently. He was highlighting the fact that record companies take less risks developing groups now, because solo artists are more economical. Black Honey are an obvious exception. The Brighton quartet grazed the Top 40 with their eponymous debut and have been given another shot. If their first album pitched them as an electro-pop Blondie making their own David Lynch soundtrack, this album remodels them as a sort of industrial pop cyberpunk, descendants of Garbage or the rougher end of the Cardigans’ Gran Turismo.
They’ve certainly thrown everything at it. Swaggering hooks, big horns and processed sounds abound. On the punky Run for Cover, big-lunged Izzy Phillips could be fronting a hi-tech Sigue Sigue Sputnik. However, the beautifully crafted Back of the Bar shows that she can turn her lungs to bittersweet Lana Del Rey cinematic pop, which she delivers perfectly short of outright melancholy.
If at times it can all sound a bit forced – Disinfect in particular is all bluster and no purpose – they get it right more than they do wrong. Beaches sounds like an improbable mix of Blur’s Girls and Boys and Shirley Ellis’s 1965 chant/hit, The Clapping Song. The instantly anthemic Summer ’92 is just crying out to be played loudly on a long summer drive with the windows open. Black Honey have lost as well as gained, but this is a confident comeback.
', true, TIMESTAMP '2020-01-06 18:23:01', 198, 'review', 'music', 65);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Furred time’s a charm? How Paddington can escape the curse of the threequel', 'abs.jpeg', 'To quote Gene Wilder’s Willy Wonka, the news that a third Paddington film is in the works shines like a good deed in a weary world. Hailed as one of the best family movies of modern times, Paddington 2 has amassed cult fanbase, and it’s easy to see why. From the earnest aphorisms of Paddington himself to the glory of Hugh Grant’s narcissistic, preening Phoenix Buchanan, the film is marmalade-packed with wit and warmth. Grant even suggested, in his customarily dry way, that it was perhaps the best film he had ever been in. But in the shadow of such a success, is a third film a mistake, especially if it is to be completed without Paul King in the director’s chair?
Reports suggest that many of the first two films’ other key creatives will be involved. Yet few threequels hit the same emotional resonance as, say, Toy Story 3, or conclude an epic saga like Lord of the Rings: The Return of the King. Indeed, Hollywood history shows us that the construction of a threequel is precarious, and often ends in anticlimax.
', true, TIMESTAMP '2021-03-08 17:03:47', 298, 'news', 'cinema', 100);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Tracy Beaker’s Dani Harmer: ‘My daughter can’t understand why I’m in the TV’', 'abs.jpeg', 'I was born in the 80s, but very much raised in the 90s. That was the best era for US teen sitcoms – I absolutely loved Saved By the Bell and Sister Sister. When we got a cable box, it was the most exciting thing, because then we had more than just the four channels. I would get home from school and rush to get changed quickly, grab a snack and then put on Trouble, which was my favourite channel, or I’d switch over to Nickelodeon.
It was always nice to see other kids on television. I think that’s what made me want to go into acting, since it always looked so fun, with their characters constantly finding themselves in unusual situations. I thought I could do that, too.
It’s so exciting that shows such as Sister Sister are back on streaming services now that we’re in lockdown and have nothing else to do. It’s always fun to take a trip down memory lane – I completely understand why people say to me that I’m their childhood, because those shows provide such nostalgia. It’s a really lovely feeling to be curled up in bed and watching all these programmes that remind you of being a kid again.
', false, TIMESTAMP '2019-10-10 04:20:06', 239, 'article', 'tv show', 52);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Terminator sitcoms and celebrity Shetland Pony racing: our writers’ lockdown TV pitches', 'abs.jpeg', 'Feeling a Little Horse
Ponying up for charity
We’ve had The Jump. We’ve heard the agonising slap of flab on drink in Splash! Celebs have proven time and again that they are willing to risk everything – injury, reputation, the privilege of being able to say: “I have never soiled myself on television” – if their agent suggests it would be beneficial to them not being dropped. So why not take this to its logical extreme: a gruelling, John O’Groats-to-Land’s End race … on Shetland ponies. The loser (almost certainly a weeping Timmy Mallett) then has to donate 50 grand of their own dwindling reserves to the other slebs’ charities. Drama, stakes, life-affirming derring-do, tiny adorwable wittle clompy-clomps: yes, that’s right, this show does have it all. Luke Holland
Where the Hell Is Amy?
Sunday nights are about to get four times more miserable
Nicola Walker – she of the saddest eyes on primetime television – was born to be in a morose yet compelling detective show where the troubled lead copper gets far too involved with a murder case as a neon sign of the words “personal life in tatters” flashes above her head. As was Anna Friel. As was Sarah Lancashire. Where the Hell Is Amy? finds all three working together, battling hangovers and horizontal, out-of-London rain to solve a disturbing mystery: where the hell is their missing colleague and fourth horsewoman of sombre crime dramas, Amy, played by Suranne Jones? Hannah J Davies
What’s Next
Covid was just the start
As lockdown ends, let’s keep the miserable national mood going with What’s Next, an unnecessarily detailed exploration of all the other horrible fates likely to befall humanity in the coming years. Now that bird flu can be transmitted to humans, let’s watch a photorealistic simulation of it tearing through humanity in a pandemic so severe it makes Covid look like the sniffles. What if the Yellowstone supervolcano went off, destroying crops and killing billions? Would you watch that? The news just said that we’re overdue a magnetic field reversal, and the last one of those killed off all the cavemen. Could we explore that in such upsettingly plausible detail that none of us will ever manage another wink of sleep ever again? To be narrated by deepfake audio produced from Donald Pleasence’s voiceover in terrifying 70s public education film The Spirit of Dark and Lonely Water. Stuart Heritage
', false, TIMESTAMP '2020-09-02 22:14:09', 159, 'review', 'tv show', 59);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('‘You think: are we really doing this?’: how TV’s strangest shows get made', 'abs.jpeg', 'Nine years ago, TV developer Park Won Woo was taking a break in a car park after shooting auditions for a South Korean talent show. He had worked on number of similar programmes throughout his career, but had come to feel uneasy about their format. “They’re not always fair,” he recalls thinking, because on numerous occasions, people seemed to win because of their looks, not their talent. A solution popped into his head: what if the singers wore masks?
For three years, nobody wanted Park’s show, the idea for which evolved to feature celebrities behind the masks. The 48-year-old had 24 years’ experience in the TV industry, but his idea was rejected by network after network. “I felt sheer desperation,” he tells me.
Eventually, a lone producer at one of South Korea’s top three television networks, MBC, gave Park a chance. The producer liked the idea, despite his colleagues being “strongly opposed”, and green-lit a pilot. His show debuted in February 2015 as Miseuteori Eumaksyo Bongmyeon-gawang – you probably know it better as The Masked Singer.
The pilot was an overnight success; the show was given a weekend primetime slot that it has now maintained for over six years. Today, more than 50 countries broadcast their own version of The Masked Singer, which sees unidentifiable celebrities performing in elaborate mascot-like costumes of mythical creatures, foodstuffs, and the occasional anthropomorphic purple blob. Part guessing game, part talent competition, the show attracted 5.2 million viewers every Saturday night when the UK version debuted on ITV in 2020. Kevin Lygo, the network’s director of television, says “there wasn’t any doubt” about a second series, particularly with household names like Mel B and Glenn Hoddle eager to climb on board. The show’s final in February had 8.6 million viewers, making it the most watched programme on British TV of the year so far. “It’s going from strength to strength.”
', false, TIMESTAMP '2020-06-12 21:27:46', 206, 'article', 'tv show', 56);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Ian McKellen’s long-awaited return as Hamlet set for June', 'abs.jpeg', 'Sir Ian McKellen’s return to the role of Hamlet, 50 years after he first took on the part, has been keenly awaited by theatregoers as a post-lockdown treat. It has now been confirmed that the production, announced last year, will open this summer at the Theatre Royal Windsor with a company of actors – also including Steven Berkoff, Jenny Seagrove and Francesca Annis – who will then present The Cherry Orchard. Both plays will be directed by Sean Mathias in a season produced by Bill Kenwright.
McKellen, who turns 82 in May, will begin previews for Hamlet in June. It is billed as an “age, colour and gender-blind production” and will offer a number of audience members the opportunity to sit on stage. Shakespeare’s tragedy will be followed in September by Chekhov’s classic, adapted by Martin Sherman and starring McKellen as Firs, Annis as Ranevskaya and Seagrove as Gaev.
“I’ve acted in both these masterpieces before – and seen them scores of times,” said McKellen. “They are in that select group of classic plays which bear, even demand, a regular look, even reappraisal. By actors, directors, producers – and audiences.”
Covid-secure rehearsals for Hamlet first began last summer. It would never have crossed his mind to play the role again, he has said. “Young Hamlet”, as he is referred to in the play, is generally thought to be no older than 30. McKellen said that portraying the prince of Denmark now provided a way to “look into how much we need to see what we’re hearing”. Rehearsals for the production will recommence next week.
', false, TIMESTAMP '2020-03-25 13:38:11', 170, 'review', 'theatre', 85);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('’I’m envious’: Lin-Manuel Miranda watches from afar as Hamilton takes the stage in Australia', 'abs.jpeg', 'The musical, which went into previews on Wednesday, is the most anticipated show opening in Australia – and maybe in the world
Last night, blockbuster musical Hamilton was seen by paying audiences in Australia for the first time.
It’s the only company in the world performing the show, in one of the only countries where theatres have reopened.
And a few hours before curtains rose, its star Jason Arrow – a relative newcomer – was understandably pumped.
“The energy tonight is going to be indescribable and we’re absolutely going to feed off it,” he told Guardian Australia, in costume and backstage at the Lyric Theatre, Sydney. “I’m so excited for people to see this … Bring it on!”
', true, TIMESTAMP '2020-04-02 18:26:00', 220, 'article', 'theatre', 63);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('‘He was a kid with a million questions’: Fauci to star in children’s book', 'abs.jpeg', 'The leading US public health expert Anthony Fauci will be the subject of a new book – for children.
The publisher told CNN the book was not endorsed by Joe Biden’s chief medical adviser, the director of the National Institute of Allergy and Infectious Diseases who has now served seven presidents but who rose to international fame last year as the coronavirus pandemic took hold. But the writer, Kate Messner, said she had spoken to Fauci “at the edges of his long work days”.
“Before Tony Fauci was America’s doctor,” she said, “he was a kid with a million questions, about everything from the tropical fish in his bedroom to the things he was taught in Sunday school.
“‘I’m really hopeful that curious kids who read this book – those we’re counting on to solve tomorrow’s scientific challenges – will see themselves in the pages of Dr Fauci’s story and set their goals just as high.”
At points in the last year it seemed Fauci’s chief goal was just not to be fired, as his frank advice clashed with Donald Trump’s inconsistent, politically motivated and often plain bizarre statements on the pandemic and how it might be contained.
But Fauci survived and even flourished while other members of the former president’s taskforce saw their reputations battered or were fired outright. According to Johns Hopkins University, by Monday more than 542,000 Americans had died of Covid-19, out of a case count of nearly 30m. The case count has slowed as the Biden administration has supervised a rapid vaccine rollout, though virus variants and public behaviour still pose considerable threats.
Recently turned 80, Fauci maintains powerful appeal among the young. In December, as Covid vaccines began to be used across the US, he told children he had saved Christmas by flying to the North Pole and giving Santa a shot.
The same month, he discussed with the Guardian the dominant theme of his career before Covid, the search for a cure for HIV and Aids.
“I’ve been in a very unique position of now being one of the very, very few people who were there from the very first day of HIV,” he said.
A friend reported Fauci as saying: “The one thing that I still have left that I want to do is put an end to” HIV.
Fauci is not the first beloved modern public figure to have his or her story told for children. For just one example, books about the late supreme court justice Ruth Bader Ginsburg – who was also from Brooklyn – have flourished.
According to an Amazon page for the book about Fauci, Messner and illustrator Alexandra Bye will offer children a story about “a curious boy in Brooklyn, delivering prescriptions from his father’s pharmacy on his blue Schwinn bicycle.
“His father and immigrant grandfather taught Anthony to ask questions,” the blurb says, “consider all the data, and never give up – and Anthony’s ability to stay curious and to communicate with people would serve him his entire life.”
The publisher also promises “a timeline, recommended reading, a full spread of facts about vaccines and how they work, and Dr Fauci’s own tips for future scientists”.
', false, TIMESTAMP '2020-03-12 14:36:35', 232, 'article', 'literature', 95);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Seun Shote, ’superbly talented’ actor, dies unexpectedly aged 47', 'abs.jpeg', 'Tributes have been paid to actor Seun Shote, who has died unexpectedly at 47. Shote was nominated for an Offies award for his blistering performance as a Trinidadian police commissioner in Mustapha Matura’s Play Mas at Richmond’s Orange Tree theatre in 2015. He was also acclaimed for his work with the Jamie Lloyd Company, who said: “We are deeply saddened to hear about the passing of our incredibly talented collaborator.”
Lloyd, who directed Shote in major West End productions of Cyrano de Bergerac and The Seagull, said he “made a huge impact on us all” and “shared so much love, joy and positivity with the world. He showed us how to be with people – with kindness, generosity, humour and heart.” The Seagull, starring Emilia Clarke, opened for previews days before theatres were shut in March 2020 due to the pandemic; Shote played Shamrayev, which he rehearsed during the day while giving his final performances in Cyrano, starring James McAvoy, at night.
Shote was born and raised in Stoke Newington, north London, and trained at the Manchester Metropolitan School of Theatre. His other stage work included a UK tour of Chinonyerem Odimba’s Princess & the Hustler in 2019, part of Eclipse Theatre’s Revolution Mix initiative to present black British “hidden histories” on stage. It was set against the backdrop of the 1963 Bristol bus boycott.
', false, TIMESTAMP '2021-01-01 19:41:17', 284, 'news', 'theatre', 48);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Ainsley Hamill: Not Just Ship Land – glossy Scottish torch songs of strong women', 'abs.jpeg', 'Traditional folk can spring artists into unusual places. Ainsley Hamill began her career in Glasgow folk group Barluath, wrapping her plush, muscular vocals around Gaelic, Scots and English language traditionals, but she begins Not Just Ship Land sounding like last year’s avant-garde newcomer Keeley Forsyth. “Saltwater and city fill my head,” she sings, her voice thick with velvet and murk.
Not Just Ship Land is an idiosyncratic debut. Born in Cardross near Dumbarton, Hamill’s love of Gaelic song was nurtured studying at the Royal Conservatoire of Scotland; you occasionally hear the wild wavering of its psalms in her melody writing. But this album’s overall mood is of mainstream, modern torch songs, hovering between the comforting warmth of The Breath and the whip-smart forlornness of early Adele (listen to the way Hamill sings “cackles of girls in trackies and short skirts”, relishing every consonant).
Many of these songs are about women from Glasgow and Govan around the turn of the 20th century. The Will of the People is Law remembers the female-led rent strikers of 1915. Respect Your Elder remembers education champion Lady Elder, whose campaigning allowed women to graduate from Glasgow University from 1892. The Czech Studio Orchestra provides lush accompaniment throughout, although some arrangements work better than others: a setting of a 1907 poem by Scottish writer John McLennan, The Daffodil King, is impressionistic and lovely, but No Time to Lose Time (about munitions worker Lizzie Robinson, awarded an OBE for working 12-hour shifts, seven days a week, for 18 months) has critical lyrics that get lost in soapy soul. Nevertheless, Hamill has a big, intriguing voice, its Scottishness ever-present, which holds crossover promise.
', true, TIMESTAMP '2020-01-16 00:55:25', 111, 'news', 'music', 18);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('See that cute animal? It’s about to go extinct: Dear Zoo gets an update', 'abs.jpeg', 'The elephant was too big, the lion was too fierce and the camel was too grumpy. For nearly 40 years, the characters of Dear Zoo have successfully convinced generations of children that wild animals belong in zoos – and that most definitely do not make good pets.
Now, the author of the children’s classic, Rod Campbell, wants to convey an altogether different and more serious message to families today about the endangered species in his most famous book: “We need to look after them better.”
In Look After Us, a new, non-fiction companion to Dear Zoo, Campbell attempts to introduce the concept of conservation to toddlers. Many of the much-loved animals from the pages of the original book are now threatened with extinction, he gently reveals, along with orangutans, tigers and whales.
“I thought there probably aren’t many books for the very youngest children about this topic, because it is difficult,” Campbell, 75, told the Observer in a rare interview. “It was a question of: how do you say that animals are dwindling in a way that a young child will understand?”
He decided the best way was to write a picture book from the perspective of someone who tries to find their favourite animals, and then discovers there aren’t many of them left. Like in Dear Zoo, which has sold over eight million copies worldwide and is a perennial top-10 picture book in the UK, an animal hides behind each flap of the book and is only revealed when the flap is opened.
But, unlike in Dear Zoo, the flaps in the new book depict these animals in their natural habitats, not in crates and boxes. The animals do not belong in a zoo, but in the wild – where, the narrator explains, they are endangered. “Really, it’s like planting a seed in children’s minds,” Campbell says. “I think, if you come to the idea of conservation when you’re young, it stays with you. And I think it grows.”
He deliberately ends the book with an uplifting message: a huge, final flap, which reveals that, because “kind people” have looked after the whale, it is thriving in the sea.
', true, TIMESTAMP '2020-06-23 00:44:46', 57, 'review', 'literature', 59);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Oscar-tipped Minari puts identity second. That’s refreshing for Asian Americans', 'abs.jpeg', 'Lee Isaac Chung’s soulful drama Minari is set to break records for Asian American representation at this year’s Oscars, over a year after it received rapturous reviews at the Sundance film festival and coming soon after Crazy Rich Asians and The Farewell made key strides.
These three films have become successive rallying points for Asian Americans looking for representation on screen and while they all tell family stories, it’s the ways in which they differ that count.
While Crazy Rich Asians and The Farewell used family as a backdrop for their primary focus on culture clash and identity, Minari flips that script. The film puts family struggles first, and identity second. Because of this, it becomes refreshingly mundane and more universally accessible, but no less powerful, and no less important for Asian American cinema.
Minari centers on the Korean American Yi family, whose patriarch Jacob moves his wife Monica, daughter Anne, and son David from California to rural Arkansas during the 1980s. There, Jacob hopes to fulfill his American dream of running a successful farm.
The first scene offers closeups of Yi family members as they drive past bucolic scenery to their new home, silent except for the soundtrack’s melancholy piano. Minari’s first dialogue only arrives when Monica steps out of the car, and mutters in disappointment at the mobile home Jacob has purchased – presaging a muted central conflict of personal and familial expectations.
That’s a world away from one-upping racist hotel staff, or exchanging white lies with your grandma using badly accented Mandarin. These openings ground Crazy Rich Asians and The Farewell respectively in collisions of cultures, with protagonists desperately ping-ponging between “Asianness” and “Americanness”.
', true, TIMESTAMP '2019-08-20 08:45:23', 66, 'article', 'cinema', 53);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('My Derry Girls and Bridgerton roles show women our complex, eejit selves on screen', 'abs.jpeg', 'In the noughties, I adored Sex And The City. Like women everywhere, my friends and I debated which of these four impossibly stylish, successful women we were – when the reality was a bunch of university freshers who drank Buckfast from the bottle and lived in hoodies. We probably had far more in common with The Inbetweeners, but there were no female Inbetweeners on screen to compare ourselves to. Where were the messy women? The loud women, the ones who were complete eejits?
When I got the script for Derry Girls many years later, it felt like being handed the holy grail. Erin, Orla, Michelle and Clare (my role) were the female characters I had been waiting for: properly funny, obnoxious, unlikable at times. I remember the show’s creator, Lisa McGee, telling us that she had received a note asking her to make Michelle (the gobbiest one) a little softer, less in your face, more palatable. Her response: why?
So much television allows for, even centres on, deeply flawed male characters, far less so women. Would anyone give a note asking that Breaking Bad’s Walter White, one of TV’s best villains, be a little sweeter? Of course not. It made me wonder how many complex women have been toned down, or removed from our screens, on the basis that women have to be likable above anything else.
When we were filming the first series of Derry Girls, I worried whether people would like it. I had watched the intense backlash against the female Ghostbusters film unfold, an experience its director, Paul Feig, described as the worst misogyny he’d ever encountered. Seeing my comic heroes Kristen Wiig and Melissa McCarthy get trashed online made me fear how the “women aren’t funny” brigade would react to our show.
', false, TIMESTAMP '2019-12-28 02:49:36', 157, 'article', 'tv show', 12);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Christopher Plummer: a fierce yet tender talent who flourished when he was let off the leash', 'abs.jpeg', 'It is 1938, and the cynical music impresario Max Detweiler is at the lakeside home of his friend Captain Georg von Trapp in Salzburg, where the conversation has turned to the disagreeable subject of the Nazis and Austria’s imminent Anschluss with Germany. “You know I have no political convictions,” shrugs Detweiler evasively. “Can I help it if other people do?” Von Trapp’s responding flash of anger is a genuinely compelling and grownup moment in this movie – the 1965 hit musical The Sound of Music: “Oh, yes, you can help it. You must help it.” Playing Von Trapp, Christopher Plummer’s face becomes fierce and hawkish with contempt for all those who do nothing and allow evil to flourish.
At 35, the Canadian-born Plummer became an international star in this film, but as the years and decades went by – and almost everyone swallowed their pride and admitted that they loved The Sound of Music – Plummer became the most famous and stubborn refusenik until almost the end of his life, calling it “awful and sentimental and gooey”.
But it wasn’t simply that The Sound of Music made him famous: it shaped many of the roles and personae of his screen career. The widower and retired naval officer Von Trapp was a man of fierce integrity, discipline, patriotism and bearing, but with a softer, romantic side. He, of course, falls in love with and marries Maria – the young novice nun employed to look after his children, played by the gamine Julie Andrews. Plummer was a handsome man with theatrical presence and a fine voice, who made his name first on the stage in classical and contemporary roles and continued to do much acclaimed theatre work in London and New York. Plummer was very different from the newer, realer-looking stars of the American new wave such as Dustin Hoffman or Jack Nicholson and was outside the method school of Marlon Brando and Robert De Niro. He also had something more reserved and controlled than his great Canadian contemporary Donald Sutherland. He was perhaps destined to become a character actor who would grow into his style. Even in relative youth, there could be something a bit scary, gruff and patriarchal about Plummer, but when the humanity and gentleness emerged it was all the more beguiling.
', true, TIMESTAMP '2020-10-12 22:48:13', 80, 'article', 'cinema', 91);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Justin Bieber: Justice review – tone-deaf pop posturing', 'abs.jpeg', 'There’s seizing a cultural moment, then there’s putting one of the greatest orators who ever lived on your album as a tone-deaf wheeze. Justin Bieber’s sixth studio album, Justice, opens with Martin Luther King Jr urging a firm stand against injustice; a later MLK interlude exhorts people to meet society’s challenges with moral courage.
Somehow, Bieber’s takeaway here is a solipsistic, God-bothering set of gushing pop songs about the redemptive powers of romantic love. “I can’t breathe without you,” he sings on Deserve You; “there were times when I couldn’t even breathe,” he adds on Unstable – not out of solidarity with victims of police brutality, but as a metaphor for needing his partner, or as a symptom of anxiety.
Dr King’s speech equates a lack of courage in the face of injustice as a kind of living death: Bieber follows up with an 80s dance-pop tune called Die for You, in which he vows to lay down his life for his wife. Meantime, songs like Peaches inform fans that Bieber endorses Georgia’s totem fruit crop and California-grown weed. Funniest pandemic record, hands down.
', true, TIMESTAMP '2020-10-13 14:22:58', 99, 'review', 'music', 53);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('’It’s the way she owns her body’: how Megan Thee Stallion rode to Grammys glory', 'abs.jpeg', 'In 2014, a then-unknown Megan Thee Stallion tweeted: “I need a team [because] I promise this rap shit gone take off for me.”
That promise has been fulfilled in quite spectacular fashion. The 26-year-old, born Megan Jovon Ruth Pete, is now one of the world’s most famous and respected rap stars, with her three Grammy awards at last weekend’s ceremony marking the peak of her career thus far.
As well as winning one of the night’s “big four” awards – becoming the first female rapper this century to win best new artist – she is the first woman to win the best rap song category as lead artist. She shared her award with Beyoncé, who had joined Megan on the remix to Savage, a matter-of-fact statement of multifaceted womanhood. Billie Eilish meanwhile spent much of her winner’s speech trying to give her record of the year award away to Megan, repeatedly telling her: “You deserve this.”
', true, TIMESTAMP '2020-03-08 09:54:32', 246, 'review', 'music', 76);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('The Guardian view on the picture book: not just for children', 'abs.jpeg', 'While anglophone fans await a translation of her 1,100-page magnum opus, the Nobel-prizewinning Polish novelist Olga Tokarczuk has a picture book out. She created her story, The Lost Soul, with artist Joanna Concejo. At 48 pages it is certainly slender compared with her epic historical novel, The Books of Jacob, which will be published in English in November. Concejo refuses the idea that the book might be any more suitable for children than adults – or vice versa.
It seems a quixotic move from Tokarczuk. And yet, from the unfurling visual narratives of Chinese handscrolls, to the jewel-bright stories contained in the stained-glass windows of medieval cathedrals, it is perfectly clear that there is intense pleasure and meaning to be gained from stories told through images. Those lucky enough to have had books to hand as children often remember, with fierce delight, the pictures at least as clearly as the words – classics such as Tove Jansson’s Moomin books, or Edward Ardizzone’s lively artworks for Stig of the Dump. And there are picture books proper, like The Tiger Who Came to Tea by the late, great Judith Kerr, that are recognised as much more profound than “mere” children’s books.
George Cruikshank had a (sometimes troubled) partnership with Dickens, and Gustave Doré produced extraordinary artworks for books such as Don Quixote, but the cheap paperback of the postwar period pushed illustrated books for adults to the luxury margins. Somehow, pictures had also come to seem childish or eccentric (one thinks of the wonderfully dark work of Edward Gorey). And yet readers love stories told through pictures, as the ever-increasing cultural purchase of the graphic novel suggests, with works by Art Spiegelman, Raymond Briggs, Marjane Satrapi and others regarded as classics.
Text and picture, after all, are not so far apart: in fact the former derives from the latter. Early writing systems such as Egyptian hieroglyphs and Chinese used pictograms: things in the world were expressed in written form by stylised pictures of them. Syllabic and alphabetic systems in the Near East developed via the rebus principle, in which the sound associated with an image became decoupled from its original meaning. For example, the Sumerian word for beautiful, sheh-gah, was written in cuneiform using the characters for barley, sheh and milk, ga, though “sheh-gah” has nothing to do with the idea of barley or milk. Through a similar process, our letter A, which derives from the Phoenician aleph via the Greek alpha, is thought ultimately to derive from the Egyptian hieroglyph for an ox – indeed, turn A on its side, and you’ll glimpse the creature’s horns, still visible in the form of our letter.
What is the use of a book without pictures? asked Alice. Very little, it turns out, particularly if we consider that pictures are buried within the very symbols used to write words. As for a picture book for adults, Tokarczuk sweeps away all doubts: “I adore the picture book,” she has said. “For me it is a powerful, primeval way of telling a story that’s able to get through to anyone – regardless of age, cultural differences or level of education”. It’s hard to disagree.
', false, TIMESTAMP '2019-06-20 22:24:56', 199, 'news', 'literature', 97);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('’I got a job on a fishing trawler’ – Covid: one year on, stars of music and theatre look back', 'abs.jpeg', 'It feels weird saying this, but it’s been a productive year. For us, the key thing was for our ambitions as a band to be unaffected. At the start I saw a lot of people’s heads go down, but we were determined to make sure we came out of this a better band.
We’ve been friends since we were kids – three of the band met in nursery – and have played together since we were 12 or 13, which helps you pull together. It was just another thing to go through as a group of friends.
We’d built up a lot of momentum, but suddenly everything was postponed, including our debut album, so we used the time to keep writing and releasing music. We put out seven singles in 2020. We also went back to the album [WL, released 2 April on Parlophone] and worked on it some more, bringing in strings and acoustic racks. I think we’re in a better position to play it live.
', false, TIMESTAMP '2019-08-09 16:15:18', 147, 'article', 'theatre', 17);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Observer/Anthony Burgess prize for arts journalism 2021: Milo Nesbitt on Electronic: From Kraftwerk to the Chemical Brothers', 'abs.jpeg', 'At one point in Electronic, which opened in July 2020, you come to an array of variously sized plastic circles, packed tightly together and lit at an angle so as to project their shadow on to the wall behind and above them. There’s a moment when you wonder what these shapes are: some kind of abstract art, a mountain-range silhouette, a heartbeat. Then you realise, of course, that it’s a spectrogram for the song you’ve just listened to through your headphones – and that these black plastic circles are supposed to look like records. It’s a lovely reflection of electronic music’s ways of generating meaning without necessarily relying on lyrics. These signs could mean anything; they could mean everything.
Electronic music has always had a utopian impulse to it. The critic Owen Hatherley has written that Kraftwerk’s music was “an imaginary universal language that anyone could learn, anyone could speak, anyone could dance to”. The 1988 “second summer of love” could easily be contextualised as a moment of escape from the Thatcher-era Conservative rule. The origins of techno in post-industrial Detroit testify to black creativity under repressive conditions. Captions in this exhibition note that the dancefloor has often acted as a space of freedom for the queer community. Peter Gay once wrote, in a different context, that “the cure for the ills of modernity is more, and the right kind, of modernity”; electronic music might be the best evidence yet.
Certainly visiting the Design Museum felt like a relief after months of lockdown, albeit a strange one: branding its atmosphere as “clublike” while having to enforce social distancing and make people bring their own headphones is a difficult balancing act to pull off. Seeing people dancing, an activity that necessitates proximity, in photographs or on video, felt instinctively unsettling. But in terms of range and quality, the exhibition’s subtitle – “from Kraftwerk to the Chemical Brothers’” – actually undersells it. The material on display encompasses the music’s origins in cold war-era science experiments through to present-day promotional nightclub graphics.
', true, TIMESTAMP '2019-09-19 14:36:02', 76, 'article', 'music', 22);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('How using a black actor to vent white frustration sinks Malcolm & Marie', 'abs.jpeg', 'Adirector by the name of Malcolm (John David Washington) and his partner, Marie (Zendaya), arrive home from Malcolm’s big film premiere. It’s a celebratory night toasted by drinks, music and mac and cheese. However, all is not well between the two.
While the main row between the couple concerns how much Malcolm values Marie, Malcolm’s distaste for white critics also arises, leading into a bevy of loaded rants. Directed by Sam Levinson, the creator of Euphoria and son of Barry Levinson, the black-and-white melodrama Malcolm & Marie, now available on Netflix, initially has good intentions – defending black art – but once Levinson begins positing his gripes through Malcolm, a black man, his sincere aims trend toward being selfishly malicious.
Malcolm first harangues white critics by claiming they lack the vocabulary to analyze black art separate from a socio-political lens. Rather white critics rely upon the descriptors “timely,” “urgent,” and “authentic” to interpret black art into a serious sphere, even if the work might only be a comedy or action film. His outlook belies the opinion that genre needn’t decide whether a creation should be analyzed seriously. For example, Coming to America starring Eddie Murphy is an irreverent comedy about a royal traveling from his fictional country of Zamunda to Queens, New York, so he might find his bride. It would be foolhardy to not see how the film also worships black excellence or the dream of an African kingdom unaffected by slavery.
But to Levinson’s point, Malcolm does slightly elucidate how black films need to be pitched to white critics as important, and it’s their perceived importance, or lack thereof, that can decide critical valuation. Regarding anti-racism lists, Racquel Gates explains in the New York Times: “Indeed, the very idea that black film’s greatest purpose is to be an educational primer on race in America is a notion that we need to lay to rest.” If Levinson only used Malcolm to extricate white critical blindspots concerning interpreting the value of black art through a white lens, Malcolm & Marie would be a fresh dose of truth serum. Levinson, a white director, uses Malcolm as a black shield for his real target, not the critics who analyze black works, but the ones who interpret his.
', false, TIMESTAMP '2019-03-18 02:44:53', 90, 'news', 'cinema', 90);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Faith Ringgold: ’I’m not going to see riots and not paint them’', 'abs.jpeg', 'It looks a long way down from the window of Faith Ringgold’s attic studio to her snow-covered garden in Englewood, New Jersey. Her friend and longtime gallerist Dorian Bergen is holding the phone aloft, giving me a video tour of an impressively ordered room. There is a long work table in the middle, with paints of every kind and colour at one end, and canvasses piled high, ready for use, at the other. Hung on one wall are two framed quilt editions from Ringgold’s Coming to Jones Road series, inspired by her move to this very house 28 years ago, when the neighbours’ hostile reception ended in a court case. Ringgold herself – now aged 90, and regal with it – sits by that window with its vertiginous view, as if on a throne backlit by the sun.
In a 70-year career spanning the US’s 20th-century social revolutions, the artist, activist and children’s author has infused the US art establishment with traditions that had previously been systematically excluded: west African; African American; the work of women; and the perspectives of children. But while her famous fans include Oprah Winfrey and Hillary Clinton, it is only in the past five years that the art world has come to appreciate the full scope of her legacy.
The celebrated story-quilts showcased many of Ringgold’s artistic preoccupations – African American history, vivid colour palettes, the elevation of oft-dismissed domestic crafts to high-art status – but their prominence has also overshadowed just how much else there is. Ringgold’s subjects have varied from prettified landscapes to highly charged political portraits, and her medium has encompassed painting, sculpture, mask-making, performance art, mosaics on the NYC subway and a large-scale mural at the Rikers Island women’s prison. As she explained in a 1972 interview, she chose the site after receiving a grant to create a public work and being rejected by a number of academic institutions, including her alma mater, City College. “When I spoke to the deans I would get a lot of ‘Who are you?’ … I asked myself, do you want your work to be somewhere where nobody wants it, or do you want it to be somewhere it is needed?”
', true, TIMESTAMP '2019-06-20 13:14:31', 80, 'article', 'literature', 97);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Michael Rosen: ’This book is about what it feels like to nearly die’', 'abs.jpeg', 'When people stop Michael Rosen in his local neighbourhood of Muswell Hill in north London to ask him how he’s doing, which they do quite often these days, he replies: “Well, I’m not dead!” As is now well known, the former children’s laureate spent 48 days in intensive care after contracting coronavirus almost exactly one year ago. He went into hospital at the end of March as one of the nation’s favourite children’s writers and emerged a national treasure: his poem “These Are the Hands”, written to celebrate the 60th anniversary of the NHS in 2008, became an unofficial anthem for health-workers coping with the first wave of the pandemic; and, in a nod to his most famous book We’re Going on a Bear Hunt, teddy bears were placed in windows for children to spot on their daily walks during lockdown.
Rosen was completely unaware of these tributes as he spent all of April and much of May in an induced coma, “a kind of pre-death that is similar, presumably, to when we go”, he says now. “People were reading this poem by this dead bloke, but he wasn’t actually dead, he was just lying like a cadaver up the road in the Whittington hospital.” He doesn’t cry so much now, he says, but when he was first told about the public reaction to his illness (Michael Sheen read “These Are the Hands”, “much better than me”, on Jo Whiley’s Radio 2 show on his birthday last year), “it was just, whoosh!”
The 74-year-old writer is very much alive on Zoom where, after a few technical hitches, he appears on screen seemingly as energetic as ever, his conversation an engaging ragbag of rants and anecdotes, ranging from King Lear to last night’s football match, even if names escape him occasionally. In real life, as has often been remarked, Rosen resembles the BFG, or at least Quentin Blake’s giant, all long limbs, extravagant ears and messy lines. “You’d have to ask Quentin. He’s never said: ‘By the way you are the BFG’,” he says of the illustrator with whom he has collaborated since 1974. “I think he was partly inspired by Dahl himself.”
', true, TIMESTAMP '2019-10-25 00:01:22', 44, 'review', 'literature', 91);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Central Cee: Wild West review – gritty street-level drill from magnetic talent', 'abs.jpeg', 'Two tracks into 22-year-old west Londoner Central Cee’s punchy debut mixtape, he raps: “Who’s up next? They’re saying it’s Cench / What’s the odds? Place your bets.” By “they” he could equally mean the suburban kids he says have “picked up our language” or the industry execs who have spied a golden egg in the UK’s blossoming drill scene. The odds certainly look good. He’s bagged two Top 20 singles already, and boasts more than 2.7m monthly listeners on Spotify. BBC Radio 1Xtra picked him for the station’s Hot For 2021 shortlist, and he shares reps with Jorja Smith, AJ Tracey, and Stormzy. Warner’s distribution arm, ADA, snapped up the rights to this, his first mixtape.
For the most part, Wild West is UK drill-by-numbers: gliding 808 basslines, stuttering hats, and slick, cascading flows that add polish to Cee’s gritty street-level narration. Central Cee is most interesting when he’s pushing at the edges of that template. The wandering brass lead on his breakout hit Loading or the Spanish guitar on Day in the Life add fresh character to the canvas. When he lowers his voice and switches up his flow – dropping momentarily to a spoken-word cadence on closer Gangbiz – his lyrics gain potency. “Things don’t tend to go my way / I made some bands but the pains stay,” he says. With things now seemingly stacked in his favour, the question is whether Central is willing to take a punt on himself and break out of the mould.
', true, TIMESTAMP '2020-08-19 15:56:39', 52, 'news', 'music', 95);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Golden Globes 2021 nominations: ’A new thoughtfulness in the air’', 'abs.jpeg', 'This year’s Golden Globes will be the first film awards season event to unfold in the grim and globally buzzkilled new world of Covid restrictions, but some traditions are sacrosanct: the world of snubs. Christopher Nolan’s colossal metaphysical thriller Tenet was lauded by many in the business, but was sent away almost empty-handed in nominations (one nod for Ludwig Göransson’s score). It is also disappointing that the overwhelmingly moving and mysterious Pixar animation Soul gets only two nominations – animation and score. Surely it deserved best film musical or comedy?
In terms of diversity, the Globes have not disgraced themselves, with three out of the five director nominees being women: Emerald Fennell for the brilliant rape-revenge satire Promising Young Woman, Regina King for the true-life 60s encounter One Night in Miami and Chloé Zhao for the docudrama Nomadland – although some will be disappointed to see the relative failure in the best film categories of the big black-ensemble pictures such as One Night in Miami, Spike Lee’s Da 5 Bloods and Shaka King’s Judas and the Black Messiah.
Of course, the streaming giants are crowding out the rest. Netflix has 22 film nominations in total, way ahead of the next contender Amazon Studios, with seven. Disney must content itself with joint third place with a mere five.
', true, TIMESTAMP '2020-02-21 19:41:35', 201, 'news', 'cinema', 95);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Beano hero: Dennis the Menace turns 70', 'abs.jpeg', 'Seventy years ago, on 17 March 1951, Dennis the Menace first strolled on to the pages of the Beano. The iconic red and black jumper of today was eschewed for a shirt and tie, and his faithful pooch Gnasher was nowhere to be seen, but – as he defied an order to “keep off the grass” – Dennis was as much of a menace then as he is today.
Dreamed up when the Beano editor, George Moonie, heard a music hall song called Dennis the Menace from Venice, Dennis was the first naughty kid character for the Beano, which was first published by DC Thomson in July 1938.
“Dennis came along after the austerity of the 1940s, after this belief that kids should be seen and not heard, and then all of a sudden you have this character through whom kids can live vicariously,” said Mike Stirling, editorial director of Beano Studios. “He started off as a half-page strip on page five, but he was so successful that by the end of the 1950s you had Minnie the Minx, the Bash Street Kids and Roger the Dodger as well, because the naughtiness was such a success. The kids aren’t fighting against each other, they’re fighting against the grownups. Kids were not just being seen, but being heard.”
Beano Studios is marking Dennis’s anniversary with a special birthday edition of the comic, guest edited by super-fan Joe Sugg. The YouTube celebrity has written multiple strips in the comic, including one that sees Dennis having a chuckle about Sugg fainting on an episode of the Great Celebrity Bake Off. Kew Gardens is also celebrating Dennis with a giant 3D Beano comic strip and an interactive trail called Dennis & Gnasher’s Big Bonanza, this Easter. And a dedicated Dennis tartan has been created by mill Prickly Thistle to mark the milestone.
', false, TIMESTAMP '2019-10-02 10:36:36', 211, 'news', 'literature', 25);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Ralph Fiennes to direct and star in TS Eliot’s Four Quartets', 'abs.jpeg', 'Ralph Fiennes is to direct and star in a solo theatre adaptation of TS Eliot’s Four Quartets that will tour the UK this summer.
A co-production by Theatre Royal Bath and the Royal & Derngate in Northampton, Four Quartets will be staged first at those venues in May and June, then visit Oxford Playhouse and Cambridge Arts Theatre and other destinations yet to be announced.
Fiennes, who recently played archaeologist Basil Brown in the Bafta-nominated Sutton Hoo drama The Dig, was last on stage in Beat the Devil at the Bridge theatre, London, in 2020. He portrayed the playwright David Hare in a monologue detailing Hare’s experience of contracting coronavirus and the government’s response to the pandemic.
Four Quartets comprises Burnt Norton, East Coker, The Dry Salvages and Little Gidding, published together in 1943. The first of the four poems was inspired by lines that were cut from the Nobel laureate’s 1935 verse drama Murder in the Cathedral. The quartet ranges across themes of time, nature and the elements, faith and spirituality, war and mortality. Eliot is believed to have drawn inspiration for the quartet from his relationship with the scholar Emily Hale. His love letters to Hale had remained hidden, on the poet and her wishes, for 50 years after Hale’s death in 1969. They were made public in 2020 at a library on the campus of Princeton University.
Fiennes’s production will be designed by Hildegard Bechtler with lighting by Tim Lutkin and sound by Christopher Shutt.
In 2019, the American choreographer Pam Tanowitz’s stage version of Four Quartets had its UK premiere at London’s Barbican. It was the first time the TS Eliot estate had granted permission for the poet’s last great work to be used in a dance production.
', true, TIMESTAMP '2020-11-20 02:42:07', 120, 'news', 'theatre', 76);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('’Solidarity in Europe’: Maria Aberg’s international theatre company looks ahead', 'abs.jpeg', 'Maria Aberg was having one of the busiest times of her 20-year theatre career when the pandemic hit. But a month after theatres closed last spring, she was almost ready to give up on being a director despite a sparkling track record. Much of it was down to the disappointment of an aborted season of European theatre she had conceived for the Royal Shakespeare Company, which meant years of work down the pan. “It was completely devastating,” she says.
Aberg had begun preparing the RSC season, Projekt Europa, just after the EU referendum in 2016, and its focus on European theatre felt profoundly personal. “I’m a Swede who has lived in Italy, Berlin, Ireland and then in the UK for 20 years [she moved to London to study drama at Mountview]. I consider myself totally European. It was the culmination of years of interest and curiosity about European theatre-makers.”
Aberg was “not going to let it all disappear” and has launched a phoenix-like theatre company, Projekt Europa, whose focus is emphatically outward-looking. It will work with migrant theatre-makers, and hopes to configure new ways to stage work across the UK, Europe and the world. “I want to collaborate in a profound way, not just arrive somewhere, perform the show and pack up our bags again. I’m interested in collaborating in a deeper way with community groups and audiences.”
Setting up an international theatre company when the industry lies in fearful pause might be seen as high risk but what interested Aberg was the enthusiasm she encountered from so many quarters. “I began contacting people around Europe, from production houses to festivals and agents. I also started thinking about international collaboration. Because of the pandemic, people really wanted to talk, and they were excited about the work and ideas. Brexit hadn’t made anyone think that Britain wasn’t interesting any more.”
Neither does she think that British theatre will be diminished by Brexit or be any less European in its tradition. “It is a part of Europe whether or not it is in the EU. Britain’s history is European history. That legacy cannot be denied. It’s rich and it’s an asset. It’s food for creativity and thought.”
Her company has already found a UK residency at the Marlowe theatre in Canterbury, whose chief executive, Deborah Shaw, is a “real internationalist” says Aberg. “The location, which is the closest part of the UK to Europe, is very serendipitous.”
', false, TIMESTAMP '2019-07-06 12:07:36', 168, 'news', 'theatre', 35);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Vivian Gornick: ’I couldn’t finish Michelle Obama’s Becoming’', 'abs.jpeg', 'The book I am currently reading
Penelope Fitzgerald: A Life by Hermione Lee. I had actually never read anything by Lee before. I’ve only read 50 or 60 pages, but her style is immensely appealing. The sentences are very simple, there’s no fancy writing – she somehow puts things together in such a lively way that I feel as if I’m listening to her. She hits that marvellous conversational style. I like Fitzgerald’s work and it’s a pleasure seeing how she developed. I’m enjoying it very much.
The book that changed my life
I was well into my 30s when I read The Little Virtues by Natalia Ginzburg and as soon as I began I felt myself deeply connected. It isn’t that it’s the greatest book in the world, but for me it was vital. I felt she was showing me the type of writer I had it in me to be. One of the essays – “My Vocation” – really hit the nail on the head. I identified profoundly with the way in which Ginzburg traced her own development as a nonfiction writer. It made me realise that it was only through this kind of writing I could employ my own storytelling gifts. I reread it irregularly but quite a lot, and I’m always amazed by what she is able to accomplish with the small personal essay.
The book I think is most overrated
A Sport and a Pastime by James Salter is immensely overrated. I could have picked 100 books like that, but this is the one that has been stuck in my craw for a long time.
', true, TIMESTAMP '2019-07-30 23:55:04', 231, 'review', 'literature', 69);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Tiggs Da Author: Blame It on the Youts – a master of hooks takes centre stage', 'abs.jpeg', 'The Tanzanian-born, London-raised vocalist, songwriter and producer Tiggs Da Author is known as a master of hooks, having lent his formidable tones to the likes of J Hus, SL and Stefflon Don. Back in 2019 he put out his own mixtape, Morefire, which had an easy vitality to it, though all but one track featured a guest artist. Tiggs’s debut album picks up from Morefire’s warm sonic energy, but this time he’s centre stage. It’s a smooth record that channels funk, soul, reggae, gospel, Afrojazz and more; Tiggs has said he wants to represent the broad array of sounds from the African continent – no mean feat.
While occasionally things can feel a little cheesy or anachronistic, overall this is an uplifting, accomplished set, not least thanks to gorgeous arrangements and Tiggs’s unfaltering voice. Opening track Enough is all rich, vast energy; then there’s the sunshine shuffle of the title track, the punchy brass of reggae bop Zulu Gang, the euphoric licks of guitar and harmonies on Just a Little, and the dazzling Fly ’Em High, a collaboration with Nines. In a heavy, fractured world, Blame It on the Youts sounds like hope.
', true, TIMESTAMP '2019-03-28 07:53:56', 105, 'news', 'music', 80);
insert into post (title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id) values ('Poem of the week: Get Down Ye Angels by John Agard', 'abs.jpeg', 'Get Down Ye Angels was first published in John Agard’s 1997 collection, From the Devil’s Pulpit. Ben Wilkinson described the book as “a meditation on the devil as a necessary evil and creatively anarchic power”. The benign state of potency and anarchy to which the angels are invited is the animal body, “the splendid risk of flesh and bone”.
There are enough kill-joy forms of religious faith still around to justify reading the poem as a rebuttal. Angels are rarely available. Genderless, heavy-winged and hierarchical as they’re usually portrayed by Christianity, angels are not deeply interested in earthly matters. They’re aristocrats with haloes. And now they’re being commanded to “Get down” – down, and possibly dirty. The archaic form of address “ye angels” might not entirely convince them of the speaker’s devotional seriousness.
The fourth line reminded me of an old phonetic taunt typically made by a pupil to a particularly stuffy schoolmaster. “Do you tickle your arse with a feather, Sir?” The response is an indignant, even outraged, “I beg your pardon?” And the pupil, keeping a perfectly straight face, replies “Particularly nasty weather, Sir.” In the poem, the wind’s feather is “brazen” – an adjective that means “excessively bold” but, originating from “brass”, might suggest a more painful kind of ouch.
In the first tercet, the speaker identifies himself: he’s none other than the goat-legged, pipe-playing nature god, Great Pan. As this essay tells us, the Catholic poet and writer GK Chesterton considered the death of Pan to have marked the advent of theology. Agard’s poem restores Pan to life, and generously makes room for some reformed theology.
Pan’s music, like that of Orpheus, brings even the inanimate world to dancing life. And the cherubim receive a special invitation to this “carnal hubbub”. I had a rethink about cherubs as a result. Why are they personified as winged baby boys (putti) in western art? As we’re told here, “there are no angel-babies in the whole of Scripture.” The earliest putti, however, were associated with Pan. It’s appropriate that “cherubs” and the Earth’s “hubbub” should hobnob in a bubbly near-rhyme.
Instead of seeing the poem as a chance for me to take issue with the religions of bodily denial and penalty, I decided to focus on the positive – the religions that celebrate and contact their God through the physicality of music and dance. So this week I’ve listened to a gospel Sunday service from the Green Pastures Tabernacle, performances by the brilliant Hassidic violinist Daniel Ahaviel, and a beautiful Sufi Dervişane. It has been quite some research experience.
In an interview quoted here, Ahaviel says, “People ask me where I get the energy from, but I say, what energy? This isn’t me – it just happens from some deep place.” Of course, that deep place wouldn’t be of such depth and availability if it hadn’t been nourished for years by Ahaviel’s training as a concert violinist. There may be an extra ingredient – but I wouldn’t know if it had anything to do with angels.
Although religion’s most basic tenet is that mankind is elevated by worship, and will ultimately rise to share God’s kingdom, the reverse process in which the Holy powers descend has often been a centrally important phase of the narrative. Agard’s poem goes farther, and persuades us to ask, what if the Thrones and Powers were incarnated, not for human redemption, but for their own? Or, what if they’re incarnate already? What if angels are us?
Gently anarchic in structure and rhyme, combining humorous wordplay with innocently erotic whispers and rustlings, Get Down Ye Angels knows that the “numinous” is bodily. In mood and imagery it’s a kind of springtime poem. It reminds us the world isn’t all bad, and could be very, very good, with less cold piety, more celebration, and a truly pancosmic philosophy.
John Agard was born in Guyana in 1949, and has lived in Britain since the late 1970s. He’s a prolific writer for children and has translated a child-friendly version of Dante’s Inferno, The Young Inferno, with illustrations by the wonderful Satoshi Kitamura.
', false, TIMESTAMP '2020-05-25 07:52:38', 2, 'review', 'literature', 61);


--PHOTO
insert into photo (photo, post_id) values ('abs.jpeg', 166);
insert into photo (photo, post_id) values ('abs.jpeg', 38);
insert into photo (photo, post_id) values ('abs.jpeg', 2);
insert into photo (photo, post_id) values ('abs.jpeg', 102);
insert into photo (photo, post_id) values ('abs.jpeg', 146);
insert into photo (photo, post_id) values ('abs.jpeg', 18);
insert into photo (photo, post_id) values ('abs.jpeg', 165);
insert into photo (photo, post_id) values ('abs.jpeg', 65);
insert into photo (photo, post_id) values ('abs.jpeg', 172);
insert into photo (photo, post_id) values ('abs.jpeg', 25);
insert into photo (photo, post_id) values ('abs.jpeg', 96);
insert into photo (photo, post_id) values ('abs.jpeg', 130);
insert into photo (photo, post_id) values ('abs.jpeg', 75);
insert into photo (photo, post_id) values ('abs.jpeg', 185);
insert into photo (photo, post_id) values ('abs.jpeg', 144);
insert into photo (photo, post_id) values ('abs.jpeg', 181);
insert into photo (photo, post_id) values ('abs.jpeg', 113);
insert into photo (photo, post_id) values ('abs.jpeg', 53);
insert into photo (photo, post_id) values ('abs.jpeg', 50);
insert into photo (photo, post_id) values ('abs.jpeg', 198);
insert into photo (photo, post_id) values ('abs.jpeg', 98);
insert into photo (photo, post_id) values ('abs.jpeg', 134);
insert into photo (photo, post_id) values ('abs.jpeg', 140);
insert into photo (photo, post_id) values ('abs.jpeg', 142);
insert into photo (photo, post_id) values ('abs.jpeg', 188);
insert into photo (photo, post_id) values ('abs.jpeg', 123);
insert into photo (photo, post_id) values ('abs.jpeg', 136);
insert into photo (photo, post_id) values ('abs.jpeg', 197);
insert into photo (photo, post_id) values ('abs.jpeg', 150);
insert into photo (photo, post_id) values ('abs.jpeg', 88);
insert into photo (photo, post_id) values ('abs.jpeg', 37);
insert into photo (photo, post_id) values ('abs.jpeg', 190);
insert into photo (photo, post_id) values ('abs.jpeg', 122);
insert into photo (photo, post_id) values ('abs.jpeg', 160);
insert into photo (photo, post_id) values ('abs.jpeg', 128);
insert into photo (photo, post_id) values ('abs.jpeg', 174);
insert into photo (photo, post_id) values ('abs.jpeg', 129);
insert into photo (photo, post_id) values ('abs.jpeg', 14);
insert into photo (photo, post_id) values ('abs.jpeg', 75);
insert into photo (photo, post_id) values ('abs.jpeg', 54);
insert into photo (photo, post_id) values ('abs.jpeg', 131);
insert into photo (photo, post_id) values ('abs.jpeg', 38);
insert into photo (photo, post_id) values ('abs.jpeg', 1);
insert into photo (photo, post_id) values ('abs.jpeg', 198);
insert into photo (photo, post_id) values ('abs.jpeg', 66);
insert into photo (photo, post_id) values ('abs.jpeg', 19);
insert into photo (photo, post_id) values ('abs.jpeg', 192);
insert into photo (photo, post_id) values ('abs.jpeg', 189);
insert into photo (photo, post_id) values ('abs.jpeg', 186);
insert into photo (photo, post_id) values ('abs.jpeg', 194);
insert into photo (photo, post_id) values ('abs.jpeg', 59);
insert into photo (photo, post_id) values ('abs.jpeg', 168);
insert into photo (photo, post_id) values ('abs.jpeg', 13);
insert into photo (photo, post_id) values ('abs.jpeg', 159);
insert into photo (photo, post_id) values ('abs.jpeg', 52);
insert into photo (photo, post_id) values ('abs.jpeg', 94);
insert into photo (photo, post_id) values ('abs.jpeg', 142);
insert into photo (photo, post_id) values ('abs.jpeg', 91);
insert into photo (photo, post_id) values ('abs.jpeg', 194);
insert into photo (photo, post_id) values ('abs.jpeg', 122);
insert into photo (photo, post_id) values ('abs.jpeg', 92);
insert into photo (photo, post_id) values ('abs.jpeg', 100);
insert into photo (photo, post_id) values ('abs.jpeg', 104);
insert into photo (photo, post_id) values ('abs.jpeg', 178);
insert into photo (photo, post_id) values ('abs.jpeg', 14);
insert into photo (photo, post_id) values ('abs.jpeg', 34);
insert into photo (photo, post_id) values ('abs.jpeg', 18);
insert into photo (photo, post_id) values ('abs.jpeg', 13);
insert into photo (photo, post_id) values ('abs.jpeg', 45);
insert into photo (photo, post_id) values ('abs.jpeg', 130);
insert into photo (photo, post_id) values ('abs.jpeg', 88);
insert into photo (photo, post_id) values ('abs.jpeg', 76);
insert into photo (photo, post_id) values ('abs.jpeg', 126);
insert into photo (photo, post_id) values ('abs.jpeg', 36);
insert into photo (photo, post_id) values ('abs.jpeg', 81);
insert into photo (photo, post_id) values ('abs.jpeg', 199);
insert into photo (photo, post_id) values ('abs.jpeg', 111);
insert into photo (photo, post_id) values ('abs.jpeg', 167);
insert into photo (photo, post_id) values ('abs.jpeg', 33);
insert into photo (photo, post_id) values ('abs.jpeg', 101);
insert into photo (photo, post_id) values ('abs.jpeg', 105);
insert into photo (photo, post_id) values ('abs.jpeg', 113);
insert into photo (photo, post_id) values ('abs.jpeg', 144);
insert into photo (photo, post_id) values ('abs.jpeg', 16);
insert into photo (photo, post_id) values ('abs.jpeg', 178);
insert into photo (photo, post_id) values ('abs.jpeg', 11);
insert into photo (photo, post_id) values ('abs.jpeg', 113);
insert into photo (photo, post_id) values ('abs.jpeg', 52);
insert into photo (photo, post_id) values ('abs.jpeg', 38);
insert into photo (photo, post_id) values ('abs.jpeg', 78);
insert into photo (photo, post_id) values ('abs.jpeg', 16);
insert into photo (photo, post_id) values ('abs.jpeg', 148);
insert into photo (photo, post_id) values ('abs.jpeg', 106);
insert into photo (photo, post_id) values ('abs.jpeg', 73);
insert into photo (photo, post_id) values ('abs.jpeg', 121);
insert into photo (photo, post_id) values ('abs.jpeg', 125);
insert into photo (photo, post_id) values ('abs.jpeg', 151);
insert into photo (photo, post_id) values ('abs.jpeg', 125);
insert into photo (photo, post_id) values ('abs.jpeg', 118);
insert into photo (photo, post_id) values ('abs.jpeg', 83);
insert into photo (photo, post_id) values ('abs.jpeg', 183);
insert into photo (photo, post_id) values ('abs.jpeg', 105);
insert into photo (photo, post_id) values ('abs.jpeg', 146);
insert into photo (photo, post_id) values ('abs.jpeg', 162);
insert into photo (photo, post_id) values ('abs.jpeg', 10);
insert into photo (photo, post_id) values ('abs.jpeg', 101);
insert into photo (photo, post_id) values ('abs.jpeg', 182);
insert into photo (photo, post_id) values ('abs.jpeg', 164);
insert into photo (photo, post_id) values ('abs.jpeg', 105);
insert into photo (photo, post_id) values ('abs.jpeg', 30);
insert into photo (photo, post_id) values ('abs.jpeg', 93);
insert into photo (photo, post_id) values ('abs.jpeg', 191);
insert into photo (photo, post_id) values ('abs.jpeg', 28);
insert into photo (photo, post_id) values ('abs.jpeg', 188);
insert into photo (photo, post_id) values ('abs.jpeg', 83);
insert into photo (photo, post_id) values ('abs.jpeg', 186);
insert into photo (photo, post_id) values ('abs.jpeg', 29);
insert into photo (photo, post_id) values ('abs.jpeg', 190);
insert into photo (photo, post_id) values ('abs.jpeg', 137);
insert into photo (photo, post_id) values ('abs.jpeg', 79);
insert into photo (photo, post_id) values ('abs.jpeg', 82);
insert into photo (photo, post_id) values ('abs.jpeg', 139);
insert into photo (photo, post_id) values ('abs.jpeg', 194);
insert into photo (photo, post_id) values ('abs.jpeg', 67);
insert into photo (photo, post_id) values ('abs.jpeg', 171);
insert into photo (photo, post_id) values ('abs.jpeg', 173);
insert into photo (photo, post_id) values ('abs.jpeg', 117);
insert into photo (photo, post_id) values ('abs.jpeg', 115);
insert into photo (photo, post_id) values ('abs.jpeg', 187);
insert into photo (photo, post_id) values ('abs.jpeg', 176);
insert into photo (photo, post_id) values ('abs.jpeg', 183);
insert into photo (photo, post_id) values ('abs.jpeg', 75);
insert into photo (photo, post_id) values ('abs.jpeg', 135);
insert into photo (photo, post_id) values ('abs.jpeg', 35);
insert into photo (photo, post_id) values ('abs.jpeg', 42);
insert into photo (photo, post_id) values ('abs.jpeg', 75);
insert into photo (photo, post_id) values ('abs.jpeg', 104);
insert into photo (photo, post_id) values ('abs.jpeg', 74);
insert into photo (photo, post_id) values ('abs.jpeg', 187);
insert into photo (photo, post_id) values ('abs.jpeg', 62);
insert into photo (photo, post_id) values ('abs.jpeg', 182);
insert into photo (photo, post_id) values ('abs.jpeg', 138);
insert into photo (photo, post_id) values ('abs.jpeg', 86);
insert into photo (photo, post_id) values ('abs.jpeg', 120);
insert into photo (photo, post_id) values ('abs.jpeg', 112);
insert into photo (photo, post_id) values ('abs.jpeg', 132);
insert into photo (photo, post_id) values ('abs.jpeg', 99);
insert into photo (photo, post_id) values ('abs.jpeg', 159);
insert into photo (photo, post_id) values ('abs.jpeg', 71);
insert into photo (photo, post_id) values ('abs.jpeg', 58);
insert into photo (photo, post_id) values ('abs.jpeg', 179);
insert into photo (photo, post_id) values ('abs.jpeg', 70);
insert into photo (photo, post_id) values ('abs.jpeg', 191);
insert into photo (photo, post_id) values ('abs.jpeg', 157);
insert into photo (photo, post_id) values ('abs.jpeg', 21);
insert into photo (photo, post_id) values ('abs.jpeg', 6);
insert into photo (photo, post_id) values ('abs.jpeg', 131);
insert into photo (photo, post_id) values ('abs.jpeg', 100);
insert into photo (photo, post_id) values ('abs.jpeg', 5);
insert into photo (photo, post_id) values ('abs.jpeg', 164);
insert into photo (photo, post_id) values ('abs.jpeg', 93);
insert into photo (photo, post_id) values ('abs.jpeg', 67);
insert into photo (photo, post_id) values ('abs.jpeg', 5);
insert into photo (photo, post_id) values ('abs.jpeg', 131);
insert into photo (photo, post_id) values ('abs.jpeg', 40);
insert into photo (photo, post_id) values ('abs.jpeg', 139);
insert into photo (photo, post_id) values ('abs.jpeg', 165);
insert into photo (photo, post_id) values ('abs.jpeg', 48);
insert into photo (photo, post_id) values ('abs.jpeg', 103);
insert into photo (photo, post_id) values ('abs.jpeg', 99);
insert into photo (photo, post_id) values ('abs.jpeg', 28);
insert into photo (photo, post_id) values ('abs.jpeg', 161);
insert into photo (photo, post_id) values ('abs.jpeg', 118);
insert into photo (photo, post_id) values ('abs.jpeg', 94);
insert into photo (photo, post_id) values ('abs.jpeg', 80);
insert into photo (photo, post_id) values ('abs.jpeg', 25);
insert into photo (photo, post_id) values ('abs.jpeg', 163);
insert into photo (photo, post_id) values ('abs.jpeg', 188);
insert into photo (photo, post_id) values ('abs.jpeg', 30);
insert into photo (photo, post_id) values ('abs.jpeg', 54);
insert into photo (photo, post_id) values ('abs.jpeg', 122);
insert into photo (photo, post_id) values ('abs.jpeg', 29);
insert into photo (photo, post_id) values ('abs.jpeg', 142);
insert into photo (photo, post_id) values ('abs.jpeg', 117);
insert into photo (photo, post_id) values ('abs.jpeg', 144);
insert into photo (photo, post_id) values ('abs.jpeg', 110);
insert into photo (photo, post_id) values ('abs.jpeg', 73);
insert into photo (photo, post_id) values ('abs.jpeg', 90);
insert into photo (photo, post_id) values ('abs.jpeg', 138);
insert into photo (photo, post_id) values ('abs.jpeg', 53);
insert into photo (photo, post_id) values ('abs.jpeg', 73);
insert into photo (photo, post_id) values ('abs.jpeg', 79);
insert into photo (photo, post_id) values ('abs.jpeg', 62);
insert into photo (photo, post_id) values ('abs.jpeg', 182);
insert into photo (photo, post_id) values ('abs.jpeg', 56);
insert into photo (photo, post_id) values ('abs.jpeg', 46);
insert into photo (photo, post_id) values ('abs.jpeg', 24);
insert into photo (photo, post_id) values ('abs.jpeg', 178);
insert into photo (photo, post_id) values ('abs.jpeg', 196);
insert into photo (photo, post_id) values ('abs.jpeg', 81);

--POST TAG
insert into post_tag (post_id, tag_id) values (1, 3);
insert into post_tag (post_id, tag_id) values (1, 19);
insert into post_tag (post_id, tag_id) values (1, 36);
insert into post_tag (post_id, tag_id) values (2, 17);
insert into post_tag (post_id, tag_id) values (2, 38);
insert into post_tag (post_id, tag_id) values (2, 72);
insert into post_tag (post_id, tag_id) values (3, 45);
insert into post_tag (post_id, tag_id) values (4, 50);
insert into post_tag (post_id, tag_id) values (5, 32);
insert into post_tag (post_id, tag_id) values (5, 79);
insert into post_tag (post_id, tag_id) values (6, 25);
insert into post_tag (post_id, tag_id) values (6, 36);
insert into post_tag (post_id, tag_id) values (6, 100);
insert into post_tag (post_id, tag_id) values (7, 77);
insert into post_tag (post_id, tag_id) values (8, 10);
insert into post_tag (post_id, tag_id) values (9, 6);
insert into post_tag (post_id, tag_id) values (9, 7);
insert into post_tag (post_id, tag_id) values (10, 94);
insert into post_tag (post_id, tag_id) values (11, 8);
insert into post_tag (post_id, tag_id) values (22, 7);
insert into post_tag (post_id, tag_id) values (12, 78);
insert into post_tag (post_id, tag_id) values (13, 22);
insert into post_tag (post_id, tag_id) values (14, 32);
insert into post_tag (post_id, tag_id) values (14, 55);
insert into post_tag (post_id, tag_id) values (15, 23);
insert into post_tag (post_id, tag_id) values (15, 42);
insert into post_tag (post_id, tag_id) values (15, 46);
insert into post_tag (post_id, tag_id) values (16, 19);
insert into post_tag (post_id, tag_id) values (17, 48);
insert into post_tag (post_id, tag_id) values (18, 96);
insert into post_tag (post_id, tag_id) values (19, 89);
insert into post_tag (post_id, tag_id) values (19, 97);
insert into post_tag (post_id, tag_id) values (20, 8);
insert into post_tag (post_id, tag_id) values (20, 15);
insert into post_tag (post_id, tag_id) values (20, 33);
insert into post_tag (post_id, tag_id) values (20, 54);
insert into post_tag (post_id, tag_id) values (20, 88);
insert into post_tag (post_id, tag_id) values (20, 95);
insert into post_tag (post_id, tag_id) values (21, 4);
insert into post_tag (post_id, tag_id) values (21, 59);
insert into post_tag (post_id, tag_id) values (22, 6);
insert into post_tag (post_id, tag_id) values (22, 56);
insert into post_tag (post_id, tag_id) values (23, 42);
insert into post_tag (post_id, tag_id) values (23, 86);
insert into post_tag (post_id, tag_id) values (23, 93);
insert into post_tag (post_id, tag_id) values (24, 35);
insert into post_tag (post_id, tag_id) values (25, 9);
insert into post_tag (post_id, tag_id) values (25, 51);
insert into post_tag (post_id, tag_id) values (25, 72);
insert into post_tag (post_id, tag_id) values (26, 20);
insert into post_tag (post_id, tag_id) values (27, 4);
insert into post_tag (post_id, tag_id) values (28, 25);
insert into post_tag (post_id, tag_id) values (29, 63);
insert into post_tag (post_id, tag_id) values (29, 96);
insert into post_tag (post_id, tag_id) values (30, 62);
insert into post_tag (post_id, tag_id) values (31, 3);
insert into post_tag (post_id, tag_id) values (31, 51);
insert into post_tag (post_id, tag_id) values (31, 75);
insert into post_tag (post_id, tag_id) values (31, 83);
insert into post_tag (post_id, tag_id) values (32, 69);
insert into post_tag (post_id, tag_id) values (32, 80);
insert into post_tag (post_id, tag_id) values (32, 83);
insert into post_tag (post_id, tag_id) values (33, 94);
insert into post_tag (post_id, tag_id) values (33, 98);
insert into post_tag (post_id, tag_id) values (34, 63);
insert into post_tag (post_id, tag_id) values (34, 100);
insert into post_tag (post_id, tag_id) values (35, 2);
insert into post_tag (post_id, tag_id) values (35, 3);
insert into post_tag (post_id, tag_id) values (35, 46);
insert into post_tag (post_id, tag_id) values (36, 26);
insert into post_tag (post_id, tag_id) values (37, 43);
insert into post_tag (post_id, tag_id) values (37, 79);
insert into post_tag (post_id, tag_id) values (37, 85);
insert into post_tag (post_id, tag_id) values (37, 91);
insert into post_tag (post_id, tag_id) values (38, 47);
insert into post_tag (post_id, tag_id) values (39, 45);
insert into post_tag (post_id, tag_id) values (40, 41);
insert into post_tag (post_id, tag_id) values (40, 90);
insert into post_tag (post_id, tag_id) values (41, 99);
insert into post_tag (post_id, tag_id) values (42, 78);
insert into post_tag (post_id, tag_id) values (43, 3);
insert into post_tag (post_id, tag_id) values (43, 74);
insert into post_tag (post_id, tag_id) values (43, 76);
insert into post_tag (post_id, tag_id) values (43, 83);
insert into post_tag (post_id, tag_id) values (43, 85);
insert into post_tag (post_id, tag_id) values (44, 47);
insert into post_tag (post_id, tag_id) values (45, 18);
insert into post_tag (post_id, tag_id) values (46, 38);
insert into post_tag (post_id, tag_id) values (46, 48);
insert into post_tag (post_id, tag_id) values (46, 93);
insert into post_tag (post_id, tag_id) values (47, 51);
insert into post_tag (post_id, tag_id) values (47, 85);
insert into post_tag (post_id, tag_id) values (48, 79);
insert into post_tag (post_id, tag_id) values (49, 100);
insert into post_tag (post_id, tag_id) values (50, 32);
insert into post_tag (post_id, tag_id) values (51, 95);
insert into post_tag (post_id, tag_id) values (52, 50);
insert into post_tag (post_id, tag_id) values (52, 54);
insert into post_tag (post_id, tag_id) values (52, 66);
insert into post_tag (post_id, tag_id) values (53, 48);
insert into post_tag (post_id, tag_id) values (53, 74);
insert into post_tag (post_id, tag_id) values (54, 3);
insert into post_tag (post_id, tag_id) values (54, 7);
insert into post_tag (post_id, tag_id) values (54, 16);
insert into post_tag (post_id, tag_id) values (54, 44);
insert into post_tag (post_id, tag_id) values (54, 87);
insert into post_tag (post_id, tag_id) values (55, 80);
insert into post_tag (post_id, tag_id) values (56, 4);
insert into post_tag (post_id, tag_id) values (56, 40);
insert into post_tag (post_id, tag_id) values (56, 80);
insert into post_tag (post_id, tag_id) values (57, 7);
insert into post_tag (post_id, tag_id) values (57, 19);
insert into post_tag (post_id, tag_id) values (58, 71);
insert into post_tag (post_id, tag_id) values (58, 75);
insert into post_tag (post_id, tag_id) values (58, 80);
insert into post_tag (post_id, tag_id) values (59, 12);
insert into post_tag (post_id, tag_id) values (59, 19);
insert into post_tag (post_id, tag_id) values (59, 79);
insert into post_tag (post_id, tag_id) values (60, 7);
insert into post_tag (post_id, tag_id) values (60, 48);
insert into post_tag (post_id, tag_id) values (61, 80);
insert into post_tag (post_id, tag_id) values (62, 48);
insert into post_tag (post_id, tag_id) values (63, 9);
insert into post_tag (post_id, tag_id) values (64, 60);
insert into post_tag (post_id, tag_id) values (65, 19);
insert into post_tag (post_id, tag_id) values (65, 31);
insert into post_tag (post_id, tag_id) values (65, 92);
insert into post_tag (post_id, tag_id) values (65, 93);
insert into post_tag (post_id, tag_id) values (66, 36);
insert into post_tag (post_id, tag_id) values (66, 57);
insert into post_tag (post_id, tag_id) values (67, 22);
insert into post_tag (post_id, tag_id) values (67, 88);
insert into post_tag (post_id, tag_id) values (67, 90);
insert into post_tag (post_id, tag_id) values (68, 44);
insert into post_tag (post_id, tag_id) values (69, 11);
insert into post_tag (post_id, tag_id) values (69, 38);
insert into post_tag (post_id, tag_id) values (70, 43);
insert into post_tag (post_id, tag_id) values (70, 65);
insert into post_tag (post_id, tag_id) values (71, 38);
insert into post_tag (post_id, tag_id) values (72, 89);
insert into post_tag (post_id, tag_id) values (73, 37);
insert into post_tag (post_id, tag_id) values (73, 43);
insert into post_tag (post_id, tag_id) values (73, 52);
insert into post_tag (post_id, tag_id) values (73, 91);
insert into post_tag (post_id, tag_id) values (74, 61);
insert into post_tag (post_id, tag_id) values (74, 82);
insert into post_tag (post_id, tag_id) values (75, 85);
insert into post_tag (post_id, tag_id) values (76, 53);
insert into post_tag (post_id, tag_id) values (76, 61);
insert into post_tag (post_id, tag_id) values (76, 98);
insert into post_tag (post_id, tag_id) values (77, 22);
insert into post_tag (post_id, tag_id) values (77, 59);
insert into post_tag (post_id, tag_id) values (77, 64);
insert into post_tag (post_id, tag_id) values (78, 75);
insert into post_tag (post_id, tag_id) values (78, 78);
insert into post_tag (post_id, tag_id) values (79, 26);
insert into post_tag (post_id, tag_id) values (79, 32);
insert into post_tag (post_id, tag_id) values (79, 88);
insert into post_tag (post_id, tag_id) values (79, 97);
insert into post_tag (post_id, tag_id) values (79, 100);
insert into post_tag (post_id, tag_id) values (80, 9);
insert into post_tag (post_id, tag_id) values (80, 41);
insert into post_tag (post_id, tag_id) values (81, 31);
insert into post_tag (post_id, tag_id) values (80, 44);
insert into post_tag (post_id, tag_id) values (82, 82);
insert into post_tag (post_id, tag_id) values (83, 68);
insert into post_tag (post_id, tag_id) values (84, 44);
insert into post_tag (post_id, tag_id) values (84, 94);
insert into post_tag (post_id, tag_id) values (85, 32);
insert into post_tag (post_id, tag_id) values (85, 85);
insert into post_tag (post_id, tag_id) values (86, 4);
insert into post_tag (post_id, tag_id) values (86, 41);
insert into post_tag (post_id, tag_id) values (86, 46);
insert into post_tag (post_id, tag_id) values (87, 10);
insert into post_tag (post_id, tag_id) values (87, 67);
insert into post_tag (post_id, tag_id) values (88, 59);
insert into post_tag (post_id, tag_id) values (89, 70);
insert into post_tag (post_id, tag_id) values (89, 78);
insert into post_tag (post_id, tag_id) values (90, 50);
insert into post_tag (post_id, tag_id) values (90, 55);
insert into post_tag (post_id, tag_id) values (91, 71);
insert into post_tag (post_id, tag_id) values (91, 88);
insert into post_tag (post_id, tag_id) values (92, 1);
insert into post_tag (post_id, tag_id) values (93, 36);
insert into post_tag (post_id, tag_id) values (93, 90);
insert into post_tag (post_id, tag_id) values (93, 84);
insert into post_tag (post_id, tag_id) values (94, 4);
insert into post_tag (post_id, tag_id) values (94, 17);
insert into post_tag (post_id, tag_id) values (94, 30);
insert into post_tag (post_id, tag_id) values (95, 50);
insert into post_tag (post_id, tag_id) values (95, 75);
insert into post_tag (post_id, tag_id) values (96, 33);
insert into post_tag (post_id, tag_id) values (96, 76);
insert into post_tag (post_id, tag_id) values (97, 88);
insert into post_tag (post_id, tag_id) values (98, 23);
insert into post_tag (post_id, tag_id) values (98, 50);
insert into post_tag (post_id, tag_id) values (99, 42);
insert into post_tag (post_id, tag_id) values (99, 44);
insert into post_tag (post_id, tag_id) values (99, 62);
insert into post_tag (post_id, tag_id) values (100, 13);
insert into post_tag (post_id, tag_id) values (100, 84);

--COMMENT
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Agreed!', TIMESTAMP '2020-05-12 18:15:43', 44, 19, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Great post!', TIMESTAMP '2020-06-15 09:17:43', 15, 15, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Very well writen!', TIMESTAMP '2020-08-10 16:45:44', 58, 1, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I don''t agree.', TIMESTAMP '2020-10-11 03:11:13', 28, 13, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Good point!', TIMESTAMP '2020-08-08 13:17:17', 80, 14, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Never thought of that!', TIMESTAMP '2021-03-01 10:10:10', 68, 8, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I see many problems on this post.', TIMESTAMP '2020-12-12 15:12:10', 81, 30, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('This made me laugh!', TIMESTAMP '2020-09-20 10:12:19', 82, null, 1);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I don''t agree.', TIMESTAMP '2020-11-23 19:10:11', 43, null, 2);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I doubt that.', TIMESTAMP '2020-08-12 14:10:12', 89, 14, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Great post!', TIMESTAMP '2020-12-13 10:00:15', 9, null, 7);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Interesting take.', TIMESTAMP '2021-03-01 20:20:20', 24, 8, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I had no idea.', TIMESTAMP '2021-01-31 23:14:30', 96, 2, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Good point!', TIMESTAMP '2021-03-06 01:10:22', 74, 9, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Very well writen!', TIMESTAMP '2021-01-26 00:10:10', 60, 7, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Agreed!', TIMESTAMP '2020-10-31 10:15:55', 59, null, 2);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Never thought of that!', TIMESTAMP '2020-06-16 08:18:12', 83, 10, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I see many problems on this post.', TIMESTAMP '2020-12-25 12:12:12', 83, null, 7);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I doubt that.', TIMESTAMP '2020-10-06 13:50:19', 92, 13, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Interesting take.', TIMESTAMP '2021-02-01 00:10:50', 59, 11, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I had no idea.', TIMESTAMP '2020-08-25 19:19:19', 32, 21, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Wow!', TIMESTAMP '2020-09-29 22:12:10', 46, null, 1);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Great post!', TIMESTAMP '2020-12-27 15:10:22', 51, null, 7);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Never thought of that!', TIMESTAMP '2020-02-25 13:22:10', 37, 29, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Good point!', TIMESTAMP '2020-12-01 15:10:55', 82, 30, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I don''t agree.', TIMESTAMP '2020-12-25 23:11:10', 54, null, 7);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I see many problems on this post.', TIMESTAMP '2020-07-11 19:18:41', 51, 16, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Very well writen!', TIMESTAMP '2021-03-03 17:16:30', 26, null, 3);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('This made me laugh!', TIMESTAMP '2020-12-07 14:12:20', 81, null, 10);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Agreed!', TIMESTAMP '2021-02-02 10:40:40', 63, 23, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I don''t agree.', TIMESTAMP '2021-03-25 16:17:15', 9, null, 2);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Good point!', TIMESTAMP '2020-10-06 18:15:18', 86, 13, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Never thought of that!', TIMESTAMP '2020-03-19 18:28:31', 3, 24, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I doubt that.', TIMESTAMP '2020-04-14 10:14:44', 76, null, 33);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I see many problems on this post.', TIMESTAMP '2020-08-13 18:15:10', 61, null, 5);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('This made me laugh!', TIMESTAMP '2020-10-07 17:16:10', 31, 5, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Very well writen!', TIMESTAMP '2020-02-04 10:33:14', 72, 26, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Interesting take.', TIMESTAMP '2021-03-02 12:16:55', 21, null, 6);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Good point!', TIMESTAMP '2020-12-08 21:25:25', 62, 20, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Never thought of that!', TIMESTAMP '2020-11-30 00:16:10', 71, 29, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I don''t agree.', TIMESTAMP '2020-12-15 15:17:11', 90, 13, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Agreed!', TIMESTAMP '2020-12-14 10:00:35', 49, null, 7);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I see many problems on this post.', TIMESTAMP '2020-11-23 20:13:45', 17, null, 17);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I had no idea.', TIMESTAMP '2021-01-15 19:55:23', 94, 13, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I doubt that.', TIMESTAMP '2021-02-18 18:03:10', 59, 25, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Great post!', TIMESTAMP '2020-11-25 10:09:19', 65, null, 21);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Interesting take.', TIMESTAMP '2021-03-01 17:28:19', 61, null, 6);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Good point!', TIMESTAMP '2020-12-23 15:22:23', 83, null, 27);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('This made me laugh!', TIMESTAMP '2020-08-10 11:11:16', 93, 14, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I see many problems on this post.', TIMESTAMP '2020-10-06 16:10:16', 59, 13, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Interesting take.', TIMESTAMP '2020-10-19 22:17:13', 65, 13, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I doubt that.', TIMESTAMP '2021-02-25 14:12:20', 61, null, 13);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Very well writen!', TIMESTAMP '2020-03-11 22:30:10', 83, 6, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('This made me laugh!', TIMESTAMP '2020-11-08 20:07:17', 93, null, 17);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I had no idea.', TIMESTAMP '2021-03-12 06:18:10', 59, null, 5);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('This made me laugh!', TIMESTAMP '2020-10-12 11:12:10', 57, 14, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Great post!', TIMESTAMP '2021-03-02 13:44:33', 10, 8, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Great post!', TIMESTAMP '2020-12-14 18:45:08', 52, null, 7);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('This made me laugh!', TIMESTAMP '2020-12-21 03:16:22', 80, null, 40);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Never thought of that!', TIMESTAMP '2020-06-17 11:11:11', 14, 10, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I had no idea.', TIMESTAMP '2021-03-13 10:10:10', 86, null, 30);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Agreed!', TIMESTAMP '2020-12-13 20:19:10', 88, null, 7);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Wow!', TIMESTAMP '2020-01-15 09:30:10', 29, 19, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I see many problems on this post.', TIMESTAMP '2021-02-08 16:18:08', 9, null, 1);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Interesting take.', TIMESTAMP '2020-08-22 17:13:44', 40, 6, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I don''t agree.', TIMESTAMP '2021-01-25 19:12:11', 67, 25, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Never thought of that!', TIMESTAMP '2020-08-19 14:44:30', 86, null, 5);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Wow!', TIMESTAMP '2020-07-12 10:09:33', 87, 21, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Agreed!', TIMESTAMP '2021-03-02 19:19:20', 92, 8, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Good point!', TIMESTAMP '2020-12-11 12:40:19', 35, 17, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I doubt that.', TIMESTAMP '2020-12-17 13:00:14', 29, null, 7);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Great post!', TIMESTAMP '2021-02-05 22:22:12', 83, 26, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I had no idea.', TIMESTAMP '2020-08-20 14:44:32', 13, null, 3);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Wow!', TIMESTAMP '2020-12-16 10:13:26', 80, 15, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Very well writen!', TIMESTAMP '2021-01-23 09:20:19', 87, 30, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Wow!', TIMESTAMP '2021-02-10 11:00:59', 20, null, 4);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Wow!', TIMESTAMP '2020-11-23 15:50:55', 15, 11, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Interesting take.', TIMESTAMP '2021-03-02 22:12:56', 48, null, 6);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Great post!', TIMESTAMP '2020-08-17 10:57:30', 35, 3, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I had no idea.', TIMESTAMP '2020-04-20 13:16:17', 23, 26, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I see many problems on this post.', TIMESTAMP '2020-12-27 09:12:20', 72, 14, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('This made me laugh!', TIMESTAMP '2020-11-22 10:09:09', 77, 6, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I don''t agree.', TIMESTAMP '2020-12-18 19:39:00', 86, 28, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Agreed!', TIMESTAMP '2020-12-02 14:18:15', 85, 29, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I doubt that.', TIMESTAMP '2020-08-23 15:16:45', 66, null, 27);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Wow!', TIMESTAMP '2021-02-08 17:12:46', 96, 14, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Never thought of that!', TIMESTAMP '2020-12-15 13:14:16', 95, 6, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Wow!', TIMESTAMP '2020-09-16 16:10:15', 78, null, 37);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Agreed!', TIMESTAMP '2020-12-21 10:13:16', 37, 20, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I had no idea.', TIMESTAMP '2021-03-06 01:11:00', 100, null, 14);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Great post!', TIMESTAMP '2020-11-29 12:17:22', 49, 6, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Interesting take.', TIMESTAMP '2021-01-12 13:22:27', 1, 20, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I doubt that.', TIMESTAMP '2020-12-11 19:22:29', 6, null, 68);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('This made me laugh!', TIMESTAMP '2021-01-06 14:55:10', 94, 20, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Very well writen!', TIMESTAMP '2020-08-04 15:19:55', 18, 1, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I see many problems on this post.', TIMESTAMP '2020-08-24 22:03:05', 68, null, 65);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Good point!', TIMESTAMP '2020-10-17 09:10:06', 99, 27, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('I don''t agree.', TIMESTAMP '2020-10-07 16:22:55', 27, null, 32);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Agreed!', TIMESTAMP '2020-08-20 21:16:10', 51, 10, null);
insert into comment (content, comment_date, user_id, post_id, comment_id) values ('Great post!', TIMESTAMP '2021-03-06 10:10:10', 57, 9, null);


--SAVES
insert into saves (user_id, post_id) values (55, 9);
insert into saves (user_id, post_id) values (77, 20);
insert into saves (user_id, post_id) values (34, 21);
insert into saves (user_id, post_id) values (3, 21);
insert into saves (user_id, post_id) values (7, 11);
insert into saves (user_id, post_id) values (3, 24);
insert into saves (user_id, post_id) values (21, 30);
insert into saves (user_id, post_id) values (95, 16);
insert into saves (user_id, post_id) values (16, 11);
insert into saves (user_id, post_id) values (95, 13);
insert into saves (user_id, post_id) values (35, 4);
insert into saves (user_id, post_id) values (2, 14);
insert into saves (user_id, post_id) values (26, 18);
insert into saves (user_id, post_id) values (56, 5);
insert into saves (user_id, post_id) values (13, 14);
insert into saves (user_id, post_id) values (64, 23);
insert into saves (user_id, post_id) values (66, 8);
insert into saves (user_id, post_id) values (37, 17);
insert into saves (user_id, post_id) values (13, 21);
insert into saves (user_id, post_id) values (74, 2);
insert into saves (user_id, post_id) values (33, 5);
insert into saves (user_id, post_id) values (38, 22);
insert into saves (user_id, post_id) values (52, 27);
insert into saves (user_id, post_id) values (13, 7);
insert into saves (user_id, post_id) values (44, 24);
insert into saves (user_id, post_id) values (9, 23);
insert into saves (user_id, post_id) values (14, 26);
insert into saves (user_id, post_id) values (12, 2);
insert into saves (user_id, post_id) values (41, 18);
insert into saves (user_id, post_id) values (77, 9);
insert into saves (user_id, post_id) values (58, 9);
insert into saves (user_id, post_id) values (81, 1);
insert into saves (user_id, post_id) values (17, 27);
insert into saves (user_id, post_id) values (29, 17);
insert into saves (user_id, post_id) values (31, 15);
insert into saves (user_id, post_id) values (87, 15);
insert into saves (user_id, post_id) values (51, 8);
insert into saves (user_id, post_id) values (90, 24);
insert into saves (user_id, post_id) values (66, 13);
insert into saves (user_id, post_id) values (30, 16);
insert into saves (user_id, post_id) values (70, 13);
insert into saves (user_id, post_id) values (57, 12);
insert into saves (user_id, post_id) values (9, 30);
insert into saves (user_id, post_id) values (82, 16);
insert into saves (user_id, post_id) values (73, 29);
insert into saves (user_id, post_id) values (80, 6);
insert into saves (user_id, post_id) values (85, 8);
insert into saves (user_id, post_id) values (95, 2);
insert into saves (user_id, post_id) values (6, 14);
insert into saves (user_id, post_id) values (23, 24);
insert into saves (user_id, post_id) values (37, 30);
insert into saves (user_id, post_id) values (73, 4);
insert into saves (user_id, post_id) values (87, 26);
insert into saves (user_id, post_id) values (32, 20);
insert into saves (user_id, post_id) values (90, 16);
insert into saves (user_id, post_id) values (1, 11);
insert into saves (user_id, post_id) values (13, 20);
insert into saves (user_id, post_id) values (8, 22);
insert into saves (user_id, post_id) values (38, 21);
insert into saves (user_id, post_id) values (19, 28);
insert into saves (user_id, post_id) values (35, 11);
insert into saves (user_id, post_id) values (42, 25);
insert into saves (user_id, post_id) values (60, 24);
insert into saves (user_id, post_id) values (40, 18);
insert into saves (user_id, post_id) values (73, 10);
insert into saves (user_id, post_id) values (26, 27);
insert into saves (user_id, post_id) values (51, 20);
insert into saves (user_id, post_id) values (100, 26);
insert into saves (user_id, post_id) values (69, 18);
insert into saves (user_id, post_id) values (58, 25);
insert into saves (user_id, post_id) values (83, 20);
insert into saves (user_id, post_id) values (5, 15);
insert into saves (user_id, post_id) values (69, 7);
insert into saves (user_id, post_id) values (11, 29);
insert into saves (user_id, post_id) values (72, 17);
insert into saves (user_id, post_id) values (38, 5);
insert into saves (user_id, post_id) values (17, 5);
insert into saves (user_id, post_id) values (61, 5);
insert into saves (user_id, post_id) values (40, 3);
insert into saves (user_id, post_id) values (24, 22);
insert into saves (user_id, post_id) values (23, 25);
insert into saves (user_id, post_id) values (51, 21);
insert into saves (user_id, post_id) values (57, 22);
insert into saves (user_id, post_id) values (63, 2);
insert into saves (user_id, post_id) values (76, 15);
insert into saves (user_id, post_id) values (65, 10);
insert into saves (user_id, post_id) values (93, 26);
insert into saves (user_id, post_id) values (50, 27);
insert into saves (user_id, post_id) values (33, 15);
insert into saves (user_id, post_id) values (32, 26);
insert into saves (user_id, post_id) values (60, 20);
insert into saves (user_id, post_id) values (5, 1);
insert into saves (user_id, post_id) values (78, 21);
insert into saves (user_id, post_id) values (1, 2);
insert into saves (user_id, post_id) values (37, 4);
insert into saves (user_id, post_id) values (81, 4);
insert into saves (user_id, post_id) values (28, 3);
insert into saves (user_id, post_id) values (86, 23);
insert into saves (user_id, post_id) values (91, 4);
insert into saves (user_id, post_id) values (15, 23);


--SUPPORT
insert into support (problem, browser, frequency, impact, email) values ('Broken link in homepage.', 'Internet Explorer', 'Often', 4, 'ebrenton0@prweb.com');
insert into support (problem, browser, frequency, impact, email) values ('Can''t edit my post.', 'Opera', 'Very Often', 4, 'mfellow1@deviantart.com');
insert into support (problem, browser, frequency, impact, email) values ('Thumbnail upload is not working.', 'Opera', 'Rarely', 5, 'nderycot2@netscape.com');
insert into support (problem, browser, frequency, impact, email) values ('How do I become a moderator?', 'Opera', 'Often', 5, 'wpummell3@jalbum.net');
insert into support (problem, browser, frequency, impact, email) values ('Another user won''t stop bullying me in the comments.', 'Opera', 'Often', 5, 'ctremoulet4@fotki.com');
insert into support (problem, browser, frequency, impact, email) values ('Why isn''t my post having more views?', 'Opera', 'Often', 5, 'ffraczak5@xrea.com');
insert into support (problem, browser, frequency, impact, email) values ('My account was hacked, what do I do?', 'Internet Explorer', 'Very Often', 4, 'abrotherwood6@shop-pro.jp');
insert into support (problem, browser, frequency, impact, email) values ('My profile page isn''t loading.', 'Opera', 'Often', 5, 'lcollinson7@deliciousdays.com');
insert into support (problem, browser, frequency, impact, email) values ('Can''t see posts by the people I follow.', 'Internet Explorer', 'Very Often', 5, 'mmatchitt8@fotki.com');
insert into support (problem, browser, frequency, impact, email) values ('How do I know if someone follows me back?', 'Opera', 'Rarely', 4, 'mketts9@prlog.org');
insert into support (problem, browser, frequency, impact, email) values ('I can''t change my profile picture.', 'Internet Explorer', 'Very Often', 4, 'beveretta@icq.com');
insert into support (problem, browser, frequency, impact, email) values ('My profile page isn''t loading.', 'Opera', 'Very Often', 5, 'uwhittinghamb@ucla.edu');
insert into support (problem, browser, frequency, impact, email) values ('How do I link my social media?', 'Opera', 'Often', 5, 'prankinec@photobucket.com');
insert into support (problem, browser, frequency, impact, email) values ('Another user won''t stop bullying me in the comments.', 'Microsoft Edge', 'Very Often', 2, 'erodbourned@ox.ac.uk');
insert into support (problem, browser, frequency, impact, email) values ('Thumbnail upload is not working.', 'Internet Explorer', 'Rarely', 4, 'pskirvine@zdnet.com');
insert into support (problem, browser, frequency, impact, email) values ('My profile page isn''t loading.', 'Internet Explorer', 'Often', 5, 'wsymsf@technorati.com');
insert into support (problem, browser, frequency, impact, email) values ('Broken link in homepage.', 'Opera', 'Often', 1, 'rtilstong@buzzfeed.com');
insert into support (problem, browser, frequency, impact, email) values ('How do I become a moderator?', 'Internet Explorer', 'Rarely', 4, 'dbaudouinh@xrea.com');
insert into support (problem, browser, frequency, impact, email) values ('Can''t see posts by the people I follow.', 'Opera', 'Very Often', 3, 'pjurczaki@histats.com');
insert into support (problem, browser, frequency, impact, email) values ('I can''t change my profile picture.', 'Opera', 'Often', 3, 'rherculesonj@economist.com');
insert into support (problem, browser, frequency, impact, email) values ('How do I link my social media?', 'Internet Explorer', 'Very Often', 3, 'ljannawayk@networksolutions.com');
insert into support (problem, browser, frequency, impact, email) values ('Why isn''t my post having more views?', 'Firefox', 'Often', 1, 'mwessonl@gmpg.org');
insert into support (problem, browser, frequency, impact, email) values ('Why isn''t my post having more views?', 'Opera', 'Rarely', 3, 'bfishleighm@google.cn');
insert into support (problem, browser, frequency, impact, email) values ('Can''t edit my post.', 'Opera', 'Very Often', 1, 'ojiran@usatoday.com');
insert into support (problem, browser, frequency, impact, email) values ('Another user won''t stop bullying me in the comments.', 'Opera', 'Very Often', 2, 'wwoolfordo@wired.com');
insert into support (problem, browser, frequency, impact, email) values ('My account was hacked, what do I do?', 'Safari', 'Rarely', 2, 'ktyzackp@washingtonpost.com');
insert into support (problem, browser, frequency, impact, email) values ('How do I know if someone follows me back?', 'Safari', 'Very Often', 2, 'cpesicq@zimbio.com');
insert into support (problem, browser, frequency, impact, email) values ('Broken link in homepage.', 'Opera', 'Very Often', 5, 'fmacguffogr@unesco.org');
insert into support (problem, browser, frequency, impact, email) values ('I can''t change my profile picture.', 'Opera', 'Often', 4, 'grolingsons@hhs.gov');
insert into support (problem, browser, frequency, impact, email) values ('My profile page isn''t loading.', 'Safari', 'Often', 2, 'ascotchfortht@admin.ch');
insert into support (problem, browser, frequency, impact, email) values ('Can''t edit my post.', 'Internet Explorer', 'Very Often', 2, 'bmcelroyu@hhs.gov');
insert into support (problem, browser, frequency, impact, email) values ('Thumbnail upload is not working.', 'Opera', 'Very Often', 1, 'hpepineauxv@businessweek.com');
insert into support (problem, browser, frequency, impact, email) values ('How do I become a moderator?', 'Opera', 'Often', 1, 'areapew@51.la');
insert into support (problem, browser, frequency, impact, email) values ('How do I know if someone follows me back?', 'Firefox', 'Often', 5, 'mgantzmanx@answers.com');
insert into support (problem, browser, frequency, impact, email) values ('How do I link my social media?', 'Opera', 'Very Often', 2, 'ymaclleesey@jimdo.com');
insert into support (problem, browser, frequency, impact, email) values ('My account was hacked, what do I do?', 'Internet Explorer', 'Often', 4, 'jantragz@360.cn');
insert into support (problem, browser, frequency, impact, email) values ('Can''t see posts by the people I follow.', 'Internet Explorer', 'Very Often', 3, 'aparker10@blog.com');
insert into support (problem, browser, frequency, impact, email) values ('Thumbnail upload is not working.', 'Opera', 'Rarely', 2, 'rkear11@sun.com');
insert into support (problem, browser, frequency, impact, email) values ('Why isn''t my post having more views?', 'Internet Explorer', 'Very Often', 5,'bgreenhalgh12@scientificamerican.com');
insert into support (problem, browser, frequency, impact, email) values ('Another user won''t stop bullying me in the comments.', 'Internet Explorer', 'Rarely', 5, 'bscyner13@noaa.gov');
insert into support (problem, browser, frequency, impact, email) values ('Broken link in homepage.', 'Google Chrome', 'Very Often', 3, 'mhundey14@paypal.com');
insert into support (problem, browser, frequency, impact, email) values ('I can''t change my profile picture.', 'Opera', 'Very Often', 2, 'qhamblington15@desdev.cn');
insert into support (problem, browser, frequency, impact, email) values ('How do I become a moderator?', 'Google Chrome', 'Rarely', 3, 'wpeacocke16@oakley.com');
insert into support (problem, browser, frequency, impact, email) values ('Can''t see posts by the people I follow.', 'Microsoft Edge', 'Very Often', 3, 'floverock17@a8.net');
insert into support (problem, browser, frequency, impact, email) values ('How do I know if someone follows me back?', 'Opera', 'Very Often', 4, 'rchastang18@ucoz.com');
insert into support (problem, browser, frequency, impact, email) values ('Can''t edit my post.', 'Internet Explorer', 'Very Often', 2, 'bcodner19@amazon.co.uk');
insert into support (problem, browser, frequency, impact, email) values ('Why isn''t my post having more views?', 'Internet Explorer', 'Often', 2, 'mhearnshaw1a@google.ca');
insert into support (problem, browser, frequency, impact, email) values ('My account was hacked, what do I do?', 'Microsoft Edge', 'Very Often', 1, 'byarker1b@ezinearticles.com');
insert into support (problem, browser, frequency, impact, email) values ('How do I become a moderator?', 'Internet Explorer', 'Very Often', 2, 'ncolling1c@mozilla.org');
insert into support (problem, browser, frequency, impact, email) values ('Thumbnail upload is not working.', 'Opera', 'Very Often', 4, 'amarquand1d@hc360.com');

--FAQ
insert into faq (question, answer) values ('Why do I need to create an account?', 'Even though you can view all posts without an account, you need one in order to be able to comment, like, dislike, follow other users and follow your favorite tags.');
insert into faq (question, answer) values ('How can I report a comment or post?', 'By clicking the forbidden icon in the post or comment you wish to report.');
insert into faq (question, answer) values ('What happens to a post that gets reported?', 'The post will be marked, one of the moderators is going to analyze it and decide if it indeed breaks the rules of the site.');
insert into faq (question, answer) values ('Where can I change my preferences?', 'On users'' profile, in settings.');
insert into faq (question, answer) values ('How old do I have to be to create an account?', 'The minimum age is 13 years old.');

--follow_tag
insert into follow_tag (user_id, tag_id) values (1, 51);
insert into follow_tag (user_id, tag_id) values (1, 70);
insert into follow_tag (user_id, tag_id) values (1, 100);
insert into follow_tag (user_id, tag_id) values (2, 38);
insert into follow_tag (user_id, tag_id) values (2, 10);
insert into follow_tag (user_id, tag_id) values (2, 18);
insert into follow_tag (user_id, tag_id) values (3, 13);
insert into follow_tag (user_id, tag_id) values (4, 46);
insert into follow_tag (user_id, tag_id) values (4, 50);
insert into follow_tag (user_id, tag_id) values (4, 95);
insert into follow_tag (user_id, tag_id) values (4, 12);
insert into follow_tag (user_id, tag_id) values (4, 97);
insert into follow_tag (user_id, tag_id) values (4, 13);
insert into follow_tag (user_id, tag_id) values (4, 19);
insert into follow_tag (user_id, tag_id) values (5, 39);
insert into follow_tag (user_id, tag_id) values (6, 21);
insert into follow_tag (user_id, tag_id) values (6, 28);
insert into follow_tag (user_id, tag_id) values (6, 96);
insert into follow_tag (user_id, tag_id) values (7, 16);
insert into follow_tag (user_id, tag_id) values (8, 71);
insert into follow_tag (user_id, tag_id) values (8, 13);
insert into follow_tag (user_id, tag_id) values (8, 17);
insert into follow_tag (user_id, tag_id) values (9, 17);
insert into follow_tag (user_id, tag_id) values (10, 25);
insert into follow_tag (user_id, tag_id) values (10, 66);
insert into follow_tag (user_id, tag_id) values (10, 11);
insert into follow_tag (user_id, tag_id) values (10, 10);
insert into follow_tag (user_id, tag_id) values (12, 23);
insert into follow_tag (user_id, tag_id) values (12, 16);
insert into follow_tag (user_id, tag_id) values (13, 14);
insert into follow_tag (user_id, tag_id) values (13, 18);
insert into follow_tag (user_id, tag_id) values (13, 19);
insert into follow_tag (user_id, tag_id) values (14, 13);
insert into follow_tag (user_id, tag_id) values (14, 41);
insert into follow_tag (user_id, tag_id) values (14, 45);
insert into follow_tag (user_id, tag_id) values (14, 74);
insert into follow_tag (user_id, tag_id) values (14, 15);
insert into follow_tag (user_id, tag_id) values (15, 87);
insert into follow_tag (user_id, tag_id) values (15, 14);
insert into follow_tag (user_id, tag_id) values (16, 73);
insert into follow_tag (user_id, tag_id) values (16, 16);
insert into follow_tag (user_id, tag_id) values (17, 29);
insert into follow_tag (user_id, tag_id) values (17, 59);
insert into follow_tag (user_id, tag_id) values (18, 23);
insert into follow_tag (user_id, tag_id) values (18, 39);
insert into follow_tag (user_id, tag_id) values (18, 46);
insert into follow_tag (user_id, tag_id) values (18, 13);
insert into follow_tag (user_id, tag_id) values (18, 27);
insert into follow_tag (user_id, tag_id) values (18, 16);
insert into follow_tag (user_id, tag_id) values (19, 59);
insert into follow_tag (user_id, tag_id) values (19, 18);
insert into follow_tag (user_id, tag_id) values (20, 4);
insert into follow_tag (user_id, tag_id) values (20, 55);
insert into follow_tag (user_id, tag_id) values (20, 81);
insert into follow_tag (user_id, tag_id) values (20, 99);
insert into follow_tag (user_id, tag_id) values (21, 22);
insert into follow_tag (user_id, tag_id) values (21, 10);
insert into follow_tag (user_id, tag_id) values (21, 18);
insert into follow_tag (user_id, tag_id) values (21, 19);
insert into follow_tag (user_id, tag_id) values (23, 26);
insert into follow_tag (user_id, tag_id) values (23, 12);
insert into follow_tag (user_id, tag_id) values (24, 97);
insert into follow_tag (user_id, tag_id) values (24, 11);
insert into follow_tag (user_id, tag_id) values (24, 16);
insert into follow_tag (user_id, tag_id) values (25, 19);
insert into follow_tag (user_id, tag_id) values (25, 10);
insert into follow_tag (user_id, tag_id) values (26, 10);
insert into follow_tag (user_id, tag_id) values (27, 16);
insert into follow_tag (user_id, tag_id) values (28, 42);
insert into follow_tag (user_id, tag_id) values (28, 48);
insert into follow_tag (user_id, tag_id) values (29, 10);
insert into follow_tag (user_id, tag_id) values (29, 86);
insert into follow_tag (user_id, tag_id) values (30, 1);
insert into follow_tag (user_id, tag_id) values (30, 100);
insert into follow_tag (user_id, tag_id) values (30, 12);
insert into follow_tag (user_id, tag_id) values (30, 15);
insert into follow_tag (user_id, tag_id) values (30, 17);
insert into follow_tag (user_id, tag_id) values (31, 10);
insert into follow_tag (user_id, tag_id) values (31, 12);
insert into follow_tag (user_id, tag_id) values (31, 17);
insert into follow_tag (user_id, tag_id) values (32, 13);
insert into follow_tag (user_id, tag_id) values (32, 19);
insert into follow_tag (user_id, tag_id) values (33, 68);
insert into follow_tag (user_id, tag_id) values (33, 80);
insert into follow_tag (user_id, tag_id) values (33, 17);
insert into follow_tag (user_id, tag_id) values (34, 9);
insert into follow_tag (user_id, tag_id) values (34, 16);
insert into follow_tag (user_id, tag_id) values (34, 18);
insert into follow_tag (user_id, tag_id) values (35, 5);
insert into follow_tag (user_id, tag_id) values (35, 74);
insert into follow_tag (user_id, tag_id) values (35, 88);
insert into follow_tag (user_id, tag_id) values (35, 95);
insert into follow_tag (user_id, tag_id) values (38, 55);
insert into follow_tag (user_id, tag_id) values (38, 19);
insert into follow_tag (user_id, tag_id) values (38, 50);
insert into follow_tag (user_id, tag_id) values (39, 10);
insert into follow_tag (user_id, tag_id) values (39, 28);
insert into follow_tag (user_id, tag_id) values (40, 35);
insert into follow_tag (user_id, tag_id) values (40, 06);
insert into follow_tag (user_id, tag_id) values (40, 46);
insert into follow_tag (user_id, tag_id) values (41, 40);
insert into follow_tag (user_id, tag_id) values (42, 50);
insert into follow_tag (user_id, tag_id) values (42, 48);
insert into follow_tag (user_id, tag_id) values (43, 5);
insert into follow_tag (user_id, tag_id) values (44, 41);
insert into follow_tag (user_id, tag_id) values (44, 07);
insert into follow_tag (user_id, tag_id) values (44, 79);
insert into follow_tag (user_id, tag_id) values (45, 55);
insert into follow_tag (user_id, tag_id) values (45, 56);
insert into follow_tag (user_id, tag_id) values (46, 79);
insert into follow_tag (user_id, tag_id) values (47, 39);
insert into follow_tag (user_id, tag_id) values (47, 42);
insert into follow_tag (user_id, tag_id) values (48, 47);
insert into follow_tag (user_id, tag_id) values (49, 32);
insert into follow_tag (user_id, tag_id) values (49, 81);
insert into follow_tag (user_id, tag_id) values (49, 91);
insert into follow_tag (user_id, tag_id) values (50, 53);
insert into follow_tag (user_id, tag_id) values (51, 58);
insert into follow_tag (user_id, tag_id) values (52, 83);
insert into follow_tag (user_id, tag_id) values (53, 99);
insert into follow_tag (user_id, tag_id) values (53, 15);
insert into follow_tag (user_id, tag_id) values (53, 47);
insert into follow_tag (user_id, tag_id) values (54, 6);
insert into follow_tag (user_id, tag_id) values (55, 55);
insert into follow_tag (user_id, tag_id) values (55, 60);
insert into follow_tag (user_id, tag_id) values (55, 73);
insert into follow_tag (user_id, tag_id) values (56, 46);
insert into follow_tag (user_id, tag_id) values (56, 81);
insert into follow_tag (user_id, tag_id) values (57, 18);
insert into follow_tag (user_id, tag_id) values (57, 09);
insert into follow_tag (user_id, tag_id) values (57, 72);
insert into follow_tag (user_id, tag_id) values (58, 58);
insert into follow_tag (user_id, tag_id) values (58, 63);
insert into follow_tag (user_id, tag_id) values (58, 81);
insert into follow_tag (user_id, tag_id) values (59, 75);
insert into follow_tag (user_id, tag_id) values (59, 86);
insert into follow_tag (user_id, tag_id) values (59, 40);
insert into follow_tag (user_id, tag_id) values (60, 12);
insert into follow_tag (user_id, tag_id) values (60, 75);
insert into follow_tag (user_id, tag_id) values (60, 45);
insert into follow_tag (user_id, tag_id) values (61, 97);
insert into follow_tag (user_id, tag_id) values (61, 57);
insert into follow_tag (user_id, tag_id) values (61, 98);
insert into follow_tag (user_id, tag_id) values (62, 37);
insert into follow_tag (user_id, tag_id) values (62, 91);
insert into follow_tag (user_id, tag_id) values (62, 80);
insert into follow_tag (user_id, tag_id) values (63, 78);
insert into follow_tag (user_id, tag_id) values (64, 39);
insert into follow_tag (user_id, tag_id) values (64, 60);
insert into follow_tag (user_id, tag_id) values (64, 58);
insert into follow_tag (user_id, tag_id) values (64, 87);
insert into follow_tag (user_id, tag_id) values (65, 69);
insert into follow_tag (user_id, tag_id) values (66, 38);
insert into follow_tag (user_id, tag_id) values (66, 82);
insert into follow_tag (user_id, tag_id) values (66, 100);
insert into follow_tag (user_id, tag_id) values (67, 60);
insert into follow_tag (user_id, tag_id) values (67, 69);
insert into follow_tag (user_id, tag_id) values (68, 66);
insert into follow_tag (user_id, tag_id) values (68, 10);
insert into follow_tag (user_id, tag_id) values (68, 48);
insert into follow_tag (user_id, tag_id) values (69, 48);
insert into follow_tag (user_id, tag_id) values (69, 78);
insert into follow_tag (user_id, tag_id) values (70, 83);
insert into follow_tag (user_id, tag_id) values (70, 39);
insert into follow_tag (user_id, tag_id) values (71, 33);
insert into follow_tag (user_id, tag_id) values (71, 70);
insert into follow_tag (user_id, tag_id) values (72, 32);
insert into follow_tag (user_id, tag_id) values (72, 48);
insert into follow_tag (user_id, tag_id) values (72, 72);
insert into follow_tag (user_id, tag_id) values (72, 04);
insert into follow_tag (user_id, tag_id) values (73, 19);
insert into follow_tag (user_id, tag_id) values (74, 18);
insert into follow_tag (user_id, tag_id) values (74, 41);
insert into follow_tag (user_id, tag_id) values (74, 50);
insert into follow_tag (user_id, tag_id) values (74, 85);
insert into follow_tag (user_id, tag_id) values (75, 30);
insert into follow_tag (user_id, tag_id) values (76, 71);
insert into follow_tag (user_id, tag_id) values (76, 96);
insert into follow_tag (user_id, tag_id) values (76, 36);
insert into follow_tag (user_id, tag_id) values (76, 38);
insert into follow_tag (user_id, tag_id) values (76, 80);
insert into follow_tag (user_id, tag_id) values (76, 88);
insert into follow_tag (user_id, tag_id) values (77, 99);
insert into follow_tag (user_id, tag_id) values (77, 54);
insert into follow_tag (user_id, tag_id) values (77, 91);
insert into follow_tag (user_id, tag_id) values (78, 36);
insert into follow_tag (user_id, tag_id) values (78, 57);
insert into follow_tag (user_id, tag_id) values (78, 14);
insert into follow_tag (user_id, tag_id) values (78, 27);
insert into follow_tag (user_id, tag_id) values (78, 65);
insert into follow_tag (user_id, tag_id) values (79, 74);
insert into follow_tag (user_id, tag_id) values (79, 87);
insert into follow_tag (user_id, tag_id) values (80, 65);
insert into follow_tag (user_id, tag_id) values (80, 80);
insert into follow_tag (user_id, tag_id) values (81, 8);
insert into follow_tag (user_id, tag_id) values (81, 51);
insert into follow_tag (user_id, tag_id) values (81, 94);
insert into follow_tag (user_id, tag_id) values (82, 2);
insert into follow_tag (user_id, tag_id) values (82, 18);
insert into follow_tag (user_id, tag_id) values (82, 19);
insert into follow_tag (user_id, tag_id) values (82, 43);
insert into follow_tag (user_id, tag_id) values (82, 14);
insert into follow_tag (user_id, tag_id) values (83, 31);
insert into follow_tag (user_id, tag_id) values (83, 10);
insert into follow_tag (user_id, tag_id) values (83, 18);
insert into follow_tag (user_id, tag_id) values (84, 10);
insert into follow_tag (user_id, tag_id) values (84, 13);
insert into follow_tag (user_id, tag_id) values (85, 19);
insert into follow_tag (user_id, tag_id) values (85, 30);
insert into follow_tag (user_id, tag_id) values (86, 13);
insert into follow_tag (user_id, tag_id) values (86, 10);
insert into follow_tag (user_id, tag_id) values (86, 11);
insert into follow_tag (user_id, tag_id) values (86, 17);
insert into follow_tag (user_id, tag_id) values (87, 58);
insert into follow_tag (user_id, tag_id) values (87, 69);
insert into follow_tag (user_id, tag_id) values (88, 28);
insert into follow_tag (user_id, tag_id) values (88, 11);
insert into follow_tag (user_id, tag_id) values (89, 27);
insert into follow_tag (user_id, tag_id) values (89, 10);
insert into follow_tag (user_id, tag_id) values (89, 19);
insert into follow_tag (user_id, tag_id) values (90, 4);
insert into follow_tag (user_id, tag_id) values (90, 6);
insert into follow_tag (user_id, tag_id) values (90, 10);
insert into follow_tag (user_id, tag_id) values (91, 51);
insert into follow_tag (user_id, tag_id) values (91, 79);
insert into follow_tag (user_id, tag_id) values (91, 84);
insert into follow_tag (user_id, tag_id) values (91, 13);
insert into follow_tag (user_id, tag_id) values (91, 19);
insert into follow_tag (user_id, tag_id) values (92, 34);
insert into follow_tag (user_id, tag_id) values (92, 71);
insert into follow_tag (user_id, tag_id) values (92, 14);
insert into follow_tag (user_id, tag_id) values (93, 22);
insert into follow_tag (user_id, tag_id) values (93, 36);
insert into follow_tag (user_id, tag_id) values (93, 16);
insert into follow_tag (user_id, tag_id) values (94, 8);
insert into follow_tag (user_id, tag_id) values (94, 94);
insert into follow_tag (user_id, tag_id) values (95, 19);
insert into follow_tag (user_id, tag_id) values (96, 6);
insert into follow_tag (user_id, tag_id) values (96, 12);
insert into follow_tag (user_id, tag_id) values (96, 15);
insert into follow_tag (user_id, tag_id) values (97, 53);
insert into follow_tag (user_id, tag_id) values (97, 81);
insert into follow_tag (user_id, tag_id) values (98, 11);
insert into follow_tag (user_id, tag_id) values (98, 12);
insert into follow_tag (user_id, tag_id) values (98, 14);
insert into follow_tag (user_id, tag_id) values (98, 18);
insert into follow_tag (user_id, tag_id) values (99, 27);
insert into follow_tag (user_id, tag_id) values (99, 71);
insert into follow_tag (user_id, tag_id) values (100, 57);

--vote_post
insert into vote_post (user_id, post_id, "like") values (55, 53, true);
insert into vote_post (user_id, post_id, "like") values (14, 184, false);
insert into vote_post (user_id, post_id, "like") values (11, 96, false);
insert into vote_post (user_id, post_id, "like") values (31, 196, false);
insert into vote_post (user_id, post_id, "like") values (72, 171, true);
insert into vote_post (user_id, post_id, "like") values (67, 88, true);
insert into vote_post (user_id, post_id, "like") values (2, 33, false);
insert into vote_post (user_id, post_id, "like") values (64, 142, true);
insert into vote_post (user_id, post_id, "like") values (65, 100, false);
insert into vote_post (user_id, post_id, "like") values (55, 106, false);
insert into vote_post (user_id, post_id, "like") values (15, 200, true);
insert into vote_post (user_id, post_id, "like") values (3, 73, true);
insert into vote_post (user_id, post_id, "like") values (93, 47, false);
insert into vote_post (user_id, post_id, "like") values (11, 144, true);
insert into vote_post (user_id, post_id, "like") values (75, 144, false);
insert into vote_post (user_id, post_id, "like") values (28, 172, false);
insert into vote_post (user_id, post_id, "like") values (100, 55, true);
insert into vote_post (user_id, post_id, "like") values (46, 4, false);
insert into vote_post (user_id, post_id, "like") values (48, 156, false);
insert into vote_post (user_id, post_id, "like") values (72, 52, true);
insert into vote_post (user_id, post_id, "like") values (48, 47, true);
insert into vote_post (user_id, post_id, "like") values (40, 178, false);
insert into vote_post (user_id, post_id, "like") values (46, 101, false);
insert into vote_post (user_id, post_id, "like") values (51, 113, true);
insert into vote_post (user_id, post_id, "like") values (97, 20, true);
insert into vote_post (user_id, post_id, "like") values (92, 91, false);
insert into vote_post (user_id, post_id, "like") values (62, 11, true);
insert into vote_post (user_id, post_id, "like") values (56, 143, false);
insert into vote_post (user_id, post_id, "like") values (37, 183, false);
insert into vote_post (user_id, post_id, "like") values (29, 97, false);
insert into vote_post (user_id, post_id, "like") values (94, 139, false);
insert into vote_post (user_id, post_id, "like") values (70, 146, false);
insert into vote_post (user_id, post_id, "like") values (98, 121, false);
insert into vote_post (user_id, post_id, "like") values (40, 29, false);
insert into vote_post (user_id, post_id, "like") values (98, 131, false);
insert into vote_post (user_id, post_id, "like") values (30, 173, true);
insert into vote_post (user_id, post_id, "like") values (72, 105, true);
insert into vote_post (user_id, post_id, "like") values (28, 151, false);
insert into vote_post (user_id, post_id, "like") values (10, 80, true);
insert into vote_post (user_id, post_id, "like") values (38, 163, false);
insert into vote_post (user_id, post_id, "like") values (9, 65, true);
insert into vote_post (user_id, post_id, "like") values (65, 189, false);
insert into vote_post (user_id, post_id, "like") values (14, 97, true);
insert into vote_post (user_id, post_id, "like") values (43, 67, false);
insert into vote_post (user_id, post_id, "like") values (44, 187, true);
insert into vote_post (user_id, post_id, "like") values (85, 75, false);
insert into vote_post (user_id, post_id, "like") values (39, 199, true);
insert into vote_post (user_id, post_id, "like") values (34, 150, true);
insert into vote_post (user_id, post_id, "like") values (83, 77, true);
insert into vote_post (user_id, post_id, "like") values (39, 86, false);
insert into vote_post (user_id, post_id, "like") values (86, 32, false);
insert into vote_post (user_id, post_id, "like") values (67, 67, false);
insert into vote_post (user_id, post_id, "like") values (56, 181, true);
insert into vote_post (user_id, post_id, "like") values (52, 91, false);
insert into vote_post (user_id, post_id, "like") values (62, 71, true);
insert into vote_post (user_id, post_id, "like") values (77, 131, false);
insert into vote_post (user_id, post_id, "like") values (15, 172, false);
insert into vote_post (user_id, post_id, "like") values (51, 81, true);
insert into vote_post (user_id, post_id, "like") values (44, 24, false);
insert into vote_post (user_id, post_id, "like") values (22, 59, false);
insert into vote_post (user_id, post_id, "like") values (92, 84, true);
insert into vote_post (user_id, post_id, "like") values (43, 119, false);
insert into vote_post (user_id, post_id, "like") values (68, 17, true);
insert into vote_post (user_id, post_id, "like") values (100, 13, true);
insert into vote_post (user_id, post_id, "like") values (45, 18, true);
insert into vote_post (user_id, post_id, "like") values (57, 168, false);
insert into vote_post (user_id, post_id, "like") values (58, 149, true);
insert into vote_post (user_id, post_id, "like") values (94, 181, false);
insert into vote_post (user_id, post_id, "like") values (72, 76, true);
insert into vote_post (user_id, post_id, "like") values (64, 20, true);
insert into vote_post (user_id, post_id, "like") values (40, 19, false);
insert into vote_post (user_id, post_id, "like") values (54, 116, true);
insert into vote_post (user_id, post_id, "like") values (14, 94, true);
insert into vote_post (user_id, post_id, "like") values (5, 68, true);
insert into vote_post (user_id, post_id, "like") values (100, 196, false);
insert into vote_post (user_id, post_id, "like") values (93, 66, false);
insert into vote_post (user_id, post_id, "like") values (42, 123, false);
insert into vote_post (user_id, post_id, "like") values (40, 49, false);
insert into vote_post (user_id, post_id, "like") values (66, 99, false);
insert into vote_post (user_id, post_id, "like") values (93, 21, false);
insert into vote_post (user_id, post_id, "like") values (95, 102, false);
insert into vote_post (user_id, post_id, "like") values (40, 126, false);
insert into vote_post (user_id, post_id, "like") values (10, 59, true);
insert into vote_post (user_id, post_id, "like") values (91, 13, false);
insert into vote_post (user_id, post_id, "like") values (12, 173, false);
insert into vote_post (user_id, post_id, "like") values (86, 168, false);
insert into vote_post (user_id, post_id, "like") values (35, 141, false);
insert into vote_post (user_id, post_id, "like") values (46, 147, false);
insert into vote_post (user_id, post_id, "like") values (6, 17, true);
insert into vote_post (user_id, post_id, "like") values (59, 182, false);
insert into vote_post (user_id, post_id, "like") values (91, 5, false);
insert into vote_post (user_id, post_id, "like") values (68, 145, false);
insert into vote_post (user_id, post_id, "like") values (91, 18, true);
insert into vote_post (user_id, post_id, "like") values (4, 35, false);
insert into vote_post (user_id, post_id, "like") values (8, 152, false);
insert into vote_post (user_id, post_id, "like") values (65, 91, true);
insert into vote_post (user_id, post_id, "like") values (71, 64, true);
insert into vote_post (user_id, post_id, "like") values (25, 168, false);
insert into vote_post (user_id, post_id, "like") values (95, 30, false);
insert into vote_post (user_id, post_id, "like") values (94, 194, false);
insert into vote_post (user_id, post_id, "like") values (85, 30, false);
insert into vote_post (user_id, post_id, "like") values (2, 42, true);
insert into vote_post (user_id, post_id, "like") values (90, 97, true);
insert into vote_post (user_id, post_id, "like") values (93, 154, false);
insert into vote_post (user_id, post_id, "like") values (59, 76, false);
insert into vote_post (user_id, post_id, "like") values (45, 35, true);
insert into vote_post (user_id, post_id, "like") values (3, 77, true);
insert into vote_post (user_id, post_id, "like") values (96, 50, true);
insert into vote_post (user_id, post_id, "like") values (89, 170, true);
insert into vote_post (user_id, post_id, "like") values (21, 38, true);
insert into vote_post (user_id, post_id, "like") values (6, 109, true);
insert into vote_post (user_id, post_id, "like") values (92, 149, true);
insert into vote_post (user_id, post_id, "like") values (18, 48, false);
insert into vote_post (user_id, post_id, "like") values (70, 56, false);
insert into vote_post (user_id, post_id, "like") values (19, 199, false);
insert into vote_post (user_id, post_id, "like") values (10, 108, false);
insert into vote_post (user_id, post_id, "like") values (29, 15, true);
insert into vote_post (user_id, post_id, "like") values (54, 87, false);
insert into vote_post (user_id, post_id, "like") values (56, 58, true);
insert into vote_post (user_id, post_id, "like") values (76, 156, false);
insert into vote_post (user_id, post_id, "like") values (18, 30, true);
insert into vote_post (user_id, post_id, "like") values (60, 182, true);
insert into vote_post (user_id, post_id, "like") values (65, 56, true);
insert into vote_post (user_id, post_id, "like") values (81, 83, true);
insert into vote_post (user_id, post_id, "like") values (83, 3, true);
insert into vote_post (user_id, post_id, "like") values (17, 176, false);
insert into vote_post (user_id, post_id, "like") values (15, 7, true);
insert into vote_post (user_id, post_id, "like") values (89, 116, true);
insert into vote_post (user_id, post_id, "like") values (39, 51, false);
insert into vote_post (user_id, post_id, "like") values (36, 72, true);
insert into vote_post (user_id, post_id, "like") values (45, 49, false);
insert into vote_post (user_id, post_id, "like") values (30, 177, true);
insert into vote_post (user_id, post_id, "like") values (24, 181, true);
insert into vote_post (user_id, post_id, "like") values (75, 17, false);
insert into vote_post (user_id, post_id, "like") values (19, 116, true);
insert into vote_post (user_id, post_id, "like") values (27, 163, false);
insert into vote_post (user_id, post_id, "like") values (72, 157, true);
insert into vote_post (user_id, post_id, "like") values (98, 26, true);
insert into vote_post (user_id, post_id, "like") values (23, 51, true);
insert into vote_post (user_id, post_id, "like") values (27, 107, false);
insert into vote_post (user_id, post_id, "like") values (8, 61, false);
insert into vote_post (user_id, post_id, "like") values (31, 123, true);
insert into vote_post (user_id, post_id, "like") values (42, 14, false);
insert into vote_post (user_id, post_id, "like") values (53, 2, true);
insert into vote_post (user_id, post_id, "like") values (39, 148, true);
insert into vote_post (user_id, post_id, "like") values (96, 15, true);
insert into vote_post (user_id, post_id, "like") values (53, 173, true);
insert into vote_post (user_id, post_id, "like") values (79, 110, false);
insert into vote_post (user_id, post_id, "like") values (17, 177, false);
insert into vote_post (user_id, post_id, "like") values (72, 185, false);
insert into vote_post (user_id, post_id, "like") values (72, 22, true);
insert into vote_post (user_id, post_id, "like") values (35, 181, true);
insert into vote_post (user_id, post_id, "like") values (13, 45, false);
insert into vote_post (user_id, post_id, "like") values (55, 173, true);
insert into vote_post (user_id, post_id, "like") values (67, 146, false);
insert into vote_post (user_id, post_id, "like") values (10, 49, true);
insert into vote_post (user_id, post_id, "like") values (95, 148, true);
insert into vote_post (user_id, post_id, "like") values (5, 167, true);
insert into vote_post (user_id, post_id, "like") values (43, 135, true);
insert into vote_post (user_id, post_id, "like") values (82, 83, true);
insert into vote_post (user_id, post_id, "like") values (68, 57, true);
insert into vote_post (user_id, post_id, "like") values (25, 164, true);
insert into vote_post (user_id, post_id, "like") values (93, 94, true);
insert into vote_post (user_id, post_id, "like") values (29, 166, false);
insert into vote_post (user_id, post_id, "like") values (24, 6, false);
insert into vote_post (user_id, post_id, "like") values (97, 141, false);
insert into vote_post (user_id, post_id, "like") values (36, 120, true);
insert into vote_post (user_id, post_id, "like") values (13, 39, false);
insert into vote_post (user_id, post_id, "like") values (79, 125, true);
insert into vote_post (user_id, post_id, "like") values (29, 111, true);
insert into vote_post (user_id, post_id, "like") values (75, 179, true);
insert into vote_post (user_id, post_id, "like") values (54, 126, true);
insert into vote_post (user_id, post_id, "like") values (35, 155, true);
insert into vote_post (user_id, post_id, "like") values (19, 64, true);
insert into vote_post (user_id, post_id, "like") values (98, 158, false);
insert into vote_post (user_id, post_id, "like") values (100, 114, false);
insert into vote_post (user_id, post_id, "like") values (80, 41, false);
insert into vote_post (user_id, post_id, "like") values (67, 1, true);
insert into vote_post (user_id, post_id, "like") values (75, 40, false);
insert into vote_post (user_id, post_id, "like") values (45, 91, true);
insert into vote_post (user_id, post_id, "like") values (72, 64, true);
insert into vote_post (user_id, post_id, "like") values (81, 151, false);
insert into vote_post (user_id, post_id, "like") values (75, 152, true);
insert into vote_post (user_id, post_id, "like") values (73, 82, true);
insert into vote_post (user_id, post_id, "like") values (25, 162, true);
insert into vote_post (user_id, post_id, "like") values (36, 14, true);
insert into vote_post (user_id, post_id, "like") values (17, 61, false);
insert into vote_post (user_id, post_id, "like") values (38, 63, true);
insert into vote_post (user_id, post_id, "like") values (29, 129, true);
insert into vote_post (user_id, post_id, "like") values (56, 161, true);
insert into vote_post (user_id, post_id, "like") values (90, 197, false);
insert into vote_post (user_id, post_id, "like") values (63, 153, true);
insert into vote_post (user_id, post_id, "like") values (77, 54, false);
insert into vote_post (user_id, post_id, "like") values (31, 44, false);
insert into vote_post (user_id, post_id, "like") values (52, 67, false);
insert into vote_post (user_id, post_id, "like") values (58, 120, false);
insert into vote_post (user_id, post_id, "like") values (82, 166, false);
insert into vote_post (user_id, post_id, "like") values (93, 128, false);
insert into vote_post (user_id, post_id, "like") values (40, 52, false);
insert into vote_post (user_id, post_id, "like") values (47, 146, false);
insert into vote_post (user_id, post_id, "like") values (34, 81, false);
insert into vote_post (user_id, post_id, "like") values (1, 118, false);
insert into vote_post (user_id, post_id, "like") values (19, 187, false);
insert into vote_post (user_id, post_id, "like") values (88, 195, true);
insert into vote_post (user_id, post_id, "like") values (74, 4, true);
insert into vote_post (user_id, post_id, "like") values (93, 95, false);
insert into vote_post (user_id, post_id, "like") values (77, 179, false);
insert into vote_post (user_id, post_id, "like") values (48, 165, false);
insert into vote_post (user_id, post_id, "like") values (85, 151, false);
insert into vote_post (user_id, post_id, "like") values (82, 167, false);
insert into vote_post (user_id, post_id, "like") values (1, 109, true);
insert into vote_post (user_id, post_id, "like") values (26, 98, false);
insert into vote_post (user_id, post_id, "like") values (16, 146, true);
insert into vote_post (user_id, post_id, "like") values (3, 146, false);
insert into vote_post (user_id, post_id, "like") values (10, 56, false);
insert into vote_post (user_id, post_id, "like") values (54, 141, true);
insert into vote_post (user_id, post_id, "like") values (64, 166, true);
insert into vote_post (user_id, post_id, "like") values (38, 12, true);
insert into vote_post (user_id, post_id, "like") values (65, 168, true);
insert into vote_post (user_id, post_id, "like") values (77, 96, false);
insert into vote_post (user_id, post_id, "like") values (76, 17, true);
insert into vote_post (user_id, post_id, "like") values (87, 95, false);
insert into vote_post (user_id, post_id, "like") values (74, 2, false);
insert into vote_post (user_id, post_id, "like") values (41, 105, true);
insert into vote_post (user_id, post_id, "like") values (24, 17, false);
insert into vote_post (user_id, post_id, "like") values (94, 145, true);
insert into vote_post (user_id, post_id, "like") values (53, 47, true);
insert into vote_post (user_id, post_id, "like") values (13, 181, false);
insert into vote_post (user_id, post_id, "like") values (6, 147, true);
insert into vote_post (user_id, post_id, "like") values (6, 172, false);
insert into vote_post (user_id, post_id, "like") values (41, 167, true);
insert into vote_post (user_id, post_id, "like") values (5, 127, false);
insert into vote_post (user_id, post_id, "like") values (23, 125, false);
insert into vote_post (user_id, post_id, "like") values (100, 192, false);
insert into vote_post (user_id, post_id, "like") values (94, 198, false);
insert into vote_post (user_id, post_id, "like") values (94, 148, true);
insert into vote_post (user_id, post_id, "like") values (34, 48, true);
insert into vote_post (user_id, post_id, "like") values (52, 133, false);
insert into vote_post (user_id, post_id, "like") values (81, 33, false);
insert into vote_post (user_id, post_id, "like") values (95, 21, true);
insert into vote_post (user_id, post_id, "like") values (21, 42, true);
insert into vote_post (user_id, post_id, "like") values (38, 134, false);
insert into vote_post (user_id, post_id, "like") values (67, 39, false);
insert into vote_post (user_id, post_id, "like") values (16, 111, false);
insert into vote_post (user_id, post_id, "like") values (82, 10, true);
insert into vote_post (user_id, post_id, "like") values (2, 27, false);
insert into vote_post (user_id, post_id, "like") values (59, 177, false);
insert into vote_post (user_id, post_id, "like") values (63, 20, true);
insert into vote_post (user_id, post_id, "like") values (53, 184, false);
insert into vote_post (user_id, post_id, "like") values (33, 24, false);
insert into vote_post (user_id, post_id, "like") values (54, 7, true);
insert into vote_post (user_id, post_id, "like") values (58, 197, false);
insert into vote_post (user_id, post_id, "like") values (60, 92, true);
insert into vote_post (user_id, post_id, "like") values (10, 191, false);
insert into vote_post (user_id, post_id, "like") values (100, 66, false);
insert into vote_post (user_id, post_id, "like") values (94, 158, false);
insert into vote_post (user_id, post_id, "like") values (40, 177, false);
insert into vote_post (user_id, post_id, "like") values (99, 75, false);
insert into vote_post (user_id, post_id, "like") values (86, 59, true);
insert into vote_post (user_id, post_id, "like") values (59, 154, false);
insert into vote_post (user_id, post_id, "like") values (35, 125, false);
insert into vote_post (user_id, post_id, "like") values (70, 187, false);
insert into vote_post (user_id, post_id, "like") values (13, 132, false);
insert into vote_post (user_id, post_id, "like") values (33, 178, false);
insert into vote_post (user_id, post_id, "like") values (79, 43, true);
insert into vote_post (user_id, post_id, "like") values (100, 161, false);
insert into vote_post (user_id, post_id, "like") values (92, 154, true);
insert into vote_post (user_id, post_id, "like") values (31, 162, false);
insert into vote_post (user_id, post_id, "like") values (63, 168, true);
insert into vote_post (user_id, post_id, "like") values (37, 193, false);
insert into vote_post (user_id, post_id, "like") values (6, 15, true);
insert into vote_post (user_id, post_id, "like") values (4, 89, false);
insert into vote_post (user_id, post_id, "like") values (7, 111, false);
insert into vote_post (user_id, post_id, "like") values (9, 196, true);
insert into vote_post (user_id, post_id, "like") values (9, 78, false);
insert into vote_post (user_id, post_id, "like") values (64, 91, true);
insert into vote_post (user_id, post_id, "like") values (62, 188, true);
insert into vote_post (user_id, post_id, "like") values (78, 45, true);
insert into vote_post (user_id, post_id, "like") values (65, 193, true);
insert into vote_post (user_id, post_id, "like") values (73, 199, true);
insert into vote_post (user_id, post_id, "like") values (41, 59, false);
insert into vote_post (user_id, post_id, "like") values (67, 151, false);
insert into vote_post (user_id, post_id, "like") values (53, 34, true);
insert into vote_post (user_id, post_id, "like") values (6, 40, true);
insert into vote_post (user_id, post_id, "like") values (41, 81, false);
insert into vote_post (user_id, post_id, "like") values (31, 12, false);
insert into vote_post (user_id, post_id, "like") values (24, 115, false);
insert into vote_post (user_id, post_id, "like") values (3, 71, true);
insert into vote_post (user_id, post_id, "like") values (18, 114, true);
insert into vote_post (user_id, post_id, "like") values (8, 35, true);
insert into vote_post (user_id, post_id, "like") values (98, 145, true);
insert into vote_post (user_id, post_id, "like") values (46, 1, true);
insert into vote_post (user_id, post_id, "like") values (95, 85, true);
insert into vote_post (user_id, post_id, "like") values (8, 182, true);
insert into vote_post (user_id, post_id, "like") values (74, 114, false);
insert into vote_post (user_id, post_id, "like") values (97, 146, true);
insert into vote_post (user_id, post_id, "like") values (66, 138, false);
insert into vote_post (user_id, post_id, "like") values (9, 21, false);
insert into vote_post (user_id, post_id, "like") values (18, 7, true);
insert into vote_post (user_id, post_id, "like") values (50, 139, true);
insert into vote_post (user_id, post_id, "like") values (85, 105, false);
insert into vote_post (user_id, post_id, "like") values (57, 16, true);
insert into vote_post (user_id, post_id, "like") values (47, 189, true);
insert into vote_post (user_id, post_id, "like") values (4, 83, false);
insert into vote_post (user_id, post_id, "like") values (30, 31, true);
insert into vote_post (user_id, post_id, "like") values (27, 141, true);
insert into vote_post (user_id, post_id, "like") values (27, 10, true);
insert into vote_post (user_id, post_id, "like") values (95, 150, false);
insert into vote_post (user_id, post_id, "like") values (77, 139, true);
insert into vote_post (user_id, post_id, "like") values (14, 68, true);
insert into vote_post (user_id, post_id, "like") values (42, 79, true);
insert into vote_post (user_id, post_id, "like") values (28, 121, false);
insert into vote_post (user_id, post_id, "like") values (98, 134, true);
insert into vote_post (user_id, post_id, "like") values (99, 74, true);
insert into vote_post (user_id, post_id, "like") values (35, 93, false);
insert into vote_post (user_id, post_id, "like") values (44, 68, true);
insert into vote_post (user_id, post_id, "like") values (62, 109, false);
insert into vote_post (user_id, post_id, "like") values (86, 89, true);
insert into vote_post (user_id, post_id, "like") values (41, 28, true);
insert into vote_post (user_id, post_id, "like") values (74, 60, false);
insert into vote_post (user_id, post_id, "like") values (69, 67, false);
insert into vote_post (user_id, post_id, "like") values (5, 36, true);
insert into vote_post (user_id, post_id, "like") values (17, 85, true);
insert into vote_post (user_id, post_id, "like") values (30, 82, true);
insert into vote_post (user_id, post_id, "like") values (99, 29, false);
insert into vote_post (user_id, post_id, "like") values (55, 94, true);
insert into vote_post (user_id, post_id, "like") values (24, 155, true);
insert into vote_post (user_id, post_id, "like") values (2, 181, true);
insert into vote_post (user_id, post_id, "like") values (68, 156, true);
insert into vote_post (user_id, post_id, "like") values (33, 31, true);
insert into vote_post (user_id, post_id, "like") values (62, 88, true);
insert into vote_post (user_id, post_id, "like") values (21, 192, false);
insert into vote_post (user_id, post_id, "like") values (92, 32, false);
insert into vote_post (user_id, post_id, "like") values (53, 162, true);
insert into vote_post (user_id, post_id, "like") values (17, 171, false);
insert into vote_post (user_id, post_id, "like") values (34, 115, true);
insert into vote_post (user_id, post_id, "like") values (68, 196, true);
insert into vote_post (user_id, post_id, "like") values (62, 142, false);
insert into vote_post (user_id, post_id, "like") values (80, 98, false);
insert into vote_post (user_id, post_id, "like") values (13, 66, true);
insert into vote_post (user_id, post_id, "like") values (33, 22, false);
insert into vote_post (user_id, post_id, "like") values (96, 13, false);
insert into vote_post (user_id, post_id, "like") values (84, 4, true);
insert into vote_post (user_id, post_id, "like") values (63, 134, true);
insert into vote_post (user_id, post_id, "like") values (71, 2, true);
insert into vote_post (user_id, post_id, "like") values (98, 123, true);
insert into vote_post (user_id, post_id, "like") values (89, 6, true);
insert into vote_post (user_id, post_id, "like") values (39, 127, false);
insert into vote_post (user_id, post_id, "like") values (84, 64, false);
insert into vote_post (user_id, post_id, "like") values (74, 33, false);
insert into vote_post (user_id, post_id, "like") values (14, 16, false);
insert into vote_post (user_id, post_id, "like") values (27, 153, true);
insert into vote_post (user_id, post_id, "like") values (49, 138, true);
insert into vote_post (user_id, post_id, "like") values (31, 56, true);
insert into vote_post (user_id, post_id, "like") values (18, 156, false);
insert into vote_post (user_id, post_id, "like") values (19, 88, true);
insert into vote_post (user_id, post_id, "like") values (97, 168, false);
insert into vote_post (user_id, post_id, "like") values (85, 32, false);
insert into vote_post (user_id, post_id, "like") values (61, 66, true);
insert into vote_post (user_id, post_id, "like") values (84, 190, false);
insert into vote_post (user_id, post_id, "like") values (19, 125, true);
insert into vote_post (user_id, post_id, "like") values (17, 126, true);
insert into vote_post (user_id, post_id, "like") values (69, 96, false);
insert into vote_post (user_id, post_id, "like") values (68, 42, false);
insert into vote_post (user_id, post_id, "like") values (97, 158, false);
insert into vote_post (user_id, post_id, "like") values (89, 82, true);
insert into vote_post (user_id, post_id, "like") values (33, 150, true);
insert into vote_post (user_id, post_id, "like") values (2, 116, false);
insert into vote_post (user_id, post_id, "like") values (44, 41, false);
insert into vote_post (user_id, post_id, "like") values (76, 10, true);
insert into vote_post (user_id, post_id, "like") values (88, 198, true);
insert into vote_post (user_id, post_id, "like") values (56, 126, false);
insert into vote_post (user_id, post_id, "like") values (32, 21, true);
insert into vote_post (user_id, post_id, "like") values (37, 120, false);
insert into vote_post (user_id, post_id, "like") values (50, 3, false);
insert into vote_post (user_id, post_id, "like") values (19, 117, true);
insert into vote_post (user_id, post_id, "like") values (12, 67, false);
insert into vote_post (user_id, post_id, "like") values (48, 103, true);
insert into vote_post (user_id, post_id, "like") values (75, 13, false);
insert into vote_post (user_id, post_id, "like") values (63, 6, true);
insert into vote_post (user_id, post_id, "like") values (23, 56, true);
insert into vote_post (user_id, post_id, "like") values (47, 145, false);
insert into vote_post (user_id, post_id, "like") values (28, 39, true);
insert into vote_post (user_id, post_id, "like") values (59, 23, false);
insert into vote_post (user_id, post_id, "like") values (60, 156, true);
insert into vote_post (user_id, post_id, "like") values (93, 17, true);
insert into vote_post (user_id, post_id, "like") values (48, 36, true);
insert into vote_post (user_id, post_id, "like") values (35, 194, false);
insert into vote_post (user_id, post_id, "like") values (39, 82, false);
insert into vote_post (user_id, post_id, "like") values (79, 117, true);
insert into vote_post (user_id, post_id, "like") values (57, 19, true);
insert into vote_post (user_id, post_id, "like") values (28, 68, false);
insert into vote_post (user_id, post_id, "like") values (59, 87, true);
insert into vote_post (user_id, post_id, "like") values (84, 67, true);
insert into vote_post (user_id, post_id, "like") values (59, 176, true);
insert into vote_post (user_id, post_id, "like") values (24, 92, true);
insert into vote_post (user_id, post_id, "like") values (12, 184, false);
insert into vote_post (user_id, post_id, "like") values (27, 174, true);
insert into vote_post (user_id, post_id, "like") values (58, 55, true);
insert into vote_post (user_id, post_id, "like") values (50, 31, true);
insert into vote_post (user_id, post_id, "like") values (74, 102, true);
insert into vote_post (user_id, post_id, "like") values (12, 195, true);
insert into vote_post (user_id, post_id, "like") values (30, 52, true);
insert into vote_post (user_id, post_id, "like") values (17, 11, true);
insert into vote_post (user_id, post_id, "like") values (38, 192, true);
insert into vote_post (user_id, post_id, "like") values (18, 181, true);
insert into vote_post (user_id, post_id, "like") values (64, 10, false);
insert into vote_post (user_id, post_id, "like") values (35, 152, true);
insert into vote_post (user_id, post_id, "like") values (1, 53, false);
insert into vote_post (user_id, post_id, "like") values (92, 30, false);
insert into vote_post (user_id, post_id, "like") values (98, 118, false);
insert into vote_post (user_id, post_id, "like") values (2, 67, false);
insert into vote_post (user_id, post_id, "like") values (73, 132, true);
insert into vote_post (user_id, post_id, "like") values (65, 152, true);
insert into vote_post (user_id, post_id, "like") values (33, 14, true);
insert into vote_post (user_id, post_id, "like") values (50, 185, false);
insert into vote_post (user_id, post_id, "like") values (79, 64, true);
insert into vote_post (user_id, post_id, "like") values (83, 126, false);
insert into vote_post (user_id, post_id, "like") values (50, 67, true);
insert into vote_post (user_id, post_id, "like") values (30, 159, false);
insert into vote_post (user_id, post_id, "like") values (37, 10, true);
insert into vote_post (user_id, post_id, "like") values (64, 63, false);
insert into vote_post (user_id, post_id, "like") values (100, 83, false);
insert into vote_post (user_id, post_id, "like") values (69, 14, false);
insert into vote_post (user_id, post_id, "like") values (40, 170, false);
insert into vote_post (user_id, post_id, "like") values (70, 132, false);
insert into vote_post (user_id, post_id, "like") values (89, 4, true);
insert into vote_post (user_id, post_id, "like") values (78, 116, true);
insert into vote_post (user_id, post_id, "like") values (13, 112, false);
insert into vote_post (user_id, post_id, "like") values (14, 141, true);
insert into vote_post (user_id, post_id, "like") values (24, 143, false);
insert into vote_post (user_id, post_id, "like") values (36, 159, true);
insert into vote_post (user_id, post_id, "like") values (99, 81, false);
insert into vote_post (user_id, post_id, "like") values (80, 64, true);
insert into vote_post (user_id, post_id, "like") values (54, 10, true);
insert into vote_post (user_id, post_id, "like") values (94, 163, false);
insert into vote_post (user_id, post_id, "like") values (65, 182, false);
insert into vote_post (user_id, post_id, "like") values (42, 81, true);
insert into vote_post (user_id, post_id, "like") values (25, 199, false);
insert into vote_post (user_id, post_id, "like") values (40, 151, false);
insert into vote_post (user_id, post_id, "like") values (77, 132, true);
insert into vote_post (user_id, post_id, "like") values (51, 99, false);
insert into vote_post (user_id, post_id, "like") values (13, 179, false);
insert into vote_post (user_id, post_id, "like") values (69, 140, true);
insert into vote_post (user_id, post_id, "like") values (53, 69, false);
insert into vote_post (user_id, post_id, "like") values (63, 66, true);
insert into vote_post (user_id, post_id, "like") values (2, 35, false);
insert into vote_post (user_id, post_id, "like") values (90, 78, false);
insert into vote_post (user_id, post_id, "like") values (42, 105, false);
insert into vote_post (user_id, post_id, "like") values (100, 120, true);
insert into vote_post (user_id, post_id, "like") values (94, 23, false);
insert into vote_post (user_id, post_id, "like") values (34, 90, true);
insert into vote_post (user_id, post_id, "like") values (75, 171, false);
insert into vote_post (user_id, post_id, "like") values (89, 91, false);
insert into vote_post (user_id, post_id, "like") values (4, 32, false);
insert into vote_post (user_id, post_id, "like") values (66, 34, false);
insert into vote_post (user_id, post_id, "like") values (31, 53, true);
insert into vote_post (user_id, post_id, "like") values (3, 59, true);
insert into vote_post (user_id, post_id, "like") values (30, 128, true);
insert into vote_post (user_id, post_id, "like") values (74, 130, false);
insert into vote_post (user_id, post_id, "like") values (72, 194, true);
insert into vote_post (user_id, post_id, "like") values (54, 153, true);
insert into vote_post (user_id, post_id, "like") values (25, 16, false);
insert into vote_post (user_id, post_id, "like") values (67, 66, true);
insert into vote_post (user_id, post_id, "like") values (73, 176, true);
insert into vote_post (user_id, post_id, "like") values (99, 103, true);
insert into vote_post (user_id, post_id, "like") values (42, 121, true);
insert into vote_post (user_id, post_id, "like") values (93, 9, false);
insert into vote_post (user_id, post_id, "like") values (76, 121, false);
insert into vote_post (user_id, post_id, "like") values (62, 113, true);
insert into vote_post (user_id, post_id, "like") values (5, 143, false);
insert into vote_post (user_id, post_id, "like") values (71, 4, true);
insert into vote_post (user_id, post_id, "like") values (23, 7, true);
insert into vote_post (user_id, post_id, "like") values (47, 151, true);
insert into vote_post (user_id, post_id, "like") values (6, 159, true);
insert into vote_post (user_id, post_id, "like") values (8, 113, false);
insert into vote_post (user_id, post_id, "like") values (18, 16, false);
insert into vote_post (user_id, post_id, "like") values (51, 17, false);
insert into vote_post (user_id, post_id, "like") values (49, 107, true);
insert into vote_post (user_id, post_id, "like") values (67, 148, false);
insert into vote_post (user_id, post_id, "like") values (6, 83, false);
insert into vote_post (user_id, post_id, "like") values (84, 89, true);
insert into vote_post (user_id, post_id, "like") values (81, 46, false);
insert into vote_post (user_id, post_id, "like") values (78, 26, false);
insert into vote_post (user_id, post_id, "like") values (9, 122, false);
insert into vote_post (user_id, post_id, "like") values (64, 129, false);
insert into vote_post (user_id, post_id, "like") values (44, 192, true);
insert into vote_post (user_id, post_id, "like") values (37, 90, true);
insert into vote_post (user_id, post_id, "like") values (82, 104, true);
insert into vote_post (user_id, post_id, "like") values (97, 58, false);
insert into vote_post (user_id, post_id, "like") values (21, 142, false);
insert into vote_post (user_id, post_id, "like") values (48, 137, true);
insert into vote_post (user_id, post_id, "like") values (85, 148, true);
insert into vote_post (user_id, post_id, "like") values (86, 169, true);
insert into vote_post (user_id, post_id, "like") values (4, 185, false);
insert into vote_post (user_id, post_id, "like") values (74, 72, false);
insert into vote_post (user_id, post_id, "like") values (71, 72, true);
insert into vote_post (user_id, post_id, "like") values (95, 75, true);
insert into vote_post (user_id, post_id, "like") values (6, 149, true);
insert into vote_post (user_id, post_id, "like") values (21, 18, true);
insert into vote_post (user_id, post_id, "like") values (26, 187, true);
insert into vote_post (user_id, post_id, "like") values (5, 155, false);
insert into vote_post (user_id, post_id, "like") values (62, 195, true);
insert into vote_post (user_id, post_id, "like") values (30, 176, false);
insert into vote_post (user_id, post_id, "like") values (21, 35, false);
insert into vote_post (user_id, post_id, "like") values (80, 128, false);
insert into vote_post (user_id, post_id, "like") values (31, 150, true);
insert into vote_post (user_id, post_id, "like") values (94, 39, true);
insert into vote_post (user_id, post_id, "like") values (76, 83, true);
insert into vote_post (user_id, post_id, "like") values (11, 26, false);
insert into vote_post (user_id, post_id, "like") values (39, 189, true);
insert into vote_post (user_id, post_id, "like") values (39, 192, false);
insert into vote_post (user_id, post_id, "like") values (36, 182, false);
insert into vote_post (user_id, post_id, "like") values (100, 54, false);
insert into vote_post (user_id, post_id, "like") values (73, 16, true);
insert into vote_post (user_id, post_id, "like") values (53, 163, true);
insert into vote_post (user_id, post_id, "like") values (36, 162, true);
insert into vote_post (user_id, post_id, "like") values (10, 147, true);
insert into vote_post (user_id, post_id, "like") values (46, 78, true);
insert into vote_post (user_id, post_id, "like") values (45, 5, false);
insert into vote_post (user_id, post_id, "like") values (5, 123, true);
insert into vote_post (user_id, post_id, "like") values (64, 100, true);
insert into vote_post (user_id, post_id, "like") values (3, 143, false);
insert into vote_post (user_id, post_id, "like") values (62, 155, true);
insert into vote_post (user_id, post_id, "like") values (34, 128, true);
insert into vote_post (user_id, post_id, "like") values (92, 152, false);
insert into vote_post (user_id, post_id, "like") values (39, 162, false);
insert into vote_post (user_id, post_id, "like") values (2, 165, true);
insert into vote_post (user_id, post_id, "like") values (6, 74, false);
insert into vote_post (user_id, post_id, "like") values (65, 142, true);
insert into vote_post (user_id, post_id, "like") values (57, 15, true);
insert into vote_post (user_id, post_id, "like") values (47, 188, false);
insert into vote_post (user_id, post_id, "like") values (25, 22, false);
insert into vote_post (user_id, post_id, "like") values (3, 192, true);
insert into vote_post (user_id, post_id, "like") values (77, 183, true);
insert into vote_post (user_id, post_id, "like") values (7, 26, false);
insert into vote_post (user_id, post_id, "like") values (45, 197, true);
insert into vote_post (user_id, post_id, "like") values (14, 77, false);
insert into vote_post (user_id, post_id, "like") values (89, 196, true);
insert into vote_post (user_id, post_id, "like") values (66, 120, false);
insert into vote_post (user_id, post_id, "like") values (54, 186, false);
insert into vote_post (user_id, post_id, "like") values (23, 6, true);
insert into vote_post (user_id, post_id, "like") values (76, 130, false);
insert into vote_post (user_id, post_id, "like") values (46, 3, false);
insert into vote_post (user_id, post_id, "like") values (70, 143, true);
insert into vote_post (user_id, post_id, "like") values (92, 137, true);
insert into vote_post (user_id, post_id, "like") values (24, 65, false);
insert into vote_post (user_id, post_id, "like") values (26, 16, true);
insert into vote_post (user_id, post_id, "like") values (55, 23, true);
insert into vote_post (user_id, post_id, "like") values (4, 33, true);
insert into vote_post (user_id, post_id, "like") values (28, 71, true);
insert into vote_post (user_id, post_id, "like") values (35, 169, true);
insert into vote_post (user_id, post_id, "like") values (59, 75, true);
insert into vote_post (user_id, post_id, "like") values (33, 128, true);
insert into vote_post (user_id, post_id, "like") values (65, 85, false);
insert into vote_post (user_id, post_id, "like") values (39, 111, true);
insert into vote_post (user_id, post_id, "like") values (19, 4, true);
insert into vote_post (user_id, post_id, "like") values (68, 61, true);
insert into vote_post (user_id, post_id, "like") values (88, 149, true);
insert into vote_post (user_id, post_id, "like") values (2, 128, true);
insert into vote_post (user_id, post_id, "like") values (35, 191, false);
insert into vote_post (user_id, post_id, "like") values (32, 124, false);
insert into vote_post (user_id, post_id, "like") values (88, 84, true);
insert into vote_post (user_id, post_id, "like") values (1, 134, true);
insert into vote_post (user_id, post_id, "like") values (49, 3, false);
insert into vote_post (user_id, post_id, "like") values (4, 125, false);
insert into vote_post (user_id, post_id, "like") values (72, 156, true);
insert into vote_post (user_id, post_id, "like") values (60, 70, true);
insert into vote_post (user_id, post_id, "like") values (37, 174, true);
insert into vote_post (user_id, post_id, "like") values (72, 130, false);
insert into vote_post (user_id, post_id, "like") values (63, 110, true);
insert into vote_post (user_id, post_id, "like") values (92, 140, false);
insert into vote_post (user_id, post_id, "like") values (89, 194, true);
insert into vote_post (user_id, post_id, "like") values (58, 111, false);
insert into vote_post (user_id, post_id, "like") values (30, 194, false);
insert into vote_post (user_id, post_id, "like") values (94, 52, true);
insert into vote_post (user_id, post_id, "like") values (30, 196, true);
insert into vote_post (user_id, post_id, "like") values (78, 133, false);
insert into vote_post (user_id, post_id, "like") values (80, 45, false);
insert into vote_post (user_id, post_id, "like") values (11, 155, false);
insert into vote_post (user_id, post_id, "like") values (82, 152, true);
insert into vote_post (user_id, post_id, "like") values (32, 8, false);
insert into vote_post (user_id, post_id, "like") values (63, 141, true);
insert into vote_post (user_id, post_id, "like") values (7, 170, true);
insert into vote_post (user_id, post_id, "like") values (94, 90, false);
insert into vote_post (user_id, post_id, "like") values (72, 119, false);
insert into vote_post (user_id, post_id, "like") values (52, 159, true);
insert into vote_post (user_id, post_id, "like") values (88, 73, true);
insert into vote_post (user_id, post_id, "like") values (27, 82, false);
insert into vote_post (user_id, post_id, "like") values (36, 142, false);
insert into vote_post (user_id, post_id, "like") values (19, 54, false);
insert into vote_post (user_id, post_id, "like") values (34, 36, false);
insert into vote_post (user_id, post_id, "like") values (71, 146, false);
insert into vote_post (user_id, post_id, "like") values (77, 63, true);
insert into vote_post (user_id, post_id, "like") values (72, 24, false);
insert into vote_post (user_id, post_id, "like") values (23, 73, true);
insert into vote_post (user_id, post_id, "like") values (64, 113, false);
insert into vote_post (user_id, post_id, "like") values (72, 167, false);
insert into vote_post (user_id, post_id, "like") values (17, 37, false);
insert into vote_post (user_id, post_id, "like") values (30, 157, false);
insert into vote_post (user_id, post_id, "like") values (24, 169, false);
insert into vote_post (user_id, post_id, "like") values (44, 63, false);
insert into vote_post (user_id, post_id, "like") values (33, 123, true);
insert into vote_post (user_id, post_id, "like") values (56, 63, true);
insert into vote_post (user_id, post_id, "like") values (27, 109, true);
insert into vote_post (user_id, post_id, "like") values (86, 164, true);
insert into vote_post (user_id, post_id, "like") values (86, 176, true);
insert into vote_post (user_id, post_id, "like") values (72, 152, false);
insert into vote_post (user_id, post_id, "like") values (90, 33, false);
insert into vote_post (user_id, post_id, "like") values (71, 88, true);
insert into vote_post (user_id, post_id, "like") values (59, 135, true);
insert into vote_post (user_id, post_id, "like") values (18, 90, false);
insert into vote_post (user_id, post_id, "like") values (79, 54, true);
insert into vote_post (user_id, post_id, "like") values (45, 41, false);
insert into vote_post (user_id, post_id, "like") values (41, 171, true);
insert into vote_post (user_id, post_id, "like") values (22, 103, false);
insert into vote_post (user_id, post_id, "like") values (85, 115, true);
insert into vote_post (user_id, post_id, "like") values (65, 72, false);
insert into vote_post (user_id, post_id, "like") values (2, 91, false);
insert into vote_post (user_id, post_id, "like") values (87, 96, false);
insert into vote_post (user_id, post_id, "like") values (88, 108, true);
insert into vote_post (user_id, post_id, "like") values (76, 122, true);
insert into vote_post (user_id, post_id, "like") values (30, 156, false);
insert into vote_post (user_id, post_id, "like") values (40, 21, true);
insert into vote_post (user_id, post_id, "like") values (48, 52, false);
insert into vote_post (user_id, post_id, "like") values (58, 15, false);
insert into vote_post (user_id, post_id, "like") values (96, 25, false);
insert into vote_post (user_id, post_id, "like") values (57, 55, true);
insert into vote_post (user_id, post_id, "like") values (62, 122, true);
insert into vote_post (user_id, post_id, "like") values (27, 132, true);
insert into vote_post (user_id, post_id, "like") values (15, 11, true);
insert into vote_post (user_id, post_id, "like") values (54, 17, true);
insert into vote_post (user_id, post_id, "like") values (57, 90, false);
insert into vote_post (user_id, post_id, "like") values (15, 130, false);
insert into vote_post (user_id, post_id, "like") values (59, 89, true);
insert into vote_post (user_id, post_id, "like") values (96, 44, true);
insert into vote_post (user_id, post_id, "like") values (35, 139, true);
insert into vote_post (user_id, post_id, "like") values (68, 184, true);
insert into vote_post (user_id, post_id, "like") values (86, 198, false);
insert into vote_post (user_id, post_id, "like") values (89, 111, false);
insert into vote_post (user_id, post_id, "like") values (61, 84, true);
insert into vote_post (user_id, post_id, "like") values (19, 50, true);
insert into vote_post (user_id, post_id, "like") values (96, 154, false);
insert into vote_post (user_id, post_id, "like") values (15, 69, true);
insert into vote_post (user_id, post_id, "like") values (85, 191, false);
insert into vote_post (user_id, post_id, "like") values (97, 55, false);
insert into vote_post (user_id, post_id, "like") values (24, 198, false);
insert into vote_post (user_id, post_id, "like") values (23, 65, true);
insert into vote_post (user_id, post_id, "like") values (47, 197, true);
insert into vote_post (user_id, post_id, "like") values (8, 70, true);
insert into vote_post (user_id, post_id, "like") values (3, 149, true);
insert into vote_post (user_id, post_id, "like") values (2, 175, false);
insert into vote_post (user_id, post_id, "like") values (32, 109, true);
insert into vote_post (user_id, post_id, "like") values (74, 143, true);
insert into vote_post (user_id, post_id, "like") values (66, 48, false);
insert into vote_post (user_id, post_id, "like") values (98, 200, false);
insert into vote_post (user_id, post_id, "like") values (63, 96, false);
insert into vote_post (user_id, post_id, "like") values (53, 164, false);
insert into vote_post (user_id, post_id, "like") values (94, 36, true);
insert into vote_post (user_id, post_id, "like") values (66, 132, false);
insert into vote_post (user_id, post_id, "like") values (68, 193, true);
insert into vote_post (user_id, post_id, "like") values (68, 137, true);
insert into vote_post (user_id, post_id, "like") values (42, 83, false);
insert into vote_post (user_id, post_id, "like") values (60, 120, false);
insert into vote_post (user_id, post_id, "like") values (82, 25, true);
insert into vote_post (user_id, post_id, "like") values (69, 145, false);
insert into vote_post (user_id, post_id, "like") values (79, 71, true);
insert into vote_post (user_id, post_id, "like") values (49, 81, true);
insert into vote_post (user_id, post_id, "like") values (30, 163, false);
insert into vote_post (user_id, post_id, "like") values (84, 136, false);
insert into vote_post (user_id, post_id, "like") values (95, 132, true);
insert into vote_post (user_id, post_id, "like") values (53, 143, true);
insert into vote_post (user_id, post_id, "like") values (20, 111, false);
insert into vote_post (user_id, post_id, "like") values (65, 186, false);
insert into vote_post (user_id, post_id, "like") values (80, 67, false);
insert into vote_post (user_id, post_id, "like") values (88, 127, true);
insert into vote_post (user_id, post_id, "like") values (3, 96, true);
insert into vote_post (user_id, post_id, "like") values (37, 112, false);
insert into vote_post (user_id, post_id, "like") values (2, 72, true);
insert into vote_post (user_id, post_id, "like") values (25, 23, true);
insert into vote_post (user_id, post_id, "like") values (53, 199, false);
insert into vote_post (user_id, post_id, "like") values (96, 104, false);
insert into vote_post (user_id, post_id, "like") values (60, 79, true);
insert into vote_post (user_id, post_id, "like") values (37, 36, false);
insert into vote_post (user_id, post_id, "like") values (75, 119, true);
insert into vote_post (user_id, post_id, "like") values (4, 13, true);
insert into vote_post (user_id, post_id, "like") values (82, 120, true);
insert into vote_post (user_id, post_id, "like") values (45, 92, false);
insert into vote_post (user_id, post_id, "like") values (63, 7, false);
insert into vote_post (user_id, post_id, "like") values (30, 111, false);
insert into vote_post (user_id, post_id, "like") values (39, 38, true);
insert into vote_post (user_id, post_id, "like") values (100, 174, false);
insert into vote_post (user_id, post_id, "like") values (75, 113, true);
insert into vote_post (user_id, post_id, "like") values (39, 145, false);
insert into vote_post (user_id, post_id, "like") values (69, 180, false);
insert into vote_post (user_id, post_id, "like") values (11, 134, false);
insert into vote_post (user_id, post_id, "like") values (75, 2, false);
insert into vote_post (user_id, post_id, "like") values (57, 85, true);
insert into vote_post (user_id, post_id, "like") values (54, 8, true);
insert into vote_post (user_id, post_id, "like") values (56, 198, false);
insert into vote_post (user_id, post_id, "like") values (54, 124, false);
insert into vote_post (user_id, post_id, "like") values (79, 130, false);
insert into vote_post (user_id, post_id, "like") values (57, 134, false);
insert into vote_post (user_id, post_id, "like") values (37, 161, true);
insert into vote_post (user_id, post_id, "like") values (13, 143, true);
insert into vote_post (user_id, post_id, "like") values (43, 177, true);
insert into vote_post (user_id, post_id, "like") values (24, 74, false);
insert into vote_post (user_id, post_id, "like") values (87, 116, false);
insert into vote_post (user_id, post_id, "like") values (60, 29, true);
insert into vote_post (user_id, post_id, "like") values (21, 124, true);
insert into vote_post (user_id, post_id, "like") values (35, 144, true);
insert into vote_post (user_id, post_id, "like") values (41, 109, true);
insert into vote_post (user_id, post_id, "like") values (45, 63, false);
insert into vote_post (user_id, post_id, "like") values (96, 175, false);
insert into vote_post (user_id, post_id, "like") values (8, 125, false);
insert into vote_post (user_id, post_id, "like") values (32, 17, false);
insert into vote_post (user_id, post_id, "like") values (93, 139, true);
insert into vote_post (user_id, post_id, "like") values (78, 71, true);
insert into vote_post (user_id, post_id, "like") values (32, 42, true);
insert into vote_post (user_id, post_id, "like") values (19, 75, true);
insert into vote_post (user_id, post_id, "like") values (5, 55, true);
insert into vote_post (user_id, post_id, "like") values (65, 57, true);
insert into vote_post (user_id, post_id, "like") values (35, 175, false);
insert into vote_post (user_id, post_id, "like") values (96, 197, false);
insert into vote_post (user_id, post_id, "like") values (25, 174, true);
insert into vote_post (user_id, post_id, "like") values (73, 70, false);
insert into vote_post (user_id, post_id, "like") values (55, 43, false);
insert into vote_post (user_id, post_id, "like") values (92, 141, true);
insert into vote_post (user_id, post_id, "like") values (100, 68, true);
insert into vote_post (user_id, post_id, "like") values (74, 171, false);
insert into vote_post (user_id, post_id, "like") values (18, 197, false);
insert into vote_post (user_id, post_id, "like") values (95, 24, true);
insert into vote_post (user_id, post_id, "like") values (2, 57, true);
insert into vote_post (user_id, post_id, "like") values (37, 119, true);
insert into vote_post (user_id, post_id, "like") values (96, 30, false);
insert into vote_post (user_id, post_id, "like") values (36, 119, false);
insert into vote_post (user_id, post_id, "like") values (8, 187, false);
insert into vote_post (user_id, post_id, "like") values (74, 22, false);
insert into vote_post (user_id, post_id, "like") values (60, 145, false);
insert into vote_post (user_id, post_id, "like") values (31, 28, false);
insert into vote_post (user_id, post_id, "like") values (20, 36, false);
insert into vote_post (user_id, post_id, "like") values (41, 79, true);
insert into vote_post (user_id, post_id, "like") values (75, 8, false);
insert into vote_post (user_id, post_id, "like") values (97, 106, true);
insert into vote_post (user_id, post_id, "like") values (88, 71, false);
insert into vote_post (user_id, post_id, "like") values (55, 85, true);
insert into vote_post (user_id, post_id, "like") values (25, 84, true);
insert into vote_post (user_id, post_id, "like") values (100, 113, true);
insert into vote_post (user_id, post_id, "like") values (30, 24, false);
insert into vote_post (user_id, post_id, "like") values (33, 121, true);
insert into vote_post (user_id, post_id, "like") values (23, 14, false);
insert into vote_post (user_id, post_id, "like") values (38, 174, false);
insert into vote_post (user_id, post_id, "like") values (63, 135, false);
insert into vote_post (user_id, post_id, "like") values (22, 43, false);
insert into vote_post (user_id, post_id, "like") values (40, 166, false);
insert into vote_post (user_id, post_id, "like") values (93, 181, true);
insert into vote_post (user_id, post_id, "like") values (44, 117, true);
insert into vote_post (user_id, post_id, "like") values (56, 18, false);
insert into vote_post (user_id, post_id, "like") values (16, 85, false);
insert into vote_post (user_id, post_id, "like") values (90, 53, false);
insert into vote_post (user_id, post_id, "like") values (59, 33, true);
insert into vote_post (user_id, post_id, "like") values (98, 45, false);
insert into vote_post (user_id, post_id, "like") values (9, 164, false);
insert into vote_post (user_id, post_id, "like") values (8, 73, true);
insert into vote_post (user_id, post_id, "like") values (23, 150, true);
insert into vote_post (user_id, post_id, "like") values (56, 45, false);
insert into vote_post (user_id, post_id, "like") values (80, 192, false);
insert into vote_post (user_id, post_id, "like") values (41, 21, false);
insert into vote_post (user_id, post_id, "like") values (64, 22, false);
insert into vote_post (user_id, post_id, "like") values (81, 182, true);
insert into vote_post (user_id, post_id, "like") values (29, 33, true);
insert into vote_post (user_id, post_id, "like") values (59, 127, true);
insert into vote_post (user_id, post_id, "like") values (68, 11, false);
insert into vote_post (user_id, post_id, "like") values (61, 53, true);
insert into vote_post (user_id, post_id, "like") values (94, 72, false);
insert into vote_post (user_id, post_id, "like") values (17, 32, true);
insert into vote_post (user_id, post_id, "like") values (55, 141, false);
insert into vote_post (user_id, post_id, "like") values (54, 53, false);
insert into vote_post (user_id, post_id, "like") values (12, 76, true);
insert into vote_post (user_id, post_id, "like") values (36, 150, false);
insert into vote_post (user_id, post_id, "like") values (38, 153, true);
insert into vote_post (user_id, post_id, "like") values (43, 103, true);
insert into vote_post (user_id, post_id, "like") values (6, 93, true);
insert into vote_post (user_id, post_id, "like") values (52, 47, true);
insert into vote_post (user_id, post_id, "like") values (71, 78, false);
insert into vote_post (user_id, post_id, "like") values (65, 110, true);
insert into vote_post (user_id, post_id, "like") values (86, 200, false);
insert into vote_post (user_id, post_id, "like") values (63, 74, false);
insert into vote_post (user_id, post_id, "like") values (21, 95, true);
insert into vote_post (user_id, post_id, "like") values (11, 140, false);
insert into vote_post (user_id, post_id, "like") values (81, 23, true);
insert into vote_post (user_id, post_id, "like") values (60, 119, false);
insert into vote_post (user_id, post_id, "like") values (79, 77, false);
insert into vote_post (user_id, post_id, "like") values (16, 179, false);
insert into vote_post (user_id, post_id, "like") values (56, 66, false);
insert into vote_post (user_id, post_id, "like") values (59, 60, false);
insert into vote_post (user_id, post_id, "like") values (73, 25, true);
insert into vote_post (user_id, post_id, "like") values (50, 73, true);
insert into vote_post (user_id, post_id, "like") values (61, 83, true);
insert into vote_post (user_id, post_id, "like") values (18, 159, false);
insert into vote_post (user_id, post_id, "like") values (24, 154, false);
insert into vote_post (user_id, post_id, "like") values (89, 23, true);
insert into vote_post (user_id, post_id, "like") values (79, 148, true);
insert into vote_post (user_id, post_id, "like") values (3, 200, false);
insert into vote_post (user_id, post_id, "like") values (44, 154, false);
insert into vote_post (user_id, post_id, "like") values (40, 51, false);
insert into vote_post (user_id, post_id, "like") values (6, 102, true);
insert into vote_post (user_id, post_id, "like") values (81, 113, true);
insert into vote_post (user_id, post_id, "like") values (65, 140, true);
insert into vote_post (user_id, post_id, "like") values (60, 3, false);
insert into vote_post (user_id, post_id, "like") values (52, 100, true);
insert into vote_post (user_id, post_id, "like") values (42, 140, false);
insert into vote_post (user_id, post_id, "like") values (17, 68, true);
insert into vote_post (user_id, post_id, "like") values (3, 127, true);
insert into vote_post (user_id, post_id, "like") values (16, 110, false);
insert into vote_post (user_id, post_id, "like") values (2, 150, true);
insert into vote_post (user_id, post_id, "like") values (10, 88, false);
insert into vote_post (user_id, post_id, "like") values (96, 146, false);
insert into vote_post (user_id, post_id, "like") values (31, 135, false);
insert into vote_post (user_id, post_id, "like") values (98, 36, false);
insert into vote_post (user_id, post_id, "like") values (21, 26, false);
insert into vote_post (user_id, post_id, "like") values (21, 175, true);
insert into vote_post (user_id, post_id, "like") values (22, 37, false);
insert into vote_post (user_id, post_id, "like") values (86, 86, false);
insert into vote_post (user_id, post_id, "like") values (92, 166, true);
insert into vote_post (user_id, post_id, "like") values (8, 193, false);
insert into vote_post (user_id, post_id, "like") values (16, 115, false);
insert into vote_post (user_id, post_id, "like") values (48, 68, true);
insert into vote_post (user_id, post_id, "like") values (3, 31, true);
insert into vote_post (user_id, post_id, "like") values (42, 196, true);
insert into vote_post (user_id, post_id, "like") values (9, 80, false);
insert into vote_post (user_id, post_id, "like") values (90, 57, true);
insert into vote_post (user_id, post_id, "like") values (73, 158, false);
insert into vote_post (user_id, post_id, "like") values (100, 163, false);
insert into vote_post (user_id, post_id, "like") values (85, 134, false);
insert into vote_post (user_id, post_id, "like") values (17, 127, false);
insert into vote_post (user_id, post_id, "like") values (17, 198, true);
insert into vote_post (user_id, post_id, "like") values (82, 37, false);
insert into vote_post (user_id, post_id, "like") values (72, 121, true);
insert into vote_post (user_id, post_id, "like") values (96, 72, true);
insert into vote_post (user_id, post_id, "like") values (35, 68, true);
insert into vote_post (user_id, post_id, "like") values (25, 185, false);
insert into vote_post (user_id, post_id, "like") values (51, 13, true);
insert into vote_post (user_id, post_id, "like") values (28, 16, true);
insert into vote_post (user_id, post_id, "like") values (98, 57, false);
insert into vote_post (user_id, post_id, "like") values (46, 192, true);
insert into vote_post (user_id, post_id, "like") values (60, 74, true);
insert into vote_post (user_id, post_id, "like") values (65, 183, true);
insert into vote_post (user_id, post_id, "like") values (32, 6, false);
insert into vote_post (user_id, post_id, "like") values (76, 48, true);
insert into vote_post (user_id, post_id, "like") values (75, 105, false);
insert into vote_post (user_id, post_id, "like") values (92, 79, true);
insert into vote_post (user_id, post_id, "like") values (62, 86, true);
insert into vote_post (user_id, post_id, "like") values (53, 125, false);
insert into vote_post (user_id, post_id, "like") values (78, 97, true);
insert into vote_post (user_id, post_id, "like") values (25, 133, false);
insert into vote_post (user_id, post_id, "like") values (11, 168, false);
insert into vote_post (user_id, post_id, "like") values (57, 97, true);
insert into vote_post (user_id, post_id, "like") values (37, 134, true);
insert into vote_post (user_id, post_id, "like") values (34, 9, false);
insert into vote_post (user_id, post_id, "like") values (83, 39, false);
insert into vote_post (user_id, post_id, "like") values (16, 185, false);
insert into vote_post (user_id, post_id, "like") values (41, 55, false);
insert into vote_post (user_id, post_id, "like") values (1, 165, true);
insert into vote_post (user_id, post_id, "like") values (36, 144, true);
insert into vote_post (user_id, post_id, "like") values (59, 111, true);
insert into vote_post (user_id, post_id, "like") values (92, 87, false);
insert into vote_post (user_id, post_id, "like") values (58, 92, true);
insert into vote_post (user_id, post_id, "like") values (54, 42, true);
insert into vote_post (user_id, post_id, "like") values (96, 93, true);
insert into vote_post (user_id, post_id, "like") values (68, 12, false);
insert into vote_post (user_id, post_id, "like") values (53, 62, true);
insert into vote_post (user_id, post_id, "like") values (88, 189, true);
insert into vote_post (user_id, post_id, "like") values (55, 176, true);
insert into vote_post (user_id, post_id, "like") values (2, 195, false);
insert into vote_post (user_id, post_id, "like") values (61, 112, true);
insert into vote_post (user_id, post_id, "like") values (24, 138, false);
insert into vote_post (user_id, post_id, "like") values (9, 138, true);
insert into vote_post (user_id, post_id, "like") values (96, 39, true);
insert into vote_post (user_id, post_id, "like") values (94, 107, false);
insert into vote_post (user_id, post_id, "like") values (85, 124, false);
insert into vote_post (user_id, post_id, "like") values (80, 139, false);
insert into vote_post (user_id, post_id, "like") values (43, 68, true);
insert into vote_post (user_id, post_id, "like") values (48, 37, true);
insert into vote_post (user_id, post_id, "like") values (92, 168, true);
insert into vote_post (user_id, post_id, "like") values (23, 28, true);
insert into vote_post (user_id, post_id, "like") values (42, 149, true);
insert into vote_post (user_id, post_id, "like") values (85, 180, true);
insert into vote_post (user_id, post_id, "like") values (63, 75, true);
insert into vote_post (user_id, post_id, "like") values (30, 106, true);
insert into vote_post (user_id, post_id, "like") values (81, 177, true);
insert into vote_post (user_id, post_id, "like") values (58, 90, true);
insert into vote_post (user_id, post_id, "like") values (65, 8, false);
insert into vote_post (user_id, post_id, "like") values (94, 129, false);
insert into vote_post (user_id, post_id, "like") values (17, 104, true);
insert into vote_post (user_id, post_id, "like") values (15, 156, false);
insert into vote_post (user_id, post_id, "like") values (55, 64, false);
insert into vote_post (user_id, post_id, "like") values (43, 81, false);
insert into vote_post (user_id, post_id, "like") values (26, 102, true);
insert into vote_post (user_id, post_id, "like") values (4, 5, true);
insert into vote_post (user_id, post_id, "like") values (91, 187, false);
insert into vote_post (user_id, post_id, "like") values (1, 122, true);
insert into vote_post (user_id, post_id, "like") values (40, 88, true);
insert into vote_post (user_id, post_id, "like") values (26, 23, false);
insert into vote_post (user_id, post_id, "like") values (1, 121, false);
insert into vote_post (user_id, post_id, "like") values (10, 123, false);
insert into vote_post (user_id, post_id, "like") values (76, 120, true);
insert into vote_post (user_id, post_id, "like") values (3, 3, true);
insert into vote_post (user_id, post_id, "like") values (93, 33, true);
insert into vote_post (user_id, post_id, "like") values (69, 69, false);
insert into vote_post (user_id, post_id, "like") values (1, 103, true);
insert into vote_post (user_id, post_id, "like") values (84, 30, true);
insert into vote_post (user_id, post_id, "like") values (41, 147, false);
insert into vote_post (user_id, post_id, "like") values (95, 135, false);
insert into vote_post (user_id, post_id, "like") values (79, 160, false);
insert into vote_post (user_id, post_id, "like") values (83, 30, true);
insert into vote_post (user_id, post_id, "like") values (96, 84, true);
insert into vote_post (user_id, post_id, "like") values (51, 141, false);
insert into vote_post (user_id, post_id, "like") values (97, 100, true);
insert into vote_post (user_id, post_id, "like") values (52, 137, true);
insert into vote_post (user_id, post_id, "like") values (34, 16, true);
insert into vote_post (user_id, post_id, "like") values (45, 7, false);
insert into vote_post (user_id, post_id, "like") values (45, 195, false);
insert into vote_post (user_id, post_id, "like") values (84, 166, false);
insert into vote_post (user_id, post_id, "like") values (68, 179, true);
insert into vote_post (user_id, post_id, "like") values (57, 109, true);
insert into vote_post (user_id, post_id, "like") values (83, 19, true);
insert into vote_post (user_id, post_id, "like") values (34, 52, false);
insert into vote_post (user_id, post_id, "like") values (27, 14, false);
insert into vote_post (user_id, post_id, "like") values (48, 160, false);
insert into vote_post (user_id, post_id, "like") values (11, 195, true);
insert into vote_post (user_id, post_id, "like") values (20, 196, true);
insert into vote_post (user_id, post_id, "like") values (46, 103, false);
insert into vote_post (user_id, post_id, "like") values (62, 47, true);
insert into vote_post (user_id, post_id, "like") values (23, 84, false);
insert into vote_post (user_id, post_id, "like") values (35, 186, true);
insert into vote_post (user_id, post_id, "like") values (68, 165, false);
insert into vote_post (user_id, post_id, "like") values (47, 25, false);
insert into vote_post (user_id, post_id, "like") values (78, 18, true);
insert into vote_post (user_id, post_id, "like") values (40, 184, true);
insert into vote_post (user_id, post_id, "like") values (73, 167, false);
insert into vote_post (user_id, post_id, "like") values (43, 120, true);
insert into vote_post (user_id, post_id, "like") values (61, 16, false);
insert into vote_post (user_id, post_id, "like") values (77, 56, false);
insert into vote_post (user_id, post_id, "like") values (29, 103, true);
insert into vote_post (user_id, post_id, "like") values (59, 189, false);
insert into vote_post (user_id, post_id, "like") values (92, 16, true);
insert into vote_post (user_id, post_id, "like") values (26, 75, false);
insert into vote_post (user_id, post_id, "like") values (15, 157, false);
insert into vote_post (user_id, post_id, "like") values (36, 80, true);
insert into vote_post (user_id, post_id, "like") values (95, 72, false);
insert into vote_post (user_id, post_id, "like") values (29, 23, true);
insert into vote_post (user_id, post_id, "like") values (60, 90, false);
insert into vote_post (user_id, post_id, "like") values (10, 18, false);
insert into vote_post (user_id, post_id, "like") values (10, 119, true);
insert into vote_post (user_id, post_id, "like") values (60, 68, false);
insert into vote_post (user_id, post_id, "like") values (33, 85, true);
insert into vote_post (user_id, post_id, "like") values (55, 39, false);
insert into vote_post (user_id, post_id, "like") values (51, 69, false);
insert into vote_post (user_id, post_id, "like") values (59, 62, true);
insert into vote_post (user_id, post_id, "like") values (36, 5, false);
insert into vote_post (user_id, post_id, "like") values (65, 61, true);
insert into vote_post (user_id, post_id, "like") values (72, 120, false);
insert into vote_post (user_id, post_id, "like") values (87, 60, false);
insert into vote_post (user_id, post_id, "like") values (2, 186, false);
insert into vote_post (user_id, post_id, "like") values (11, 132, false);
insert into vote_post (user_id, post_id, "like") values (50, 62, false);
insert into vote_post (user_id, post_id, "like") values (29, 71, true);
insert into vote_post (user_id, post_id, "like") values (5, 200, false);
insert into vote_post (user_id, post_id, "like") values (74, 116, true);
insert into vote_post (user_id, post_id, "like") values (99, 69, false);

--vote_comment
insert into vote_comment (user_id, comment_id, "like") values (1, 4, false);
insert into vote_comment (user_id, comment_id, "like") values (1, 7, true);
insert into vote_comment (user_id, comment_id, "like") values (1, 29, false);
insert into vote_comment (user_id, comment_id, "like") values (1, 90, false);
insert into vote_comment (user_id, comment_id, "like") values (2, 75, true);
insert into vote_comment (user_id, comment_id, "like") values (2, 85, false);
insert into vote_comment (user_id, comment_id, "like") values (2, 99, false);
insert into vote_comment (user_id, comment_id, "like") values (3, 3, false);
insert into vote_comment (user_id, comment_id, "like") values (3, 43, true);
insert into vote_comment (user_id, comment_id, "like") values (3, 54, true);
insert into vote_comment (user_id, comment_id, "like") values (3, 55, false);
insert into vote_comment (user_id, comment_id, "like") values (3, 71, false);
insert into vote_comment (user_id, comment_id, "like") values (3, 85, false);
insert into vote_comment (user_id, comment_id, "like") values (3, 95, false);
insert into vote_comment (user_id, comment_id, "like") values (4, 11, false);
insert into vote_comment (user_id, comment_id, "like") values (4, 13, true);
insert into vote_comment (user_id, comment_id, "like") values (4, 16, true);
insert into vote_comment (user_id, comment_id, "like") values (4, 17, false);
insert into vote_comment (user_id, comment_id, "like") values (4, 30, true);
insert into vote_comment (user_id, comment_id, "like") values (4, 36, true);
insert into vote_comment (user_id, comment_id, "like") values (4, 55, false);
insert into vote_comment (user_id, comment_id, "like") values (4, 70, true);
insert into vote_comment (user_id, comment_id, "like") values (4, 91, true);
insert into vote_comment (user_id, comment_id, "like") values (4, 98, true);
insert into vote_comment (user_id, comment_id, "like") values (5, 19, false);
insert into vote_comment (user_id, comment_id, "like") values (5, 25, true);
insert into vote_comment (user_id, comment_id, "like") values (5, 28, false);
insert into vote_comment (user_id, comment_id, "like") values (5, 85, true);
insert into vote_comment (user_id, comment_id, "like") values (6, 44, false);
insert into vote_comment (user_id, comment_id, "like") values (6, 58, true);
insert into vote_comment (user_id, comment_id, "like") values (7, 32, true);
insert into vote_comment (user_id, comment_id, "like") values (7, 37, true);
insert into vote_comment (user_id, comment_id, "like") values (7, 87, true);
insert into vote_comment (user_id, comment_id, "like") values (8, 10, false);
insert into vote_comment (user_id, comment_id, "like") values (8, 16, true);
insert into vote_comment (user_id, comment_id, "like") values (8, 44, false);
insert into vote_comment (user_id, comment_id, "like") values (8, 47, true);
insert into vote_comment (user_id, comment_id, "like") values (8, 50, true);
insert into vote_comment (user_id, comment_id, "like") values (8, 60, true);
insert into vote_comment (user_id, comment_id, "like") values (8, 99, false);
insert into vote_comment (user_id, comment_id, "like") values (9, 40, true);
insert into vote_comment (user_id, comment_id, "like") values (9, 42, false);
insert into vote_comment (user_id, comment_id, "like") values (9, 59, true);
insert into vote_comment (user_id, comment_id, "like") values (9, 62, true);
insert into vote_comment (user_id, comment_id, "like") values (10, 11, false);
insert into vote_comment (user_id, comment_id, "like") values (10, 84, false);
insert into vote_comment (user_id, comment_id, "like") values (10, 85, true);
insert into vote_comment (user_id, comment_id, "like") values (10, 86, false);
insert into vote_comment (user_id, comment_id, "like") values (10, 91, false);
insert into vote_comment (user_id, comment_id, "like") values (10, 95, true);
insert into vote_comment (user_id, comment_id, "like") values (11, 36, false);
insert into vote_comment (user_id, comment_id, "like") values (11, 42, false);
insert into vote_comment (user_id, comment_id, "like") values (11, 50, false);
insert into vote_comment (user_id, comment_id, "like") values (11, 60, true);
insert into vote_comment (user_id, comment_id, "like") values (11, 79, true);
insert into vote_comment (user_id, comment_id, "like") values (11, 100, true);
insert into vote_comment (user_id, comment_id, "like") values (12, 9, false);
insert into vote_comment (user_id, comment_id, "like") values (12, 39, false);
insert into vote_comment (user_id, comment_id, "like") values (12, 90, false);
insert into vote_comment (user_id, comment_id, "like") values (13, 57, false);
insert into vote_comment (user_id, comment_id, "like") values (13, 69, true);
insert into vote_comment (user_id, comment_id, "like") values (13, 76, false);
insert into vote_comment (user_id, comment_id, "like") values (13, 82, true);
insert into vote_comment (user_id, comment_id, "like") values (13, 83, false);
insert into vote_comment (user_id, comment_id, "like") values (14, 16, false);
insert into vote_comment (user_id, comment_id, "like") values (14, 25, false);
insert into vote_comment (user_id, comment_id, "like") values (14, 41, false);
insert into vote_comment (user_id, comment_id, "like") values (14, 42, true);
insert into vote_comment (user_id, comment_id, "like") values (14, 75, false);
insert into vote_comment (user_id, comment_id, "like") values (14, 100, true);
insert into vote_comment (user_id, comment_id, "like") values (15, 5, false);
insert into vote_comment (user_id, comment_id, "like") values (15, 11, false);
insert into vote_comment (user_id, comment_id, "like") values (15, 14, false);
insert into vote_comment (user_id, comment_id, "like") values (15, 39, true);
insert into vote_comment (user_id, comment_id, "like") values (15, 71, true);
insert into vote_comment (user_id, comment_id, "like") values (15, 78, true);
insert into vote_comment (user_id, comment_id, "like") values (16, 15, true);
insert into vote_comment (user_id, comment_id, "like") values (16, 33, true);
insert into vote_comment (user_id, comment_id, "like") values (16, 43, true);
insert into vote_comment (user_id, comment_id, "like") values (16, 44, false);
insert into vote_comment (user_id, comment_id, "like") values (16, 63, false);
insert into vote_comment (user_id, comment_id, "like") values (16, 82, false);
insert into vote_comment (user_id, comment_id, "like") values (16, 90, true);
insert into vote_comment (user_id, comment_id, "like") values (17, 8, true);
insert into vote_comment (user_id, comment_id, "like") values (17, 13, false);
insert into vote_comment (user_id, comment_id, "like") values (17, 75, true);
insert into vote_comment (user_id, comment_id, "like") values (17, 81, true);
insert into vote_comment (user_id, comment_id, "like") values (17, 83, true);
insert into vote_comment (user_id, comment_id, "like") values (17, 85, true);
insert into vote_comment (user_id, comment_id, "like") values (17, 88, false);
insert into vote_comment (user_id, comment_id, "like") values (18, 16, false);
insert into vote_comment (user_id, comment_id, "like") values (18, 17, true);
insert into vote_comment (user_id, comment_id, "like") values (18, 37, false);
insert into vote_comment (user_id, comment_id, "like") values (18, 65, true);
insert into vote_comment (user_id, comment_id, "like") values (18, 66, false);
insert into vote_comment (user_id, comment_id, "like") values (18, 76, false);
insert into vote_comment (user_id, comment_id, "like") values (18, 77, true);
insert into vote_comment (user_id, comment_id, "like") values (18, 79, false);
insert into vote_comment (user_id, comment_id, "like") values (19, 10, true);
insert into vote_comment (user_id, comment_id, "like") values (19, 52, true);
insert into vote_comment (user_id, comment_id, "like") values (19, 81, true);
insert into vote_comment (user_id, comment_id, "like") values (19, 87, true);
insert into vote_comment (user_id, comment_id, "like") values (20, 20, true);
insert into vote_comment (user_id, comment_id, "like") values (20, 75, false);
insert into vote_comment (user_id, comment_id, "like") values (21, 69, true);
insert into vote_comment (user_id, comment_id, "like") values (21, 92, false);
insert into vote_comment (user_id, comment_id, "like") values (21, 97, false);
insert into vote_comment (user_id, comment_id, "like") values (22, 4, true);
insert into vote_comment (user_id, comment_id, "like") values (22, 30, false);
insert into vote_comment (user_id, comment_id, "like") values (22, 42, false);
insert into vote_comment (user_id, comment_id, "like") values (22, 43, true);
insert into vote_comment (user_id, comment_id, "like") values (22, 48, false);
insert into vote_comment (user_id, comment_id, "like") values (22, 67, false);
insert into vote_comment (user_id, comment_id, "like") values (22, 86, true);
insert into vote_comment (user_id, comment_id, "like") values (22, 95, false);
insert into vote_comment (user_id, comment_id, "like") values (23, 37, false);
insert into vote_comment (user_id, comment_id, "like") values (24, 31, false);
insert into vote_comment (user_id, comment_id, "like") values (24, 60, false);
insert into vote_comment (user_id, comment_id, "like") values (24, 68, false);
insert into vote_comment (user_id, comment_id, "like") values (24, 97, false);
insert into vote_comment (user_id, comment_id, "like") values (25, 1, false);
insert into vote_comment (user_id, comment_id, "like") values (25, 33, true);
insert into vote_comment (user_id, comment_id, "like") values (25, 35, true);
insert into vote_comment (user_id, comment_id, "like") values (25, 52, true);
insert into vote_comment (user_id, comment_id, "like") values (25, 53, false);
insert into vote_comment (user_id, comment_id, "like") values (25, 66, true);
insert into vote_comment (user_id, comment_id, "like") values (25, 71, true);
insert into vote_comment (user_id, comment_id, "like") values (25, 74, true);
insert into vote_comment (user_id, comment_id, "like") values (25, 90, false);
insert into vote_comment (user_id, comment_id, "like") values (26, 2, false);
insert into vote_comment (user_id, comment_id, "like") values (26, 15, false);
insert into vote_comment (user_id, comment_id, "like") values (26, 51, true);
insert into vote_comment (user_id, comment_id, "like") values (27, 5, false);
insert into vote_comment (user_id, comment_id, "like") values (27, 9, true);
insert into vote_comment (user_id, comment_id, "like") values (27, 22, false);
insert into vote_comment (user_id, comment_id, "like") values (27, 47, true);
insert into vote_comment (user_id, comment_id, "like") values (27, 100, true);
insert into vote_comment (user_id, comment_id, "like") values (28, 19, true);
insert into vote_comment (user_id, comment_id, "like") values (28, 22, true);
insert into vote_comment (user_id, comment_id, "like") values (28, 24, true);
insert into vote_comment (user_id, comment_id, "like") values (28, 31, true);
insert into vote_comment (user_id, comment_id, "like") values (28, 63, false);
insert into vote_comment (user_id, comment_id, "like") values (29, 22, false);
insert into vote_comment (user_id, comment_id, "like") values (29, 45, false);
insert into vote_comment (user_id, comment_id, "like") values (29, 52, false);
insert into vote_comment (user_id, comment_id, "like") values (29, 88, false);
insert into vote_comment (user_id, comment_id, "like") values (30, 18, false);
insert into vote_comment (user_id, comment_id, "like") values (30, 48, false);
insert into vote_comment (user_id, comment_id, "like") values (30, 58, true);
insert into vote_comment (user_id, comment_id, "like") values (30, 63, true);
insert into vote_comment (user_id, comment_id, "like") values (30, 64, false);
insert into vote_comment (user_id, comment_id, "like") values (30, 77, false);
insert into vote_comment (user_id, comment_id, "like") values (30, 88, true);
insert into vote_comment (user_id, comment_id, "like") values (30, 92, false);
insert into vote_comment (user_id, comment_id, "like") values (30, 98, true);
insert into vote_comment (user_id, comment_id, "like") values (31, 26, true);
insert into vote_comment (user_id, comment_id, "like") values (31, 28, false);
insert into vote_comment (user_id, comment_id, "like") values (31, 37, false);
insert into vote_comment (user_id, comment_id, "like") values (31, 68, true);
insert into vote_comment (user_id, comment_id, "like") values (31, 81, false);
insert into vote_comment (user_id, comment_id, "like") values (32, 7, false);
insert into vote_comment (user_id, comment_id, "like") values (32, 15, false);
insert into vote_comment (user_id, comment_id, "like") values (32, 50, true);
insert into vote_comment (user_id, comment_id, "like") values (32, 53, false);
insert into vote_comment (user_id, comment_id, "like") values (33, 78, false);
insert into vote_comment (user_id, comment_id, "like") values (33, 84, true);
insert into vote_comment (user_id, comment_id, "like") values (33, 96, false);
insert into vote_comment (user_id, comment_id, "like") values (33, 97, false);
insert into vote_comment (user_id, comment_id, "like") values (34, 16, false);
insert into vote_comment (user_id, comment_id, "like") values (34, 52, false);
insert into vote_comment (user_id, comment_id, "like") values (34, 58, false);
insert into vote_comment (user_id, comment_id, "like") values (34, 66, true);
insert into vote_comment (user_id, comment_id, "like") values (34, 67, true);
insert into vote_comment (user_id, comment_id, "like") values (35, 31, false);
insert into vote_comment (user_id, comment_id, "like") values (34, 70, false);
insert into vote_comment (user_id, comment_id, "like") values (35, 95, false);
insert into vote_comment (user_id, comment_id, "like") values (36, 38, false);
insert into vote_comment (user_id, comment_id, "like") values (36, 42, true);
insert into vote_comment (user_id, comment_id, "like") values (36, 85, true);
insert into vote_comment (user_id, comment_id, "like") values (37, 4, true);
insert into vote_comment (user_id, comment_id, "like") values (37, 16, false);
insert into vote_comment (user_id, comment_id, "like") values (37, 21, true);
insert into vote_comment (user_id, comment_id, "like") values (37, 84, true);
insert into vote_comment (user_id, comment_id, "like") values (37, 99, false);
insert into vote_comment (user_id, comment_id, "like") values (38, 11, true);
insert into vote_comment (user_id, comment_id, "like") values (38, 37, false);
insert into vote_comment (user_id, comment_id, "like") values (38, 63, false);
insert into vote_comment (user_id, comment_id, "like") values (38, 75, true);
insert into vote_comment (user_id, comment_id, "like") values (38, 92, false);
insert into vote_comment (user_id, comment_id, "like") values (39, 2, false);
insert into vote_comment (user_id, comment_id, "like") values (39, 18, false);
insert into vote_comment (user_id, comment_id, "like") values (39, 23, true);
insert into vote_comment (user_id, comment_id, "like") values (39, 39, false);
insert into vote_comment (user_id, comment_id, "like") values (39, 40, true);
insert into vote_comment (user_id, comment_id, "like") values (39, 92, false);
insert into vote_comment (user_id, comment_id, "like") values (39, 93, false);
insert into vote_comment (user_id, comment_id, "like") values (40, 32, false);
insert into vote_comment (user_id, comment_id, "like") values (40, 53, true);
insert into vote_comment (user_id, comment_id, "like") values (40, 54, true);
insert into vote_comment (user_id, comment_id, "like") values (40, 69, false);
insert into vote_comment (user_id, comment_id, "like") values (40, 88, true);
insert into vote_comment (user_id, comment_id, "like") values (41, 8, true);
insert into vote_comment (user_id, comment_id, "like") values (41, 40, false);
insert into vote_comment (user_id, comment_id, "like") values (41, 41, false);
insert into vote_comment (user_id, comment_id, "like") values (41, 44, true);
insert into vote_comment (user_id, comment_id, "like") values (41, 49, false);
insert into vote_comment (user_id, comment_id, "like") values (41, 65, false);
insert into vote_comment (user_id, comment_id, "like") values (42, 42, true);
insert into vote_comment (user_id, comment_id, "like") values (42, 58, false);
insert into vote_comment (user_id, comment_id, "like") values (42, 67, true);
insert into vote_comment (user_id, comment_id, "like") values (43, 7, false);
insert into vote_comment (user_id, comment_id, "like") values (43, 50, false);
insert into vote_comment (user_id, comment_id, "like") values (43, 72, true);
insert into vote_comment (user_id, comment_id, "like") values (43, 80, true);
insert into vote_comment (user_id, comment_id, "like") values (43, 96, false);
insert into vote_comment (user_id, comment_id, "like") values (44, 23, false);
insert into vote_comment (user_id, comment_id, "like") values (44, 27, false);
insert into vote_comment (user_id, comment_id, "like") values (44, 50, false);
insert into vote_comment (user_id, comment_id, "like") values (44, 73, true);
insert into vote_comment (user_id, comment_id, "like") values (45, 9, false);
insert into vote_comment (user_id, comment_id, "like") values (45, 54, true);
insert into vote_comment (user_id, comment_id, "like") values (45, 80, false);
insert into vote_comment (user_id, comment_id, "like") values (45, 81, false);
insert into vote_comment (user_id, comment_id, "like") values (45, 82, true);
insert into vote_comment (user_id, comment_id, "like") values (46, 7, false);
insert into vote_comment (user_id, comment_id, "like") values (46, 18, true);
insert into vote_comment (user_id, comment_id, "like") values (46, 41, false);
insert into vote_comment (user_id, comment_id, "like") values (46, 42, false);
insert into vote_comment (user_id, comment_id, "like") values (46, 45, true);
insert into vote_comment (user_id, comment_id, "like") values (46, 46, false);
insert into vote_comment (user_id, comment_id, "like") values (46, 64, false);
insert into vote_comment (user_id, comment_id, "like") values (47, 17, false);
insert into vote_comment (user_id, comment_id, "like") values (47, 25, false);
insert into vote_comment (user_id, comment_id, "like") values (47, 80, true);
insert into vote_comment (user_id, comment_id, "like") values (48, 12, true);
insert into vote_comment (user_id, comment_id, "like") values (48, 13, true);
insert into vote_comment (user_id, comment_id, "like") values (48, 46, true);
insert into vote_comment (user_id, comment_id, "like") values (48, 59, true);
insert into vote_comment (user_id, comment_id, "like") values (48, 82, true);
insert into vote_comment (user_id, comment_id, "like") values (49, 25, false);
insert into vote_comment (user_id, comment_id, "like") values (49, 71, false);
insert into vote_comment (user_id, comment_id, "like") values (50, 5, false);
insert into vote_comment (user_id, comment_id, "like") values (50, 12, true);
insert into vote_comment (user_id, comment_id, "like") values (50, 27, true);
insert into vote_comment (user_id, comment_id, "like") values (50, 61, false);
insert into vote_comment (user_id, comment_id, "like") values (51, 8, false);
insert into vote_comment (user_id, comment_id, "like") values (51, 13, false);
insert into vote_comment (user_id, comment_id, "like") values (51, 14, false);
insert into vote_comment (user_id, comment_id, "like") values (51, 75, false);
insert into vote_comment (user_id, comment_id, "like") values (51, 100, false);
insert into vote_comment (user_id, comment_id, "like") values (52, 47, true);
insert into vote_comment (user_id, comment_id, "like") values (52, 79, false);
insert into vote_comment (user_id, comment_id, "like") values (52, 89, false);
insert into vote_comment (user_id, comment_id, "like") values (53, 41, true);
insert into vote_comment (user_id, comment_id, "like") values (53, 43, true);
insert into vote_comment (user_id, comment_id, "like") values (53, 54, false);
insert into vote_comment (user_id, comment_id, "like") values (53, 73, false);
insert into vote_comment (user_id, comment_id, "like") values (53, 83, false);
insert into vote_comment (user_id, comment_id, "like") values (53, 86, true);
insert into vote_comment (user_id, comment_id, "like") values (53, 87, false);
insert into vote_comment (user_id, comment_id, "like") values (54, 31, false);
insert into vote_comment (user_id, comment_id, "like") values (54, 46, false);
insert into vote_comment (user_id, comment_id, "like") values (54, 50, false);
insert into vote_comment (user_id, comment_id, "like") values (55, 8, false);
insert into vote_comment (user_id, comment_id, "like") values (55, 61, true);
insert into vote_comment (user_id, comment_id, "like") values (55, 77, false);
insert into vote_comment (user_id, comment_id, "like") values (55, 81, false);
insert into vote_comment (user_id, comment_id, "like") values (55, 89, false);
insert into vote_comment (user_id, comment_id, "like") values (55, 90, true);
insert into vote_comment (user_id, comment_id, "like") values (56, 2, false);
insert into vote_comment (user_id, comment_id, "like") values (56, 3, false);
insert into vote_comment (user_id, comment_id, "like") values (56, 24, true);
insert into vote_comment (user_id, comment_id, "like") values (56, 28, false);
insert into vote_comment (user_id, comment_id, "like") values (56, 41, true);
insert into vote_comment (user_id, comment_id, "like") values (56, 44, true);
insert into vote_comment (user_id, comment_id, "like") values (56, 49, true);
insert into vote_comment (user_id, comment_id, "like") values (56, 59, true);
insert into vote_comment (user_id, comment_id, "like") values (56, 69, true);
insert into vote_comment (user_id, comment_id, "like") values (56, 76, false);
insert into vote_comment (user_id, comment_id, "like") values (56, 92, false);
insert into vote_comment (user_id, comment_id, "like") values (56, 98, false);
insert into vote_comment (user_id, comment_id, "like") values (57, 26, false);
insert into vote_comment (user_id, comment_id, "like") values (57, 30, true);
insert into vote_comment (user_id, comment_id, "like") values (57, 72, false);
insert into vote_comment (user_id, comment_id, "like") values (57, 89, true);
insert into vote_comment (user_id, comment_id, "like") values (57, 93, true);
insert into vote_comment (user_id, comment_id, "like") values (58, 2, false);
insert into vote_comment (user_id, comment_id, "like") values (58, 13, true);
insert into vote_comment (user_id, comment_id, "like") values (58, 15, false);
insert into vote_comment (user_id, comment_id, "like") values (58, 26, true);
insert into vote_comment (user_id, comment_id, "like") values (58, 59, true);
insert into vote_comment (user_id, comment_id, "like") values (58, 68, false);
insert into vote_comment (user_id, comment_id, "like") values (58, 85, false);
insert into vote_comment (user_id, comment_id, "like") values (59, 8, true);
insert into vote_comment (user_id, comment_id, "like") values (59, 42, true);
insert into vote_comment (user_id, comment_id, "like") values (59, 51, false);
insert into vote_comment (user_id, comment_id, "like") values (59, 68, true);
insert into vote_comment (user_id, comment_id, "like") values (59, 75, true);
insert into vote_comment (user_id, comment_id, "like") values (59, 96, true);
insert into vote_comment (user_id, comment_id, "like") values (60, 18, false);
insert into vote_comment (user_id, comment_id, "like") values (60, 30, true);
insert into vote_comment (user_id, comment_id, "like") values (60, 34, false);
insert into vote_comment (user_id, comment_id, "like") values (60, 36, true);
insert into vote_comment (user_id, comment_id, "like") values (60, 43, true);
insert into vote_comment (user_id, comment_id, "like") values (60, 80, true);
insert into vote_comment (user_id, comment_id, "like") values (60, 90, true);
insert into vote_comment (user_id, comment_id, "like") values (61, 12, true);
insert into vote_comment (user_id, comment_id, "like") values (61, 29, false);
insert into vote_comment (user_id, comment_id, "like") values (61, 69, true);
insert into vote_comment (user_id, comment_id, "like") values (61, 90, true);
insert into vote_comment (user_id, comment_id, "like") values (61, 95, true);
insert into vote_comment (user_id, comment_id, "like") values (62, 50, false);
insert into vote_comment (user_id, comment_id, "like") values (62, 62, true);
insert into vote_comment (user_id, comment_id, "like") values (62, 69, false);
insert into vote_comment (user_id, comment_id, "like") values (62, 72, false);
insert into vote_comment (user_id, comment_id, "like") values (62, 82, false);
insert into vote_comment (user_id, comment_id, "like") values (62, 87, true);
insert into vote_comment (user_id, comment_id, "like") values (62, 89, true);
insert into vote_comment (user_id, comment_id, "like") values (62, 91, true);
insert into vote_comment (user_id, comment_id, "like") values (62, 95, true);
insert into vote_comment (user_id, comment_id, "like") values (63, 4, false);
insert into vote_comment (user_id, comment_id, "like") values (63, 14, false);
insert into vote_comment (user_id, comment_id, "like") values (63, 21, true);
insert into vote_comment (user_id, comment_id, "like") values (63, 32, true);
insert into vote_comment (user_id, comment_id, "like") values (63, 46, false);
insert into vote_comment (user_id, comment_id, "like") values (63, 47, true);
insert into vote_comment (user_id, comment_id, "like") values (63, 49, true);
insert into vote_comment (user_id, comment_id, "like") values (63, 55, true);
insert into vote_comment (user_id, comment_id, "like") values (64, 19, false);
insert into vote_comment (user_id, comment_id, "like") values (64, 20, true);
insert into vote_comment (user_id, comment_id, "like") values (64, 30, true);
insert into vote_comment (user_id, comment_id, "like") values (64, 88, true);
insert into vote_comment (user_id, comment_id, "like") values (65, 6, false);
insert into vote_comment (user_id, comment_id, "like") values (65, 7, true);
insert into vote_comment (user_id, comment_id, "like") values (65, 70, false);
insert into vote_comment (user_id, comment_id, "like") values (65, 92, true);
insert into vote_comment (user_id, comment_id, "like") values (66, 12, false);
insert into vote_comment (user_id, comment_id, "like") values (66, 29, true);
insert into vote_comment (user_id, comment_id, "like") values (65, 85, false);
insert into vote_comment (user_id, comment_id, "like") values (67, 20, true);
insert into vote_comment (user_id, comment_id, "like") values (67, 31, false);
insert into vote_comment (user_id, comment_id, "like") values (67, 36, false);
insert into vote_comment (user_id, comment_id, "like") values (67, 53, true);
insert into vote_comment (user_id, comment_id, "like") values (67, 86, true);
insert into vote_comment (user_id, comment_id, "like") values (67, 100, true);
insert into vote_comment (user_id, comment_id, "like") values (68, 11, false);
insert into vote_comment (user_id, comment_id, "like") values (68, 26, false);
insert into vote_comment (user_id, comment_id, "like") values (68, 38, false);
insert into vote_comment (user_id, comment_id, "like") values (68, 67, false);
insert into vote_comment (user_id, comment_id, "like") values (68, 88, true);
insert into vote_comment (user_id, comment_id, "like") values (68, 95, true);
insert into vote_comment (user_id, comment_id, "like") values (69, 11, true);
insert into vote_comment (user_id, comment_id, "like") values (69, 26, true);
insert into vote_comment (user_id, comment_id, "like") values (69, 42, true);
insert into vote_comment (user_id, comment_id, "like") values (70, 30, true);
insert into vote_comment (user_id, comment_id, "like") values (70, 50, true);
insert into vote_comment (user_id, comment_id, "like") values (70, 55, true);
insert into vote_comment (user_id, comment_id, "like") values (71, 51, true);
insert into vote_comment (user_id, comment_id, "like") values (71, 82, false);
insert into vote_comment (user_id, comment_id, "like") values (71, 89, true);
insert into vote_comment (user_id, comment_id, "like") values (72, 9, true);
insert into vote_comment (user_id, comment_id, "like") values (72, 52, true);
insert into vote_comment (user_id, comment_id, "like") values (72, 55, true);
insert into vote_comment (user_id, comment_id, "like") values (73, 5, true);
insert into vote_comment (user_id, comment_id, "like") values (73, 21, false);
insert into vote_comment (user_id, comment_id, "like") values (73, 38, true);
insert into vote_comment (user_id, comment_id, "like") values (73, 51, true);
insert into vote_comment (user_id, comment_id, "like") values (73, 61, true);
insert into vote_comment (user_id, comment_id, "like") values (73, 69, true);
insert into vote_comment (user_id, comment_id, "like") values (73, 88, false);
insert into vote_comment (user_id, comment_id, "like") values (73, 97, false);
insert into vote_comment (user_id, comment_id, "like") values (74, 15, true);
insert into vote_comment (user_id, comment_id, "like") values (74, 27, true);
insert into vote_comment (user_id, comment_id, "like") values (74, 28, true);
insert into vote_comment (user_id, comment_id, "like") values (74, 30, false);
insert into vote_comment (user_id, comment_id, "like") values (74, 67, true);
insert into vote_comment (user_id, comment_id, "like") values (75, 19, false);
insert into vote_comment (user_id, comment_id, "like") values (75, 62, false);
insert into vote_comment (user_id, comment_id, "like") values (76, 91, false);
insert into vote_comment (user_id, comment_id, "like") values (77, 23, false);
insert into vote_comment (user_id, comment_id, "like") values (77, 83, true);
insert into vote_comment (user_id, comment_id, "like") values (77, 99, false);
insert into vote_comment (user_id, comment_id, "like") values (78, 4, true);
insert into vote_comment (user_id, comment_id, "like") values (78, 5, true);
insert into vote_comment (user_id, comment_id, "like") values (78, 42, true);
insert into vote_comment (user_id, comment_id, "like") values (78, 98, false);
insert into vote_comment (user_id, comment_id, "like") values (79, 9, false);
insert into vote_comment (user_id, comment_id, "like") values (79, 17, true);
insert into vote_comment (user_id, comment_id, "like") values (79, 23, false);
insert into vote_comment (user_id, comment_id, "like") values (79, 25, true);
insert into vote_comment (user_id, comment_id, "like") values (79, 27, true);
insert into vote_comment (user_id, comment_id, "like") values (79, 33, false);
insert into vote_comment (user_id, comment_id, "like") values (79, 84, false);
insert into vote_comment (user_id, comment_id, "like") values (79, 90, false);
insert into vote_comment (user_id, comment_id, "like") values (79, 94, false);
insert into vote_comment (user_id, comment_id, "like") values (80, 33, false);
insert into vote_comment (user_id, comment_id, "like") values (80, 43, false);
insert into vote_comment (user_id, comment_id, "like") values (80, 70, true);
insert into vote_comment (user_id, comment_id, "like") values (81, 3, false);
insert into vote_comment (user_id, comment_id, "like") values (81, 22, false);
insert into vote_comment (user_id, comment_id, "like") values (81, 53, false);
insert into vote_comment (user_id, comment_id, "like") values (81, 73, false);
insert into vote_comment (user_id, comment_id, "like") values (81, 88, true);
insert into vote_comment (user_id, comment_id, "like") values (82, 5, true);
insert into vote_comment (user_id, comment_id, "like") values (82, 41, false);
insert into vote_comment (user_id, comment_id, "like") values (82, 79, true);
insert into vote_comment (user_id, comment_id, "like") values (83, 20, false);
insert into vote_comment (user_id, comment_id, "like") values (83, 60, true);
insert into vote_comment (user_id, comment_id, "like") values (83, 67, true);
insert into vote_comment (user_id, comment_id, "like") values (83, 68, false);
insert into vote_comment (user_id, comment_id, "like") values (83, 70, false);
insert into vote_comment (user_id, comment_id, "like") values (84, 2, true);
insert into vote_comment (user_id, comment_id, "like") values (84, 3, false);
insert into vote_comment (user_id, comment_id, "like") values (84, 16, true);
insert into vote_comment (user_id, comment_id, "like") values (84, 24, true);
insert into vote_comment (user_id, comment_id, "like") values (84, 48, true);
insert into vote_comment (user_id, comment_id, "like") values (84, 62, true);
insert into vote_comment (user_id, comment_id, "like") values (84, 93, true);
insert into vote_comment (user_id, comment_id, "like") values (85, 6, true);
insert into vote_comment (user_id, comment_id, "like") values (85, 18, true);
insert into vote_comment (user_id, comment_id, "like") values (85, 95, true);
insert into vote_comment (user_id, comment_id, "like") values (86, 28, false);
insert into vote_comment (user_id, comment_id, "like") values (86, 30, false);
insert into vote_comment (user_id, comment_id, "like") values (86, 50, false);
insert into vote_comment (user_id, comment_id, "like") values (86, 62, true);
insert into vote_comment (user_id, comment_id, "like") values (86, 87, false);
insert into vote_comment (user_id, comment_id, "like") values (87, 33, false);
insert into vote_comment (user_id, comment_id, "like") values (87, 63, true);
insert into vote_comment (user_id, comment_id, "like") values (87, 72, false);
insert into vote_comment (user_id, comment_id, "like") values (87, 95, false);
insert into vote_comment (user_id, comment_id, "like") values (88, 8, true);
insert into vote_comment (user_id, comment_id, "like") values (88, 15, true);
insert into vote_comment (user_id, comment_id, "like") values (88, 36, true);
insert into vote_comment (user_id, comment_id, "like") values (88, 40, true);
insert into vote_comment (user_id, comment_id, "like") values (89, 6, false);
insert into vote_comment (user_id, comment_id, "like") values (89, 16, false);
insert into vote_comment (user_id, comment_id, "like") values (89, 18, false);
insert into vote_comment (user_id, comment_id, "like") values (89, 39, false);
insert into vote_comment (user_id, comment_id, "like") values (89, 40, true);
insert into vote_comment (user_id, comment_id, "like") values (89, 54, false);
insert into vote_comment (user_id, comment_id, "like") values (89, 88, true);
insert into vote_comment (user_id, comment_id, "like") values (89, 99, true);
insert into vote_comment (user_id, comment_id, "like") values (90, 36, true);
insert into vote_comment (user_id, comment_id, "like") values (90, 37, true);
insert into vote_comment (user_id, comment_id, "like") values (90, 59, true);
insert into vote_comment (user_id, comment_id, "like") values (90, 88, true);
insert into vote_comment (user_id, comment_id, "like") values (90, 92, true);
insert into vote_comment (user_id, comment_id, "like") values (90, 100, true);
insert into vote_comment (user_id, comment_id, "like") values (91, 42, true);
insert into vote_comment (user_id, comment_id, "like") values (91, 69, false);
insert into vote_comment (user_id, comment_id, "like") values (91, 72, false);
insert into vote_comment (user_id, comment_id, "like") values (92, 17, false);
insert into vote_comment (user_id, comment_id, "like") values (92, 21, true);
insert into vote_comment (user_id, comment_id, "like") values (92, 53, false);
insert into vote_comment (user_id, comment_id, "like") values (92, 58, true);
insert into vote_comment (user_id, comment_id, "like") values (92, 75, false);
insert into vote_comment (user_id, comment_id, "like") values (93, 78, true);
insert into vote_comment (user_id, comment_id, "like") values (93, 91, true);
insert into vote_comment (user_id, comment_id, "like") values (94, 2, false);
insert into vote_comment (user_id, comment_id, "like") values (94, 25, false);
insert into vote_comment (user_id, comment_id, "like") values (94, 74, false);
insert into vote_comment (user_id, comment_id, "like") values (94, 80, true);
insert into vote_comment (user_id, comment_id, "like") values (95, 41, false);
insert into vote_comment (user_id, comment_id, "like") values (95, 44, true);
insert into vote_comment (user_id, comment_id, "like") values (95, 42, false);
insert into vote_comment (user_id, comment_id, "like") values (95, 54, true);
insert into vote_comment (user_id, comment_id, "like") values (95, 62, true);
insert into vote_comment (user_id, comment_id, "like") values (96, 8, false);
insert into vote_comment (user_id, comment_id, "like") values (96, 29, true);
insert into vote_comment (user_id, comment_id, "like") values (96, 52, false);
insert into vote_comment (user_id, comment_id, "like") values (96, 59, false);
insert into vote_comment (user_id, comment_id, "like") values (97, 13, false);
insert into vote_comment (user_id, comment_id, "like") values (97, 59, true);
insert into vote_comment (user_id, comment_id, "like") values (97, 73, false);
insert into vote_comment (user_id, comment_id, "like") values (97, 81, true);
insert into vote_comment (user_id, comment_id, "like") values (97, 86, false);
insert into vote_comment (user_id, comment_id, "like") values (98, 23, false);
insert into vote_comment (user_id, comment_id, "like") values (98, 25, true);
insert into vote_comment (user_id, comment_id, "like") values (98, 31, true);
insert into vote_comment (user_id, comment_id, "like") values (98, 34, false);
insert into vote_comment (user_id, comment_id, "like") values (98, 53, true);
insert into vote_comment (user_id, comment_id, "like") values (98, 74, true);
insert into vote_comment (user_id, comment_id, "like") values (98, 82, true);
insert into vote_comment (user_id, comment_id, "like") values (99, 28, true);
insert into vote_comment (user_id, comment_id, "like") values (99, 64, true);
insert into vote_comment (user_id, comment_id, "like") values (99, 71, true);
insert into vote_comment (user_id, comment_id, "like") values (99, 82, true);
insert into vote_comment (user_id, comment_id, "like") values (100, 15, true);
insert into vote_comment (user_id, comment_id, "like") values (100, 19, false);
insert into vote_comment (user_id, comment_id, "like") values (100, 62, false);
insert into vote_comment (user_id, comment_id, "like") values (100, 92, false);


--block_user
INSERT INTO block_user (blocking_user, blocked_user) VALUES (16, 14);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (14, 16);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (31, 30);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (40, 43);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (63, 65);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (91, 99);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (74, 56);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (49, 67);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (67, 49);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (65, 57);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (73, 57);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (86, 57);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (7, 57);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (2, 57);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (87, 97);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (82, 97);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (79, 97);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (38, 44);
INSERT INTO block_user (blocking_user, blocked_user) VALUES (60, 44);

--follow_user
insert into follow_user (following_user, followed_user) values (1, 22);
insert into follow_user (following_user, followed_user) values (1, 57);
insert into follow_user (following_user, followed_user) values (1, 63);
insert into follow_user (following_user, followed_user) values (1, 75);
insert into follow_user (following_user, followed_user) values (1, 80);
insert into follow_user (following_user, followed_user) values (1, 85);
insert into follow_user (following_user, followed_user) values (1, 98);
insert into follow_user (following_user, followed_user) values (10, 67);
insert into follow_user (following_user, followed_user) values (10, 76);
insert into follow_user (following_user, followed_user) values (10, 82);
insert into follow_user (following_user, followed_user) values (10, 86);
insert into follow_user (following_user, followed_user) values (10, 99);
insert into follow_user (following_user, followed_user) values (100, 1);
insert into follow_user (following_user, followed_user) values (100, 24);
insert into follow_user (following_user, followed_user) values (100, 35);
insert into follow_user (following_user, followed_user) values (100, 74);
insert into follow_user (following_user, followed_user) values (100, 85);
insert into follow_user (following_user, followed_user) values (100, 92);
insert into follow_user (following_user, followed_user) values (11, 39);
insert into follow_user (following_user, followed_user) values (11, 7);
insert into follow_user (following_user, followed_user) values (11, 74);
insert into follow_user (following_user, followed_user) values (12, 10);
insert into follow_user (following_user, followed_user) values (12, 16);
insert into follow_user (following_user, followed_user) values (12, 18);
insert into follow_user (following_user, followed_user) values (12, 23);
insert into follow_user (following_user, followed_user) values (12, 64);
insert into follow_user (following_user, followed_user) values (12, 71);
insert into follow_user (following_user, followed_user) values (12, 72);
insert into follow_user (following_user, followed_user) values (12, 76);
insert into follow_user (following_user, followed_user) values (12, 87);
insert into follow_user (following_user, followed_user) values (13, 23);
insert into follow_user (following_user, followed_user) values (13, 37);
insert into follow_user (following_user, followed_user) values (13, 43);
insert into follow_user (following_user, followed_user) values (13, 44);
insert into follow_user (following_user, followed_user) values (13, 5);
insert into follow_user (following_user, followed_user) values (13, 59);
insert into follow_user (following_user, followed_user) values (13, 63);
insert into follow_user (following_user, followed_user) values (13, 64);
insert into follow_user (following_user, followed_user) values (13, 70);
insert into follow_user (following_user, followed_user) values (13, 75);
insert into follow_user (following_user, followed_user) values (13, 77);
insert into follow_user (following_user, followed_user) values (13, 89);
insert into follow_user (following_user, followed_user) values (14, 17);
insert into follow_user (following_user, followed_user) values (14, 2);
insert into follow_user (following_user, followed_user) values (14, 67);
insert into follow_user (following_user, followed_user) values (14, 68);
insert into follow_user (following_user, followed_user) values (14, 73);
insert into follow_user (following_user, followed_user) values (14, 77);
insert into follow_user (following_user, followed_user) values (14, 78);
insert into follow_user (following_user, followed_user) values (14, 87);
insert into follow_user (following_user, followed_user) values (14, 88);
insert into follow_user (following_user, followed_user) values (15, 18);
insert into follow_user (following_user, followed_user) values (15, 23);
insert into follow_user (following_user, followed_user) values (15, 25);
insert into follow_user (following_user, followed_user) values (15, 31);
insert into follow_user (following_user, followed_user) values (15, 35);
insert into follow_user (following_user, followed_user) values (15, 55);
insert into follow_user (following_user, followed_user) values (15, 70);
insert into follow_user (following_user, followed_user) values (15, 76);
insert into follow_user (following_user, followed_user) values (15, 81);
insert into follow_user (following_user, followed_user) values (15, 84);
insert into follow_user (following_user, followed_user) values (15, 98);
insert into follow_user (following_user, followed_user) values (16, 42);
insert into follow_user (following_user, followed_user) values (16, 48);
insert into follow_user (following_user, followed_user) values (16, 55);
insert into follow_user (following_user, followed_user) values (16, 56);
insert into follow_user (following_user, followed_user) values (16, 81);
insert into follow_user (following_user, followed_user) values (16, 88);
insert into follow_user (following_user, followed_user) values (16, 9);
insert into follow_user (following_user, followed_user) values (16, 96);
insert into follow_user (following_user, followed_user) values (17, 1);
insert into follow_user (following_user, followed_user) values (17, 100);
insert into follow_user (following_user, followed_user) values (17, 22);
insert into follow_user (following_user, followed_user) values (17, 27);
insert into follow_user (following_user, followed_user) values (17, 36);
insert into follow_user (following_user, followed_user) values (17, 37);
insert into follow_user (following_user, followed_user) values (17, 41);
insert into follow_user (following_user, followed_user) values (17, 49);
insert into follow_user (following_user, followed_user) values (17, 52);
insert into follow_user (following_user, followed_user) values (17, 73);
insert into follow_user (following_user, followed_user) values (17, 81);
insert into follow_user (following_user, followed_user) values (17, 91);
insert into follow_user (following_user, followed_user) values (18, 2);
insert into follow_user (following_user, followed_user) values (18, 22);
insert into follow_user (following_user, followed_user) values (18, 25);
insert into follow_user (following_user, followed_user) values (18, 30);
insert into follow_user (following_user, followed_user) values (18, 44);
insert into follow_user (following_user, followed_user) values (18, 52);
insert into follow_user (following_user, followed_user) values (18, 60);
insert into follow_user (following_user, followed_user) values (18, 79);
insert into follow_user (following_user, followed_user) values (18, 8);
insert into follow_user (following_user, followed_user) values (19, 1);
insert into follow_user (following_user, followed_user) values (19, 13);
insert into follow_user (following_user, followed_user) values (19, 17);
insert into follow_user (following_user, followed_user) values (19, 25);
insert into follow_user (following_user, followed_user) values (19, 36);
insert into follow_user (following_user, followed_user) values (19, 41);
insert into follow_user (following_user, followed_user) values (19, 46);
insert into follow_user (following_user, followed_user) values (19, 54);
insert into follow_user (following_user, followed_user) values (19, 55);
insert into follow_user (following_user, followed_user) values (19, 64);
insert into follow_user (following_user, followed_user) values (19, 92);
insert into follow_user (following_user, followed_user) values (2, 17);
insert into follow_user (following_user, followed_user) values (2, 21);
insert into follow_user (following_user, followed_user) values (2, 30);
insert into follow_user (following_user, followed_user) values (2, 36);
insert into follow_user (following_user, followed_user) values (2, 6);
insert into follow_user (following_user, followed_user) values (2, 70);
insert into follow_user (following_user, followed_user) values (2, 84);
insert into follow_user (following_user, followed_user) values (2, 85);
insert into follow_user (following_user, followed_user) values (2, 90);
insert into follow_user (following_user, followed_user) values (2, 95);
insert into follow_user (following_user, followed_user) values (20, 16);
insert into follow_user (following_user, followed_user) values (20, 24);
insert into follow_user (following_user, followed_user) values (20, 26);
insert into follow_user (following_user, followed_user) values (20, 37);
insert into follow_user (following_user, followed_user) values (20, 39);
insert into follow_user (following_user, followed_user) values (20, 40);
insert into follow_user (following_user, followed_user) values (20, 41);
insert into follow_user (following_user, followed_user) values (20, 49);
insert into follow_user (following_user, followed_user) values (20, 63);
insert into follow_user (following_user, followed_user) values (20, 66);
insert into follow_user (following_user, followed_user) values (20, 7);
insert into follow_user (following_user, followed_user) values (20, 72);
insert into follow_user (following_user, followed_user) values (20, 83);
insert into follow_user (following_user, followed_user) values (20, 85);
insert into follow_user (following_user, followed_user) values (20, 90);
insert into follow_user (following_user, followed_user) values (21, 29);
insert into follow_user (following_user, followed_user) values (21, 35);
insert into follow_user (following_user, followed_user) values (21, 4);
insert into follow_user (following_user, followed_user) values (21, 43);
insert into follow_user (following_user, followed_user) values (21, 5);
insert into follow_user (following_user, followed_user) values (21, 6);
insert into follow_user (following_user, followed_user) values (21, 65);
insert into follow_user (following_user, followed_user) values (21, 69);
insert into follow_user (following_user, followed_user) values (21, 70);
insert into follow_user (following_user, followed_user) values (21, 80);
insert into follow_user (following_user, followed_user) values (22, 20);
insert into follow_user (following_user, followed_user) values (22, 4);
insert into follow_user (following_user, followed_user) values (22, 48);
insert into follow_user (following_user, followed_user) values (22, 54);
insert into follow_user (following_user, followed_user) values (22, 58);
insert into follow_user (following_user, followed_user) values (22, 8);
insert into follow_user (following_user, followed_user) values (22, 89);
insert into follow_user (following_user, followed_user) values (22, 96);
insert into follow_user (following_user, followed_user) values (23, 4);
insert into follow_user (following_user, followed_user) values (23, 49);
insert into follow_user (following_user, followed_user) values (23, 51);
insert into follow_user (following_user, followed_user) values (23, 60);
insert into follow_user (following_user, followed_user) values (23, 9);
insert into follow_user (following_user, followed_user) values (23, 94);
insert into follow_user (following_user, followed_user) values (24, 30);
insert into follow_user (following_user, followed_user) values (24, 37);
insert into follow_user (following_user, followed_user) values (24, 4);
insert into follow_user (following_user, followed_user) values (24, 90);
insert into follow_user (following_user, followed_user) values (24, 94);
insert into follow_user (following_user, followed_user) values (25, 14);
insert into follow_user (following_user, followed_user) values (25, 2);
insert into follow_user (following_user, followed_user) values (25, 32);
insert into follow_user (following_user, followed_user) values (25, 37);
insert into follow_user (following_user, followed_user) values (25, 4);
insert into follow_user (following_user, followed_user) values (25, 40);
insert into follow_user (following_user, followed_user) values (25, 48);
insert into follow_user (following_user, followed_user) values (25, 53);
insert into follow_user (following_user, followed_user) values (25, 56);
insert into follow_user (following_user, followed_user) values (25, 59);
insert into follow_user (following_user, followed_user) values (25, 65);
insert into follow_user (following_user, followed_user) values (25, 7);
insert into follow_user (following_user, followed_user) values (25, 73);
insert into follow_user (following_user, followed_user) values (25, 8);
insert into follow_user (following_user, followed_user) values (25, 82);
insert into follow_user (following_user, followed_user) values (25, 94);
insert into follow_user (following_user, followed_user) values (26, 22);
insert into follow_user (following_user, followed_user) values (26, 3);
insert into follow_user (following_user, followed_user) values (26, 41);
insert into follow_user (following_user, followed_user) values (26, 43);
insert into follow_user (following_user, followed_user) values (26, 52);
insert into follow_user (following_user, followed_user) values (26, 56);
insert into follow_user (following_user, followed_user) values (26, 65);
insert into follow_user (following_user, followed_user) values (26, 71);
insert into follow_user (following_user, followed_user) values (27, 1);
insert into follow_user (following_user, followed_user) values (27, 12);
insert into follow_user (following_user, followed_user) values (27, 28);
insert into follow_user (following_user, followed_user) values (27, 35);
insert into follow_user (following_user, followed_user) values (27, 4);
insert into follow_user (following_user, followed_user) values (27, 5);
insert into follow_user (following_user, followed_user) values (27, 75);
insert into follow_user (following_user, followed_user) values (27, 79);
insert into follow_user (following_user, followed_user) values (27, 80);
insert into follow_user (following_user, followed_user) values (27, 84);
insert into follow_user (following_user, followed_user) values (27, 87);
insert into follow_user (following_user, followed_user) values (27, 96);
insert into follow_user (following_user, followed_user) values (28, 18);
insert into follow_user (following_user, followed_user) values (28, 24);
insert into follow_user (following_user, followed_user) values (28, 3);
insert into follow_user (following_user, followed_user) values (28, 30);
insert into follow_user (following_user, followed_user) values (28, 42);
insert into follow_user (following_user, followed_user) values (28, 47);
insert into follow_user (following_user, followed_user) values (28, 73);
insert into follow_user (following_user, followed_user) values (28, 85);
insert into follow_user (following_user, followed_user) values (28, 86);
insert into follow_user (following_user, followed_user) values (29, 13);
insert into follow_user (following_user, followed_user) values (29, 16);
insert into follow_user (following_user, followed_user) values (29, 2);
insert into follow_user (following_user, followed_user) values (29, 56);
insert into follow_user (following_user, followed_user) values (29, 62);
insert into follow_user (following_user, followed_user) values (29, 66);
insert into follow_user (following_user, followed_user) values (29, 77);
insert into follow_user (following_user, followed_user) values (29, 8);
insert into follow_user (following_user, followed_user) values (29, 89);
insert into follow_user (following_user, followed_user) values (29, 93);
insert into follow_user (following_user, followed_user) values (3, 1);
insert into follow_user (following_user, followed_user) values (3, 19);
insert into follow_user (following_user, followed_user) values (3, 32);
insert into follow_user (following_user, followed_user) values (3, 45);
insert into follow_user (following_user, followed_user) values (3, 75);
insert into follow_user (following_user, followed_user) values (30, 12);
insert into follow_user (following_user, followed_user) values (30, 29);
insert into follow_user (following_user, followed_user) values (30, 36);
insert into follow_user (following_user, followed_user) values (30, 41);
insert into follow_user (following_user, followed_user) values (30, 43);
insert into follow_user (following_user, followed_user) values (30, 48);
insert into follow_user (following_user, followed_user) values (30, 60);
insert into follow_user (following_user, followed_user) values (30, 62);
insert into follow_user (following_user, followed_user) values (30, 91);
insert into follow_user (following_user, followed_user) values (30, 93);
insert into follow_user (following_user, followed_user) values (30, 94);
insert into follow_user (following_user, followed_user) values (31, 10);
insert into follow_user (following_user, followed_user) values (31, 24);
insert into follow_user (following_user, followed_user) values (31, 43);
insert into follow_user (following_user, followed_user) values (31, 46);
insert into follow_user (following_user, followed_user) values (31, 50);
insert into follow_user (following_user, followed_user) values (31, 60);
insert into follow_user (following_user, followed_user) values (31, 74);
insert into follow_user (following_user, followed_user) values (31, 79);
insert into follow_user (following_user, followed_user) values (31, 84);
insert into follow_user (following_user, followed_user) values (32, 11);
insert into follow_user (following_user, followed_user) values (32, 12);
insert into follow_user (following_user, followed_user) values (32, 16);
insert into follow_user (following_user, followed_user) values (32, 2);
insert into follow_user (following_user, followed_user) values (32, 48);
insert into follow_user (following_user, followed_user) values (32, 52);
insert into follow_user (following_user, followed_user) values (32, 53);
insert into follow_user (following_user, followed_user) values (32, 72);
insert into follow_user (following_user, followed_user) values (32, 81);
insert into follow_user (following_user, followed_user) values (32, 84);
insert into follow_user (following_user, followed_user) values (33, 28);
insert into follow_user (following_user, followed_user) values (33, 46);
insert into follow_user (following_user, followed_user) values (33, 50);
insert into follow_user (following_user, followed_user) values (33, 52);
insert into follow_user (following_user, followed_user) values (33, 57);
insert into follow_user (following_user, followed_user) values (33, 67);
insert into follow_user (following_user, followed_user) values (33, 7);
insert into follow_user (following_user, followed_user) values (34, 10);
insert into follow_user (following_user, followed_user) values (34, 13);
insert into follow_user (following_user, followed_user) values (34, 15);
insert into follow_user (following_user, followed_user) values (34, 2);
insert into follow_user (following_user, followed_user) values (34, 30);
insert into follow_user (following_user, followed_user) values (34, 35);
insert into follow_user (following_user, followed_user) values (34, 48);
insert into follow_user (following_user, followed_user) values (34, 49);
insert into follow_user (following_user, followed_user) values (34, 51);
insert into follow_user (following_user, followed_user) values (34, 67);
insert into follow_user (following_user, followed_user) values (34, 80);
insert into follow_user (following_user, followed_user) values (34, 9);
insert into follow_user (following_user, followed_user) values (34, 91);
insert into follow_user (following_user, followed_user) values (34, 93);
insert into follow_user (following_user, followed_user) values (35, 2);
insert into follow_user (following_user, followed_user) values (35, 3);
insert into follow_user (following_user, followed_user) values (35, 36);
insert into follow_user (following_user, followed_user) values (35, 37);
insert into follow_user (following_user, followed_user) values (35, 42);
insert into follow_user (following_user, followed_user) values (35, 43);
insert into follow_user (following_user, followed_user) values (35, 60);
insert into follow_user (following_user, followed_user) values (35, 68);
insert into follow_user (following_user, followed_user) values (35, 71);
insert into follow_user (following_user, followed_user) values (35, 72);
insert into follow_user (following_user, followed_user) values (35, 76);
insert into follow_user (following_user, followed_user) values (35, 77);
insert into follow_user (following_user, followed_user) values (35, 97);
insert into follow_user (following_user, followed_user) values (36, 10);
insert into follow_user (following_user, followed_user) values (36, 34);
insert into follow_user (following_user, followed_user) values (36, 65);
insert into follow_user (following_user, followed_user) values (36, 94);
insert into follow_user (following_user, followed_user) values (36, 98);
insert into follow_user (following_user, followed_user) values (37, 19);
insert into follow_user (following_user, followed_user) values (37, 59);
insert into follow_user (following_user, followed_user) values (37, 67);
insert into follow_user (following_user, followed_user) values (37, 73);
insert into follow_user (following_user, followed_user) values (37, 85);
insert into follow_user (following_user, followed_user) values (37, 93);
insert into follow_user (following_user, followed_user) values (37, 94);
insert into follow_user (following_user, followed_user) values (37, 96);
insert into follow_user (following_user, followed_user) values (38, 11);
insert into follow_user (following_user, followed_user) values (38, 13);
insert into follow_user (following_user, followed_user) values (38, 17);
insert into follow_user (following_user, followed_user) values (38, 24);
insert into follow_user (following_user, followed_user) values (38, 26);
insert into follow_user (following_user, followed_user) values (38, 36);
insert into follow_user (following_user, followed_user) values (38, 40);
insert into follow_user (following_user, followed_user) values (39, 22);
insert into follow_user (following_user, followed_user) values (39, 34);
insert into follow_user (following_user, followed_user) values (39, 37);
insert into follow_user (following_user, followed_user) values (39, 4);
insert into follow_user (following_user, followed_user) values (39, 42);
insert into follow_user (following_user, followed_user) values (39, 49);
insert into follow_user (following_user, followed_user) values (39, 5);
insert into follow_user (following_user, followed_user) values (39, 63);
insert into follow_user (following_user, followed_user) values (39, 67);
insert into follow_user (following_user, followed_user) values (39, 69);
insert into follow_user (following_user, followed_user) values (4, 11);
insert into follow_user (following_user, followed_user) values (4, 18);
insert into follow_user (following_user, followed_user) values (4, 19);
insert into follow_user (following_user, followed_user) values (4, 30);
insert into follow_user (following_user, followed_user) values (4, 55);
insert into follow_user (following_user, followed_user) values (4, 66);
insert into follow_user (following_user, followed_user) values (4, 79);
insert into follow_user (following_user, followed_user) values (4, 87);
insert into follow_user (following_user, followed_user) values (40, 46);
insert into follow_user (following_user, followed_user) values (40, 48);
insert into follow_user (following_user, followed_user) values (40, 49);
insert into follow_user (following_user, followed_user) values (40, 51);
insert into follow_user (following_user, followed_user) values (40, 58);
insert into follow_user (following_user, followed_user) values (40, 6);
insert into follow_user (following_user, followed_user) values (41, 16);
insert into follow_user (following_user, followed_user) values (41, 4);
insert into follow_user (following_user, followed_user) values (41, 45);
insert into follow_user (following_user, followed_user) values (41, 48);
insert into follow_user (following_user, followed_user) values (41, 57);
insert into follow_user (following_user, followed_user) values (41, 66);
insert into follow_user (following_user, followed_user) values (41, 80);
insert into follow_user (following_user, followed_user) values (41, 89);
insert into follow_user (following_user, followed_user) values (41, 96);
insert into follow_user (following_user, followed_user) values (42, 10);
insert into follow_user (following_user, followed_user) values (42, 100);
insert into follow_user (following_user, followed_user) values (42, 11);
insert into follow_user (following_user, followed_user) values (42, 48);
insert into follow_user (following_user, followed_user) values (43, 100);
insert into follow_user (following_user, followed_user) values (43, 2);
insert into follow_user (following_user, followed_user) values (43, 36);
insert into follow_user (following_user, followed_user) values (43, 37);
insert into follow_user (following_user, followed_user) values (43, 51);
insert into follow_user (following_user, followed_user) values (43, 71);
insert into follow_user (following_user, followed_user) values (43, 79);
insert into follow_user (following_user, followed_user) values (44, 15);
insert into follow_user (following_user, followed_user) values (44, 29);
insert into follow_user (following_user, followed_user) values (44, 39);
insert into follow_user (following_user, followed_user) values (44, 57);
insert into follow_user (following_user, followed_user) values (44, 58);
insert into follow_user (following_user, followed_user) values (44, 6);
insert into follow_user (following_user, followed_user) values (44, 62);
insert into follow_user (following_user, followed_user) values (44, 74);
insert into follow_user (following_user, followed_user) values (44, 8);
insert into follow_user (following_user, followed_user) values (45, 1);
insert into follow_user (following_user, followed_user) values (45, 15);
insert into follow_user (following_user, followed_user) values (45, 33);
insert into follow_user (following_user, followed_user) values (45, 34);
insert into follow_user (following_user, followed_user) values (45, 65);
insert into follow_user (following_user, followed_user) values (45, 70);
insert into follow_user (following_user, followed_user) values (45, 93);
insert into follow_user (following_user, followed_user) values (46, 18);
insert into follow_user (following_user, followed_user) values (46, 35);
insert into follow_user (following_user, followed_user) values (46, 4);
insert into follow_user (following_user, followed_user) values (46, 74);
insert into follow_user (following_user, followed_user) values (46, 93);
insert into follow_user (following_user, followed_user) values (47, 13);
insert into follow_user (following_user, followed_user) values (47, 16);
insert into follow_user (following_user, followed_user) values (47, 3);
insert into follow_user (following_user, followed_user) values (47, 33);
insert into follow_user (following_user, followed_user) values (47, 35);
insert into follow_user (following_user, followed_user) values (47, 49);
insert into follow_user (following_user, followed_user) values (47, 57);
insert into follow_user (following_user, followed_user) values (47, 70);
insert into follow_user (following_user, followed_user) values (47, 78);
insert into follow_user (following_user, followed_user) values (47, 79);
insert into follow_user (following_user, followed_user) values (47, 89);
insert into follow_user (following_user, followed_user) values (48, 10);
insert into follow_user (following_user, followed_user) values (48, 17);
insert into follow_user (following_user, followed_user) values (48, 18);
insert into follow_user (following_user, followed_user) values (48, 4);
insert into follow_user (following_user, followed_user) values (48, 46);
insert into follow_user (following_user, followed_user) values (48, 62);
insert into follow_user (following_user, followed_user) values (48, 98);
insert into follow_user (following_user, followed_user) values (49, 1);
insert into follow_user (following_user, followed_user) values (49, 6);
insert into follow_user (following_user, followed_user) values (5, 1);
insert into follow_user (following_user, followed_user) values (5, 100);
insert into follow_user (following_user, followed_user) values (5, 14);
insert into follow_user (following_user, followed_user) values (5, 3);
insert into follow_user (following_user, followed_user) values (5, 52);
insert into follow_user (following_user, followed_user) values (5, 55);
insert into follow_user (following_user, followed_user) values (5, 56);
insert into follow_user (following_user, followed_user) values (5, 59);
insert into follow_user (following_user, followed_user) values (5, 64);
insert into follow_user (following_user, followed_user) values (5, 70);
insert into follow_user (following_user, followed_user) values (5, 74);
insert into follow_user (following_user, followed_user) values (5, 75);
insert into follow_user (following_user, followed_user) values (5, 99);
insert into follow_user (following_user, followed_user) values (50, 100);
insert into follow_user (following_user, followed_user) values (50, 13);
insert into follow_user (following_user, followed_user) values (50, 19);
insert into follow_user (following_user, followed_user) values (50, 20);
insert into follow_user (following_user, followed_user) values (50, 23);
insert into follow_user (following_user, followed_user) values (50, 27);
insert into follow_user (following_user, followed_user) values (50, 37);
insert into follow_user (following_user, followed_user) values (50, 48);
insert into follow_user (following_user, followed_user) values (50, 49);
insert into follow_user (following_user, followed_user) values (50, 59);
insert into follow_user (following_user, followed_user) values (50, 68);
insert into follow_user (following_user, followed_user) values (50, 74);
insert into follow_user (following_user, followed_user) values (50, 87);
insert into follow_user (following_user, followed_user) values (50, 90);
insert into follow_user (following_user, followed_user) values (50, 98);
insert into follow_user (following_user, followed_user) values (51, 12);
insert into follow_user (following_user, followed_user) values (51, 3);
insert into follow_user (following_user, followed_user) values (51, 5);
insert into follow_user (following_user, followed_user) values (51, 55);
insert into follow_user (following_user, followed_user) values (51, 64);
insert into follow_user (following_user, followed_user) values (51, 68);
insert into follow_user (following_user, followed_user) values (51, 79);
insert into follow_user (following_user, followed_user) values (51, 86);
insert into follow_user (following_user, followed_user) values (51, 9);
insert into follow_user (following_user, followed_user) values (51, 90);
insert into follow_user (following_user, followed_user) values (51, 93);
insert into follow_user (following_user, followed_user) values (52, 25);
insert into follow_user (following_user, followed_user) values (52, 29);
insert into follow_user (following_user, followed_user) values (52, 3);
insert into follow_user (following_user, followed_user) values (52, 37);
insert into follow_user (following_user, followed_user) values (52, 4);
insert into follow_user (following_user, followed_user) values (52, 50);
insert into follow_user (following_user, followed_user) values (52, 54);
insert into follow_user (following_user, followed_user) values (52, 60);
insert into follow_user (following_user, followed_user) values (52, 85);
insert into follow_user (following_user, followed_user) values (53, 19);
insert into follow_user (following_user, followed_user) values (53, 2);
insert into follow_user (following_user, followed_user) values (53, 3);
insert into follow_user (following_user, followed_user) values (53, 36);
insert into follow_user (following_user, followed_user) values (53, 4);
insert into follow_user (following_user, followed_user) values (53, 55);
insert into follow_user (following_user, followed_user) values (53, 60);
insert into follow_user (following_user, followed_user) values (53, 61);
insert into follow_user (following_user, followed_user) values (53, 70);
insert into follow_user (following_user, followed_user) values (53, 75);
insert into follow_user (following_user, followed_user) values (53, 9);
insert into follow_user (following_user, followed_user) values (53, 99);
insert into follow_user (following_user, followed_user) values (54, 16);
insert into follow_user (following_user, followed_user) values (54, 17);
insert into follow_user (following_user, followed_user) values (54, 3);
insert into follow_user (following_user, followed_user) values (54, 5);
insert into follow_user (following_user, followed_user) values (54, 51);
insert into follow_user (following_user, followed_user) values (54, 60);
insert into follow_user (following_user, followed_user) values (54, 88);
insert into follow_user (following_user, followed_user) values (54, 9);
insert into follow_user (following_user, followed_user) values (54, 98);
insert into follow_user (following_user, followed_user) values (55, 100);
insert into follow_user (following_user, followed_user) values (55, 14);
insert into follow_user (following_user, followed_user) values (55, 25);
insert into follow_user (following_user, followed_user) values (55, 34);
insert into follow_user (following_user, followed_user) values (55, 38);
insert into follow_user (following_user, followed_user) values (55, 40);
insert into follow_user (following_user, followed_user) values (55, 45);
insert into follow_user (following_user, followed_user) values (55, 69);
insert into follow_user (following_user, followed_user) values (55, 82);
insert into follow_user (following_user, followed_user) values (56, 13);
insert into follow_user (following_user, followed_user) values (56, 17);
insert into follow_user (following_user, followed_user) values (56, 28);
insert into follow_user (following_user, followed_user) values (56, 33);
insert into follow_user (following_user, followed_user) values (56, 64);
insert into follow_user (following_user, followed_user) values (56, 80);
insert into follow_user (following_user, followed_user) values (56, 85);
insert into follow_user (following_user, followed_user) values (56, 91);
insert into follow_user (following_user, followed_user) values (56, 96);
insert into follow_user (following_user, followed_user) values (57, 10);
insert into follow_user (following_user, followed_user) values (57, 16);
insert into follow_user (following_user, followed_user) values (57, 45);
insert into follow_user (following_user, followed_user) values (57, 59);
insert into follow_user (following_user, followed_user) values (57, 60);
insert into follow_user (following_user, followed_user) values (57, 82);
insert into follow_user (following_user, followed_user) values (57, 99);
insert into follow_user (following_user, followed_user) values (58, 17);
insert into follow_user (following_user, followed_user) values (58, 2);
insert into follow_user (following_user, followed_user) values (58, 34);
insert into follow_user (following_user, followed_user) values (58, 39);
insert into follow_user (following_user, followed_user) values (58, 52);
insert into follow_user (following_user, followed_user) values (58, 53);
insert into follow_user (following_user, followed_user) values (58, 54);
insert into follow_user (following_user, followed_user) values (58, 56);
insert into follow_user (following_user, followed_user) values (58, 60);
insert into follow_user (following_user, followed_user) values (58, 65);
insert into follow_user (following_user, followed_user) values (58, 70);
insert into follow_user (following_user, followed_user) values (58, 79);
insert into follow_user (following_user, followed_user) values (58, 80);
insert into follow_user (following_user, followed_user) values (59, 20);
insert into follow_user (following_user, followed_user) values (59, 28);
insert into follow_user (following_user, followed_user) values (59, 3);
insert into follow_user (following_user, followed_user) values (59, 30);
insert into follow_user (following_user, followed_user) values (59, 39);
insert into follow_user (following_user, followed_user) values (59, 46);
insert into follow_user (following_user, followed_user) values (59, 49);
insert into follow_user (following_user, followed_user) values (59, 88);
insert into follow_user (following_user, followed_user) values (6, 10);
insert into follow_user (following_user, followed_user) values (6, 12);
insert into follow_user (following_user, followed_user) values (6, 14);
insert into follow_user (following_user, followed_user) values (6, 27);
insert into follow_user (following_user, followed_user) values (6, 36);
insert into follow_user (following_user, followed_user) values (6, 47);
insert into follow_user (following_user, followed_user) values (6, 51);
insert into follow_user (following_user, followed_user) values (6, 56);
insert into follow_user (following_user, followed_user) values (6, 68);
insert into follow_user (following_user, followed_user) values (6, 7);
insert into follow_user (following_user, followed_user) values (6, 78);
insert into follow_user (following_user, followed_user) values (6, 82);
insert into follow_user (following_user, followed_user) values (6, 87);
insert into follow_user (following_user, followed_user) values (60, 37);
insert into follow_user (following_user, followed_user) values (60, 4);
insert into follow_user (following_user, followed_user) values (60, 42);
insert into follow_user (following_user, followed_user) values (60, 51);
insert into follow_user (following_user, followed_user) values (60, 62);
insert into follow_user (following_user, followed_user) values (60, 71);
insert into follow_user (following_user, followed_user) values (60, 79);
insert into follow_user (following_user, followed_user) values (60, 93);
insert into follow_user (following_user, followed_user) values (61, 1);
insert into follow_user (following_user, followed_user) values (61, 11);
insert into follow_user (following_user, followed_user) values (61, 25);
insert into follow_user (following_user, followed_user) values (61, 31);
insert into follow_user (following_user, followed_user) values (61, 4);
insert into follow_user (following_user, followed_user) values (61, 56);
insert into follow_user (following_user, followed_user) values (61, 58);
insert into follow_user (following_user, followed_user) values (61, 65);
insert into follow_user (following_user, followed_user) values (61, 69);
insert into follow_user (following_user, followed_user) values (61, 72);
insert into follow_user (following_user, followed_user) values (61, 73);
insert into follow_user (following_user, followed_user) values (61, 75);
insert into follow_user (following_user, followed_user) values (61, 80);
insert into follow_user (following_user, followed_user) values (61, 84);
insert into follow_user (following_user, followed_user) values (62, 12);
insert into follow_user (following_user, followed_user) values (62, 13);
insert into follow_user (following_user, followed_user) values (62, 18);
insert into follow_user (following_user, followed_user) values (62, 36);
insert into follow_user (following_user, followed_user) values (62, 4);
insert into follow_user (following_user, followed_user) values (62, 41);
insert into follow_user (following_user, followed_user) values (62, 52);
insert into follow_user (following_user, followed_user) values (62, 65);
insert into follow_user (following_user, followed_user) values (62, 73);
insert into follow_user (following_user, followed_user) values (62, 82);
insert into follow_user (following_user, followed_user) values (63, 10);
insert into follow_user (following_user, followed_user) values (63, 16);
insert into follow_user (following_user, followed_user) values (63, 18);
insert into follow_user (following_user, followed_user) values (63, 19);
insert into follow_user (following_user, followed_user) values (63, 32);
insert into follow_user (following_user, followed_user) values (63, 51);
insert into follow_user (following_user, followed_user) values (63, 53);
insert into follow_user (following_user, followed_user) values (63, 54);
insert into follow_user (following_user, followed_user) values (63, 55);
insert into follow_user (following_user, followed_user) values (63, 71);
insert into follow_user (following_user, followed_user) values (63, 9);
insert into follow_user (following_user, followed_user) values (64, 1);
insert into follow_user (following_user, followed_user) values (64, 47);
insert into follow_user (following_user, followed_user) values (64, 53);
insert into follow_user (following_user, followed_user) values (64, 6);
insert into follow_user (following_user, followed_user) values (64, 62);
insert into follow_user (following_user, followed_user) values (64, 78);
insert into follow_user (following_user, followed_user) values (64, 90);
insert into follow_user (following_user, followed_user) values (64, 97);
insert into follow_user (following_user, followed_user) values (65, 18);
insert into follow_user (following_user, followed_user) values (65, 22);
insert into follow_user (following_user, followed_user) values (65, 47);
insert into follow_user (following_user, followed_user) values (65, 55);
insert into follow_user (following_user, followed_user) values (65, 57);
insert into follow_user (following_user, followed_user) values (65, 64);
insert into follow_user (following_user, followed_user) values (65, 68);
insert into follow_user (following_user, followed_user) values (65, 70);
insert into follow_user (following_user, followed_user) values (65, 72);
insert into follow_user (following_user, followed_user) values (65, 73);
insert into follow_user (following_user, followed_user) values (65, 9);
insert into follow_user (following_user, followed_user) values (66, 14);
insert into follow_user (following_user, followed_user) values (66, 26);
insert into follow_user (following_user, followed_user) values (66, 27);
insert into follow_user (following_user, followed_user) values (66, 40);
insert into follow_user (following_user, followed_user) values (66, 57);
insert into follow_user (following_user, followed_user) values (66, 69);
insert into follow_user (following_user, followed_user) values (66, 75);
insert into follow_user (following_user, followed_user) values (66, 87);
insert into follow_user (following_user, followed_user) values (66, 9);
insert into follow_user (following_user, followed_user) values (66, 90);
insert into follow_user (following_user, followed_user) values (67, 43);
insert into follow_user (following_user, followed_user) values (67, 54);
insert into follow_user (following_user, followed_user) values (67, 65);
insert into follow_user (following_user, followed_user) values (67, 66);
insert into follow_user (following_user, followed_user) values (67, 74);
insert into follow_user (following_user, followed_user) values (67, 77);
insert into follow_user (following_user, followed_user) values (67, 80);
insert into follow_user (following_user, followed_user) values (67, 88);
insert into follow_user (following_user, followed_user) values (67, 91);
insert into follow_user (following_user, followed_user) values (67, 95);
insert into follow_user (following_user, followed_user) values (68, 1);
insert into follow_user (following_user, followed_user) values (68, 10);
insert into follow_user (following_user, followed_user) values (68, 18);
insert into follow_user (following_user, followed_user) values (68, 36);
insert into follow_user (following_user, followed_user) values (68, 53);
insert into follow_user (following_user, followed_user) values (68, 60);
insert into follow_user (following_user, followed_user) values (68, 66);
insert into follow_user (following_user, followed_user) values (68, 80);
insert into follow_user (following_user, followed_user) values (68, 95);
insert into follow_user (following_user, followed_user) values (68, 98);
insert into follow_user (following_user, followed_user) values (69, 11);
insert into follow_user (following_user, followed_user) values (69, 24);
insert into follow_user (following_user, followed_user) values (69, 29);
insert into follow_user (following_user, followed_user) values (69, 32);
insert into follow_user (following_user, followed_user) values (69, 45);
insert into follow_user (following_user, followed_user) values (69, 53);
insert into follow_user (following_user, followed_user) values (69, 67);
insert into follow_user (following_user, followed_user) values (69, 68);
insert into follow_user (following_user, followed_user) values (69, 85);
insert into follow_user (following_user, followed_user) values (69, 86);
insert into follow_user (following_user, followed_user) values (69, 87);
insert into follow_user (following_user, followed_user) values (69, 88);
insert into follow_user (following_user, followed_user) values (7, 1);
insert into follow_user (following_user, followed_user) values (7, 16);
insert into follow_user (following_user, followed_user) values (7, 2);
insert into follow_user (following_user, followed_user) values (7, 24);
insert into follow_user (following_user, followed_user) values (7, 54);
insert into follow_user (following_user, followed_user) values (7, 75);
insert into follow_user (following_user, followed_user) values (70, 16);
insert into follow_user (following_user, followed_user) values (70, 29);
insert into follow_user (following_user, followed_user) values (70, 33);
insert into follow_user (following_user, followed_user) values (70, 52);
insert into follow_user (following_user, followed_user) values (70, 55);
insert into follow_user (following_user, followed_user) values (70, 89);
insert into follow_user (following_user, followed_user) values (71, 2);
insert into follow_user (following_user, followed_user) values (71, 27);
insert into follow_user (following_user, followed_user) values (71, 28);
insert into follow_user (following_user, followed_user) values (71, 30);
insert into follow_user (following_user, followed_user) values (71, 36);
insert into follow_user (following_user, followed_user) values (71, 38);
insert into follow_user (following_user, followed_user) values (71, 4);
insert into follow_user (following_user, followed_user) values (71, 52);
insert into follow_user (following_user, followed_user) values (71, 6);
insert into follow_user (following_user, followed_user) values (71, 73);
insert into follow_user (following_user, followed_user) values (71, 85);
insert into follow_user (following_user, followed_user) values (71, 90);
insert into follow_user (following_user, followed_user) values (72, 13);
insert into follow_user (following_user, followed_user) values (72, 16);
insert into follow_user (following_user, followed_user) values (72, 18);
insert into follow_user (following_user, followed_user) values (72, 2);
insert into follow_user (following_user, followed_user) values (72, 21);
insert into follow_user (following_user, followed_user) values (72, 26);
insert into follow_user (following_user, followed_user) values (72, 41);
insert into follow_user (following_user, followed_user) values (72, 5);
insert into follow_user (following_user, followed_user) values (72, 60);
insert into follow_user (following_user, followed_user) values (72, 71);
insert into follow_user (following_user, followed_user) values (72, 73);
insert into follow_user (following_user, followed_user) values (73, 30);
insert into follow_user (following_user, followed_user) values (73, 55);
insert into follow_user (following_user, followed_user) values (73, 67);
insert into follow_user (following_user, followed_user) values (73, 69);
insert into follow_user (following_user, followed_user) values (73, 78);
insert into follow_user (following_user, followed_user) values (73, 83);
insert into follow_user (following_user, followed_user) values (74, 21);
insert into follow_user (following_user, followed_user) values (74, 49);
insert into follow_user (following_user, followed_user) values (74, 58);
insert into follow_user (following_user, followed_user) values (74, 69);
insert into follow_user (following_user, followed_user) values (74, 81);
insert into follow_user (following_user, followed_user) values (74, 92);
insert into follow_user (following_user, followed_user) values (74, 98);
insert into follow_user (following_user, followed_user) values (75, 32);
insert into follow_user (following_user, followed_user) values (75, 52);
insert into follow_user (following_user, followed_user) values (75, 83);
insert into follow_user (following_user, followed_user) values (75, 94);
insert into follow_user (following_user, followed_user) values (75, 95);
insert into follow_user (following_user, followed_user) values (76, 13);
insert into follow_user (following_user, followed_user) values (76, 14);
insert into follow_user (following_user, followed_user) values (76, 32);
insert into follow_user (following_user, followed_user) values (76, 33);
insert into follow_user (following_user, followed_user) values (76, 37);
insert into follow_user (following_user, followed_user) values (76, 40);
insert into follow_user (following_user, followed_user) values (76, 5);
insert into follow_user (following_user, followed_user) values (76, 54);
insert into follow_user (following_user, followed_user) values (76, 57);
insert into follow_user (following_user, followed_user) values (76, 69);
insert into follow_user (following_user, followed_user) values (76, 75);
insert into follow_user (following_user, followed_user) values (76, 88);
insert into follow_user (following_user, followed_user) values (76, 97);
insert into follow_user (following_user, followed_user) values (77, 2);
insert into follow_user (following_user, followed_user) values (77, 23);
insert into follow_user (following_user, followed_user) values (77, 33);
insert into follow_user (following_user, followed_user) values (77, 39);
insert into follow_user (following_user, followed_user) values (77, 46);
insert into follow_user (following_user, followed_user) values (77, 56);
insert into follow_user (following_user, followed_user) values (77, 65);
insert into follow_user (following_user, followed_user) values (77, 81);
insert into follow_user (following_user, followed_user) values (77, 94);
insert into follow_user (following_user, followed_user) values (78, 11);
insert into follow_user (following_user, followed_user) values (78, 18);
insert into follow_user (following_user, followed_user) values (78, 37);
insert into follow_user (following_user, followed_user) values (78, 41);
insert into follow_user (following_user, followed_user) values (78, 49);
insert into follow_user (following_user, followed_user) values (78, 53);
insert into follow_user (following_user, followed_user) values (78, 56);
insert into follow_user (following_user, followed_user) values (78, 59);
insert into follow_user (following_user, followed_user) values (78, 65);
insert into follow_user (following_user, followed_user) values (78, 8);
insert into follow_user (following_user, followed_user) values (78, 86);
insert into follow_user (following_user, followed_user) values (79, 12);
insert into follow_user (following_user, followed_user) values (79, 20);
insert into follow_user (following_user, followed_user) values (79, 24);
insert into follow_user (following_user, followed_user) values (79, 33);
insert into follow_user (following_user, followed_user) values (79, 38);
insert into follow_user (following_user, followed_user) values (79, 39);
insert into follow_user (following_user, followed_user) values (79, 40);
insert into follow_user (following_user, followed_user) values (79, 46);
insert into follow_user (following_user, followed_user) values (79, 50);
insert into follow_user (following_user, followed_user) values (79, 57);
insert into follow_user (following_user, followed_user) values (79, 59);
insert into follow_user (following_user, followed_user) values (79, 61);
insert into follow_user (following_user, followed_user) values (79, 63);
insert into follow_user (following_user, followed_user) values (79, 71);
insert into follow_user (following_user, followed_user) values (79, 95);
insert into follow_user (following_user, followed_user) values (79, 97);
insert into follow_user (following_user, followed_user) values (8, 13);
insert into follow_user (following_user, followed_user) values (8, 27);
insert into follow_user (following_user, followed_user) values (8, 35);
insert into follow_user (following_user, followed_user) values (8, 46);
insert into follow_user (following_user, followed_user) values (8, 56);
insert into follow_user (following_user, followed_user) values (8, 7);
insert into follow_user (following_user, followed_user) values (8, 79);
insert into follow_user (following_user, followed_user) values (8, 95);
insert into follow_user (following_user, followed_user) values (8, 97);
insert into follow_user (following_user, followed_user) values (80, 29);
insert into follow_user (following_user, followed_user) values (80, 60);
insert into follow_user (following_user, followed_user) values (80, 72);
insert into follow_user (following_user, followed_user) values (80, 73);
insert into follow_user (following_user, followed_user) values (80, 78);
insert into follow_user (following_user, followed_user) values (80, 81);
insert into follow_user (following_user, followed_user) values (80, 83);
insert into follow_user (following_user, followed_user) values (80, 89);
insert into follow_user (following_user, followed_user) values (80, 94);
insert into follow_user (following_user, followed_user) values (81, 1);
insert into follow_user (following_user, followed_user) values (81, 10);
insert into follow_user (following_user, followed_user) values (81, 18);
insert into follow_user (following_user, followed_user) values (81, 49);
insert into follow_user (following_user, followed_user) values (81, 61);
insert into follow_user (following_user, followed_user) values (81, 69);
insert into follow_user (following_user, followed_user) values (81, 70);
insert into follow_user (following_user, followed_user) values (81, 71);
insert into follow_user (following_user, followed_user) values (81, 76);
insert into follow_user (following_user, followed_user) values (81, 78);
insert into follow_user (following_user, followed_user) values (81, 82);
insert into follow_user (following_user, followed_user) values (81, 87);
insert into follow_user (following_user, followed_user) values (81, 9);
insert into follow_user (following_user, followed_user) values (81, 96);
insert into follow_user (following_user, followed_user) values (82, 22);
insert into follow_user (following_user, followed_user) values (82, 39);
insert into follow_user (following_user, followed_user) values (82, 40);
insert into follow_user (following_user, followed_user) values (82, 49);
insert into follow_user (following_user, followed_user) values (82, 54);
insert into follow_user (following_user, followed_user) values (82, 59);
insert into follow_user (following_user, followed_user) values (82, 71);
insert into follow_user (following_user, followed_user) values (82, 94);
insert into follow_user (following_user, followed_user) values (82, 97);
insert into follow_user (following_user, followed_user) values (83, 29);
insert into follow_user (following_user, followed_user) values (83, 35);
insert into follow_user (following_user, followed_user) values (83, 40);
insert into follow_user (following_user, followed_user) values (83, 47);
insert into follow_user (following_user, followed_user) values (83, 48);
insert into follow_user (following_user, followed_user) values (83, 5);
insert into follow_user (following_user, followed_user) values (83, 50);
insert into follow_user (following_user, followed_user) values (83, 51);
insert into follow_user (following_user, followed_user) values (83, 57);
insert into follow_user (following_user, followed_user) values (83, 59);
insert into follow_user (following_user, followed_user) values (83, 63);
insert into follow_user (following_user, followed_user) values (84, 100);
insert into follow_user (following_user, followed_user) values (84, 19);
insert into follow_user (following_user, followed_user) values (84, 21);
insert into follow_user (following_user, followed_user) values (84, 28);
insert into follow_user (following_user, followed_user) values (84, 4);
insert into follow_user (following_user, followed_user) values (84, 88);
insert into follow_user (following_user, followed_user) values (84, 9);
insert into follow_user (following_user, followed_user) values (85, 13);
insert into follow_user (following_user, followed_user) values (85, 17);
insert into follow_user (following_user, followed_user) values (85, 27);
insert into follow_user (following_user, followed_user) values (85, 34);
insert into follow_user (following_user, followed_user) values (85, 43);
insert into follow_user (following_user, followed_user) values (85, 46);
insert into follow_user (following_user, followed_user) values (85, 49);
insert into follow_user (following_user, followed_user) values (85, 5);
insert into follow_user (following_user, followed_user) values (85, 53);
insert into follow_user (following_user, followed_user) values (85, 89);
insert into follow_user (following_user, followed_user) values (85, 90);
insert into follow_user (following_user, followed_user) values (85, 97);
insert into follow_user (following_user, followed_user) values (86, 16);
insert into follow_user (following_user, followed_user) values (86, 18);
insert into follow_user (following_user, followed_user) values (86, 19);
insert into follow_user (following_user, followed_user) values (86, 21);
insert into follow_user (following_user, followed_user) values (86, 34);
insert into follow_user (following_user, followed_user) values (86, 73);
insert into follow_user (following_user, followed_user) values (87, 30);
insert into follow_user (following_user, followed_user) values (87, 33);
insert into follow_user (following_user, followed_user) values (87, 56);
insert into follow_user (following_user, followed_user) values (88, 13);
insert into follow_user (following_user, followed_user) values (88, 22);
insert into follow_user (following_user, followed_user) values (88, 62);
insert into follow_user (following_user, followed_user) values (88, 75);
insert into follow_user (following_user, followed_user) values (88, 87);
insert into follow_user (following_user, followed_user) values (89, 15);
insert into follow_user (following_user, followed_user) values (89, 48);
insert into follow_user (following_user, followed_user) values (89, 51);
insert into follow_user (following_user, followed_user) values (89, 53);
insert into follow_user (following_user, followed_user) values (89, 55);
insert into follow_user (following_user, followed_user) values (89, 58);
insert into follow_user (following_user, followed_user) values (89, 73);
insert into follow_user (following_user, followed_user) values (89, 76);
insert into follow_user (following_user, followed_user) values (89, 8);
insert into follow_user (following_user, followed_user) values (89, 84);
insert into follow_user (following_user, followed_user) values (89, 96);
insert into follow_user (following_user, followed_user) values (89, 97);
insert into follow_user (following_user, followed_user) values (9, 1);
insert into follow_user (following_user, followed_user) values (9, 29);
insert into follow_user (following_user, followed_user) values (9, 32);
insert into follow_user (following_user, followed_user) values (9, 35);
insert into follow_user (following_user, followed_user) values (9, 58);
insert into follow_user (following_user, followed_user) values (9, 59);
insert into follow_user (following_user, followed_user) values (9, 60);
insert into follow_user (following_user, followed_user) values (9, 95);
insert into follow_user (following_user, followed_user) values (90, 26);
insert into follow_user (following_user, followed_user) values (90, 30);
insert into follow_user (following_user, followed_user) values (90, 36);
insert into follow_user (following_user, followed_user) values (90, 37);
insert into follow_user (following_user, followed_user) values (90, 57);
insert into follow_user (following_user, followed_user) values (90, 58);
insert into follow_user (following_user, followed_user) values (90, 62);
insert into follow_user (following_user, followed_user) values (90, 70);
insert into follow_user (following_user, followed_user) values (90, 83);
insert into follow_user (following_user, followed_user) values (90, 95);
insert into follow_user (following_user, followed_user) values (91, 21);
insert into follow_user (following_user, followed_user) values (91, 40);
insert into follow_user (following_user, followed_user) values (91, 41);
insert into follow_user (following_user, followed_user) values (91, 54);
insert into follow_user (following_user, followed_user) values (91, 58);
insert into follow_user (following_user, followed_user) values (91, 61);
insert into follow_user (following_user, followed_user) values (91, 68);
insert into follow_user (following_user, followed_user) values (91, 75);
insert into follow_user (following_user, followed_user) values (91, 93);
insert into follow_user (following_user, followed_user) values (92, 18);
insert into follow_user (following_user, followed_user) values (92, 45);
insert into follow_user (following_user, followed_user) values (92, 68);
insert into follow_user (following_user, followed_user) values (93, 10);
insert into follow_user (following_user, followed_user) values (93, 12);
insert into follow_user (following_user, followed_user) values (93, 16);
insert into follow_user (following_user, followed_user) values (93, 2);
insert into follow_user (following_user, followed_user) values (93, 27);
insert into follow_user (following_user, followed_user) values (93, 38);
insert into follow_user (following_user, followed_user) values (93, 7);
insert into follow_user (following_user, followed_user) values (94, 1);
insert into follow_user (following_user, followed_user) values (94, 16);
insert into follow_user (following_user, followed_user) values (94, 47);
insert into follow_user (following_user, followed_user) values (94, 49);
insert into follow_user (following_user, followed_user) values (94, 56);
insert into follow_user (following_user, followed_user) values (94, 63);
insert into follow_user (following_user, followed_user) values (95, 12);
insert into follow_user (following_user, followed_user) values (95, 17);
insert into follow_user (following_user, followed_user) values (95, 27);
insert into follow_user (following_user, followed_user) values (95, 47);
insert into follow_user (following_user, followed_user) values (95, 48);
insert into follow_user (following_user, followed_user) values (95, 59);
insert into follow_user (following_user, followed_user) values (95, 62);
insert into follow_user (following_user, followed_user) values (95, 66);
insert into follow_user (following_user, followed_user) values (95, 82);
insert into follow_user (following_user, followed_user) values (95, 85);
insert into follow_user (following_user, followed_user) values (96, 28);
insert into follow_user (following_user, followed_user) values (96, 32);
insert into follow_user (following_user, followed_user) values (96, 33);
insert into follow_user (following_user, followed_user) values (96, 64);
insert into follow_user (following_user, followed_user) values (96, 66);
insert into follow_user (following_user, followed_user) values (96, 73);
insert into follow_user (following_user, followed_user) values (96, 85);
insert into follow_user (following_user, followed_user) values (96, 90);
insert into follow_user (following_user, followed_user) values (96, 98);
insert into follow_user (following_user, followed_user) values (97, 100);
insert into follow_user (following_user, followed_user) values (97, 22);
insert into follow_user (following_user, followed_user) values (97, 42);
insert into follow_user (following_user, followed_user) values (97, 45);
insert into follow_user (following_user, followed_user) values (97, 50);
insert into follow_user (following_user, followed_user) values (97, 68);
insert into follow_user (following_user, followed_user) values (97, 7);
insert into follow_user (following_user, followed_user) values (97, 87);
insert into follow_user (following_user, followed_user) values (98, 10);
insert into follow_user (following_user, followed_user) values (98, 100);
insert into follow_user (following_user, followed_user) values (98, 12);
insert into follow_user (following_user, followed_user) values (98, 18);
insert into follow_user (following_user, followed_user) values (98, 23);
insert into follow_user (following_user, followed_user) values (98, 31);
insert into follow_user (following_user, followed_user) values (98, 41);
insert into follow_user (following_user, followed_user) values (98, 87);
insert into follow_user (following_user, followed_user) values (98, 93);
insert into follow_user (following_user, followed_user) values (99, 18);
insert into follow_user (following_user, followed_user) values (99, 2);
insert into follow_user (following_user, followed_user) values (99, 32);
insert into follow_user (following_user, followed_user) values (99, 35);
insert into follow_user (following_user, followed_user) values (99, 83);



--REPORT
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-05-30', false, '2020-06-30', 'Fake news', 26, 10, NULL, 5);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-12-14', false, '2020-12-20', 'Innapropriate content', 77, NULL, NULL, 18);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-03-09', false, '2020-04-20', 'Innapropriate content', 25, 53, 27, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-10-07', false, '2020-10-11', 'Fake news', 72, 78, 1, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-12-11', false, NULL, 'Abusive content', 36, 61, 16, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-03-14', false, '2020-03-25', 'Other', 38, 36, 35, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2021-02-24', false, NULL, 'Hate speech', 16, NULL, 37, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-08-29', false, NULL, 'Fake news', 90, NULL, 51, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2021-01-04', false, NULL, 'Other', 18, NULL, 81, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2021-03-19', false, '2021-03-28', 'Abusive content', 84, 74, 61, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-02-09', false, NULL, 'Innapropriate content', 52, NULL, 21, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-12-08', false, '2020-12-20', 'Other', 92, 49, NULL,  67);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-02-29', false, NULL, 'Other', 96, NULL, 76, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-05-29', false, NULL, 'Other', 42, NULL, 80, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-03-24', false, NULL, 'Fake news', 34, NULL, 58, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-07-28', false, NULL, 'Other', 29, NULL, 84, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-05-29', false, '2020-06-05', 'Other', 82, 19, 93, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-10-05', false, '2020-10-09', 'Other', 46, 34, NULL, 31);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-12-23', false, '2020-12-30', 'Abusive content', 64, 45, 100, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-06-07', false, NULL, 'Fake news', 5, NULL, 69, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-02-17', false, NULL, 'Hate speech', 85, NULL, 18, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2021-03-07', false, NULL, 'Other', 89, NULL, 108, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-06-19', false, '2020-06-20', 'Other', 40, 23, 116, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-07-22', false, '2020-07-25', 'Other', 92, 21, NULL, 97);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-01-30', false, NULL,'Other', 11, NULL, 122, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2021-01-16', false, NULL, 'Fake news', 55, NULL, 130, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-09-04', false, '2020-09-18', 'Abusive content', 59, 7, 152,NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-10-27', false, '2020-10-30', 'Other', 95, 7, 150, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-04-21', false, '2020-04-27', 'Innapropriate content', 59, 7, 156, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-09-19', false, '2020-09-22', 'Hate speech', 66, 51, NULL, 96);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-02-03', false, '2020-02-20', 'Other', 1, 8, 167, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-06-22', false, '2020-06-28', 'Innapropriate content', 96, 8, 174, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2021-03-27', false, NULL,'Other', 42, NULL, 182, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-06-30', false, NULL, 'Other', 73, NULL, 188, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-01-31', false, '2020-02-15','Hate speech', 98, 21, NULL, 96);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-03-21', false, NULL, 'Other', 40, NULL, 198, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2021-03-25', false, '2021-03-29', 'Abusive content', 78, 23, 152, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-09-14', false, '2020-09-17', 'Other', 64, 34, 188, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-06-26', false, NULL,'Other', 8, NULL, 188, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-07-26', false, NULL, 'Fake news', 8, NULL, 69, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-11-29', false, '2020-12-05','Hate speech', 60, 75, NULL, 66);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-08-12', false, '2020-08-20', 'Innapropriate content', 79, 77, 174, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-04-15', false, '2020-04-20', 'Other', 46, 91, 188, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-05-18', false, NULL, 'Other', 66, NULL, 188, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2021-01-16', false, '2021-01-20', 'Other', 42, 93, 188, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-07-10', false, NULL, 'Hate speech', 79, NULL, 188, NULL);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2021-01-23', false, '2021-03-24', 'Hate speech', 83, 88, NULL, 93);
insert into report (reported_date, accepted, closed_date, motive, user_reporting, user_assigned, post_reported, comment_reported) values ('2020-02-24', false, NULL, 'Other', 98, NULL, 156, NULL);

-- notifications are generated automatically using triggers
