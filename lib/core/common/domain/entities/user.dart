class User {
  final String email;
  final String id;
  final String? password;
  final String firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? city;
  final String? imageUrl;
  final int? experience;
  final String? category;
  final String? userType;

  User({
    required this.email,
    this.experience,
    this.category,
    this.password,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.city,
    required this.imageUrl,
    required this.userType,
  });
}
