# Public E-commerce REST API 🌏

# Motivation

- flutter junior developers need to learn how to use rest api for the they need a rest api not just json place holder
  so we built this api 💜

## how to use

## Base URL

`http://18.191.185.209:3000/api/v1/`

## 1. auth api

### for register

method **post** parameters

1. name _string_
2. email _string must be in email format_ and unique
3. password _string_

> http://18.191.185.209:3000/api/v1/auth/register

```
{
   "success": true,
   "data": {
       "tb_user_id": 10,
       "tb_user_name": "hatem",
       "tb_user_email": "34@1.com",
       "tb_user_image": "default_user_image.png",
       "tb_user_image_thumb": "default_user_image.png",
       "auth_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAsInRpbWUiOiIxNjE3NzMwOTI5ODA5IiwiaWF0IjoxNjE3NzMwOTI5LCJleHAiOjE2NDkyNjY5Mjl9.rABOYnjVSO5t-u8_iSRPNOrmb32MePR03XhC384f9BU"
   }
}
```

if email found in db will return error like that

```
{
    "success": false,
    "data": "Error 1062 (23000): Duplicate entry '34@1.com' for key 'tb_user_email'"
}
```

---

### for login

method **post** parameters

1. email _string must be in email format_
2. password _string_

> http://18.191.185.209:3000/api/v1/auth/login

```
{
   "success": true,
   "data": {
       "tb_user_id": 1,
       "tb_user_name": "hatem",
       "tb_user_email": "1@1.com",
       "tb_user_image": "default_user_image.png",
       "tb_user_image_thumb": "default_user_image.png",
       "auth_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidGltZSI6IjE2MTc3MzA4OTkyNDYiLCJpYXQiOjE2MTc3MzA4OTksImV4cCI6MTY0OTI2Njg5OX0.8MgZT06wGZr7qZeDqub9fPJw8BXyLhwH095Fz_Rlzfc"
   }
}
```

---

> note all api then required auth token to work if not provided this is the response

you have to pass the authorization Key in headers **note Bearer pass just the token**

- flutter dio example

```
_dio.options.headers = {
'Authorization': eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiaW
};
```

- response if not provided

```
{
    "success": false,
    "data": "No auth provided !"
}
```

## 2. users data

- for All users limited to 20 after the last id u will send in last param which is 0 mean get first 20 users start from 0
- to get the next 20 users u have to past the last user id from your list of users replace it with the 0 value

method **get** params

1. /0 _int last user data if first request pass 0_

> http://18.191.185.209:3000/api/v1/user/all/0

---

```
{
   "success": true,
   "data": [
       {
           "tb_user_id": 1,
           "tb_user_name": "hatem",
           "tb_user_email": "1@1.com",
           "tb_user_image": "default_user_image.png",
           "tb_user_image_thumb": "default_user_image.png"
       },
       {
           "tb_user_id": 3,
           "tb_user_name": "hatem",
           "tb_user_email": "2@1.com",
           "tb_user_image": "default_user_image.png",
           "tb_user_image_thumb": "default_user_image.png"
       },
       {
           "tb_user_id": 5,
           "tb_user_name": "hatem",
           "tb_user_email": "3@1.com",
           "tb_user_image": "default_user_image.png",
           "tb_user_image_thumb": "default_user_image.png"
       },

   ]
}
```

---

if u send last item id in list suppose it will be 6 then the data will return after the last id u send limited to 20

> http://18.191.185.209:3000/api/v1/user/all/6

---

```
{
    "success": true,
    "data": [
        {
            "tb_user_id": 7,
            "tb_user_name": "hatem",
            "tb_user_email": "4@1.com",
            "tb_user_image": "default_user_image.png",
            "tb_user_image_thumb": "default_user_image.png"
        },
        {
            "tb_user_id": 8,
            "tb_user_name": "hatem",
            "tb_user_email": "5@1.com",
            "tb_user_image": "default_user_image.png",
            "tb_user_image_thumb": "default_user_image.png"
        },
        {
            "tb_user_id": 10,
            "tb_user_name": "hatem",
            "tb_user_email": "34@1.com",
            "tb_user_image": "default_user_image.png",
            "tb_user_image_thumb": "default_user_image.png"
        }
    ]
}
```

---
