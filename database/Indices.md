


| **INDEX**  | INDEX01 |
| ----- | ----- |
| **Related Queries** | SELECT16 |
| **Index Relation** | post |
| **Index attribute** | user_id |
| **Index type** | Hash |
| **Cardinality** | Medium |
| **Clustering** | No |
| **Justification** | Cardinality is medium:not a good candidate for clustering. The query doesn’t need support for range search nor sorting. The query is executed frequently. |
| `SQL code` | [INDEX01](#index01) |  

| **INDEX**  | INDEX02 |
| ----- | ----- |
| **Related Queries** | SELECT01 |
| **Index Relation** | post |
| **Index attribute** | created_at |
| **Index type** | Btree |
| **Cardinality** | low |
| **Clustering** | No |
| **Justification** | Cardinality is low(a lot of posts can be published at the same date). There is no need for clustering. The query must support sorting by the index attribute. The query is executed many times. |
| `SQL code` | [INDEX02](#index02) |  

| **INDEX**  | INDEX03 |
| ----- | ----- |
| **Related Queries** | SELECT15 |
| **Index Relation** | follow_tag |
| **Index attribute** | user_id |
| **Index type** | Hash |
| **Cardinality** | low |
| **Clustering** | No |
| **Justification** | Cardinality is low(a user can follow a lot of tags). There is no need for clustering. The query doesn’t need support for range search nor sorting by the index attribute. The query is executed many times.|
| `SQL code` | [INDEX03](#index03) |  

| **INDEX**  | INDEX04 |
| ----- | ----- |
| **Related Queries** | SELECT11 |
| **Index Relation** | authenticated_user |
| **Index attribute** | username |
| **Index type** | Hash |
| **Cardinality** | low |
| **Clustering** | No |
| **Justification** | Cardinality is high(username is unique) : not a good candidate for clustering. The query doesn’t need support for range search. The query is executed many times. |
| `SQL code` | [INDEX04](#index04) |  

| **INDEX**  | INDEX05 |
| ----- | ----- |
| **Related Queries** | SELECT06 |
| **Index Relation** | comment |
| **Index attribute** | post_id |
| **Index type** | Hash |
| **Cardinality** | low |
| **Clustering** | No |
| **Justification** | Cardinality is low(a post can have many comments). The query doesn’t need support for range search. The query is executed many times. |
| `SQL code` | [INDEX05](#index05) |

| **INDEX**  | INDEX06 |
| ----- | ----- |
| **Related Queries** | SELECT21 |
| **Index Relation** | post |
| **Index attribute** | title,content |
| **Index type** | GIN |
| **Clustering** | No |
| **Justification** | Even though post data is dynamic, updates to the index attributes will be rare.GIN's lookup time is lower than GISTs. |
| `SQL code` | [INDEX06](#index06) |


## INDEX01
```sql
    CREATE INDEX author_post ON post USING HASH(user_id);
```

## INDEX02
```sql
    CREATE INDEX post_date ON post USING BTREE(created_at);
```

## INDEX03
```sql
    CREATE INDEX user_tags ON follow_tag USING HASH(user_id);
```

## INDEX04
```sql
    CREATE INDEX user_type_idx ON authenticated_user USING HASH(username);
```

## INDEX05
```sql
    CREATE INDEX post_comments ON comment USING HASH(post_id);
```

## INDEX06
```sql
    CREATE INDEX search_post ON post USING GIN(to_tsvector('english',content || ' ' || title));
```









