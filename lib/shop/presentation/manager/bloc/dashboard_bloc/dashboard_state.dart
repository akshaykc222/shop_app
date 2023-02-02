part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoadingState extends DashboardState {
  @override
  List<Object?> get props => [];
}

class DashboardLoadedState extends DashboardState {
  @override
  List<Object?> get props => [];
}

class DashboardErrorState extends DashboardState {
  @override
  List<Object?> get props => [];
}
