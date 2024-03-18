import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/mensa/mensa_meal_plan.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MealsList extends StatelessWidget {
  final DayPlan selectedDayPlan;
  final double rate = 3.0; //christina's changes

  const MealsList({super.key, required this.selectedDayPlan});

  String getIconName(MealCategories categories) {
    switch (categories) {
      case MealCategories.dessert:
        return SvgIcons.dessert;
      case MealCategories.dessertVegan:
        return SvgIcons.dessert;
      case MealCategories.soup:
        return SvgIcons.soup;
      case MealCategories.meat:
        return SvgIcons.meat;
      case MealCategories.vegan:
        return SvgIcons.vegan;
      case MealCategories.vegatarian:
        return SvgIcons.vegetarian;
    }
  }

  String getTranslations(BuildContext context, MealCategories categories) {
    switch (categories) {
      case MealCategories.dessert:
        return S.of(context).mensa_view_meal_categories_dessert;
      case MealCategories.dessertVegan:
        return S.of(context).mensa_view_meal_categories_dessert_vegan;
      case MealCategories.soup:
        return S.of(context).mensa_view_meal_categories_soup;
      case MealCategories.meat:
        return S.of(context).mensa_view_meal_categories_meat;
      case MealCategories.vegan:
        return S.of(context).mensa_view_meal_categories_vegan;
      case MealCategories.vegatarian:
        return S.of(context).mensa_view_meal_categories_vegetarian;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedDayPlan.isDisabled(DateTime.now())) {
      if (!selectedDayPlan.datum.isBefore(DateTime.now())) {
        return Center(
          child: Text(
            S.of(context).mensa_view_closed_text,
            style: const TextStyle(
              color: Color(0xFF979797),
              fontSize: 16,
              fontFamily: 'DIN OT',
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }

      return Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: S.of(context).mensa_view_in_the_past_label_part1,
                style: const TextStyle(
                  color: Color(0xFF979797),
                  fontSize: 16,
                  fontFamily: 'DIN OT',
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: S.of(context).mensa_view_in_the_past_label_part2,
                style: const TextStyle(
                  color: Color(0xFF979797),
                  fontSize: 16,
                  fontFamily: 'DIN OT',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.builder(
      itemCount: selectedDayPlan.linie?.length,
      itemBuilder: (context, idx) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 10,
          shadowColor: Colors.black26,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Selector<UserViewModel, Locale?>(
              selector: (_, viewModel) => viewModel.locale,
              builder: (context, locale, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        getIconName(selectedDayPlan.linie![idx].ausgabe),
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF2B78A7),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        getTranslations(
                            context, selectedDayPlan.linie![idx].ausgabe),
                        style: const TextStyle(
                          color: Color(0xFF2B78A7),
                          fontSize: 16,
                          fontFamily: 'DIN OT',
                          fontWeight: FontWeight.w700,
                          height: 0.06,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    locale?.languageCode == 'en'
                        ? selectedDayPlan.linie![idx].gericht.first.textEn
                        : selectedDayPlan.linie![idx].gericht.first.text,
                    style: const TextStyle(
                      color: Color(0xFF3B3B3B),
                      fontSize: 14,
                      fontFamily: 'DIN OT',
                      fontWeight: FontWeight.w700,
                      height: 0,
                      letterSpacing: 0.13,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),  //christina's changes
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start, // Align children to the start (left) of the row
                        children: [
                          Text(
                            'Rating: $rate / 5.0', //selectedDayPlan.linie![idx].gericht.first.rating,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'DIN OT',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.13,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(), // Add a spacer to push the right container to the right corner
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end, // Align children to the end (right) of the row
                        children: [
                          IgnorePointer(
                            ignoring: true, // Make the child non-interactive
                            child: RatingBar.builder(
                              initialRating: 3, //selectedDayPlan.linie![idx].gericht.first.rating,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
