import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';

import 'package:DartWiseBot/variables.dart';
import 'package:DartWiseBot/responds.dart';

void main() {
  final telegram = Telegram(envVars['BOT_TOKEN']);
  final webhook =
      Webhook(telegram, envVars['HOST_URL'], envVars['BOT_TOKEN'], cert, key)
        ..port = int.parse(envVars['BOT_PORT']);
  final teledart = TeleDart(telegram, Event(), fetcher: webhook);
  final respond = Responds(teledart);

  teledart
    ..start().then((User user) async {
      me = user;
      await teledart.telegram.setMyCommands(commands);
    })
    ..onCommand('start').listen(respond.sendStartMessage)
    ..onCommand('help').listen(respond.sendHelpMessage)
    ..onCommand('about').listen(respond.sendAboutMessage)
    ..onCommand('flip').listen(respond.sendCoinMessage)
    ..onCommand('roll').listen(respond.sendDice)
    ..onCommand('draw').listen(respond.sendCardMessage)
    ..onCommand('pick').listen(respond.sendChoiceMessage)
    ..onCommand('learn').listen(respond.sendWiseMessage)
    ..onCommand('suggest').listen(respond.sendSuggestMessage)
    ..onInlineQuery().listen(respond.answerInlineQuery);
}
