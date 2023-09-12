import 'package:flutter/material.dart';

import 'package:resources/resources.dart';

class AppSolidPatternStatusBar extends StatelessWidget {
  const AppSolidPatternStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: R.pngs.topBarGround.image(
        width: double.infinity,
        height: MediaQuery.of(context).viewPadding.top,
        fit: BoxFit.cover,
      ),
    );
  }
}
