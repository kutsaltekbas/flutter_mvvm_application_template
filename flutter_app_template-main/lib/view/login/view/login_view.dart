import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mvvm_app_template/core/constants/image/lottie_constants.dart';
import 'package:flutter_mvvm_app_template/core/extension/context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/base/view/base_widget.dart';
import '../viewmodel/login_view_model.dart';

@RoutePage<String>(name: 'LoginRoute')
class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      viewModel: LoginViewModel(),
      onModelReady: (viewmodel) {
        viewmodel.setContext(context);
        viewmodel.init();
      },
      onPageBuilder: (context, viewmodel) {
        return Scaffold(
          body: Observer(
              builder: (context) => viewmodel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Container(
                        width: context.width,
                        height: context.height,
                        decoration: BoxDecoration(
                            color: context.colorScheme.background),
                        padding: context.paddingLow,
                        child: Column(
                          children: [
                            const Spacer(),
                            Text(
                              "WELCOME",
                              style: context.textTheme.displayLarge!
                                  .copyWith(color: context.colorScheme.primary),
                            ),
                            SizedBox(
                              width: 250.w,
                              height: 160.h,
                              child: LottieBuilder.asset(
                                LottieImageConstants.instance.login,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: context.paddingNormalHorizontal,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Mail",
                                textAlign: TextAlign.start,
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: context.colorScheme.primary),
                              ),
                            ),
                            SizedBox(
                                width: 330.w,
                                height: 60.h,
                                child: TextField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: context.colorScheme.primary,
                                      prefixIcon: Icon(
                                        Icons.mail_outline_outlined,
                                        color: context.colorScheme.background,
                                      )),
                                )),
                            SizedBox(height: 5.h),
                            Container(
                                padding: context.paddingNormalHorizontal,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Password",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                      color: context.colorScheme.primary),
                                )),
                            SizedBox(
                                width: 330.w,
                                height: 60.h,
                                child: TextField(
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: context.colorScheme.primary,
                                        prefixIcon: Icon(
                                          Icons.lock_outlined,
                                          color: context.colorScheme.background,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.visibility,
                                          color: context.colorScheme.background,
                                        )))),
                            Container(
                              padding: context.paddingLowHorizontal,
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forgot Password?",
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: context.colorScheme.onPrimary),
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w)),
                              width: 330.w,
                              height: 60.h,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          context.colorScheme.onSecondary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.w))),
                                  onPressed: viewmodel.navigateHomePage,
                                  child: Text(
                                    "Login",
                                    style: context.textTheme.displaySmall!
                                        .copyWith(
                                            color: context.colorScheme.primary),
                                  )),
                            ),
                            const Spacer()
                          ],
                        ),
                      ),
                    )),
        );
      },
    );
  }
}
