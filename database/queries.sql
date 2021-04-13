--------------------------> CREATE QUERIES

---> Posts order by publication date as a visitor
SELECT title, thumbnail, content, is_spoiler, created_at, n_views, category, post.user_id, n_likes
FROM post, (SELECT post_id, COUNT(user_id) AS n_likes
FROM vote_post
WHERE vote_post.like
GROUP BY post_id
union
SELECT id AS post_id, 0 AS n_likes
FROM post
WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = true AND vote_post.post_id = post.id)) AS likes_post
WHERE likes_post.post_id = post.id
ORDER BY created_at DESC; 

---> Posts order by number of likes (user is authenticated)
SELECT DISTINCT title, thumbnail, content, is_spoiler, created_at, n_views, category, post.user_id, n_likes
FROM post, block_user, (SELECT post_id, COUNT(user_id) AS n_likes
FROM vote_post WHERE vote_post.like GROUP BY post_id
union
SELECT id AS post_id, 0 AS n_likes
FROM post WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = true AND vote_post.post_id = post.id)) AS likes_post
WHERE likes_post.post_id = post.id AND post.user_id NOT IN (SELECT blocked_user FROM block_user WHERE blocking_user = 3) AND post.user_id NOT IN (SELECT blocking_user FROM block_user WHERE blocked_user = 3)
ORDER BY created_at DESC; 

---> Category's posts 
SELECT title, thumbnail, content, is_spoiler, created_at, n_views, category, post.user_id, n_likes
FROM post, (SELECT post_id, COUNT(user_id) AS n_likes
FROM vote_post
WHERE vote_post.like
GROUP BY post_id
union
SELECT id AS post_id, 0 AS n_likes
FROM post
WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = true AND vote_post.post_id = post.id)) AS likes_post
WHERE likes_post.post_id = post.id AND category = $category
ORDER BY created_at DESC; 

---> User's posts 
SELECT title, thumbnail, content, is_spoiler, created_at, n_views, category, post.user_id, n_likes
FROM post, (SELECT post_id, COUNT(user_id) AS n_likes
FROM vote_post
WHERE vote_post.like
GROUP BY post_id
union
SELECT id AS post_id, 0 AS n_likes
FROM post
WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = true AND vote_post.post_id = post.id)) AS likes_post
WHERE likes_post.post_id = post.id AND post.user_id = $user_id
ORDER BY created_at DESC; 

---> Single comments of post 
SELECT content, comment_date 
FROM comment
WHERE post_id = $post_id and comment_id is null
ORDER BY comment_date DESC;

---> Comments of comment 
SELECT content, comment_date 
FROM comment
WHERE comment_id = $comment_id
ORDER BY comment_date DESC;

---> User's info for profile 
SELECT username, name, instagram, twitter, facebook, linkedin, profile_photo
FROM authenticated_user
WHERE id = $id;

---> All user's info for settings page 
SELECT *
FROM authenticated_user
WHERE id = $id;

---> Get type of all users 
SELECT username, authenticated_user_type
FROM authenticated_user
ORDER BY authenticated_user_type;

---> All Posts with tags followed by a given user
SELECT title, thumbnail, content, is_spoiler, created_at, n_views, category, post.user_id, n_likes
FROM post, follow_tag, post_tag, (SELECT post_id, COUNT(user_id) AS n_likes
FROM vote_post
WHERE vote_post.like
GROUP BY post_id
union
SELECT id AS post_id, 0 AS n_likes
FROM post
WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = true AND vote_post.post_id = post.id)) AS likes_post
WHERE likes_post.post_id = post.id AND follow_tag.user_id = $user_id AND post_tag.post_id = post.id AND post_tag.tag_id = follow_tag.tag_id
ORDER BY created_at DESC; 

---> All posts from users followed by a certain user
SELECT title, thumbnail, content, is_spoiler, created_at, n_views, category, post.user_id, n_likes
FROM post, follow_user, (SELECT post_id, COUNT(user_id) AS n_likes
FROM vote_post
WHERE vote_post.like
GROUP BY post_id
union
SELECT id AS post_id, 0 AS n_likes
FROM post
WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = true AND vote_post.post_id = post.id)) AS likes_post
WHERE likes_post.post_id = post.id AND follow_user.following_user = $id AND follow_user.followed_user = post.user_id
ORDER BY created_at DESC; 

