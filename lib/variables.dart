import 'dart:io' show Directory;
import 'dart:io' show File;
import 'dart:io' show Platform;

import 'package:teledart/model.dart' show User, BotCommand;

User me;

final String root = Directory.fromUri(Platform.script).parent.parent.path;

final Map<String, String> envVars = Platform.environment;

final String startMsg = File('${root}/txt/start').readAsStringSync();

final String helpMsg = File('${root}/txt/help').readAsStringSync();

final String theHeartSutra =
    File('${root}/txt/the_heart_sutra').readAsStringSync();

final String githubMsg = File('${root}/txt/github').readAsStringSync();

final List<String> suits = <String>['♠️', '♥️', '♣️', '♦️'];

final List<String> ranks = <String>[
  'A',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  'J',
  'Q',
  'K',
];

String invalidChoices({bool hasUsername = false}) =>
    'Huh? My hearing isn\'t too well. Try again with following pattern: \/pick${hasUsername ? '\@${me.username}' : ''} 🅰️, 🅱️,...';

String oneChoice(String choice) =>
    '${choice} is the one and the only one. Unlike the universe, there\'re multiple of them existing parallely.';

String theOne(List<String> choices, String choice) =>
    '''Out of ${choices.join(', ')}
*${choice}* has to be the one. 😉''';

String letMeGoogle(String keywords) {
  var query = keywords
      .trim()
      .split(' ')
      .map((String str) => Uri.encodeQueryComponent(str))
      .toList()
      .join('+');
  return '''Any fool can know. The point is to understand.
I found a lot regarding to *${keywords.trim()}* you could know [here](http://lmgtfy.com/?iie=1&q=${query}).
But can you understand, it's entirely depends on you.''';
}

String invalidSuggestions({bool hasUsername = false}) =>
    'Huh? My hearing isn\'t too well. Try again with \/suggest${hasUsername ? '\@${me.username}' : ''} and follow by your suggestions. The universe won\'t accept blank suggestions.';

final String validSuggestions =
    'May the universe be with you, I will look into this soon. 💪';

String suggestionMsg(String username, String suggestions) =>
    '@${username} suggested to ${suggestions}';

List<BotCommand> commands = <BotCommand>[
  BotCommand(command: '\/flip', description: 'flip a 🌝'),
  BotCommand(command: '\/roll', description: 'roll a 🎲'),
  BotCommand(command: '\/draw', description: 'draw a 🃏'),
  BotCommand(
      command: '\/pick', description: 'make the decision from your choices'),
  BotCommand(command: '/learn', description: 'learn from the wise'),
  BotCommand(
      command: '\/suggest',
      description:
          'suggest a decision making method, or share your view of the universe with me'),
  BotCommand(
      command: '\/about',
      description: 'check out how the wise looks like under the hood'),
];
