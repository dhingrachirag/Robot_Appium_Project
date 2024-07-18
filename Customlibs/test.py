import json


def main():
    json_str = """
    {
        "users" : {
        "Ellie": {
            "ip": "10.50.10.138:5555",
            "username": "plcm42@3pip.onmicrosoft.com",
            "password": "MSBlore@20",
            "displayname": "plcm42",
            "Mode": "Personal",
            "phonenumber": "14084759281",
            "pstndisplay": "+1 408-475-9281"
        },
        "Leo": {
            "ip": "10.50.10.146:5555",
            "username": "plcm43@3pip.onmicrosoft.com",
            "password": "MSBlore@20",
            "displayname": "plcm 43",
            "Mode": "Personal",
            "phonenumber": "14084719849",
            "pstndisplay": "+1 408-471-9849"
        },
        "Elizabeth": {
            "ip": "10.50.10.111:5555",
            "username": "plcm44@3pip.onmicrosoft.com",
            "password": "MSBlore@20",
            "displayname": "plcm 44",
            "Mode": "Personal",
            "phonenumber": "14084719863",
            "pstndisplay": "+1 408-471-9863"
       }
    }
    """
    json_object = json.loads(json_str)
    for line in json_str.split('\n'):
        if '"' in line and ':' in line and '{' in line and '"users"' not in line:
            key = line.split('"')[1]
            print(key, json_object['users'][key])

