import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/core/custom_exception.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/models/deliveryman_detail_model.dart';
import 'package:shop_app/shop/data/models/requests/delivery_man_list_request.dart';
import 'package:shop_app/shop/data/routes/app_remote_routes.dart';
import 'package:shop_app/shop/domain/entities/deliveryman_entity.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../data/models/requests/deliver_man_adding_request.dart';
import '../../../../domain/use_cases/add_deliveryman_use_case.dart';
import '../../../../domain/use_cases/deliveryman_listing_use_case.dart';
import '../../../../domain/use_cases/edit_deliveryman_use_case.dart';
import '../../../../domain/use_cases/get_delivery_man_detail_use_case.dart';

part 'delivery_man_event.dart';
part 'delivery_man_state.dart';

class DeliveryManBloc extends Bloc<DeliveryManEvent, DeliveryManState> {
  final DeliveryManListingUseCase deliveryManListingUseCase;
  final AddDeliveryManUseCase addDeliveryManUseCase;
  final UpdateDeliveryManUseCase updateDeliveryManUseCase;
  final GetDeliveryManDetailUseCase getDeliveryManDetailUseCase;
  DeliveryManBloc(this.deliveryManListingUseCase, this.addDeliveryManUseCase,
      this.updateDeliveryManUseCase, this.getDeliveryManDetailUseCase)
      : super(DeliveryManInitial()) {
    on<DeliveryManEvent>((event, emit) {});
    on<GetDeliveryManListEvent>((event, emit) async {
      emit(DeliveryManLoading());
      try {
        currentPage = 1;
        totalPage = 1;
        final data = await deliveryManListingUseCase.call(
            DeliveryManListRequest(
                query: searchTextController.text,
                dateSort: event.sort,
                page: currentPage));
        deliveryManList = data.deliveryMan;
        currentPage = data.currentPageNo;
        totalPage = data.totalPages;
        sort = event.sort;
        emit(DeliveryManLoaded());
        // emit(DeliveryManLoading());
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
        emit(DeliveryManError());
      } catch (e) {
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
        emit(DeliveryManError());
      }
    });
    on<AddDeliveryManEvent>((event, emit) async {
      emit(DeliveryManLoading());
      try {
        await addDeliveryManUseCase
            .call(event.request)
            .then((value) => GoRouter.of(event.context).pop());

        emit(DeliveryManLoaded());
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
        emit(DeliveryManError());
      } catch (e) {
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
        emit(DeliveryManError());
      }
    });
    on<GetDeliveryManDetailEvent>((event, emit) async {
      emit(DeliveryManLoading());
      try {
        var data = await getDeliveryManDetailUseCase.call(event.id);
        fName.text = data.fName;
        lName.text = data.lName;
        email.text = data.email;
        initialCountryCode.value = data.phone;
        // phone.text = data.phone;
        // initialCountryCode.notifyListeners();
        // var phoneNumber = seperatePhoneAndDialCode(data.phone);
        //
        // if (phoneNumber != null) {
        //   phone.text = phoneNumber.phoneNumber;
        //   prettyPrint("country code ${phoneNumber.countryCode}");
        //   initialCountryCode.value = phoneNumber.countryCode;
        //   initialCountryCode.notifyListeners();
        // }
        phone.text = data.phone;
        selectedDropDown.value = getIdentityTypeString(data.identityType);
        selectedDropDown.notifyListeners();
        identityNumber.text = data.identityNumber;
        // identityImage = data.identityImage;
        password.text = "*********";
        emit(DeliveryManDetailLoaded(data));
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
        emit(DeliveryManError());
      } catch (e) {
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
        emit(DeliveryManError());
      }
    });
    on<UpdateDeliveryManEvent>((event, emit) async {
      emit(DeliveryManLoading());
      try {
        await updateDeliveryManUseCase
            .call(event.request)
            .then((value) => GoRouter.of(event.context).pop());

        emit(DeliveryManLoaded());
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
        emit(DeliveryManError());
      } catch (e) {
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
        emit(DeliveryManError());
      }
    });
    on<RefreshDeliveryManEvent>((event, emit) => emit(DeliveryManInitial()));
    on<GetPaginatedDeliveryManEvent>((event, emit) async {
      emit(DeliveryManMoreLoading());
      try {
        currentPage = currentPage + 1;
        if (currentPage != totalPage && currentPage < totalPage) {
          var data = await deliveryManListingUseCase.call(
              DeliveryManListRequest(
                  query: searchTextController.text,
                  dateSort: sort,
                  page: currentPage));
          deliveryManList.addAll(data.deliveryMan);
          emit(DeliveryManLoaded());
        } else {
          currentPage = totalPage;
        }
      } on UnauthorisedException {
        emit(DeliveryManLoaded());
        handleUnAuthorizedError(event.context);
      } catch (e) {
        emit(DeliveryManLoaded());
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
      }
    });
  }
  static DeliveryManBloc get(BuildContext context) => BlocProvider.of(context);
  String sort = "desc";
  int currentPage = 1;
  int totalPage = 1;

  List<DeliveryManEntity> deliveryManList = [];
  final fName = TextEditingController();
  final lName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final identityType = TextEditingController();
  final identityNumber = TextEditingController();
  final password = TextEditingController();
  final form = GlobalKey<FormState>();
  String image = "";
  String identityImage = "";
  String countryCode = "+91";

  changeImage(String im) {
    prettyPrint("CHANGING IMAGE PATH");
    image = im;
  }

  addDeliveryMan(BuildContext context) {
    prettyPrint("ADDING DELIVERY MAN WITH $image && $identityImage");
    add(AddDeliveryManEvent(
        context: context,
        request: DeliveryManAddRequest(
            image: image,
            fName: fName.text,
            lName: lName.text,
            email: email.text,
            phone: phone.text,
            identityNumber: identityNumber.text,
            identityImage: identityImage,
            password: password.text,
            identityType: identityType.text)));
  }

  updateDeliveryMan(BuildContext context, int id) {
    add(UpdateDeliveryManEvent(
        context,
        DeliveryManAddRequest(
            id: id,
            image: image,
            fName: fName.text,
            lName: lName.text,
            email: email.text,
            phone: phone.text,
            identityNumber: identityNumber.text,
            identityImage: identityImage.contains(AppRemoteRoutes.baseUrl)
                ? ""
                : identityImage,
            password: password.text,
            identityType: identityType.text)));
  }

  editValues(DeliveryManEntity entity) {
    // fName.text =entity.
  }
  ValueNotifier<String> selectedDropDown = ValueNotifier("Passport");
  final searchTextController = TextEditingController();
  String getIdentityTypeString(String type) {
    switch (type) {
      case "passport":
        return "Passport";
      default:
        return "Driving Licence";
    }
  }

  ValueNotifier<String?> initialCountryCode = ValueNotifier(null);
  clearALlValues() {
    searchTextController.clear();
    selectedDropDown.value = "Passport";
    fName.clear();
    lName.clear();
    email.clear();
    phone.clear();
    identityType.clear();
    identityNumber.clear();
    password.clear();
    image = "";
    identityImage = "";
  }
}
