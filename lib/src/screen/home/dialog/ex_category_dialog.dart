import 'package:flutter/material.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_button.dart';
import 'package:escape_anchovy/src/common/common_svg.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';

class ExCategoryDialog extends StatefulWidget {
  const ExCategoryDialog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExCategoryDialogState();
  }
}

class _ExCategoryDialogState extends State<ExCategoryDialog> {
  final _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, snapshot) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: SizedBox(
              height: 310,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          '운동항목 설정',
                          style: TextStyles.b2Medium,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '각 항목에서 운동을 하나씩 선택해주세요',
                          style: TextStyles.b4Regular.copyWith(
                              color: context.isLight
                                  ? LightModeColors.dark3
                                  : DarkModeColors.dark3),
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
                                  _controller.isSelected1 =
                                      !_controller.isSelected1;
                                  _controller.isSelected2 =
                                      !_controller.isSelected2;
                                });
                              },
                              child: Column(
                                children: [
                                  const CommonSvg(
                                      src: 'assets/svg/pull_up.svg'),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '풀업',
                                    style: TextStyles.b3Regular.copyWith(
                                        color: _controller.isSelected1
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
                                  _controller.isSelected1 =
                                      !_controller.isSelected1;
                                  _controller.isSelected2 =
                                      !_controller.isSelected2;
                                });
                              },
                              child: Column(
                                children: [
                                  const CommonSvg(
                                      src: 'assets/svg/chin_up.svg'),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '친업',
                                    style: TextStyles.b3Regular.copyWith(
                                        color: _controller.isSelected2
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
                                  _controller.isSelected3 =
                                      !_controller.isSelected3;
                                  _controller.isSelected4 =
                                      !_controller.isSelected4;
                                });
                              },
                              child: Column(
                                children: [
                                  const CommonSvg(
                                      src: 'assets/svg/push_up.svg'),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '푸쉬업',
                                    style: TextStyles.b3Regular.copyWith(
                                        color: _controller.isSelected3
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
                                  _controller.isSelected3 =
                                      !_controller.isSelected3;
                                  _controller.isSelected4 =
                                      !_controller.isSelected4;
                                });
                              },
                              child: Column(
                                children: [
                                  const CommonSvg(
                                      src: 'assets/svg/nuckle_push_up.svg'),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '너클 푸쉬업',
                                    style: TextStyles.b3Regular.copyWith(
                                        color: _controller.isSelected4
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
                  ),
                  CommonButton(
                    text: '완료',
                    height: 45,
                    onPressed: () async {
                      _controller.saveCategory();
                      Navigator.pop(context);
                    },
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
