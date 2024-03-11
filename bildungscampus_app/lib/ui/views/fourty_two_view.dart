import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/game/screens/start_game.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/views/feature_view.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FourtyTwoView extends StatelessWidget {
  const FourtyTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    final url = context.read<AppViewModel>().gitHubLink;

    return Scaffold(
      appBar: ReusableAppBars.standardAppBar(
        context,
        '42',
      ),
      body: FeatureView(
        featureType: FeatureType.fourtyTwo,
        children: [
          Container(
            color: Colors.white,
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.of(context).welcome_tile_hello,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontFamily: 'DINOT Bold',
                        color: AppColors.mainTextColor,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  S.of(context).fourtytwo_view_text,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.mainTextColor,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (url != null)
                  InkWell(
                    child: Text(
                      url,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.primaryTwoLightColor,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                    onTap: () async {
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                S.of(context).fourtytwo_view_snackbar_text(url),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const StartGame(),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTwoColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 8.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    S.of(context).fourtytwo_view_button_text,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
