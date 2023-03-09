import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/viewmodels/privacy_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/widgets/common/custom_checkbox.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({Key? key}) : super(key: key);

  void _formButtonPressed(BuildContext context) async {
    await Provider.of<PrivacyViewModel>(context, listen: false).acceptTerms();

    if (context.mounted) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRouter.homeRoute, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.primaryOneColor,
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: SafeArea(
          child: FutureBuilder(
            future:
                Provider.of<PrivacyViewModel>(context, listen: false).load(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Consumer<PrivacyViewModel>(
                builder: (context, viewmodel, child) => Column(
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      S.of(context).privacy_view_headline_text,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              CustomCheckbox(
                                  value: viewmodel.termsOfUse,
                                  onChanged: (newValue) =>
                                      Provider.of<PrivacyViewModel>(context,
                                              listen: false)
                                          .setTermsOfUse(newValue ?? false)),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      children: [
                                        TextSpan(
                                          text: S
                                              .of(context)
                                              .privacy_view_terms_of_use_text_part1,
                                        ),
                                        TextSpan(
                                            text: S
                                                .of(context)
                                                .privacy_view_terms_of_use_text_part2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: AppColors
                                                        .primaryTwoLightColor),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                final url = Provider.of<
                                                            PrivacyViewModel>(
                                                        context,
                                                        listen: false)
                                                    .termsOfUseLink;
                                                launchUrlString(url);
                                              }),
                                      ]),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 60),
                          Row(
                            children: [
                              CustomCheckbox(
                                  value: viewmodel.privacyAgreement,
                                  onChanged: (newValue) =>
                                      Provider.of<PrivacyViewModel>(context,
                                              listen: false)
                                          .setPrivacyAgreement(newValue)),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      children: [
                                        TextSpan(
                                          text: S
                                              .of(context)
                                              .privacy_view_privacy_agreement_text_part1,
                                        ),
                                        TextSpan(
                                            text: S
                                                .of(context)
                                                .privacy_view_privacy_agreement_text_part2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: AppColors
                                                        .primaryTwoLightColor),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                final url = Provider.of<
                                                            PrivacyViewModel>(
                                                        context,
                                                        listen: false)
                                                    .privacyAgreementLink;
                                                launchUrlString(url);
                                              }),
                                        TextSpan(
                                          text: S
                                              .of(context)
                                              .privacy_view_privacy_agreement_text_part3,
                                        ),
                                      ]),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (!viewmodel.formValid)
                            ? null
                            : () => _formButtonPressed(context),
                        style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryTwoColor,
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge!)
                            .copyWith(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return AppColors.disabledButtonBgColor;
                              }
                              return AppColors.primaryTwoColor;
                            },
                          ),
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return AppColors.disabledButtonTextColor;
                              }
                              return Colors.white;
                            },
                          ),
                        ),
                        child: Text(
                          S.of(context).privacy_view_accept_button_text,
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
