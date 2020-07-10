import 'package:flutter/material.dart';
import 'package:tasks_flutter/ui/core_ui/spacing.dart';
import 'package:tasks_flutter/ui/styles/values.dart';
import 'package:tasks_flutter/ui/core_ui/exts.dart';

class PageTemplate extends StatelessWidget {
  final List children;
  final bool showBackButton;
  final bool overscroll;

  PageTemplate(
      {this.children, this.showBackButton = false, this.overscroll = true});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        padding: EdgeInsets.only(
          // top: statusBarHeight,
          left: Values.pageHorizontalPadding,
          right: Values.pageHorizontalPadding,
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            Spacing(height: statusBarHeight).sliver(),
            if (showBackButton)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacing(height: Values.marginBelowTitle),
                  Spacing(height: Values.marginBelowTitle),
                ],
              ).sliverToBoxAdapter()
            else
              Spacing(height: 20).sliver(),

            ...children,

            // allow for some overscroll
            // this is a feature, not a bug
            if (overscroll) ...[
              Spacing(height: 240).sliver(),
            ]
          ],
        ),
      ),
    );
  }

  Widget scaffold() {
    return Scaffold(
      body: this,
    );
  }
}
