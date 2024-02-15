import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/feature_info.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/widgets/common/custom_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewFlag extends StatefulWidget {
  final FeatureInfo? featureInfo;
  final FeatureType featureType;

  const NewFlag(
      {required this.featureInfo, required this.featureType, super.key});

  @override
  State<NewFlag> createState() => _NewFlagState();
}

class _NewFlagState extends State<NewFlag> {
  late int _currentIndex;
  late CarouselController _controller;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;
    _controller = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final locale =
        context.select<UserViewModel, Locale?>((model) => model.locale);
    final shouldShowFeatureInfo = context
        .read<AppViewModel>()
        .shouldShowFeatureInfo(widget.featureType, widget.featureInfo);

    return FutureBuilder(
        future: shouldShowFeatureInfo,
        builder: (context, shouldShowFeatureInfo) {
          if (shouldShowFeatureInfo.data == null ||
              !shouldShowFeatureInfo.data!) {
            return const SizedBox.shrink();
          }

          return Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColors.newFlagBgColor,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    S.of(context).new_flag_widget_title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 24.0,
                          fontFamily: 'DINOT Bold',
                          letterSpacing: 0.3,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: CarouselSlider.builder(
                        carouselController: _controller,
                        itemCount: widget.featureInfo!.slides.length,
                        itemBuilder: (ctx, idx, readIndex) {
                          final page = widget.featureInfo!.slides[idx];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CustomNetworkImage(
                                  imagePath: page.image,
                                ),
                              ),
                              Text(
                                LocalizedTextUtils.getLocalizedText(
                                    page.title, locale),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      height: 1.6,
                                      letterSpacing: 0.19,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              if (page.text.isNotEmpty)
                                const SizedBox(height: 8),
                              if (page.text.isNotEmpty)
                                Text(
                                  LocalizedTextUtils.getLocalizedText(
                                      page.text, locale),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontSize: 12.0,
                                        letterSpacing: 0.3,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              const SizedBox(height: 24),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: Iterable<int>.generate(
                            widget.featureInfo!.slides.length)
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
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<AppViewModel>()
                              .saveFeatureInfoReadStatus(
                                  widget.featureType, widget.featureInfo!);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.newFlagButtonBgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          S
                              .of(context)
                              .new_flag_widget_close_button
                              .toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        });
  }
}
