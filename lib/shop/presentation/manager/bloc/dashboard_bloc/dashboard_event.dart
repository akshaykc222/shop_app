part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class ChangeStoreStatus extends DashboardEvent {
  final bool status;
  final String? opensIn;
  final BuildContext context;
  const ChangeStoreStatus(this.context,
      {required this.status, required this.opensIn});

  @override
  List<Object?> get props => [status, opensIn];
}

class DashBoardGetEvent extends DashboardEvent {
  final BuildContext context;

  const DashBoardGetEvent(this.context);

  @override
  List<Object?> get props => [];
}
