import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/pretty_printer.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {});
    on<SearchProductTapEvent>((event, emit) {
      search = !search;
      prettyPrint("changing value");
      emit(SearchProductTap(!search));
    });
  }
  bool search = false;
  static ProductBloc get(context) => BlocProvider.of(context);
}
