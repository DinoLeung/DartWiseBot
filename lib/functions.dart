import 'dart:math';
import 'package:teledart/model.dart';
import 'variables.dart';

String coin() => Random().nextBool() ? 'Heads' : 'Tails';

String roll() => (Random().nextInt(5) + 1).toString();

String card() =>
    '${suits[Random().nextInt(suits.length)]} ${ranks[Random().nextInt(ranks.length)]}';

String getCommandQuery(Message message) {
  MessageEntity entity = message.entityOf('bot_command');
  return message.text.substring(entity.offset + entity.length).trim();
}

String pick(Message message) {
  List<String> choices = getCommandQuery(message)
      .split(',')
      .map((String str) => str.trim())
      .where((String str) => str.isNotEmpty)
      .toList();

  if (choices.isEmpty) return invalidChoices;

  if (choices.length == 1) return oneChoice(choices[0]);

  return theOne(choices, choices[Random().nextInt(choices.length)]);
}

String learn(Message message) {
  String keywords = getCommandQuery(message);
  if (keywords.isEmpty) return theHeartSutra;
  return letMeGoogle(keywords);
}