---> Get all saved posts 
SELECT title, thumbnail, content, is_spoiler, created_at, n_views, category, post.user_id, n_likes
FROM post, saves, (SELECT post_id, COUNT(user_id) AS n_likes
FROM vote_post
WHERE vote_post.like
GROUP BY post_id
union
SELECT id AS post_id, 0 AS n_likes
FROM post
WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = true AND vote_post.post_id = post.id)) AS likes_post
WHERE likes_post.post_id = post.id AND saves.user_id = $user_id AND saves.post_id = post.id
ORDER BY created_at DESC; 

---> Get all tags followed 
SELECT tag.id, tag.name
FROM tag, follow_tag
WHERE follow_tag.user_id = $id AND tag.id = follow_tag.tag_id;

---> Get all posts from a certain tag 
SELECT title, thumbnail, content, is_spoiler, created_at, n_views, category, post.user_id, n_likes
FROM post, tag, post_tag, (SELECT post_id, COUNT(user_id) AS n_likes
FROM vote_post
WHERE vote_post.like
GROUP BY post_id
union
SELECT id AS post_id, 0 AS n_likes
FROM post
WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = true AND vote_post.post_id = post.id)) AS likes_post
WHERE likes_post.post_id = post.id AND tag.name = $tag_name AND post_tag.tag_id = tag.id AND post_tag.post_id = post.id 
ORDER BY created_at DESC;

---> Get all posts from a certain time interval 
SELECT title, thumbnail, content, is_spoiler, created_at, n_views, category, post.user_id, n_likes
FROM post, (SELECT post_id, COUNT(user_id) AS n_likes
FROM vote_post
WHERE vote_post.like
GROUP BY post_id
union
SELECT id AS post_id, 0 AS n_likes
FROM post
WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = true AND vote_post.post_id = post.id)) AS likes_post
WHERE likes_post.post_id = post.id AND created_at >= $start_date AND created_at <= $end_date
ORDER BY created_at DESC;

---> All reports main info 
(SELECT post.id, title, user_id AS content_author, count(user_reporting) AS n_reports, most_frequent_motive.motive
FROM report, post, (SELECT post_reported, motive, count(motive) AS motive_freq FROM report WHERE comment_reported is null AND closed_date is null GROUP BY post_reported, motive) AS most_frequent_motive
WHERE closed_date is null AND most_frequent_motive.post_reported = post.id AND most_frequent_motive.motive in (SELECT motive FROM report WHERE post_reported = post.id AND closed_date is null GROUP BY motive, post_reported ORDER BY COUNT(motive) DESC LIMIT 1) AND report.post_reported = post.id AND user_reporting <> $user_id AND (user_assigned = $user_id OR user_assigned is null)
GROUP BY post.id, title, user_id, most_frequent_motive.motive)
union
(SELECT post.id, title, comment.user_id AS content_author, count(user_reporting) AS n_reports, most_frequent_motive.motive
FROM report, post, "comment", (SELECT post_reported, motive, count(motive) AS motive_freq FROM report WHERE comment_reported is null AND closed_date is null GROUP BY post_reported, motive) AS most_frequent_motive
WHERE closed_date is null AND most_frequent_motive.post_reported = post.id AND most_frequent_motive.motive in (SELECT motive FROM report WHERE post_reported = post.id AND closed_date is null GROUP BY motive, post_reported ORDER BY COUNT(motive) DESC LIMIT 1) AND report.comment_reported = comment.id AND post.id = comment.post_id AND user_reporting <> $user_id AND (user_assigned = $user_id OR user_assigned is null)
GROUP BY post.id, title, comment.user_id, most_frequent_motive.motive)
ORDER BY n_reports DESC

---> Search content/title of post 
SELECT DISTINCT title, thumbnail, content, is_spoiler, created_at, n_views, category, post.user_id, n_likes
FROM post, (SELECT post_id, COUNT(user_id) AS n_likes
FROM vote_post
WHERE vote_post.like
GROUP BY post_id
union
SELECT id AS post_id, 0 AS n_likes
FROM post
WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = true AND vote_post.post_id = post.id)) AS likes_post
WHERE likes_post.post_id = post.id AND (to_tsvector('english', title || ' ' || content)) @@ plainto_tsquery('english',$input);
ORDER BY created_at DESC;

---> All user's notifications 
SELECT *
FROM notification
WHERE notificated_user = $user_id AND read = false
ORDER BY created_date;

