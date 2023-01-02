import 'package:teledart/teledart.dart';
import 'package:teledart/model.dart';

import 'package:DartWiseBot/variables.dart';
import 'package:DartWiseBot/functions.dart';

class Responds {
  final TeleDart _teledart;

  Responds(this._teledart);

  Future<Message> sendStartMessage(TeleDartMessage message) =>
      message.reply(startMsg);

  Future<Message> sendHelpMessage(TeleDartMessage message) =>
      message.reply(helpMsg, parseMode: 'markdown');

  Future<Message> sendAboutMessage(TeleDartMessage message) => message
      .reply(githubMsg, parseMode: 'markdown', disableWebPagePreview: true);

  Future<Message> sendCoinMessage(TeleDartMessage message) =>
      message.reply(coin());

  Future<Message> sendDieMessage(TeleDartMessage message) =>
      message.reply(die());

  Future<Message> sendCardMessage(TeleDartMessage message) =>
      message.reply(card());

  Future<Message> sendChoiceMessage(TeleDartMessage message) =>
      message.reply(pick(getCommandQuery(message), commandHasUsername(message)),
          parseMode: 'markdown');

  Future<Message> sendWiseMessage(TeleDartMessage message) =>
      message.reply(learn(getCommandQuery(message)),
          parseMode: 'markdown', disableWebPagePreview: true);

  Future<Message> sendSuggestMessage(TeleDartMessage message) {
    var suggestions = getCommandQuery(message);

    if (suggestions.isEmpty) {
      return message
          .reply(invalidSuggestions(hasUsername: commandHasUsername(message)));
    }

    _teledart.sendMessage(int.parse(envVars['MYID']!),
        suggestionMsg(message.from?.username ?? 'Someone', suggestions));
    return message.reply(validSuggestions);
  }

  Future<Message> sendDice(TeleDartMessage message) =>
      _teledart.sendDice(message.chat.id);

  Future<bool> answerInlineQuery(TeleDartInlineQuery inlineQuery) =>
      inlineQuery.answer(<InlineQueryResult>[
        InlineQueryResultArticle(
            id: 'flip',
            title: '🌝',
            inputMessageContent: InputTextMessageContent(
              messageText: coin(),
              parseMode: 'markdown',
            )),
        InlineQueryResultArticle(
            id: 'roll',
            title: '🎲',
            inputMessageContent: InputTextMessageContent(
              messageText: die(),
              parseMode: 'markdown',
            )),
        InlineQueryResultArticle(
            id: 'card',
            title: '🃏',
            inputMessageContent: InputTextMessageContent(
              messageText: card(),
              parseMode: 'markdown',
            )),
        InlineQueryResultArticle(
            id: 'pick',
            title: 'Pick from',
            description: '🅰️, 🅱️,...',
            inputMessageContent: InputTextMessageContent(
              messageText: pick(inlineQuery.query, false),
              parseMode: 'markdown',
            )),
        InlineQueryResultArticle(
            id: 'learn',
            title: 'Ask the wise...',
            description: '🧙',
            inputMessageContent: InputTextMessageContent(
                messageText: learn(inlineQuery.query), parseMode: 'markdown')),
      ]);
}
