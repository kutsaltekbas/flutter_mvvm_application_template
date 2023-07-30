
import 'package:auto_route/auto_route.dart';

import '../../../core/constants/app/app_constants.dart';
import '../../../core/constants/image/image_constants.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../core/base/view/base_widget.dart';
import '../../_product/language_dropdown/language_dropdown.dart';
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
        return Material(
          child: Scaffold(
            backgroundColor: context.colorScheme.secondaryContainer,
            appBar: AppBar(
              elevation: 0,
              title: buildLogo(context),
              centerTitle: true,
              actions: [
                Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: context.colorScheme.onTertiary,
                    ),
                    const SizedBox(width: 10),
                    const LanguageDropdown(),
                  ],
                ),
              ],
            ),
            body: Observer(
              builder: (_) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        buildWhiteHeroContainer(context, viewmodel),
                        buildLoginButtonHeroWidget(context, viewmodel),
                        const Spacer(),
                      ],
                    ),
                    viewmodel.isLoading
                        ? Container(
                            color: context.colorScheme.onBackground.withOpacity(0.4),
                            width: context.width,
                            height: context.height,
                            child: const Center(child: CircularProgressIndicator()),
                          )
                        : Container(),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget buildWhiteHeroContainer(BuildContext context, LoginViewModel viewmodel) {
    return Hero(
      tag: ApplicationConstants.ON_BOARD_ID,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 375.w,
        height: MediaQuery.of(context).viewInsets.bottom.toInt() == 0
            ? !viewmodel.hasError
                ? 400.h
                : 410.h
            : !viewmodel.hasError
                ? 200.h
                : 220.h,
        color: context.colorScheme.background,
        child: Material(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MediaQuery.of(context).viewInsets.bottom.toInt() == 0 ? SizedBox(height: 20.h) : Container(),
                buildImage(context),
                buildForm(viewmodel, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildLogo(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: context.lowValue),
      height: 37.h,
      child: Image.asset(ImageConstants.instance.logo),
    );
  }

  AnimatedContainer buildImage(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: MediaQuery.of(context).viewInsets.bottom.toInt() == 0 ? 200.h : 0,
      child: const Center(
        child: Placeholder(),
        // child: Container(
        //   height: 200.h,
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //     image: AssetImage(
        //       ImageConstants.instance.onBoard3,
        //     ),
        //     fit: BoxFit.contain,
        //   )),
        // ),
      ),
    );
  }

  FormBuilder buildForm(LoginViewModel viewmodel, BuildContext context) {
    return FormBuilder(
      key: viewmodel.formKey,
      onChanged: () {
        viewmodel.formKey.currentState!.save();
      },
      child: Observer(
        builder: (_) {
          return Padding(
            padding: context.paddingNormalHorizontal,
            child: Column(
              children: [
                viewmodel.isReady
                    ? AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: viewmodel.startAnimation ? 1 : 0,
                        child: buildEmailTextField(context, viewmodel),
                      )
                    : Container(),
                viewmodel.isReady
                    ? AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: viewmodel.startAnimation ? 1 : 0,
                        child: buildPasswordTextField(context, viewmodel),
                      )
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }

  Column buildEmailTextField(BuildContext context, LoginViewModel viewmodel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: context.paddingLowVertical, child: Text(LocaleKeys.login_email.locale)),
        SizedBox(
          height: !viewmodel.hasError ? 44.h : 62.h,
          child: FormBuilderTextField(
            controller: viewmodel.emailController,
            name: 'email',
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.email(errorText: LocaleKeys.login_enter_valid_email.locale),
                FormBuilderValidators.required(errorText: LocaleKeys.login_email_required.locale),
              ],
            ),
            decoration: const InputDecoration(
              filled: true,
            ),
            style: context.textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }

  Column buildPasswordTextField(BuildContext context, LoginViewModel viewmodel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: context.paddingLowVertical, child: Text(LocaleKeys.login_password.locale)),
        Observer(builder: (_) {
          return SizedBox(
            height: !viewmodel.hasError ? 44.h : 62.h,
            child: FormBuilderTextField(
              controller: viewmodel.passwordController,
              name: 'password',
              obscureText: viewmodel.isObscure,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: LocaleKeys.login_password_required.locale),
              ]),
              decoration: InputDecoration(
                filled: true,
                suffixIcon: Observer(builder: (_) {
                  return GestureDetector(
                    onTap: viewmodel.changeIsObscure,
                    child: Icon(viewmodel.isObscure ? Icons.visibility : Icons.visibility_off),
                  );
                }),
              ),
              style: context.textTheme.headlineSmall,
            ),
          );
        }),
      ],
    );
  }

  Hero buildLoginButtonHeroWidget(BuildContext context, LoginViewModel viewmodel) {
    return Hero(
      tag: ApplicationConstants.LOGIN_BUTTON_ID,
      child: buildLoginButton(context, viewmodel),
    );
  }

  Container buildLoginButton(BuildContext context, LoginViewModel viewmodel) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      padding: context.paddingNormal,
      width: context.width,
      height: 70.h,
      child: ElevatedButton(
        onPressed: viewmodel.login,
        child: Text(LocaleKeys.login_login.locale),
      ),
    );
  }

  Text buildDontHaveAccountText(BuildContext context) {
    return Text(
      LocaleKeys.login_dont_have_account.locale,
      textAlign: TextAlign.center,
      style: context.textTheme.bodyLarge!.copyWith(
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Container buildRegisterButton(BuildContext context) {
    return Container(
        padding: context.paddingNormalHorizontal,
        width: context.width,
        height: 40.h,
        child: OutlinedButton(onPressed: () {}, child: Text(LocaleKeys.login_register.locale)));
  }
}
