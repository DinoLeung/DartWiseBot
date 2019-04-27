import 'dart:math';
import 'package:teledart/model.dart';
import 'variables.dart';

String coin() => Random().nextBool() ? 'Heads' : 'Tails';

String die() => (Random().nextInt(5) + 1).toString();

String card() =>
    '${suits[Random().nextInt(suits.length)]} ${ranks[Random().nextInt(ranks.length)]}';

String getCommandQuery(Message message) {
  MessageEntity entity = message.entityOf('bot_command');
  return message.text.substring(entity.offset + entity.length).trim();
}

bool commandHasUsername(Message message) {
  MessageEntity entity = message.entityOf('bot_command');
  return message.text
      .substring(entity.offset, entity.offset + entity.length)
      .contains('@${me.username}');
}

String pick(String query, bool hasUsername) {
  List<String> choices = query
      .split(',')
      .map((String str) => str.trim())
      .where((String str) => str.isNotEmpty)
      .toList();

  if (choices.isEmpty) return invalidChoices(hasUsername: hasUsername);

  if (choices.length == 1) return oneChoice(choices[0]);

  return theOne(choices, choices[Random().nextInt(choices.length)]);
}

String learn(String query) {
  if (query.isEmpty) return theHeartSutra;
  return letMeGoogle(query);
}
