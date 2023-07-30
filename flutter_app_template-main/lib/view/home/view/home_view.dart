import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app_template/core/constants/image/image_constants.dart';
import 'package:flutter_mvvm_app_template/core/extension/context_extension.dart';
import 'package:flutter_mvvm_app_template/core/extension/string_extension.dart';
import 'package:flutter_mvvm_app_template/core/init/lang/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/base/view/base_widget.dart';
import '../viewmodel/home_view_model.dart';

@RoutePage<String>(name: 'HomeRoute')
class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (viewmodel) {
        viewmodel.setContext(context);
        viewmodel.init();
      },
      onPageBuilder: (context, viewmodel) {
        return Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (ctx) {
                return IconButton(
                  onPressed: Scaffold.of(ctx).openDrawer,
                  icon: const Icon(Icons.menu),
                  color: context.colorScheme.onBackground,
                );
              },
            ),
            title: Text(
              LocaleKeys.home_appbar_title.locale,
              style: context.textTheme.labelLarge,
            ),
          ),
          body: const Column(),
          drawer: buildDrawer(context),
        );
      },
    );
  }

  ClipRRect buildDrawer(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
      child: Drawer(
          child: SafeArea(
        child: Padding(
          padding: context.paddingNormal,
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
                child: Image.asset(ImageConstants.instance.logo),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
