part of 'variant_bloc.dart';

abstract class VariantEvent extends Equatable {
  const VariantEvent();
}

class VariantAdd extends VariantEvent {
  @override
  List<Object?> get props => [];
}

class VariantDecrement extends VariantEvent {
  @override
  List<Object?> get props => [];
}

class AddColor extends VariantEvent {
  @override
  List<Object?> get props => [];
}

class DeleteColor extends VariantEvent {
  @override
  List<Object?> get props => [];
}

class VariantColorSelected extends VariantEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
