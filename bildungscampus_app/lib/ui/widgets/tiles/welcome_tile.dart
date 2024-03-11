import 'package:auto_size_text/auto_size_text.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeTile extends StatefulWidget {
  const WelcomeTile({super.key, required this.firstLogin});

  final bool firstLogin;

  @override
  State<WelcomeTile> createState() => _WelcomeTileState();
}

class _WelcomeTileState extends State<WelcomeTile>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    if (widget.firstLogin) {
      _controller.repeat(reverse: true);

      Future.delayed(const Duration(milliseconds: 4400), () {
        if (mounted) {
          setState(() {
            _controller.stop();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = context.select<UserViewModel, String?>(
      (value) => value.userName,
    );

    const handWidget = Text(
      '👋',
      style: TextStyle(fontSize: 70, height: 1),
    );

    final firstLine = userName != null && userName.isNotEmpty
        ? S.of(context).welcome_tile_hello
        : S.of(context).welcome_tile_no_user_text;

    final secondLine = userName != null && userName.isNotEmpty ? userName : "";

    return Container(
      padding: const EdgeInsets.all(4.0),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  firstLine,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontFamily: 'DINOT Bold',
                      color: Colors.white,
                      backgroundColor: AppColors.welcomeTileTextBgColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: AutoSizeText(
                    secondLine,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontFamily: 'DINOT Bold',
                        color: Colors.white,
                        backgroundColor: AppColors.welcomeTileTextBgColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          if (widget.firstLogin)
            RotationTransition(
                turns: Tween(begin: -0.1, end: 0.1).animate(_controller),
                child: handWidget),
          if (!widget.firstLogin) handWidget
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
