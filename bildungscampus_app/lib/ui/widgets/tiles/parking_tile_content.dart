import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/parking_tile_viewmodel.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/carousel_tile_content.dart';

class ParkingTileContent extends StatelessWidget {
  final List<ParkingLotCategory> parkingCategories;
  final Color contentColor;
  final String? buttonText;
  final Color buttonTextColor;
  final Function? onTap;

  const ParkingTileContent({
    super.key,
    required this.parkingCategories,
    required this.contentColor,
    required this.buttonText,
    required this.buttonTextColor,
    this.onTap,
  });

  String _getCategoryTranslation(
      BuildContext context, ParkingLotCategory category) {
    switch (category) {
      case ParkingLotCategory.students:
        return S.of(context).parking_view_categories_students;
      case ParkingLotCategory.staff:
        return S.of(context).parking_view_categories_staff;
      case ParkingLotCategory.guests:
        return S.of(context).parking_view_categories_guests;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselTileContent<ParkingLotCategory>(
        items: parkingCategories,
        contentColor: Colors.white,
        builder: (ctx, model) {
          return Center(
            child: Text(
              "${S.of(context).privacy_view_tile_appendix} ${_getCategoryTranslation(context, model)}",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: contentColor,
                    height: 1.33,
                  ),
              textAlign: TextAlign.center,
            ),
          );
        },
        onSlideTap: (ctx, model) {
          if (onTap != null) {
            onTap!();
          }
        },
        onSlideChange: (newIndex) => context
            .read<ParkingTileViewModel>()
            .updateSelectedParkinglot(newIndex),
      ),
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: onTap as void Function()?,
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: SvgPicture.asset(
            SvgIcons.arrowRight,
            colorFilter: ColorFilter.mode(contentColor, BlendMode.srcIn),
            height: 16.0,
            width: 16.0,
          ),
        ),
      ),
    ]);
  }
}
