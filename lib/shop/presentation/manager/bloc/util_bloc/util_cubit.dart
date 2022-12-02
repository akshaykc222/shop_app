import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'util_state.dart';

class UtilCubit extends Cubit<UtilState> {
  UtilCubit() : super(UtilInitial());

  bool categoryContextMenuOpen = false;
}
