import 'package:brilliant_voices/pages/create_game_page/create_game_page.dart';
import 'package:brilliant_voices/pages/home_page/constants.dart';
import 'package:brilliant_voices/pages/join_game/join_game_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/view_models/home.dart';
import '../common/widgets.dart';
import '../common/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Widget create() {
    return ChangeNotifierProvider(
        create: (context) => HomeViewModel(context: context),
        child: HomePage(),
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
        leading: Container(
          margin: kCommonAppBarMargin,
          child: CustomIconButton(
            icon: Image.asset("assets/icons/music.png", width: 17.82, height: 20.4),
            onPressed: () {},
            width: 44,
            height: 44,
            backgroundColor: kMainColor,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(15, 5, 10, 10),
            child: CustomIconButton(
              icon: Image.asset("assets/icons/user.png", width: 17.82, height: 20.4),
              onPressed: () {},
              width: 44,
              height: 44,
              backgroundColor: kMainColor,
            ),
          ),
        ],
        ),
       body: Container(
         decoration: kBackgroundDecoration,
          child: Container(
            margin: kCommonPageMargin,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SizedBox(height: 80),
                  _TitleWidget(),
                  _NameWidget(),
                  _ActionsWidget(),
                  CustomFooter()
                ],
            ),
          ),
       ),

    );
  }
}

class _ActionsWidget extends StatelessWidget {
  const _ActionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CreateWidget(),
        _JoinWidget()
      ]),
    );
  }
}

class _JoinWidget extends StatelessWidget {
  const _JoinWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeViewModel model = context.read<HomeViewModel>();
    return Column(
      children: [
        CustomIconButton(
            onPressed: () {
              model.onJoinButtonGame();
            },
            icon: Image.asset('assets/icons/key.png', width: 60.8, height: 37.56),
            width: 85,
            height: 85,
            backgroundColor: secondaryColor,
        ),
        const SizedBox(height: 15),
        Text(
          "Войти",
          style: kTextActionStyle
        )
      ],
    );
  }
}

class _CreateWidget extends StatelessWidget {
  const _CreateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeViewModel model = context.read<HomeViewModel>();
    return Column(
      children: [
        CustomIconButton(
            onPressed: () {
              model.onCreateButtonGame();
            },
            icon: Image.asset('assets/icons/play.png', width: 52.8, height: 50.01),
            width: 85,
            height: 85,
          backgroundColor: kMainColor,
        ),
        const SizedBox(height: 15),
        Text(
            "Создать",
            style: kTextActionStyle
        )
      ],
    );
  }
}

class _NameWidget extends StatelessWidget {
  const _NameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeViewModel model = context.read<HomeViewModel>();
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: Colors.black,
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
      constraints: BoxConstraints(
        maxWidth: 300
      ),
      child: TextField(
        onChanged: (value) {
          model.onChangeUsername(value);
        },
        style: kRuleTextStyle,
        decoration: InputDecoration(
          hintText: 'Введите имя...',
          hintStyle: kRuleTextStyle,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
          ),
          fillColor: kRuleBGColor,
          filled: true
      ),
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
    return Row(
        children: [
        Expanded(
          child: titleText
        ),
    ]);
  }
}

class CustomFooter extends StatelessWidget {
  const CustomFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: secondaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          CustomIconButton(onPressed: () {}, width: 47, height: 45, icon: Image.asset("assets/icons/question.png", width: 32, height: 31,), backgroundColor: secondaryColor,), //TODO refactor
          CustomIconButton(onPressed: () {}, width: 47, height: 45, icon: Image.asset("assets/icons/settings.png", width: 32, height: 31,), backgroundColor: secondaryColor,),
          CustomIconButton(onPressed: () {}, width: 47, height: 45, icon: Image.asset("assets/icons/exit.png", width: 32, height: 31,), backgroundColor: secondaryColor,),
        ],)
    );
  }
}





