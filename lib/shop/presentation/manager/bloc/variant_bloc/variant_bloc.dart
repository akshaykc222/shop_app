import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/ProductEntity.dart';

part 'variant_event.dart';
part 'variant_state.dart';

class VariantBloc extends Bloc<VariantEvent, VariantState> {
  VariantBloc() : super(VariantInitial(1, [QuantityVariant()])) {
    on<VariantEvent>((event, emit) {});
    on<VariantAdd>((event, emit) {
      var count = state.count + 1;
      emit(VariantAddSate(count, [...state.variants, QuantityVariant()]));
    });
    on<VariantDecrement>((event, emit) {
      var count = state.count - 1;
      if (state.variants.isNotEmpty) {
        state.variants.removeLast();

        emit(VariantDeleteState(
          count,
          List.from(state.variants),
        ));
      }
    });

    on<VariantColorSelected>((event, emit) {
      // emit(VariantColorAdd(state.count, colorsList.last));
    });
    on<DeleteColor>((event, emit) {
      // emit(VariantColorRemove(state.count, removedColor));
    });
    on<VariantsBulkAdd>((event, emit) {
      print("Adding events ${event.variants}");
      emit(VariantAddSate(state.count, [...event.variants, ...state.variants]));
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
