part of 'variant_bloc.dart';

abstract class VariantState extends Equatable {
  final int count;
  final List<QuantityVariant> variants;

  const VariantState(
    this.count,
    this.variants,
  );
}

class VariantInitial extends VariantState {
  const VariantInitial(super.count, super.variants);

  @override
  List<Object> get props => [super.count];
}

class VariantAddSate extends VariantState {
  const VariantAddSate(super.count, super.variants);

  @override
  List<Object?> get props => [super.count];
}

class VariantDeleteState extends VariantState {
  const VariantDeleteState(super.count, super.variants);

  @override
  List<Object?> get props => [super.count];
}

class VariantColorAdd extends VariantState {
  final Color color;

  const VariantColorAdd(
    super.count,
    super.variants,
    this.color,
  );

  @override
  List<Object?> get props => [color];
}

class VariantColorRemove extends VariantState {
  final Color color;

  VariantColorRemove(super.count, super.variants, {required this.color});

  @override
  List<Object?> get props => [];
}
