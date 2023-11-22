import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/info/contact_info.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context
        .select<AppViewModel, ContactInfoV2?>((model) => model.contactInfo);

    return Scaffold(
      appBar: ReusableAppBars.transparentAppBarWithTitle(
        context,
        S.of(context).contact_view_title_backup,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        color: AppColors.primaryOneColor,
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: SafeArea(
          child: model != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontFamily: 'DINOT Bold'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      '${model.city}\n${model.street}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      model.phone,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      onTap: () async {
                        final params = Uri(
                          scheme: 'mailto',
                          path: model.email,
                        );

                        final url = params.toString();

                        if (await canLaunchUrlString(url)) {
                          await launchUrlString(url);
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(S
                                  .of(context)
                                  .contact_view_open_email_failed_message(
                                      model.email)),
                            ));
                          }
                        }
                      },
                      child: Text(
                        model.email,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.primaryTwoLightColor,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Selector<UserViewModel, Locale?>(
                      selector: (_, model) => model.locale,
                      builder: (context, locale, child) => Text(
                        model.getDescription(locale),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
