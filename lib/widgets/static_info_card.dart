import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StaticInfoCard extends StatelessWidget {
  static const id = 'StaticInfoCard';

  static final _points = [
    'point1' * 20,
    'point2' * 15,
    'point3' * 11,
    'point4' * 18,
    'point5' * 18,
    'point6' * 18,
  ];

  const StaticInfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showRowLayout = MediaQuery.of(context).size.width >= 950;
    return ListView(
      padding: const EdgeInsets.all(50),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "Heading",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 25),
                  CustomText(
                    "Description" * 250,
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 25),
                  if (!showRowLayout) _buildTimeline(),
                ],
              ),
            ),
            if (showRowLayout) ...[
              const SizedBox(width: 25),
              Expanded(child: _buildTimeline()),
            ],
          ],
        ),
        Lottie.asset("assets/lottie/orphan.json", height: 300),
      ],
    );
  }

  Widget _buildTimeline() {
    final _completedStageIndex = _points.length - 1;
    final _selectedColor = kFocusColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _points.length,
        (index) => TimelineTile(
          isFirst: index == 0,
          isLast: index == _points.length - 1,
          beforeLineStyle: LineStyle(
            color: _completedStageIndex >= index ? _selectedColor : Colors.grey,
          ),
          afterLineStyle: LineStyle(
            color: _completedStageIndex <= index ? Colors.grey : _selectedColor,
          ),
          indicatorStyle: IndicatorStyle(
            height: 65,
            width: 65,
            indicator: EasyContainer(
              shadowColor:
                  _completedStageIndex < index ? Colors.grey : _selectedColor,
              color:
                  _completedStageIndex < index ? Colors.grey : _selectedColor,
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _completedStageIndex < index
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ),
          endChild: ListTile(
            title: CustomText(_points[index]),
            contentPadding: const EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
