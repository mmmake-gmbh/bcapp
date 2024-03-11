import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/intro.dart';
import 'package:bildungscampus_app/core/repositories/intro/intro_repository.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: CarouselSlider.builder(
                  carouselController: _controller,
                  itemCount: _introPages.length,
                  itemBuilder: (ctx, idx, readIndex) {
                    final page = _introPages[idx];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
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
                        ),
                        const SizedBox(height: 30),
                        Expanded(
                          child: Column(children: [
                            if (page.imageTitle.isNotEmpty)
                              Text(page.imageTitle),
                            Expanded(
                              child: Image.asset(
                                page.imagePath,
                                fit: BoxFit.fitWidth,
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
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.privacyRoute);
                },
                child: Text(
                  _getButtonText(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white60,
                        color: Colors.white60,
                        fontSize: 18.0,
                      ),
                ),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: Iterable<int>.generate(_introPages.length)
                    .toList()
                    .map((index) {
                  return InkWell(
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 6.0,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? const Color(0xFF11C1B0)
                              : AppColors.initialIndicatorColor),
                    ),
                    onTap: () {
                      _controller.animateToPage(index);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
