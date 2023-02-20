import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/core/response_classify.dart';
import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/login_response.dart';
import 'package:shop_app/shop/data/models/requests/change_account_detail_model.dart';
import 'package:shop_app/shop/data/routes/hive_storage_name.dart';
import 'package:shop_app/shop/domain/entities/account_detail_enitity.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../../core/custom_exception.dart';
import '../../../../domain/use_cases/change_account_detail_use_case.dart';
import '../../../../domain/use_cases/change_password_use_case.dart';
import '../../../../domain/use_cases/get_account_details_use_case.dart';
import '../../../../domain/use_cases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final GetAccountDetailUseCase getAccountDetail;
  final ChangePasswordUseCase changePasswordUseCase;
  final ChangeAccountDetailUseCase changeAccountDetailUseCase;
  LoginBloc(this.loginUseCase, this.getAccountDetail,
      this.changePasswordUseCase, this.changeAccountDetailUseCase)
      : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoginWithPassword>((event, emit) async {
      var response = ResponseClassify<LoginResponse>.loading();
      emit(LoginLoadingState());
      try {
        response = ResponseClassify<LoginResponse>.completed(
            await loginUseCase.call(
                email: event.email,
                password: event.password,
                type: event.type));
        emit(LoginDataFetchedState(response.data!));

        GetStorage storage = GetStorage();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(LocalStorageNames.token, response.data!.token);
        storage.write(LocalStorageNames.token, response.data!.token);
        await prefs.setString(LocalStorageNames.userData,
            jsonEncode(response.data!.userData.toJson()));
        await prefs.setInt(LocalStorageNames.type, event.type);
        event.onSuccess();
      } on UnauthorisedException {
        Map<String, dynamic> data = jsonDecode(response.error ?? "{}");
        // List<String> errors = data["errors"].map((x) => x['message']);

        event.onError(data.toString());
        emit(LoginErrorState(data.toString()));
      } catch (e) {
        emit(LoginErrorState(e.toString()));
        event.onError(e.toString());
      }
    });
    on<ShowPasswordEvent>((event, emit) {
      prettyPrint("emitting state");
      emit(PasswordEyeState(showPassWord));
    });
    on<GetAccountDetailEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final data = await getAccountDetail.call(NoParams());

        emit(AccountDetailFetchedState(data));
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
        emit(const LoginErrorState("something went wrong"));
      } catch (e) {
        emit(LoginErrorState(e.toString()));
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
      }
    });
    on<ChangePasswordEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        await changePasswordUseCase.call(event.password);
        emit(ChangePasswordState());
      } catch (e) {
        emit(LoginErrorState(e.toString()));
      }
    });
    on<ChangeAccountDetailsEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        await changeAccountDetailUseCase.call(event.model).then((value) {
          ScaffoldMessenger.of(event.context)
              .showSnackBar(const SnackBar(content: Text("Profile updated")));
          add(GetAccountDetailEvent(event.context));
          Navigator.of(event.context).pop();
        });

        emit(ChangePasswordState());
      } catch (e) {
        emit(LoginErrorState(e.toString()));
      }
    });
  }

  static LoginBloc get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String image = "";
  bool showPassWord = false;

  logOut(BuildContext context) async {
    SharedPreferences.getInstance().then((value) {
      value.clear();
      GetStorage storage = GetStorage();
      storage.remove(LocalStorageNames.token);
      storage.remove(LocalStorageNames.userData);
      GoRouter.of(context).replaceNamed(AppPages.login);
    });
  }
}
