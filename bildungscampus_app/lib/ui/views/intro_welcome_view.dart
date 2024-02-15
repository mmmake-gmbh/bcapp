import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/shared/app_images.dart';
import 'package:flutter/material.dart';

class IntroWelcomeView extends StatelessWidget {
  const IntroWelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.5,
              1,
            ],
            colors: [
              Color.fromRGBO(29, 61, 106, 1),
              Color.fromRGBO(96, 169, 214, 1)
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AppImages.logoStiftung,
                width: 140,
              ),
              const SizedBox(
                height: 1,
              ),
              const SizedBox(
                height: 1,
              ),
              const SizedBox(
                height: 1,
              ),
              const SizedBox(
                height: 1,
              ),
              const SizedBox(
                height: 1,
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                S.of(context).intro_welcome_view_main_text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'DIN OT',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouter.loginRoute,
                            arguments: AppRouter.introRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.newFlagButtonBgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        S.of(context).intro_welcome_view_login_button,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'DIN OT',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouter.introRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        S.of(context).intro_welcome_view_skip_login_button,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'DIN OT',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: S
                          .of(context)
                          .intro_welcome_view_registration_text_part1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'DIN OT',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: S
                          .of(context)
                          .intro_welcome_view_registration_text_part2,
                      style: const TextStyle(
                        color: Color(0xFF11c1b0),
                        fontSize: 15,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
