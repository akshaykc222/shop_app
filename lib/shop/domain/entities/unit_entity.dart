import 'package:equatable/equatable.dart';

class UnitEntity extends Equatable {
  const UnitEntity({
    required this.id,
    required this.unit,
  });

  final int id;
  final String unit;

  @override
  List<Object?> get props => [id, unit];
}
