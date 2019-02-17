import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';

import 'package:DartWiseBot/variables.dart';
import 'package:DartWiseBot/functions.dart';

void main() {
  final Telegram telegram = new Telegram(envVars['WISE_BOT_TOKEN']);
  final TeleDart teledart = new TeleDart(telegram, new Event());

  teledart.startFetching();

  teledart
      .onCommand('start')
      .listen((Message message) => teledart.replyMessage(message, startMsg));

  teledart.onCommand('help').listen((Message message) =>
      teledart.replyMessage(message, helpMsg, parse_mode: 'markdown'));

  teledart
      .onCommand('github')
      .listen((Message message) => teledart.replyMessage(message, githubMsg));

  teledart
      .onCommand('flip')
      .listen((Message message) => teledart.replyMessage(message, coin()));

  teledart
      .onCommand('roll')
      .listen((Message message) => teledart.replyMessage(message, die()));

  teledart
      .onCommand('draw')
      .listen((Message message) => teledart.replyMessage(message, card()));

  teledart.onCommand('pick').listen((Message message) {
    List<String> choices = getCommandQuery(message)
        .split(',')
        .map((String str) => str.trim())
        .where((String str) => str.isNotEmpty)
        .toList();

    if (choices.isEmpty) return teledart.replyMessage(message, invalidChoices);

    if (choices.length == 1)
      return teledart.replyMessage(message, oneChoice(choices[0]));

    return teledart.replyMessage(message, theOne(choices, pick(choices)),
        parse_mode: 'markdown');
  });

  teledart.onCommand('learn').listen((Message message) {
    String keywords = getCommandQuery(message);
    return teledart.replyMessage(message, letMeGoogle(keywords),
        parse_mode: 'markdown');
  });

  teledart.onCommand('suggest').listen((Message message) {
    String suggestions = getCommandQuery(message);

    if (suggestions.isEmpty)
      return teledart.replyMessage(message, invalidSuggestions);

    telegram.sendMessage(int.parse(envVars['MYID']),
        suggestionMsg(message.from.username, suggestions));
    return teledart.replyMessage(message, validSuggestions);
  });
}
