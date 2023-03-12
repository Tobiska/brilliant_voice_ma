import 'package:brilliant_voices/ui/view_models/wait_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';
import '../common/widgets.dart';

class WaitPage extends StatelessWidget {
  const WaitPage({Key? key}) : super(key: key);

  static Widget create() {
    return ChangeNotifierProvider(
        create: (context) => WaitViewModel(context: context),
        child: WaitPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: const Center(
              child: WaitWidget(),
            )),
      ),
    );
  }
}

class WaitWidget extends StatelessWidget {
  const WaitWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WaitViewModel model = context.watch<WaitViewModel>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Код игры: ${model.state.code}',
          style: const TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 52),
        const Text(
          'Ожидание игроков',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          '${model.state.countPlayers} из ${model.state.requiredCountPlayers}',
          style: const TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
