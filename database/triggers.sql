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
  