---> Post's info
SELECT title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id, n_likes, n_dislikes, n_comments
FROM post, (SELECT post_id, COUNT(user_id) AS n_likes
FROM vote_post
WHERE vote_post.like
GROUP BY post_id
union
SELECT id AS post_id, 0 AS n_likes
FROM post
WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = true AND vote_post.post_id = post.id)) AS likes_post,
(SELECT post_id, COUNT(user_id) AS n_dislikes
FROM vote_post
WHERE vote_post.like = false
GROUP BY post_id
union
SELECT id AS post_id, 0 AS n_dislikes
FROM post
WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = false AND vote_post.post_id = post.id)) AS dislikes_post,
(SELECT post_id, (number_comments + number_single_comments) AS n_comments 
FROM 
( SELECT C1.post_id AS post_id, count(C2.comment_id) AS number_comments
FROM comment C1, comment C2
WHERE C2.comment_id = C1.id AND C1.post_id IS NOT null
GROUP BY C1.post_id
 union
 SELECT id AS post_id, 0 AS number_comments
 FROM post
 WHERE NOT EXISTS (SELECT * FROM comment C1, comment C2 WHERE C2.comment_id = C1.id AND C1.post_id = post.id)
) AS t1 NATURAL JOIN
(SELECT post_id, COUNT(id) AS number_single_comments
FROM comment
WHERE post_id IS NOT null
GROUP BY post_id
 union
SELECT id AS post_id, 0 AS n_comments 
FROM post
WHERE NOT EXISTS (SELECT * from comment WHERE post.id = comment.post_id)
) AS t2) AS comments_post
WHERE post.id = likes_post.post_id AND post.id = dislikes_post.post_id AND post.id = comments_post.post_id  AND post.id = $post_id;

---> Search by username
SELECT id, username, authenticated_user_type
FROM authenticated_user
WHERE username ILIKE '%username%';


--------------------------> INSERT QUERIES

---> New user registered
INSERT INTO authenticated_user(username, name, email, password, birthdate)
VALUES ($username, $name, $email, $password, $birthdate); 

---> New Post
INSERT INTO post(title, thumbnail, content, is_spoiler, type, category, user_id)
VALUES ($title, $thumbnail, $content, $is_spoiler, $type, $category, $user_id);

---> New Report
INSERT INTO report(motive, user_reporting, comment_reported, post_reported)
VALUES ($motive, $user_reporting, $comment_reported, $post_reported);

---> New Post Comment
INSERT INTO "comment"(content, user_id, post_id)
VALUES ($content, $user_id, $post_id);

---> New Comment Comment
INSERT INTO "comment"(content, user_id, comment_id)
VALUES ($content, $user_id, $comment_id);

---> New Post Vote
INSERT INTO vote_post(user_id, post_id, "like")
VALUES ($user_id, $post_id, $vote);

---> New Comment Vote
INSERT INTO vote_comment(user_id, comment_id, "like")
VALUES ($user_id, $post_id, $vote);

---> New Tag
INSERT INTO tag(name)
VALUES ($name);

---> New block user
INSERT INTO block_user(blocking_user, blocked_user)
VALUES ($bloking, $blocked);

---> New follow user
INSERT INTO follow_user(following_user, followed_user)
VALUES ($following_user, $followed_user);

--------------------------> UPDATE QUERIES

---> Update type of user
UPDATE authenticated_user
SET authenticated_user_type = $type
WHERE id = $id;

---> Update Social Media
UPDATE authenticated_user
SET instagram = $instagram, twitter = $twitter, facebook = $facebook, linkedin = $linkedin
WHERE id = $id;

---> Update Post Content
UPDATE post
SET content = $content
WHERE id = $id;

--------------------------> DELETE QUERIES

---> Delete user
DELETE FROM authenticated_user
WHERE id = $id;

---> Delete Post
DELETE FROM post
WHERE id = $id;

---> Delete Report
DELETE FROM report
WHERE id = $id;

---> Delete Post Comment
DELETE FROM "comment"
WHERE id = $id;

---> Delete Post Vote
DELETE FROM vote_post
WHERE id = $id;

---> Delete Comment Vote
DELETE FROM vote_comment
where id = $id;

---> Delete Tag
DELETE FROM tag
WHERE id = $id;

---> Delete block user
DELETE FROM block_user 
WHERE id = $id;

---> Delete follow user
DELETE FROM follow_user
WHERE id = $id;

