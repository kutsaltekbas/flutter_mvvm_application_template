import 'package:auto_route/auto_route.dart';
import '../../../core/constants/enums/locale_keys_enum.dart';
import '../../../core/init/cache/locale_manager.dart';
import '../../../core/init/navigation/navigation_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/base/model/base_view_model.dart';
import 'package:mobx/mobx.dart';
part 'on_board_view_model.g.dart';

class OnBoardViewModel = _OnBoardViewModelBase with _$OnBoardViewModel;

abstract class _OnBoardViewModelBase with Store, BaseViewModel {
  @observable
  int pageIndex = 0;
  PageController controller = PageController();

  //! Uncomment this section to initialize images and texts
  // List<OnBoardModel> onBoardItems = [
  //   OnBoardModel(
  //     image: ImageConstants.instance.onBoard1,
  //     description: LocaleKeys.onBoard_description_1.locale,
  //   ),
  //   OnBoardModel(
  //     image: ImageConstants.instance.onBoard2,
  //     description: LocaleKeys.onBoard_description_2.locale,
  //   ),
  //   OnBoardModel(
  //     image: ImageConstants.instance.onBoard3,
  //     description: LocaleKeys.onBoard_description_3.locale,
  //   ),
  // ];

  @override
  void setContext(BuildContext context) => buildContext = context;
  @override
  void init() {}

  void changePageIndex(int value) {
    pageIndex = value;
  }

  void navigateLogin() {
    LocaleManager.instance.setBoolValue(PreferencesKeys.SHOW_ON_BOARD, true);
    buildContext!.router.push(const LoginRoute());
  }
}
