import 'package:escape_anchovy/src/common/common_dialog.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_svg.dart';

class ExCategoryDialog extends StatefulWidget {
  const ExCategoryDialog({super.key, required this.homeController});

  static const routeName = '/ex_category_dialog';

  final HomeController homeController;

  @override
  State<StatefulWidget> createState() {
    return _ExCategoryDialogState();
  }
}

class _ExCategoryDialogState extends State<ExCategoryDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.homeController,
      builder: (context, snapshot) {
        return CommonDialog(
          title: '운동항목 설정',
          explain: '각 항목에서 운동을 하나씩 선택해주세요',
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      '항목1',
                      style: TextStyles.b1Regular.copyWith(
                          color: context.isLight
                              ? LightModeColors.dark2
                              : DarkModeColors.dark2),
                    ),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.homeController.isSelected1 = true;
                        widget.homeController.isSelected2 = false;
                      });
                    },
                    child: Column(
                      children: [
                        const CommonSvg(src: 'assets/svg/pull_up.svg'),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '풀업',
                          style: TextStyles.b3Regular.copyWith(
                              color: widget.homeController.isSelected1
                                  ? (context.isLight
                                      ? LightModeColors.green
                                      : DarkModeColors.green)
                                  : (context.isLight
                                      ? DarkModeColors.background
                                      : LightModeColors.background)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 36,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.homeController.isSelected1 = false;
                        widget.homeController.isSelected2 = true;
                      });
                    },
                    child: Column(
                      children: [
                        const CommonSvg(src: 'assets/svg/chin_up.svg'),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '친업',
                          style: TextStyles.b3Regular.copyWith(
                              color: widget.homeController.isSelected2
                                  ? (context.isLight
                                      ? LightModeColors.green
                                      : DarkModeColors.green)
                                  : (context.isLight
                                      ? DarkModeColors.background
                                      : LightModeColors.background)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      '항목2',
                      style: TextStyles.b1Regular.copyWith(
                          color: context.isLight
                              ? LightModeColors.dark2
                              : DarkModeColors.dark2),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.homeController.isSelected3 = true;
                        widget.homeController.isSelected4 = false;
                      });
                    },
                    child: Column(
                      children: [
                        const CommonSvg(src: 'assets/svg/push_up.svg'),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '푸쉬업',
                          style: TextStyles.b3Regular.copyWith(
                              color: widget.homeController.isSelected3
                                  ? (context.isLight
                                      ? LightModeColors.green
                                      : DarkModeColors.green)
                                  : (context.isLight
                                      ? DarkModeColors.background
                                      : LightModeColors.background)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.homeController.isSelected3 = false;
                        widget.homeController.isSelected4 = true;
                      });
                    },
                    child: Column(
                      children: [
                        const CommonSvg(src: 'assets/svg/nuckle_push_up.svg'),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '너클 푸쉬업',
                          style: TextStyles.b3Regular.copyWith(
                              color: widget.homeController.isSelected4
                                  ? (context.isLight
                                      ? LightModeColors.green
                                      : DarkModeColors.green)
                                  : (context.isLight
                                      ? DarkModeColors.background
                                      : LightModeColors.background)),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          buttonHeight: 42,
          onPressed: () {
            widget.homeController.saveCategory(
                widget.homeController.isSelected1,
                widget.homeController.isSelected2,
                widget.homeController.isSelected3,
                widget.homeController.isSelected4);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
