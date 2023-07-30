import 'package:auto_route/auto_route.dart';
import 'package:flutter_mvvm_app_template/core/init/navigation/navigation_route.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constants/enums/locale_keys_enum.dart';
import '../../../core/init/cache/locale_manager.dart';

part 'splash_view_model.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase with Store, BaseViewModel {
  @observable
  bool isStarted = false;

  @action
  void changeIsStarted() {
    isStarted = !isStarted;
  }

  Future<void> startTimer() async {
    await Future.delayed(const Duration(seconds: 1));
    changeIsStarted();
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void setContext(BuildContext context) => buildContext = context;
  @override
  void init() async {
    await startTimer();
    _navigateOnBoard();
  }

  Future<void> _navigateOnBoard() async {
    LocaleManager.instance.getBoolValue(PreferencesKeys.SHOW_ON_BOARD) == true
        ? LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN) != ''
            ? buildContext!.router.replace(const HomeRoute())
            : buildContext!.router.replace(const LoginRoute())
        : buildContext!.router.replace(const OnBoardRoute()); // if (LocaleManager.instance.getBoolValue(PreferencesKeys.IS_REVISIT_APP) == false) {
  }
}
