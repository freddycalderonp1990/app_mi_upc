import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tab;
  final Widget? desktop;

  const ResponsiveWidget({
    Key? key,
    required this.mobile,
    this.tab,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 768) {
          return mobile;
        } else {
          if (tab != null) {
            return tab!;
          }
          return mobile;
        }
      },
    );
  }
}
