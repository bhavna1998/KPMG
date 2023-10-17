def get_nested_value(obj, key):                      #function
    keys = key.split('/')
    current_obj = obj

    for k in keys:
        if k in current_obj:
            current_obj = current_obj[k]
        else:
            return None  # Key not found
    return current_obj                               #returns the current object

object1 = {"a": {"b": {"c": "d"}}}
key1 = "a/b/c"                                       #passing Key
value1 = get_nested_value(object1, key1)
print(value1)                                        # Output should be: "d"

object2 = {"x": {"y": {"z": "a"}}}
key2 = "x/y/z"                                       #passing Key
value2 = get_nested_value(object2, key2)
print(value2)                                        # Output should be: "a"
