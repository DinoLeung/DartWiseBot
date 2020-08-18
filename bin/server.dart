import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';

import 'package:DartWiseBot/variables.dart';
import 'package:DartWiseBot/responds.dart';

void main() {
  final TeleDart teledart = TeleDart(Telegram(envVars['BOT_TOKEN']), Event());
  final Responds respond = Responds(teledart);

  teledart
    ..setupWebhook(
      envVars['HOST_URL'],
      envVars['BOT_TOKEN'],
      cert,
      key,
      port: int.parse(envVars['BOT_PORT']),
    )
    ..start(webhook: true).then((User user) async {
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
