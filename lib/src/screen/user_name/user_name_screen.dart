import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_button.dart';
import 'package:escape_anchovy/src/common/common_text_field.dart';
import 'package:escape_anchovy/src/common/common_validation_message.dart';
import 'package:escape_anchovy/src/screen/user_name/user_name_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  static const routeName = '/name';

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final _controller = UserNameController();

  @override
  void initState() {
    super.initState();
    _controller.nameFocus.addListener(() {
      _controller.isNameInputting = _controller.nameFocus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, snapshot) {
          return Scaffold(
            body: _buildPage(context),
          );
        });
  }

  Widget _buildPage(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    _controller.isLocaleKorean(context)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.hello,
                                style: TextStyles.h1Bold.copyWith(
                                    color: context.isLight
                                        ? DarkModeColors.background
                                        : LightModeColors.background),
                              ),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!.name,
                                  style: TextStyles.h1Bold.copyWith(
                                      color: context.isLight
                                          ? LightModeColors.blue
                                          : DarkModeColors.blue),
                                ),
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .name_explain,
                                  style: TextStyles.h1Bold.copyWith(
                                      color: context.isLight
                                          ? DarkModeColors.background
                                          : LightModeColors.background),
                                )
                              ])),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.hello,
                                style: TextStyles.h1Bold.copyWith(
                                    fontSize: 34,
                                    letterSpacing: 1.0,
                                    color: context.isLight
                                        ? DarkModeColors.background
                                        : LightModeColors.background),
                              ),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .name_explain,
                                  style: TextStyles.h1Bold.copyWith(
                                      color: context.isLight
                                          ? DarkModeColors.background
                                          : LightModeColors.background),
                                ),
                                TextSpan(
                                  text: AppLocalizations.of(context)!.name,
                                  style: TextStyles.h1Bold.copyWith(
                                      color: context.isLight
                                          ? LightModeColors.blue
                                          : DarkModeColors.blue),
                                ),
                              ])),
                            ],
                          ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                        child: Image.asset(context.isLight
                            ? 'assets/png/user_icon.png'
                            : 'assets/png/dark_user_icon.png')),
                    const SizedBox(
                      height: 50,
                    ),
                    CommonTextField(
                      maxLength: 8,
                      controller: _controller.nameController,
                      focusNode: _controller.nameFocus,
                      hintText: AppLocalizations.of(context)!.name_hint,
                      onChanged: (value) {
                        _controller.checkNameValidation(value);
                      },
                    ),
                    CommonValidationMessage(
                      isInputting: _controller.isNameInputting,
                      isValidation: _controller.isNameValid,
                      errorText: AppLocalizations.of(context)!.name_error_text,
                      passText: AppLocalizations.of(context)!.name_pass_text,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 25),
            child: SizedBox(
                width: double.maxFinite,
                height: 50,
                child: CommonButton(
                    text: AppLocalizations.of(context)!.completion,
                    onPressed: _controller.isNameValid
                        ? () => _controller.savedName(context)
                        : null)),
          ),
        )
      ],
    );
  }
}
