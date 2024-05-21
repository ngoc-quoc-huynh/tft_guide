import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tft_guide/static/resources/assets.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.actions,
    super.key,
  }) : super(
          centerTitle: true,
          title: SvgPicture.asset(
            Assets.logo.path,
            height: kToolbarHeight,
          ),
        );
}
