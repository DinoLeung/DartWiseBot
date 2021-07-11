import 'package:teledart/teledart.dart';
import 'package:teledart/model.dart';

import 'package:DartWiseBot/variables.dart';
import 'package:DartWiseBot/functions.dart';

import 'variables.dart';

class Responds {
  final TeleDart _teledart;

  Responds(this._teledart);

  Future<Message> sendStartMessage(TeleDartMessage message) =>
      message.reply(startMsg);

  Future<Message> sendHelpMessage(TeleDartMessage message) =>
      message.reply(helpMsg, parse_mode: 'markdown');

  Future<Message> sendAboutMessage(TeleDartMessage message) => message
      .reply(githubMsg, parse_mode: 'markdown', disable_web_page_preview: true);

  Future<Message> sendCoinMessage(TeleDartMessage message) =>
      message.reply(coin());

  Future<Message> sendDieMessage(TeleDartMessage message) =>
      message.reply(die());

  Future<Message> sendCardMessage(TeleDartMessage message) =>
      message.reply(card());

  Future<Message> sendChoiceMessage(TeleDartMessage message) =>
      message.reply(pick(getCommandQuery(message), commandHasUsername(message)),
          parse_mode: 'markdown');

  Future<Message> sendWiseMessage(TeleDartMessage message) =>
      message.reply(learn(getCommandQuery(message)),
          parse_mode: 'markdown', disable_web_page_preview: true);

  Future<Message> sendSuggestMessage(TeleDartMessage message) {
    var suggestions = getCommandQuery(message);

    if (suggestions.isEmpty) {
      return message
          .reply(invalidSuggestions(hasUsername: commandHasUsername(message)));
    }

    _teledart.telegram.sendMessage(int.parse(envVars['MYID']!),
        suggestionMsg(message.from?.username ?? 'Someone', suggestions));
    return message.reply(validSuggestions);
  }

  Future<Message> sendDice(TeleDartMessage message) =>
      _teledart.telegram.sendDice(message.chat.id);

  Future<bool> answerInlineQuery(TeleDartInlineQuery inlineQuery) =>
      inlineQuery.answer(<InlineQueryResult>[
        InlineQueryResultArticle(
            id: 'flip',
            title: '🌝',
            input_message_content: InputTextMessageContent(
              message_text: coin(),
              parse_mode: 'markdown',
            )),
        InlineQueryResultArticle(
            id: 'roll',
            title: '🎲',
            input_message_content: InputTextMessageContent(
              message_text: die(),
              parse_mode: 'markdown',
            )),
        InlineQueryResultArticle(
            id: 'card',
            title: '🃏',
            input_message_content: InputTextMessageContent(
              message_text: card(),
              parse_mode: 'markdown',
            )),
        InlineQueryResultArticle(
            id: 'pick',
            title: 'Pick from',
            description: '🅰️, 🅱️,...',
            input_message_content: InputTextMessageContent(
              message_text: pick(inlineQuery.query, false),
              parse_mode: 'markdown',
            )),
        InlineQueryResultArticle(
            id: 'learn',
            title: 'Ask the wise...',
            description: '🧙',
            input_message_content: InputTextMessageContent(
                message_text: learn(inlineQuery.query),
                parse_mode: 'markdown')),
      ]);
}
