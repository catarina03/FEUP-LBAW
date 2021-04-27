--CREATE POST
BEGIN;
 --Standard isolation level is enough to guarantee that all the inserts happen or none at all. 
INSERT INTO post(title, thumbnail, content, is_spoiler, created_at, n_views, type, category, user_id)
VALUES($title, $thumbnail, $content, $is_spoiler, $created_at, $n_views, $type, $category, $user_id);
INSERT INTO post_tag(post_id, tag_id) VALUES($post_id, $tag_id);
INSERT INTO photo(photo, post_id) VALUES($photo, $post_id);
COMMIT;

--UPDATE POST
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; 
--Multiple update posts are guaranteed to not interfere with each other 
--(guarantee that the SERIAl id of a post_tag hasnt been already used by another commited transaction)

UPDATE post 
SET title=$title,thumbnail=$thum, content=$content, is_spoiler=$spoiler, 
type=$type, category=$category 
WHERE user_id = $id;

--Tags
--(
DELETE FROM post_tag WHERE id = $pt_id;
--OR
INSERT INTO post_tag(post_id, tag_id) VALUES($post_id, $tag_id);
--)* -> Zero or more

--Photos
--(
DELETE FROM photo WHERE id = $photo_id;
--OR
INSERT INTO photo(photo, post_id) VALUES($photo, $post_id);
--)* -> Zero or more
COMMIT;

