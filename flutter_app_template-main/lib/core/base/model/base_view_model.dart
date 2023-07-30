import 'package:flutter/material.dart';

import '../../init/cache/locale_manager.dart';
import '../../init/network/vexana_manager.dart';
import 'base_response_model.dart';

abstract class BaseViewModel {
  BuildContext? buildContext;

  VexanaManager vexanaManager = VexanaManager.instance;
  LocaleManager localeManager = LocaleManager.instance;
  void setContext(BuildContext context);

  void init();

  void showMessage(BaseResponseModel? model) {
    if (model == null) return;
    ScaffoldMessenger.of(buildContext!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          model.message ?? model.type.toString(),
        ),
        backgroundColor: model.type! ? Colors.green : Colors.red,
      ),
    );
  }
}
