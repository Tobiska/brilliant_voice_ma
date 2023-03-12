
import 'package:brilliant_voices/pages/player_game_page/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/view_models/player_game_view_model.dart';
import '../common/constants.dart';
import '../common/widgets.dart';

class PlayerGamePage extends StatelessWidget {
  const PlayerGamePage({Key? key}) : super(key: key);

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => PlayerGameViewModel(context: context),
      child: PlayerGamePage(),
    );
  }


  @override
  Widget build(BuildContext context) {
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
          child: Stack(
            children:[
              Positioned(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: TimerField()),
              ),
              Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PlayerGridBox(),
                PlaceholderBox()
              ],
            ),
            ]
          ),
        ),
      ),
    );
  }
}

class PlaceholderBox extends StatelessWidget {
  const PlaceholderBox({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerGameViewModel model = context.watch<PlayerGameViewModel>();
    return Container(
      constraints: const BoxConstraints(
          minHeight: 225
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            model.state.placeholderFirst,
            model.state.placeHolderSecond
          ]
      ),
    );
  }
}

class PlayerGridBox extends StatelessWidget {
  const PlayerGridBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(
            minHeight: 200
        ),
        child: _PlayersGrid()
    );
  }
}

class _PlayersGrid extends StatelessWidget {
  const _PlayersGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerGameViewModel model = context.watch<PlayerGameViewModel>();
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

class ReadyButton extends StatelessWidget {
  const ReadyButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerGameViewModel model = context.read<PlayerGameViewModel>();
    return Container(
      decoration: const BoxDecoration(
          color: kReadyColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            boxShadow
          ]
      ),
      child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(53, 15, 53, 15),
          ),
          onPressed: () {
            model.onPressedReadyButton();
          },
          child: Text(
            'Готов',
            style: kButtonReadyTextStyle,
          )),
    );
  }
}

class WaitButton extends StatelessWidget {
  const WaitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: kWaitColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            boxShadow
          ]
      ),
      child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          ),
          onPressed: () {},
          child: Text(
            'Ожидание',
            style: kButtonWaitTextStyle,
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

class AnswerField extends StatelessWidget {
  const AnswerField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(217, 217, 217, 1),
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
          boxShadow: const [
            boxShadow
          ]
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      child: Center(
        child: _AnswerTextForm(),
      ),
    );
  }
}

class _AnswerTextForm extends StatelessWidget {
  _AnswerTextForm({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    PlayerGameViewModel model = context.watch<PlayerGameViewModel>();
    return TextField(
      onChanged: (text) {
        model.onChangedAnswerField(text);
      },
      enabled: model.state.isAnswerFieldLocked,
      style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Rostov',
          fontWeight: FontWeight.w400,
          color: Colors.black
      ),
    );
  }
}

class TimerField extends StatelessWidget {
  TimerField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerGameViewModel model = context.watch<PlayerGameViewModel>();
    return Text(
      model.state.time,
      style: const TextStyle(
          fontSize: 55,
          fontFamily: 'vcrosdmonorusbyd',
          fontWeight: FontWeight.w500,
          color: Colors.white
      ),

    );
  }
}




