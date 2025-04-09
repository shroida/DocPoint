class User {
  final String email;
  final String password;
  final String firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? city;
  final String? imageUrl;

  User({
    required this.email,
    required this.password,
    required this.firstName,
    this.lastName,
    this.phoneNumber,
    this.city,
    this.imageUrl,
  });
}
