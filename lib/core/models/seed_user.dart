class SeedUser {
  const SeedUser({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  final String username;
  final String password;
  final String firstName;
  final String lastName;

  String get fullName => '$firstName $lastName';
}


