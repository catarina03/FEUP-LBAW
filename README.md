# Collaborative News 

AltArt aims to provide an aesthetically pleasing collaborative news website, without information explosion, that allows people who have the same interests in music, literature and the arts to come together to connect and share opinions.

Link to the release with the final version of the source code in the group's git repository: ```https://git.fe.up.pt/lbaw/lbaw2021/lbaw2123```


To run the project image locally, must run the following command:
```docker run -it -p 8000:80 -e DB_DATABASE="lbaw2123" -e DB_USERNAME="lbaw2123" -e DB_PASSWORD="PASSWORD" lbaw2123/lbaw2123```


**Run Database** : ```php artisan db::seed```
**Run laravel php local server**: ```php artisan serve```

### Administration Credentials

Administration URL: ```http://lbaw2123.lbaw-prod.fe.up.pt/administration/roles```

| Username | Password |
| -------- | -------- |
| nellicombeg | 123456 |

### User Credentials

Moderation URL: ```http://lbaw2123.lbaw-prod.fe.up.pt/moderator/reports```

| Type          | Username  | Password |
| ------------- | --------- | -------- |
| moderator | styrere    | 123456 |
| regular | ssmoote1      | 123456 |




## Team 

* Allan Sousa, up201800149@fe.up.pt
* Catarina Fernandes, up201806610@fe.up.pt
* Mariana Truta, up201806543@fe.up.pt
* Rita Peixoto, up201806257@fe.up.pt


GROUP2123, 05/06/2021
