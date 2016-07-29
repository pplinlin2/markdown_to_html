# __A. GPIO Setting__

## 1. Get GPIO Pin List
#### Description
List all GPIO pin
#### Command
```
$ curl -X GET http://<ip>:9590/gpios -u <account>:<password>
```
#### Example
```
$ curl -X GET http://192.168.80.107:9590/gpios -u admin:admin
[
    {
        "id": 1,
        "direction": "out",
        "value": 0
    },
    ...
    {
        "id": 8,
        "direction": "out",
        "value": 0
    }
]
```

## 2. Get a GPIO Pin
#### Description
Find a GPIO pin by ID
#### Command
```
$ curl -X GET http://<ip>:9590/gpios/<GPIO_ID> -u <account>:<password>
```
|Field  |Description            |
|-------|-----------------------|
|GPIO_ID|integer between 1 and 8|
#### Example
```
$ curl -X GET http://192.168.80.107:9590/gpios/1 -u admin:admin
{
    "id": 1,
    "direction": "out",
    "value": 0
}
```

## 3. Change Direction of GPIO Pin
#### Description
Change the direction of a specified GPIO pin.
#### Command
```
$ curl -H "Content-Type: application/json" -X PATCH -d '{"direction": "<GPIO_DIR>"}' http://<ip>:9590/gpios/<GPIO_ID> -u <account>:<password>
```
|Field   |Description            |
|--------|-----------------------|
|GPIO_ID |integer between 1 and 8|
|GPIO_DIR|"in" or "out"          |
#### Example
```
$ curl -H "Content-Type: application/json" -X PATCH -d '{"direction": "in"}' http://192.168.80.107:9590/gpios/1 -u admin:admin
{
    "id": 1,
    "direction": "in",
    "value": 0
}
```

## 4. Change Value of GPIO Pin
#### Description
Change the value of a specified GPIO pin when the direction is "out".
#### Command
```
$ curl -H "Content-Type: application/json" -X PATCH -d '{"direction": <GPIO_VAL>}' http://<ip>:9590/gpios/<GPIO_ID> -u <account>:<password>
```
|Field   |Description            |
|--------|-----------------------|
|GPIO_ID |integer between 1 and 8|
|GPIO_VAL|0 or 1                 |
#### Example
```
$ curl -H "Content-Type: application/json" -X PATCH -d '{"value": 0}' http://192.168.80.107:9590/gpios/1 -u admin:admin
{
    "id": 1,
    "direction": "out",
    "value": 0
}
```

# __User Permission__

## 1. Get User Permission List
#### Description
Get the permission of all users in the QDIO.
#### Command
```
$ curl -X GET http://<ip>:9590/users -u <account>:<password>

```
#### Example
```
$ curl -X GET http://192.168.80.107:9590/users -u admin:admin
[
    {
        "uid": 501,
        "username": "qq",
        "is_superuser": false,
        "gpio": [
            {
                "pin_id": 1,
                "uid": 501
            },
            {
                "pin_id": 7,
                "uid": 501
            }
        ]
    }
]
```

## 2. Get Permission of User
#### Description
Find a user's permission in the QDIO by ID.
#### Command
```
$ curl -X GET http://<ip>:9590/users/<USER_ID>/gpio -u <account>:<password>
```
|Field  |Description            |
|-------|-----------------------|
|USER_ID|UID of the user        |
#### Example
```
$ curl -X GET http://192.168.80.107:9590/users/501/gpio -u admin:admin
[
    {
        "pin_id": 1,
        "uid": 501
    },
    {
        "pin_id": 7,
        "uid": 501
    }
]
```

## 3. Add Permission to User
#### Description
Add a permission of a pin to a user in the QDIO.
#### Command
```
$ curl -H "Content-Type: application/json" -X POST -d '{"pin_id": <GPIO_ID>}' http://<ip>:9590/users/<USER_ID>/gpio -u <account>:<password>
```
|Field  |Description            |
|-------|-----------------------|
|GPIO_ID|integer between 1 and 8|
|USER_ID|UID of the user        |
#### Example
```
$ curl -H "Content-Type: application/json" -X POST -d '{"pin_id": 8}' http://192.168.80.107:9590/users/501/gpio -u admin:admin
```

## 4. Remove Permission from User
#### Description
Remove a permission of a pin from a user in the QDIO.
#### Command
```
$ curl -X DELETE http://<ip>:9590/users/<USER_ID>/gpio/<GPIO_ID> -u <account>:<password>
```
|Field  |Description            |
|-------|-----------------------|
|GPIO_ID|integer between 1 and 8|
|USER_ID|UID of the user        |
#### Example
```
$ curl -X DELETE http://192.168.80.107:9590/users/501/gpio/8 -u admin:admin
```
