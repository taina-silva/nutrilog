import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class CustomScaffold extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Color backgroundColor;
  final Color statusBarColor;

  const CustomScaffold({
    Key? key,
    this.appBar = const SizedBox(),
    this.body = const SizedBox(),
    this.floatingActionButton,
    this.backgroundColor = CColors.primaryBackground,
    this.statusBarColor = CColors.primaryBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            color: statusBarColor,
          ),
          appBar,
          Expanded(child: body),
        ],
      ),
    );
  }
}
