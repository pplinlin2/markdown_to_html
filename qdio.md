# QDIO API documentation
```
version: 1.0.0
```
## A. GPIO Setting
### 1. Get GPIO Pin List
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
|Field    |Description            |
|---------|-----------------------|
|id       |Integer between 1 and 8|
|direction|"in" or "out"          |
|value    |0 or 1                 |

### 2. Get a GPIO Pin
#### Description
Find a GPIO pin by ID
#### Command
```
$ curl -X GET http://<ip>:9590/gpios/<GPIO_ID> -u <account>:<password>
```
|Field  |Description            |
|-------|-----------------------|
|GPIO_ID|Integer between 1 and 8|

#### Example
```
$ curl -X GET http://192.168.80.107:9590/gpios/1 -u admin:admin
{
    "id": 1,
    "direction": "out",
    "value": 0
}
```
|Field    |Description            |
|---------|-----------------------|
|id       |Integer between 1 and 8|
|direction|"in" or "out"          |
|value    |0 or 1                 |

### 3. Change Direction of GPIO Pin
#### Description
Change the direction of a specified GPIO pin.
#### Command
```
$ curl -H "Content-Type: application/json" -X PATCH -d '{"direction": "<GPIO_DIR>"}' http://<ip>:9590/gpios/<GPIO_ID> -u <account>:<password>
```
|Field   |Description            |
|--------|-----------------------|
|GPIO_ID |Integer between 1 and 8|
|GPIO_DIR|"in" or "out"          |

#### Example
Change the direction of GPIO pin 1 to "in"
```
$ curl -H "Content-Type: application/json" -X PATCH -d '{"direction": "in"}' http://192.168.80.107:9590/gpios/1 -u admin:admin
{
    "id": 1,
    "direction": "in",
    "value": 0
}
```
|Field    |Description            |
|---------|-----------------------|
|id       |Integer between 1 and 8|
|direction|"in" or "out"          |
|value    |0 or 1                 |


![direction out](../images/direction_out.png) ![direction in](../images/direction_in.png)

### 4. Change Value of GPIO Pin
#### Description
Change the value of a specified GPIO pin when the direction is "out".
#### Command
```
$ curl -H "Content-Type: application/json" -X PATCH -d '{"direction": <GPIO_VAL>}' http://<ip>:9590/gpios/<GPIO_ID> -u <account>:<password>
```
|Field   |Description            |
|--------|-----------------------|
|GPIO_ID |Integer between 1 and 8|
|GPIO_VAL|0 or 1                 |

#### Example
Change the value of GPIO pin 8 to "1".
```
$ curl -H "Content-Type: application/json" -X PATCH -d '{"value": 1}' http://192.168.80.107:9590/gpios/8 -u admin:admin
{
    "id": 8,
    "direction": "out",
    "value": 0
}
```
|Field    |Description            |
|---------|-----------------------|
|id       |Integer between 1 and 8|
|direction|"in" or "out"          |
|value    |0 or 1                 |


![value 0](../images/value_0.png) ![value 1](../images/value_1.png)

---
## B. User Permission

### 1. Get User Permission List
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
|Field       |Description            |
|------------|-----------------------|
|uid         |ID of user             |
|username    |Name of user           |
|is_superuser|true or false          |
|gpio        |Permission list of user|
|pin_id      |Integer between 1 and 8|


### 2. Get Permission of User
#### Description
Find a user's permission in the QDIO by ID.
#### Command
```
$ curl -X GET http://<ip>:9590/users/<USER_ID>/gpio -u <account>:<password>
```
|Field  |Description            |
|-------|-----------------------|
|USER_ID|ID of the user         |

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
|Field       |Description            |
|------------|-----------------------|
|pin_id      |integer between 1 and 8|
|uid         |ID of user             |

### 3. Add Permission to User
#### Description
Add a permission of a pin to a user in the QDIO.
#### Command
```
$ curl -H "Content-Type: application/json" -X POST -d '{"pin_id": <GPIO_ID>}' http://<ip>:9590/users/<USER_ID>/gpio -u <account>:<password>
```
|Field  |Description            |
|-------|-----------------------|
|GPIO_ID|integer between 1 and 8|
|USER_ID|ID of the user         |

#### Example
Add the permission of GPIO pin 8 to user 501.
```
$ curl -H "Content-Type: application/json" -X POST -d '{"pin_id": 8}' http://192.168.80.107:9590/users/501/gpio -u admin:admin
```

![permission 8 on](../images/permission_8_on.png)

### 4. Remove Permission from User
#### Description
Remove a permission of a pin from a user in the QDIO.
#### Command
```
$ curl -X DELETE http://<ip>:9590/users/<USER_ID>/gpio/<GPIO_ID> -u <account>:<password>
```
|Field  |Description            |
|-------|-----------------------|
|GPIO_ID|integer between 1 and 8|
|USER_ID|ID of the user         |

#### Example
Remove the permission of GPIO pin 8 from user 501.
```
$ curl -X DELETE http://192.168.80.107:9590/users/501/gpio/8 -u admin:admin
```

![permission 8 off](../images/permission_8_off.png)
