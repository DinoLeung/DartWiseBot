import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';

import 'package:DartWiseBot/variables.dart';
import 'package:DartWiseBot/functions.dart';

void main() {
  final TeleDart teledart = TeleDart(Telegram(envVars['BOT_TOKEN']), Event());

  teledart.setupWebhook(envVars['HOST_URL'], envVars['BOT_TOKEN'], cert, key,
      port: int.parse(envVars['BOT_PORT']));

  teledart.start(webhook: true).then((User user) => me = user);

  teledart
      .onCommand('start')
      .listen((Message message) => teledart.replyMessage(message, startMsg));

  teledart.onCommand('help').listen((Message message) =>
      teledart.replyMessage(message, helpMsg, parse_mode: 'markdown'));

  teledart.onCommand('about').listen((Message message) => teledart.replyMessage(
      message, githubMsg,
      parse_mode: 'markdown', disable_web_page_preview: true));

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
      message, pick(getCommandQuery(message), commandHasUsername(message)),
      parse_mode: 'markdown'));

  teledart.onCommand('learn').listen((Message message) => teledart.replyMessage(
      message, learn(getCommandQuery(message)),
      parse_mode: 'markdown', disable_web_page_preview: true));

  teledart.onCommand('suggest').listen((Message message) {
    String suggestions = getCommandQuery(message);

    if (suggestions.isEmpty)
      return teledart.replyMessage(message,
          invalidSuggestions(hasUsername: commandHasUsername(message)));

    teledart.telegram.sendMessage(int.parse(envVars['MYID']),
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
          ..message_text = pick(inlineQuery.query, false)
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
