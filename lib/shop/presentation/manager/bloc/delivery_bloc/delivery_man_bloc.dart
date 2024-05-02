import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/core/custom_exception.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/models/deliveryman_detail_model.dart';
import 'package:shop_app/shop/data/models/new/delivery_men_model.dart';
import 'package:shop_app/shop/data/routes/app_remote_routes.dart';
import 'package:shop_app/shop/domain/entities/deliveryman_entity.dart';
import 'package:shop_app/shop/domain/use_cases/get_delivery_men_use_case.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../domain/use_cases/add_delivery_men_use_case.dart';

part 'delivery_man_event.dart';
part 'delivery_man_state.dart';

class DeliveryManBloc extends Bloc<DeliveryManEvent, DeliveryManState> {
  final GetDeliveryMenUseCase deliveryManListingUseCase;
  final AddDeliveryMenUseCase addDeliveryManUseCase;

  DeliveryManBloc(
    this.deliveryManListingUseCase,
    this.addDeliveryManUseCase,
  ) : super(DeliveryManInitial()) {
    on<DeliveryManEvent>((event, emit) {});
    on<GetDeliveryManListEvent>((event, emit) async {
      emit(DeliveryManLoading());
      // try {
      currentPage = 1;
      totalPage = 1;
      final data = await deliveryManListingUseCase.call(currentPage);
      deliveryManList = data.results;
      hasMore = data.next != null;
      sort = event.sort;
      emit(DeliveryManLoaded());
      // emit(DeliveryManLoading());
      // } on UnauthorisedException {
      //   handleUnAuthorizedError(event.context);
      //   emit(DeliveryManError());
      // } catch (e) {
      //   handleError(
      //       event.context, e.toString(), () => Navigator.pop(event.context));
      //   emit(DeliveryManError());
      // }
    });
    on<AddDeliveryManEvent>((event, emit) async {
      emit(DeliveryManLoading());
      try {
        await addDeliveryManUseCase.call(event.request).then((value) {
          add(GetDeliveryManListEvent(context: event.context, sort: sort));
          GoRouter.of(event.context).pop();
        });

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
      // emit(DeliveryManLoading());
      // try {
      //   initialCountryCode.value = null;
      //   var data = await getDeliveryManDetailUseCase.call(event.id);
      //   fName.text = data.fName;
      //   lName.text = data.lName;
      //   email.text = data.email;
      //   initialCountryCode.value = data.phone;
      //   completePhone.text = data.phone;
      //   // phone.text = data.phone;
      //   initialCountryCode.notifyListeners();
      //   var phoneNumber = seperatePhoneAndDialCode(data.phone);
      //
      //   if (phoneNumber != null) {
      //     phone.text = phoneNumber.phoneNumber;
      //     prettyPrint("country code ${phoneNumber.countryCode}");
      //     initialCountryCode.value = phoneNumber.countryCode;
      //     Future.delayed(
      //         const Duration(
      //           seconds: 1,
      //         ), () {
      //       initialCountryCode.notifyListeners();
      //     });
      //   }
      //
      //   selectedDropDown.value = getIdentityTypeString(data.identityType);
      //   selectedDropDown.notifyListeners();
      //   identityNumber.text = data.identityNumber;
      //   // identityImage = data.identityImage;
      //   password.text = "*********";
      //   emit(DeliveryManDetailLoaded(data));
      // } on UnauthorisedException {
      //   handleUnAuthorizedError(event.context);
      //   emit(DeliveryManError());
      // } catch (e) {
      //   handleError(
      //       event.context, e.toString(), () => Navigator.pop(event.context));
      //   emit(DeliveryManError());
      // }
    });
    on<UpdateDeliveryManEvent>((event, emit) async {
      emit(DeliveryManLoading());
      try {
        await addDeliveryManUseCase.call(event.request).then((value) {
          add(GetDeliveryManListEvent(context: event.context, sort: sort));
          GoRouter.of(event.context).pop();
        });

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
        if (hasMore) {
          var data = await deliveryManListingUseCase.call(currentPage);
          hasMore = data.next != null;
          deliveryManList.addAll(data.results);
          emit(DeliveryManLoaded());
        } else {}
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
  bool hasMore = false;
  List<DeliveryMenResult> deliveryManList = [];
  final fName = TextEditingController();
  final lName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final completePhone = TextEditingController();
  final identityType = TextEditingController();
  final staffType = TextEditingController();
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
        request: DeliveryMenResult(
            firstName: fName.text,
            lastName: lName.text,
            email: email.text,
            phoneNumber: completePhone.text,
            idNumber: identityNumber.text,
            enable: true,
            idImage: identityImage.contains(AppRemoteRoutes.baseUrl)
                ? ""
                : identityImage,
            password: password.text,
            staffType: staffType.text,
            idType: identityType.text)));
  }

  updateDeliveryMan(BuildContext context, int id) {
    add(UpdateDeliveryManEvent(
        context,
        DeliveryMenResult(
            id: id,
            firstName: fName.text,
            lastName: lName.text,
            email: email.text,
            phoneNumber: completePhone.text,
            idNumber: identityNumber.text,
            enable: enable.value,
            idImage: identityImage.contains(AppRemoteRoutes.baseUrl)
                ? ""
                : identityImage,
            password: password.text,
            idType: identityType.text)));
  }

  editValues(DeliveryManEntity entity) {
    // fName.text =entity.
  }
  ValueNotifier<String> selectedDropDown = ValueNotifier("Passport");
  ValueNotifier<String> selectedDropDownType = ValueNotifier("delivery_boy");
  ValueNotifier<bool> enable = ValueNotifier(false);
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
    enable.value = false;
    fName.clear();
    lName.clear();
    email.clear();
    phone.clear();
    completePhone.clear();
    identityType.clear();
    identityNumber.clear();
    password.clear();
    image = "";
    identityImage = "";
  }
}
