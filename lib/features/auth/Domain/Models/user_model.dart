/*
U S E R model

this is the user object

------------------------------------------------------
it has these 5 properties

- id
- email
- password
- first Names
- surname

 */

class User {
  final int id;
  final String email;
  final String password;
  // final String firstName;
  // final String surname;

  User({
    required this.id,
    required this.email,
    required this.password,
    // required this.firstName,
    // required this.surname,
  });
}
