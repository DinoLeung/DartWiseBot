import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';

import 'package:DartWiseBot/variables.dart';
import 'package:DartWiseBot/functions.dart';

void main() {
  final Telegram telegram = Telegram(envVars['BOT_TOKEN']);
  final TeleDart teledart = TeleDart(telegram, Event());

  teledart.startFetching();

  teledart
      .onCommand('start')
      .listen((Message message) => teledart.replyMessage(message, startMsg));

  teledart.onCommand('help').listen((Message message) =>
      teledart.replyMessage(message, helpMsg, parse_mode: 'markdown'));

  teledart.onCommand('about').listen((Message message) =>
      teledart.replyMessage(message, githubMsg, parse_mode: 'markdown'));

  teledart
      .onCommand('flip')
      .listen((Message message) => teledart.replyMessage(message, coin()));

  teledart
      .onCommand('roll')
      .listen((Message message) => teledart.replyMessage(message, die()));

  teledart
      .onCommand('draw')
      .listen((Message message) => teledart.replyMessage(message, card()));

  teledart.onCommand('pick').listen((Message message) => teledart.replyMessage(
      message, pick(getCommandQuery(message)),
      parse_mode: 'markdown'));

  teledart.onCommand('learn').listen((Message message) => teledart.replyMessage(
      message, learn(getCommandQuery(message)),
      parse_mode: 'markdown'));

  teledart.onCommand('suggest').listen((Message message) {
    String suggestions = getCommandQuery(message);

    if (suggestions.isEmpty)
      return teledart.replyMessage(message, invalidSuggestions);

    telegram.sendMessage(int.parse(envVars['MYID']),
        suggestionMsg(message.from.username, suggestions));
    return teledart.replyMessage(message, validSuggestions);
  });

  teledart.onInlineQuery().listen((InlineQuery inlineQuery) {
    List<InlineQueryResult> results = [
      InlineQueryResultArticle()
        ..id = 'flip'
        ..title = '🌝'
        ..input_message_content = (InputTextMessageContent()
          ..message_text = coin()
          ..parse_mode = 'markdown'),
      InlineQueryResultArticle()
        ..id = 'roll'
        ..title = '🎲'
        ..input_message_content = (InputTextMessageContent()
          ..message_text = die()
          ..parse_mode = 'markdown'),
      InlineQueryResultArticle()
        ..id = 'draw'
        ..title = '🃏'
        ..input_message_content = (InputTextMessageContent()
          ..message_text = card()
          ..parse_mode = 'markdown'),
      InlineQueryResultArticle()
        ..id = 'pick'
        ..title = 'Pick from'
        ..description = '🅰️, 🅱️,...'
        ..input_message_content = (InputTextMessageContent()
          ..message_text = pick(inlineQuery.query)
          ..parse_mode = 'markdown'),
      InlineQueryResultArticle()
        ..id = 'learn'
        ..title = 'Ask the wise...'
        ..description = '🧙'
        ..input_message_content = (InputTextMessageContent()
          ..message_text = learn(inlineQuery.query)
          ..parse_mode = 'markdown'),
    ];
    teledart.answerInlineQuery(inlineQuery, results);
  });
}
