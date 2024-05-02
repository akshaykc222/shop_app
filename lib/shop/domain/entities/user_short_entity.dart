import 'package:equatable/equatable.dart';

class UserShortDetailsEntity extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String logo;
  final String address;
  final int storeId;
  // final CurrencyModel currency;
  const UserShortDetailsEntity({
    required this.name,
    required this.phone,
    required this.email,
    required this.logo,
    required this.storeId,
    required this.address,
  });

  @override
  List<Object?> get props => [name, phone, email, storeId, logo, address];
}
