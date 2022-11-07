import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/pretty_printer.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationInitial());
  static BottomNavigationCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int shadeWidth = 0;

  changeBottomNav(int index) {
    currentIndex = index;
    prettyPrint("changing index $index", type: "ERROR");
    shadeWidth = 80;
    // Future.delayed(Duration(seconds: 0), () {
    //   shadeWidth = 0;
    // });
    emit(BottomNavState(index));
  }
}
