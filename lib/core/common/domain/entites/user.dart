class User {
  final String email;
  final String password;
  final String firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? city;
  final String? imageUrl;
  final int? experience;
  final String? category;

  User({
    required this.email,
    this.experience,
    this.category,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.city,
    required this.imageUrl,
  });
}
