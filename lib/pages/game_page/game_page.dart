
import 'package:brilliant_voices/pages/game_page/constants.dart';
import 'package:brilliant_voices/ui/view_models/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';
import '../common/widgets.dart';

class OwnerGamePage extends StatelessWidget {
  const OwnerGamePage({Key? key}) : super(key: key);

  static Widget createStartGame() {
    return ChangeNotifierProvider(
      create: (context) => GameViewModel(context: context),
      child: OwnerGamePage(),
    );
  }

  static Widget createDuringGame() {
    return ChangeNotifierProvider(
      create: (context) => GameViewModel.duringGame(context: context),
      child: OwnerGamePage(),
    );
  }


  @override
  Widget build(BuildContext context) {
    GameViewModel model = context.watch<GameViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kMainColor,
        leadingWidth: 65,
        leading: const BackButtonWidget(),
      ),
      body: Container(
        decoration: kBackgroundDecoration,
        child: Container(
          width: double.infinity,
          margin: kCommonPageMargin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  constraints: const BoxConstraints(
                    minHeight: 162
                  ),
                  child: _PlayersGrid()
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: 225
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      model.state.placeholderFirst,
                      model.state.placeHolderSecond
                    ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



class _PlayersGrid extends StatelessWidget {
  const _PlayersGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameViewModel model = context.watch<GameViewModel>();
    return Container(
    constraints: const BoxConstraints(
    maxHeight: 300,
    ),
    child: Wrap(
      clipBehavior: Clip.hardEdge,
      runSpacing: 33,
      spacing: 42,
      children: model.state.playerCards,
    ),
        );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameViewModel model = context.read<GameViewModel>();
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
            padding: const EdgeInsets.fromLTRB(53, 15, 53, 15),
          ),
          onPressed: () {
            model.onPressedStartButton();
          },
          child: Text(
            'Старт',
            style: kButtonTextStyle,
          )),
    );
  }
}

class PlayerCard extends StatelessWidget {
  const PlayerCard({Key? key, required this.username}): super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(5, 7),
                        color: Colors.black
                    )
                  ]
              ),
              child: Image.asset("assets/images/unknown.png", width: 78, height: 78)),
        ),
        Text(username, style: const TextStyle(
          fontFamily: 'Rostov',
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),)
      ],
    );
  }
}

class QuestionField extends StatelessWidget {
  const QuestionField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameViewModel model = context.watch<GameViewModel>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      constraints: const BoxConstraints(
          maxWidth: 300,
          maxHeight: 100
      ),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(217, 217, 217, 1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
          boxShadow: const [
            boxShadow
          ]
      ),
      child: Center(
          child: Text(model.state.question, style: kTextFormStyle)
      ),
    );
  }
}

class TimerField extends StatelessWidget {
  TimerField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameViewModel model = context.watch<GameViewModel>();
    return Container(
      width: 187,
      height: 75,
      decoration: BoxDecoration(
          color: Color.fromRGBO(27, 24, 24, 1),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
          boxShadow: const [
            boxShadow
          ]
      ),
      // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Center(
        child: Text(
      model.state.time,
    style: const TextStyle(
    fontSize: 55,
    fontFamily: 'vcrosdmonorusbyd',
    fontWeight: FontWeight.w500,
    color: Colors.white
    ),
      ),
    )
    );
  }
}





