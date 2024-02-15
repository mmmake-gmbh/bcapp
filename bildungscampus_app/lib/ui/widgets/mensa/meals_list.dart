import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/mensa/mensa_meal_plan.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MealsList extends StatelessWidget {
  final DayPlan selectedDayPlan;

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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
