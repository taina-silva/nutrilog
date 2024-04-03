import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/utils/constants.dart';

class GraphicsPage extends StatefulWidget {
  const GraphicsPage({super.key});

  @override
  State<GraphicsPage> createState() => _GraphicsPageState();
}

class _GraphicsPageState extends State<GraphicsPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: Right(Padding(
          padding: const EdgeInsets.symmetric(vertical: DefaultPadding.nano),
          child: Image.asset(Assets.logo),
        )),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: DefaultMargin.vertical),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("${Assets.gifs}/coding.gif"),
            const AdaptiveText(
                text: 'Novidades estão por vir. Fique de olho!', textType: TextType.small),
          ],
        ),
      ),
    );
  }
}
