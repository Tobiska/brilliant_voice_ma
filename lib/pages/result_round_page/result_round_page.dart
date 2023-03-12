import 'package:brilliant_voices/pages/result_round_page/constants.dart';
import 'package:brilliant_voices/ui/view_models/result_round_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';

class ResultRoundPage extends StatelessWidget {
  const ResultRoundPage({Key? key}) : super(key: key);

  static Widget createWin() {
    return ChangeNotifierProvider(
      create: (context) => ResultViewModel.win(context: context),
      child: ResultRoundPage(),
    );
  }

  static Widget createLose() {
    return ChangeNotifierProvider(
      create: (context) => ResultViewModel.lose(context: context),
      child: ResultRoundPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
      ),
      body: Container(
        decoration: kBackgroundDecoration,
        child: Container(
          margin: kCommonPageMargin,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: double.infinity, height: 150),
            ResultTextField(),
            ResultImageWidget(),
            const ResumeButtonWidget(),
          ],
        )
        )
    )
    );
  }
}

class ResumeButtonWidget extends StatelessWidget {
  const ResumeButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 100),
        child: ResumeButton()
    );
  }
}

class ResultImageWidget extends StatelessWidget {
  const ResultImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResultViewModel model = context.read<ResultViewModel>();
    return Container(
        margin: EdgeInsets.only(top: 60),
        child: model.state.resultImage
    );
  }
}

class ResultTextField extends StatelessWidget {
  const ResultTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResultViewModel model = context.read<ResultViewModel>();
    return Center(child: Text(
      model.state.resultText,
      style: kTextResultStyle,
      textAlign: TextAlign.center,
    ));
  }
}


class ResumeButton extends StatelessWidget {
  const ResumeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResultViewModel model = context.read<ResultViewModel>();
    return Container(
      decoration: const BoxDecoration(
          color: kButtonColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            boxShadow
          ]
      ),
      child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          ),
          onPressed: () {
            model.onPressedNext();
          },
          child: Text(
            'Продолжить',
            style: kButtonTextStyle,
          )),
    );
  }
}
