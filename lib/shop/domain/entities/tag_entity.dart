import 'package:equatable/equatable.dart';

class TagEntity extends Equatable {
  const TagEntity({
    required this.id,
    required this.tagName,
  });

  final int id;
  final String tagName;

  @override
  List<Object?> get props => [id, tagName];
}
