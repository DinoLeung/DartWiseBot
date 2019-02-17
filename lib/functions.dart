import 'dart:math';
import 'package:teledart/model.dart';
import 'variables.dart';

String coin() => Random().nextBool() ? 'Heads' : 'Tails';

String die() => (Random().nextInt(5) + 1).toString();

String card() =>
    '${suits[Random().nextInt(suits.length)]} ${ranks[Random().nextInt(ranks.length)]}';

String pick(List<String> choice) => choice[Random().nextInt(choice.length)];

String getCommandQuery(Message message) {
  MessageEntity entity = message.entityOf('bot_command');
  return message.text.substring(entity.offset + entity.length).trim();
}
