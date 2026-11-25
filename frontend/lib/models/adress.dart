class Address {
  String street;
  String city;
  String state;
  String postalCode;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
  });

  @override
  String toString() {
    return '$street, $city, $state $postalCode';
  }
  bool isEqual(Address other) {
    return this.street == other.street &&
        this.city == other.city &&
        this.state == other.state &&
        this.postalCode == other.postalCode;
  }
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
      state: json['adresse'],
      postalCode: json['codepostal'],
    );
  }
}
