import 'package:auto_route/auto_route.dart';

import '../../../core/constants/app/app_constants.dart';
import '../../../core/constants/image/image_constants.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/base/view/base_widget.dart';
import '../viewmodel/on_board_view_model.dart';

@RoutePage<String>(name: 'OnBoardRoute')
class OnBoardView extends StatelessWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OnBoardViewModel>(
      viewModel: OnBoardViewModel(),
      onModelReady: (viewmodel) {
        viewmodel.setContext(context);
        viewmodel.init();
      },
      onPageBuilder: (context, viewmodel) {
        return Material(
          child: Scaffold(
            backgroundColor: context.colorScheme.secondaryContainer,
            body: Column(
              children: [
                buildHeroContainer(context, viewmodel),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildWelcomeText(context),
                      buildPageDescriptionText(context, viewmodel),
                      buildHeroButton(viewmodel),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Hero buildHeroContainer(BuildContext context, OnBoardViewModel viewmodel) {
    return Hero(
      tag: ApplicationConstants.ON_BOARD_ID,
      child: Container(
        width: 375.w,
        height: 400.h,
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              buildLogo(),
              SizedBox(height: 20.h),
              buildImages(viewmodel),
              const Spacer(),
              buildPageIndicator(viewmodel, context),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildLogo() {
    return SizedBox(
      height: 37.h,
      child: Image.asset(ImageConstants.instance.logo),
    );
  }

  SizedBox buildImages(OnBoardViewModel viewmodel) {
    return SizedBox(
      height: 200.h,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: viewmodel.controller,
        onPageChanged: (value) {
          viewmodel.changePageIndex(value);
        },
        itemBuilder: (context, index) {
          return Center(
            child: Column(
              children: [
                Placeholder(fallbackHeight: 200.h),
                // SizedBox(
                //   height: 200.h,
                //   child: Image.asset(viewmodel.onBoardItems[index].image),
                // ),
              ],
            ),
          );
        },
        itemCount: 3,
      ),
    );
  }

  Observer buildPageIndicator(OnBoardViewModel viewmodel, BuildContext context) {
    return Observer(builder: (_) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: viewmodel.pageIndex == 0 ? 5.w : 3.w,
            backgroundColor: viewmodel.pageIndex == 0 ? context.colorScheme.primary : context.colorScheme.onSurface,
          ),
          SizedBox(width: 5.w),
          CircleAvatar(
            radius: viewmodel.pageIndex == 1 ? 5.w : 3.w,
            backgroundColor: viewmodel.pageIndex == 1 ? context.colorScheme.primary : context.colorScheme.onSurface,
          ),
          SizedBox(width: 5.w),
          CircleAvatar(
            radius: viewmodel.pageIndex == 2 ? 5.w : 3.w,
            backgroundColor: viewmodel.pageIndex == 2 ? context.colorScheme.primary : context.colorScheme.onSurface,
          ),
        ],
      );
    });
  }

  Text buildWelcomeText(BuildContext context) {
    return Text(
      LocaleKeys.on_board_welcome.locale,
      style: context.textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Observer buildPageDescriptionText(BuildContext context, OnBoardViewModel viewmodel) {
    return Observer(builder: (_) {
      return Padding(
        padding: context.paddingMediumHorizontal,
        child: Text(
          // viewmodel.onBoardItems[viewmodel.pageIndex].description,
          'Place holder text ${viewmodel.pageIndex}',
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium!.copyWith(color: context.colorScheme.onSurfaceVariant),
        ),
      );
    });
  }

  Hero buildHeroButton(OnBoardViewModel viewmodel) {
    return Hero(
      tag: ApplicationConstants.LOGIN_BUTTON_ID,
      child: SizedBox(
        width: 320.w,
        height: 40.h,
        child: ElevatedButton(
          onPressed: viewmodel.navigateLogin,
          child: Text(LocaleKeys.login_login.locale),
        ),
      ),
    );
  }
}
