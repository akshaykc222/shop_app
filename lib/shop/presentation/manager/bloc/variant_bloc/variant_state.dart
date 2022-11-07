part of 'variant_bloc.dart';

abstract class VariantState extends Equatable {
  final int count;

  const VariantState(
    this.count,
  );
}

class VariantInitial extends VariantState {
  const VariantInitial(super.count);

  @override
  List<Object> get props => [super.count];
}

class VariantAddSate extends VariantState {
  const VariantAddSate(super.count);

  @override
  List<Object?> get props => [super.count];
}

class VariantDeleteState extends VariantState {
  const VariantDeleteState(super.count);

  @override
  List<Object?> get props => [super.count];
}

class VariantColorAdd extends VariantState {
  final Color color;

  const VariantColorAdd(
    super.count,
    this.color,
  );

  @override
  List<Object?> get props => [color];
}

class VariantColorRemove extends VariantState {
  final Color color;

  const VariantColorRemove(
    super.count,
    this.color,
  );

  @override
  List<Object?> get props => [];
}
