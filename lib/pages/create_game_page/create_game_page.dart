import 'package:brilliant_voices/pages/common/widgets.dart';
import 'package:brilliant_voices/pages/create_game_page/constants.dart';
import 'package:brilliant_voices/ui/view_models/create_game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';

class CreateGamePage extends StatelessWidget {
  const CreateGamePage({Key? key}) : super(key: key);

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => CreateGameViewModel(context: context),
      child: CreateGamePage(),
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
          child: Column(
            children: const [
              SizedBox(height: 40, width: double.infinity),
              _TitleWidget(),
              SizedBox(height: 40, width: double.infinity),
              _PropertiesWidget(),
              SizedBox(height: 39),
              _ButtonsWidget(),
              SizedBox(height: 30, width: double.infinity),
              _CreateWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateWidget extends StatelessWidget {
  const _CreateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<CreateGameViewModel>();
    return Center(
      child: CustomTextButton(
        color: kMainColor,
        onPressed: () {
          model.onPressedCreateGame();
        },
        text: Text('Создать',
          style: kButtonTextStyle,
        ),
      ),
    );
  }
}

class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _QuestionWidget(),
        _PlaylistWidget()
      ],
    );
  }
}

class _PlaylistWidget extends StatelessWidget {
  const _PlaylistWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomIconButton(
          onPressed: () {},
          icon: Image.asset('assets/icons/book.png', width: 70, height: 70),
          width: 85,
          height: 85,
          backgroundColor: secondaryColor,
        ),
        const SizedBox(height: 15),
        Text(
            "Плейлист",
            style: kPropertiesTextStyle
        )
      ],
    );
  }
}

class _QuestionWidget extends StatelessWidget {
  const _QuestionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomIconButton(
          onPressed: () {},
          icon: Image.asset('assets/icons/music_2.png', width: 75, height: 75),
          width: 85,
          height: 85,
          backgroundColor: kMainColor,
        ),
        const SizedBox(height: 15),
        Text(
            "Вопросы",
            style: kPropertiesTextStyle
        )
      ],
    );
  }
}

class _PropertiesWidget extends StatelessWidget {
  const _PropertiesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _SubtitleWidget(),
        SizedBox(height: 21, width: double.infinity),
        _CountPlayersWidget(),
        SizedBox(height: 16, width: double.infinity),
        _TimerWidget(),
    ]);
  }
}

class _TimerWidget extends StatelessWidget {
  const _TimerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              "Таймер",
              style: kPropertiesTextStyle
          ),
          _TimeRoundTextField(),
      ]);
  }
}

class _CountPlayersWidget extends StatelessWidget {
  const _CountPlayersWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Text(
        "Кол-во участников",
        style: kPropertiesTextStyle
      ),
          _CountPlayersTextField()
    ]);
  }
}

class _CountPlayersTextField extends StatefulWidget {
  const _CountPlayersTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<_CountPlayersTextField> createState() => _CountPlayersTextFieldState();
}

class _CountPlayersTextFieldState extends State<_CountPlayersTextField> {
  bool _validate = true;

  @override
  Widget build(BuildContext context) {
    final model = context.read<CreateGameViewModel>();
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: _validate ? Colors.black : Colors.red,
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(3, 2)
            )
          ]
      ),
      constraints: const BoxConstraints(
          maxWidth: 120
      ),
      height: 40,
      child: TextFormField(
        initialValue: model.state.countPlayers,
        onChanged: (value) {
          if (model.validateCountPlayers(value)) {
            _validate = true;
            model.onChangeCountPlayer(value);
          } else {
            _validate = false;
          }
          setState(() {});
        },
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
            ),
            fillColor: kMainColor,
            filled: true
        ),
      ),
    );
  }
}//TODO decompose

class _TimeRoundTextField extends StatefulWidget {
  const _TimeRoundTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<_TimeRoundTextField> createState() => _TimeRoundTextFieldState();
}

class _TimeRoundTextFieldState extends State<_TimeRoundTextField> {
  bool _validate = true;

  @override
  Widget build(BuildContext context) {
    final model = context.read<CreateGameViewModel>();
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: _validate ? Colors.black : Colors.red,
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(3, 2)
            )
          ]
      ),
      constraints: const BoxConstraints(
          maxWidth: 120
      ),
      height: 40,
      child: TextFormField(
        initialValue: model.state.roundTime,
        onChanged: (value) {
          if (model.validateRoundTime(value)) {
            _validate = true;
            model.onChangeTime(value);
          } else {
            _validate = false;
          }
          setState(() {});
        },
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
            ),
            fillColor: kMainColor,
            filled: true
        ),
      ),
    );
  }
}

class _SubtitleWidget extends StatelessWidget {
  const _SubtitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Создание комнаты",
        style: kSubtitleTextStyle
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: titleText
    );
  }
}

