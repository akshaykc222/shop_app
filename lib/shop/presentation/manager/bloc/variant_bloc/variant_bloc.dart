import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'variant_event.dart';
part 'variant_state.dart';

class VariantBloc extends Bloc<VariantEvent, VariantState> {
  VariantBloc() : super(const VariantInitial(1)) {
    on<VariantEvent>((event, emit) {});
    on<VariantAdd>((event, emit) {
      emit(VariantAddSate(state.count + 1));
    });
    on<VariantDecrement>((event, emit) {
      emit(VariantDeleteState(state.count - 1));
    });

    on<VariantColorSelected>((event, emit) {
      emit(VariantColorAdd(state.count, colorsList.last));
    });
    on<DeleteColor>((event, emit) {
      emit(VariantColorRemove(state.count, removedColor));
    });
  }
  static VariantBloc get(context) => BlocProvider.of(context);

  List<Color> colorsList = [];
  Color removedColor = const Color(0x00ffffff);
  removeColor(Color color) {
    removedColor = color;
    colorsList.removeWhere((element) => element == color);
    DeleteColor();
    // VariantColorSelected();
  }

  addColor(Color color) {
    colorsList.add(color);
  }

  Color currentColor = const Color(0x0fffffff);
  Color pickerColor = const Color(0x0fffffff);
  void changeColor(Color color) {
    currentColor = color;
    // colorsList.add(color);
  }
}
