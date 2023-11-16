import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/intro.dart';
import 'package:bildungscampus_app/core/repositories/intro/intro_repository.dart';
import 'package:bildungscampus_app/core/viewmodels/privacy_viewmodel.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _InitialViewState();
}

class _InitialViewState extends State<IntroView> {
  late int _currentIndex;
  late CarouselController _controller;
  late List<Intro> _introPages;

  String _getButtonText() {
    if (_introPages.isNotEmpty && _currentIndex == _introPages.length - 1) {
      return S.of(context).intro_view_stop_intro;
    }

    return S.of(context).intro_view_skip_intro;
  }

  @override
  void initState() {
    _currentIndex = 0;
    _controller = CarouselController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _introPages = locator<IntroRepository>().getAllIntroPages(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.primaryOneColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Expanded(
                child: CarouselSlider.builder(
                    carouselController: _controller,
                    itemCount: _introPages.length,
                    itemBuilder: (ctx, idx, readIndex) {
                      final page = _introPages[idx];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                page.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      height: 1.6,
                                      letterSpacing: 0.07,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              if (page.subtitle.isNotEmpty)
                                const SizedBox(height: 10),
                              if (page.subtitle.isNotEmpty)
                                Text(
                                  page.subtitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontSize: 12.0,
                                        letterSpacing: 0.3,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Expanded(
                            child: Column(children: [
                              if (page.imageTitle.isNotEmpty)
                                Text(page.imageTitle),
                              Expanded(
                                child: Image.asset(
                                  page.imagePath,
                                ),
                              )
                            ]),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      height: height,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    )),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.privacyRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryTwoColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6), // <-- Radius
                      ),
                    ),
                    child: Text(
                      _getButtonText(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                    children: [
                      TextSpan(
                        text: S.of(context).intro_view_term_of_use_part1,
                      ),
                      TextSpan(
                        text: S.of(context).intro_view_term_of_use_part2,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            final url =
                                context.read<PrivacyViewModel>().termsOfUseLink;
                            launchUrlString(url);
                          },
                      ),
                      TextSpan(
                          text: S.of(context).intro_view_term_of_use_part3),
                      TextSpan(
                        text: S.of(context).intro_view_term_of_use_part4,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            final url = context
                                .read<PrivacyViewModel>()
                                .privacyAgreementLink;
                            launchUrlString(url);
                          },
                      ),
                      TextSpan(
                          text: S.of(context).intro_view_term_of_use_part5),
                    ]),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: Iterable<int>.generate(_introPages.length)
                    .toList()
                    .map((index) {
                  return InkWell(
                    child: Container(
                      width: 6.0,
                      height: 6.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 6.0,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? AppColors.initialIndicatorActiveColor
                              : AppColors.initialIndicatorColor),
                    ),
                    onTap: () {
                      _controller.animateToPage(index);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
