class PersonalDetails {
  final String name;
  final String address;
  final String email;
  final String phone;

  PersonalDetails({
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'address': address, 'email': email, 'phone': phone};
  }

  factory PersonalDetails.fromMap(Map<String, dynamic> map) {
    return PersonalDetails(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }
}
