import 'package:brilliant_voices/domain/services/game.dart';
import 'package:brilliant_voices/infrustructure/game_user_provider.dart';
import 'package:brilliant_voices/pages/common/constants.dart';
import 'package:brilliant_voices/pages/create_game_page/create_game_page.dart';
import 'package:brilliant_voices/pages/game_page/game_page.dart';
import 'package:brilliant_voices/pages/home_page/home_page.dart';
import 'package:brilliant_voices/pages/join_game/join_game_page.dart';
import 'package:brilliant_voices/pages/show_answers_page/show_answers_page.dart';
import 'package:brilliant_voices/pages/wait_page/wait_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/services/answers.dart';
import 'domain/services/round.dart';
import 'domain/services/user.dart';
import 'infrustructure/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpDependencies();
  await GetIt.instance.allReady();
  runApp(const MyApp());
}

void setUpDependencies() {
  GetIt.instance
      .registerSingletonAsync<SharedPreferences>(SharedPreferences.getInstance);
  GetIt.instance.registerSingleton<GameProvider>(GameProvider());
  GetIt.instance.registerSingletonWithDependencies<UserProvider>(
      () => UserProvider(),
      dependsOn: [SharedPreferences]);
  GetIt.instance.registerFactory<UserService>(UserService.new);
  GetIt.instance.registerSingletonWithDependencies<GameService>(
      () => GameService(),
      dependsOn: [UserProvider]);
  GetIt.instance.registerFactory<RoundService>(RoundService.new);
  GetIt.instance.registerFactory<AnswersService>(AnswersService.new);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomePageName: (_) => HomePage.create(),
        CreatePageName: (_) => CreateGamePage.create(),
        // PlayerGamePageName: (_) => PlayerGamePage.create(),
        OwnerGamePageName: (_) => OwnerGamePage.createStartGame(),
        AnswerResultPageName: (_) => ShowAnswersPage.create(),
        WaitPageName: (_) => WaitPage.create(),
      },
      title: "Brilliant Voices",
      home: HomePage.create(),
    );
  }
}
