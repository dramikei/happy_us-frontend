import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StaticInfoCard extends StatelessWidget {
  static const id = 'StaticInfoCard';

  static final _points = [
    "Following a legal process to help a child reach a foster family, any concerned citizen can call Child-Line on 1098 to report an abandoned or orphaned child.",
    "The concerned citizen may also refer the child to the Specialized Adoption Agency, which is an authorized child shelter.",
    "One can find the nearest adoption agency by going to this link https://waic.in/report2020/ and selecting any state. The link will take you to the Central Adoption Resource Authority (CARA) page, which is part of the Department of Women and Children Development.",
    "With the exception of abandoned children and orphans, or in cases where parents or guardians decide they will not be able to raise a child, the child may be provided by the family by going to a Specialized Adoption Agency.",
    "When the specialised agencies receive a child they first enquire whether the child has any relative willing to look after them before declaring the child legally free. After the process the child would be available and put up for adoption by 30000 families willing to adopt them who have been assessed as eligible parents by cara, police, social workers. ",
  ];

  const StaticInfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final showRowLayout = size.width >= 950;
    return ListView(
      padding: EdgeInsets.all(size.width * 0.06),
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
                    "How to help others",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 25),
                  CustomText(
                    "As we all know covid 19 has made many children orphans  as loosing both their parents to  disease. It is important that such children enter the legal pool of adoption, not only for the welfare of the child but also for the legal protection of the entire adoptive family. If the procedure is not completed legally, the child may be separated from the adoptive parents, and the parents may even be arrested for child trafficking.",
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
