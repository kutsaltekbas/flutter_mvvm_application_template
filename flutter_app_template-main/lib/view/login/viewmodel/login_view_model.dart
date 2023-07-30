
import '../../../view/login/model/login_model.dart';
import '../../../view/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../core/base/model/base_view_model.dart';
import 'package:mobx/mobx.dart';

import '../service/i_login_service.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  @observable
  bool isObscure = true;
  @observable
  bool isLoading = false;
  @observable
  bool isReady = false;
  @observable
  bool startAnimation = false;
  @observable
  bool hasError = false;

  int selectedLanguage = 0;

  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late ILoginService loginService;

  late LoginModel loginModel;

  @override
  void setContext(BuildContext context) => buildContext = context;
  @override
  Future<void> init() async {
    loginService = LoginService(vexanaManager.networkManager);
    await startAnimationSequence();
  }

  Future<void> startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 400));
    isReady = !isReady;
    await Future.delayed(const Duration(milliseconds: 100));
    startAnimation = !startAnimation;
  }

  @action
  changeHasError() {
    hasError = !hasError;
  }

  @action
  void changeIsObscure() {
    isObscure = !isObscure;
  }

  @action
  void changeIsLoading() {
    isLoading = !isLoading;
  }

  Future<void> login() async {
    FocusScope.of(buildContext!).unfocus();
    changeIsLoading();
    if (formKey.currentState != null) {
      formKey.currentState!.validate();
      hasError = !formKey.currentState!.isValid;
      if (formKey.currentState!.isValid) {
        loginModel = LoginModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        final response = await loginService.postLogin(loginModel);
        if (response != null) {
          if (response.type == true) {
            //navigate
          } else {
            showMessage(response);
          }
        }
      }
    }
    changeIsLoading();
  }
}
