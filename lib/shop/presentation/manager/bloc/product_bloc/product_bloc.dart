import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/core/pretty_printer.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductInitial()) {
    on<ProductEvent>((event, emit) {});
    on<SearchProductTapEvent>((event, emit) {
      search = !search;
      prettyPrint("changing value");
      emit(SearchProductTap(!search));
    });
    on<AddTagsFilterEvent>((event, emit) {
      prettyPrint("adding");
      emit(ProductTagsAddState(tagList));
    });
    on<DeleteTagsFilterEvent>((event, emit) {
      prettyPrint("Deleting");

      emit(ProductTagsAddState(tagList));
    });
    on<ImageFilesAddedEvent>((event, emit) {
      prettyPrint("image added");

      emit(ProductImagesAddedState(productImages));
    });
    on<ImageFilesRemovedEvent>((event, emit) {
      prettyPrint("image removed");

      emit(ProductImagesAddedState(productImages));
    });
  }
  bool search = false;
  static ProductBloc get(context) => BlocProvider.of(context);
  final tagList = <String>[];
  addTags(String item) {
    tagList.add(item);
    return AddTagsFilterEvent();
  }

  removeTag(String item) {
    tagList.removeWhere((i) => i == item);
    prettyPrint("item deleted ${tagList.length}");
    return DeleteTagsFilterEvent();
  }

  final productImages = <XFile>[];

  addFiles(XFile file) {
    productImages.add(file);
    ImageFilesAddedEvent();
  }

  removeFile(XFile file) {
    productImages.remove(file);
  }

  final productTagController = TextEditingController();
}
