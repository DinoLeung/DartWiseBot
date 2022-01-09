import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'package:DartWiseBot/variables.dart';
import 'package:DartWiseBot/responds.dart';

Future<void> main() async {
  final telegram = Telegram(envVars['BOT_TOKEN']!);
  me = await telegram.getMe();
  final webhook = await Webhook.createHttpWebhok(
      telegram, envVars['HOST_URL']!, envVars['BOT_TOKEN']!,
      port: int.parse(envVars['BOT_PORT']!),
      serverPort: int.parse(envVars['SERVER_PORT']!));
  final teledart =
      TeleDart(envVars['BOT_TOKEN']!, Event(me.username!), fetcher: webhook);
  // final teledart = TeleDart(envVars['BOT_TOKEN']!, Event(me.username!));
  final respond = Responds(teledart);

  await teledart.setMyCommands(commands);

  teledart
    ..start()
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
