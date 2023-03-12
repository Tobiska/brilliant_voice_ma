import 'package:brilliant_voices/pages/show_answers_page/constants.dart';
import 'package:brilliant_voices/ui/view_models/show_answers_view_model.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';
import '../common/widgets.dart';

class ShowAnswersPage extends StatelessWidget {
  const ShowAnswersPage({Key? key}) : super(key: key);

  static Widget create() {
    return ChangeNotifierProvider(
        create: (context) => ShowAnswerViewModel(context: context),
        child: ShowAnswersPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ShowAnswerViewModel model = context.watch<ShowAnswerViewModel>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kMainColor,
        leadingWidth: 65,
        leading: const BackButtonWidget(),
        actions: [
        Container(
        margin: kCommonAppBarMargin,
        child: CustomIconButton(
          icon: Image.asset('assets/icons/arrow.png', width: 27, height: 20),
          onPressed: () {
            model.onShowTotal();
          },
          backgroundColor: kMainColor,
          width: 44,
          height: 42,
        ),
      )
        ],
      ),
      body: Container(
        decoration: kBackgroundDecoration,
        child: Container(
            margin: kCommonPageMargin,
            child: Center(
              child: ListView(
                children: model.state.users,
              )
            )
        ),
      ),
    );
  }
}

class CardAnswer extends StatelessWidget {
  final String username;
  final Widget answer;
  const CardAnswer({Key? key, required this.username, required this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          PlayerCardWidget(username: username),
          Expanded(
            child: answer,
          )
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String answer;

  const MessageBubble({
    Key? key, required this.answer
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: BubbleEdges.only(left: 15),
      nip: BubbleNip.leftTop,
      nipWidth: 10,
      nipHeight: 10,
      radius: Radius.circular(15),
      color: Color.fromRGBO(217, 217, 217, 1),
      child: Text(answer,
          textAlign: TextAlign.center,
          style: kBubbleTextStyle,
      ),
    );
  }
}
class PlayerCardWidget extends StatelessWidget {
  const PlayerCardWidget({Key? key, required this.username}): super(key: key);

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
              child: Image.asset("assets/images/unknown.png", width: 70, height: 70)),
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

