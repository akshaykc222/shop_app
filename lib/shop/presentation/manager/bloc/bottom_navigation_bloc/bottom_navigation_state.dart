part of 'bottom_navigation_cubit.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();
}

class BottomNavigationInitial extends BottomNavigationState {
  @override
  List<Object> get props => [];
}

class BottomNavState extends BottomNavigationState {
  final int index;

  const BottomNavState(this.index);

  @override
  List<Object?> get props => [index];
}
