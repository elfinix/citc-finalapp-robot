import requests
import random
import string

class DataRetrieval():

    def get_random_users(self):
        response = requests.get("https://jsonplaceholder.typicode.com/users", verify=False)
        users = response.json()
        prefixes = {"Mr.", "Mrs.", "Ms.", "Dr.", "Miss", "Prof.", "Sir", "Madam", "Mx.", "Master", "Rev.", "Fr.", "Sr.", "Sra.", "Jr.", "Hon.", "Dame"}
        for i in users:
            name_parts = i['name'].split()
            if name_parts[0] in prefixes and len(name_parts) > 2:
                i["formatted_name"] = f"{name_parts[1]} {name_parts[2]}"
            else:
                i["formatted_name"] = f"{name_parts[0]} {name_parts[1]}"
            i["birthday"] = self.get_random_birthday()
            i["password"]= self.generate_password()
            i["email"] = self.lower_email(i["email"])
            i["address"]["stateAbbr"]= str(i["address"]["street"][0]) + str(i["address"]["suite"][0])+str(i["address"]["city"][0])
        print(users)
        return users
        
    def get_random_birthday(self):
        return str(random.randint(1, 12)).zfill(2) + str(random.randint(1, 28)).zfill(2) + str(random.randint(1996, 2006)).zfill(4)

    def generate_password(self, length=8):
        chars = string.ascii_letters + string.digits + "!@#$%"
        return ''.join(random.choice(chars) for _ in range(length))

    def lower_email(self, email):
        return email.lower()