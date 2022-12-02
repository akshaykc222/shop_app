import 'package:equatable/equatable.dart';

class UserShortDetailsEntity extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String logo;
  final String address;
  const UserShortDetailsEntity(
      {required this.name,
      required this.phone,
      required this.email,
      required this.logo,
      required this.address});

  @override
  List<Object?> get props => [name, phone, email, logo, address];
}
