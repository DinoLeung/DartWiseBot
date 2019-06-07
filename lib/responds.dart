import 'package:teledart/teledart.dart';
import 'package:teledart/model.dart';

import 'package:DartWiseBot/variables.dart';
import 'package:DartWiseBot/functions.dart';

class Responds {
  static TeleDart _teledart;

  Responds(TeleDart teledart) {
    _teledart = teledart;
  }

  Future<Message> sendStartMessage(Message message) =>
      _teledart.replyMessage(message, startMsg);

  Future<Message> sendHelpMessage(Message message) =>
      _teledart.replyMessage(message, helpMsg, parse_mode: 'markdown');

  Future<Message> sendAboutMessage(Message message) =>
      _teledart.replyMessage(message, githubMsg,
          parse_mode: 'markdown', disable_web_page_preview: true);

  Future<Message> sendCoinMessage(Message message) =>
      _teledart.replyMessage(message, coin());

  Future<Message> sendDieMessage(Message message) =>
      _teledart.replyMessage(message, die());

  Future<Message> sendCardMessage(Message message) =>
      _teledart.replyMessage(message, card());

  Future<Message> sendChoiceMessage(Message message) => _teledart.replyMessage(
      message, pick(getCommandQuery(message), commandHasUsername(message)),
      parse_mode: 'markdown');

  Future<Message> sendWiseMessage(Message message) =>
      _teledart.replyMessage(message, learn(getCommandQuery(message)),
          parse_mode: 'markdown', disable_web_page_preview: true);

  Future<Message> sendSuggestMessage(Message message) {
    String suggestions = getCommandQuery(message);

    if (suggestions.isEmpty)
      return _teledart.replyMessage(message,
          invalidSuggestions(hasUsername: commandHasUsername(message)));

    _teledart.telegram.sendMessage(int.parse(envVars['MYID']),
        suggestionMsg(message.from.username, suggestions));
    return _teledart.replyMessage(message, validSuggestions);
  }

  Future<bool> answerInlineQuery(InlineQuery inlineQuery) =>
      _teledart.answerInlineQuery(inlineQuery, <InlineQueryResult>[
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
      ]);
}
