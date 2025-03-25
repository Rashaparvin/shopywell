// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDetailsModel {
  final String email;
  final String password;
  final String pincode;
  final String address;
  final String city;
  final String state;
  final String country;
  final String bankAccountNumber;
  final String accountHolderName;
  final String ifscCode;
  UserDetailsModel({
    required this.email,
    required this.password,
    required this.pincode,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.bankAccountNumber,
    required this.accountHolderName,
    required this.ifscCode,
  });

  UserDetailsModel copyWith({
    String? email,
    String? password,
    String? pincode,
    String? address,
    String? city,
    String? state,
    String? country,
    String? bankAccountNumber,
    String? accountHolderName,
    String? ifscCode,
  }) {
    return UserDetailsModel(
      email: email ?? this.email,
      password: password ?? this.password,
      pincode: pincode ?? this.pincode,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      ifscCode: ifscCode ?? this.ifscCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'pincode': pincode,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'bankAccountNumber': bankAccountNumber,
      'accountHolderName': accountHolderName,
      'ifscCode': ifscCode,
    };
  }

  factory UserDetailsModel.fromMap(Map<String, dynamic> map) {
    return UserDetailsModel(
      email: map['email'] as String,
      password: map['password'] as String,
      pincode: map['pincode'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      bankAccountNumber: map['bankAccountNumber'] as String,
      accountHolderName: map['accountHolderName'] as String,
      ifscCode: map['ifscCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailsModel.fromJson(String source) =>
      UserDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDetailsModel(email: $email, password: $password, pincode: $pincode, address: $address, city: $city, state: $state, country: $country, bankAccountNumber: $bankAccountNumber, accountHolderName: $accountHolderName, ifscCode: $ifscCode)';
  }

  @override
  bool operator ==(covariant UserDetailsModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.pincode == pincode &&
        other.address == address &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.bankAccountNumber == bankAccountNumber &&
        other.accountHolderName == accountHolderName &&
        other.ifscCode == ifscCode;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        pincode.hashCode ^
        address.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        bankAccountNumber.hashCode ^
        accountHolderName.hashCode ^
        ifscCode.hashCode;
  }
}
