import 'package:brilliant_voices/pages/common/widgets.dart';
import 'package:brilliant_voices/pages/create_game_page/constants.dart';
import 'package:brilliant_voices/pages/join_game/constaits.dart';
import 'package:brilliant_voices/ui/view_models/join_game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';

const kTextFieldStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(255, 255, 255, 0.7));

class JoinGamePage extends StatelessWidget {
  const JoinGamePage({Key? key}) : super(key: key);

  static Widget create() {
    return ChangeNotifierProvider(
        create: (context) => JoinGameViewModel(context: context),
        child: JoinGamePage(),
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
          margin: kCommonPageMargin,
          child: ContentWidget(),
        ),
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 41, width: double.infinity),
        Center(child: titleText),
        const SizedBox(height: 33, width: double.infinity),
        const Center(child: _SubtitleTextField()),
        const SizedBox(height: 60, width: double.infinity),
        const Center(child: _JoinTextField()),
        const SizedBox(height: 145, width: double.infinity),
        const _JoinButton()
      ],
    );
  }
}

class _SubtitleTextField extends StatelessWidget {
  const _SubtitleTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Вход в комнату',
      style: kSubtitleTextStyle,
    );
  }
}

class _JoinTextField extends StatefulWidget {
  const _JoinTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<_JoinTextField> createState() => _JoinTextFieldState();
}

class _JoinTextFieldState extends State<_JoinTextField> {
  bool _validate = true;

  @override
  Widget build(BuildContext context) {
    JoinGameViewModel model = context.read<JoinGameViewModel>();
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
        BoxShadow(
            color: Colors.black,
            spreadRadius: 0,
            blurRadius: 0,
            offset: Offset(5, 3))
      ]),
      child: Container(
        width: 280,
        height: 50,
        child: TextField(
          onChanged: (text) {
            _validate = model.onChangeCodeField(text);
            setState(() {});
          },
          style: kTextFieldStyle,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: _validate ? Colors.white : Colors.red,
                    width: 3.0),
              ),
              fillColor: kDarkColor,
              hintText: 'Введите код',
              hintStyle: kTextFieldStyle,
              filled: true),
        ),
      ),
    );
  }
}

class _JoinButton extends StatelessWidget {
  const _JoinButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    JoinGameViewModel model = context.read<JoinGameViewModel>();
    return Container(
      decoration: BoxDecoration(
          color: kDarkColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [boxShadow]),
      child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
          ),
          onPressed: () {
            model.onPressedJoinButton();
          },
          child: Text(
            'Вход',
            style: kButtonTextStyle,
          )),
    );
  }
}
