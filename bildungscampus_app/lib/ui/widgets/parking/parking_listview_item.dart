import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:bildungscampus_app/ui/widgets/parking/parking_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/core/viewmodels/parking/parkinglot_viewmodel.dart';

class ParkingListViewItem extends StatelessWidget {
  final ParkingLotCategory category;

  const ParkingListViewItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final locale = context.select<UserViewModel, Locale?>(
        (userViewModel) => userViewModel.locale);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 10,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Consumer<ParkingLotViewModel>(
            builder: (ctx, model, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.parkingLot.getTitle(locale),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: AppColors.primaryOneColor,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              model.parkingLot.street,
                              style: const TextStyle(
                                color: AppColors.parkingCardSubtitleColor,
                              ),
                            ),
                            Text(
                              model.parkingLot.city,
                              style: const TextStyle(
                                color: AppColors.parkingCardSubtitleColor,
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    final navigated = await context
                                        .read<ParkingLotViewModel>()
                                        .navigateTo();

                                    if (!navigated && context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(S
                                              .of(context)
                                              .parkinglot_view_google_maps_error_text),
                                        ),
                                      );
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 16),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          fontSize: 12.0,
                                          height: 1.33,
                                          letterSpacing: 0.3,
                                          decoration: TextDecoration.underline,
                                          color: AppColors.primaryTwoColor,
                                          decorationColor:
                                              AppColors.primaryTwoColor,
                                        ),
                                  ),
                                  child: Text(
                                    S
                                        .of(context)
                                        .parkinglot_view_google_maps_text,
                                    style: const TextStyle(
                                      color: AppColors.primaryTwoColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            S
                                .of(context)
                                .parking_view_parkinglistitem_occupancy_text(
                                    model.parkingLot.availableCapacity
                                        .toString()),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: AppColors.primaryOneColor,
                                ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              if (model.parkingLot.disabledTotalCapacity > 0)
                                ParkingBadge(
                                    text: model
                                        .parkingLot.disabledAvailableCapacity
                                        .toString(),
                                    iconPath: SvgIcons.wheelchair),
                              const SizedBox(
                                width: 6,
                              ),
                              if (model.parkingLot.eAutoTotalCapacity > 0)
                                ParkingBadge(
                                    text: model
                                        .parkingLot.eAutoAvailableCapacity
                                        .toString(),
                                    iconPath: SvgIcons.thunder),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        model.parkingLot.getPriceHeader(locale),
                        style: const TextStyle(
                          color: AppColors.primaryOneColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (model.parkingLot.priceItems.isEmpty &&
                          category == ParkingLotCategory.students)
                        Container(
                          height: 80,
                          color: AppColors.parkingViewEmptyPriceBgColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  SvgIcons.info,
                                  height: 24,
                                  width: 24,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.parkingViewEmptyPriceTextColor,
                                      BlendMode.srcIn),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      S
                                          .of(context)
                                          .parkinglot_view_students_category_description_text,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: AppColors
                                                .parkingViewEmptyPriceTextColor,
                                          ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: ShapeDecoration(
                          color: const Color.fromRGBO(250, 250, 250, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Column(
                          children: [
                            ...model.parkingLot.priceItems.map((priceItem) =>
                                Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(priceItem.getTitle(locale)),
                                      ),
                                      Text(
                                        priceItem.getDescription(locale),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  if (model.parkingLot.priceItems
                                          .indexOf(priceItem) !=
                                      model.parkingLot.priceItems.length - 1)
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      height: 1,
                                      width: double.infinity,
                                      color: const Color.fromRGBO(
                                          245, 245, 245, 1),
                                    )
                                ])),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                  Text(
                    model.parkingLot.getAdditionalInformation(locale),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 9,
                      fontFamily: 'DIN OT',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.30,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
