# Shop

Creating a Shopping App with flutter.

Also training my skills with FireBase and GitHub.


Packages used in this project:

intl: ^0.17.0.
provider: ^6.0.3.
http: ^0.13.5.
shared_preferences: ^2.0.15.

# Rules in FireBase

{
  "rules": {
    "orders": {
      "$uid": {
        ".write": "$uid === auth.uid",
        ".read": "$uid === auth.uid",
      },
    },
    "userFavorites": {
    	"$uid": {
      	".write": "$uid === auth.uid",
        ".read": "$uid === auth.uid",
      },
    },
    "products": {
        ".write": "auth != null",
        ".read": "auth != null",
    }
  }
}