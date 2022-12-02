import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/core/custom_exception.dart';
import 'package:shop_app/core/response_classify.dart';
import 'package:shop_app/shop/data/models/login_response.dart';
import 'package:shop_app/shop/data/routes/hive_storage_name.dart';

import '../../../../domain/use_cases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoginWithPassword>((event, emit) async {
      var response = ResponseClassify<LoginResponse>.loading();
      emit(LoginLoadingState());
      try {
        response = ResponseClassify<LoginResponse>.completed(await loginUseCase
            .call(email: event.email, password: event.password));
        emit(LoginDataFetchedState(response.data!));
        GetStorage storage = GetStorage();
        storage.write(LocalStorageNames.token, response.data!.token);
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
      emit(PasswordEyeState(event.shown));
    });
  }
  static LoginBloc get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

}
