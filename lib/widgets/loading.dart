import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eat_well/theme/color_codes.dart';

class LoadingWidget extends StatelessWidget {
  final bool isImage;

  const LoadingWidget({this.isImage = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    if (isImage) {
      return const SpinKitRipple(
        color: secondaryColor,
      );
    } else {
      return const SpinKitChasingDots(
        color: secondaryColor,
      );
    }
  }
}
