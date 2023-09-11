import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

class StandardErrorDialog extends StatelessWidget {
  const StandardErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 200,
        margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
        child: Material(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.primaryOneColor,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox.expand(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.warning,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          S.of(context).error_dialog_title,
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          S.of(context).error_dialog_text,
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
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
