part of 'util_cubit.dart';

abstract class UtilState extends Equatable {
  const UtilState();
}

class UtilInitial extends UtilState {
  @override
  List<Object> get props => [];
}

class UtilTapState extends UtilState {
  final bool isOpen;

  const UtilTapState(this.isOpen);

  @override
  // TODO: implement props
  List<Object?> get props => [isOpen];
}
