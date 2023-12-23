class User {
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarURL,
  });

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatarURL;
}
