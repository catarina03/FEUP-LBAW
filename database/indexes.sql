CREATE INDEX author_post ON post USING HASH(user_id);
CREATE INDEX post_date ON post USING BTREE(created_at);
CREATE INDEX user_tags ON follow_tag USING HASH(user_id);
CREATE INDEX user_type_idx ON authenticated_user USING HASH(username);
CREATE INDEX post_comments ON comment USING HASH(post_id);
CREATE INDEX search_post ON post USING GIN(to_tsvector('english',title || ' ' || content));
CREATE INDEX search_username ON authenticated_user USING GIN(to_tsvector('english',username));
