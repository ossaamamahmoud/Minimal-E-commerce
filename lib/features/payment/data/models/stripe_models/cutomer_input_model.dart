class CustomerInputModel {
  final String name;
  final String email;
  final String phone;

  CustomerInputModel(
      {required this.name, required this.email, required this.phone});

  toMap() => {'name': name, 'email': email, 'phone': phone};
}
