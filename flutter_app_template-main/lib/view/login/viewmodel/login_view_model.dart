import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/base/model/base_view_model.dart';
import 'package:mobx/mobx.dart';

import '../../../core/init/navigation/navigation_route.dart';
part 'login_view_model.g.dart';

// ignore: library_private_types_in_public_api
class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;
abstract class _LoginViewModelBase with Store, BaseViewModel {

@observable
bool isLoading = false;

  @override
  void setContext(BuildContext context) => buildContext = context;
  @override
  void init() {}

  @action
  void changeIsLoading() {
    isLoading = !isLoading;
  }
   void navigateHomePage() {
    buildContext!.router.replace(const HomeRoute());
  }
}