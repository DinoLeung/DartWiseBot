import 'dart:io' show Platform;
import 'dart:io' show File;

final Map<String, String> envVars = Platform.environment;

final String startMsg = File('docs/start').readAsStringSync();

final String helpMsg = File('docs/help').readAsStringSync();

final String theHeartSutra = File('docs/the_heart_sutra').readAsStringSync();

final List<String> suits = ['♠️', '♥️', '♣️', '♦️'];

final List<String> ranks = [
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

final String invalidChoices =
    'Huh? My hearing isn\'t too well. Try again with following pattern: \/pick 🅰️, 🅱️, ...';

String oneChoice(String choice) =>
    '${choice} is the one and the only one. Unlike the universe, there\'re multiple of them existing parallely.';

String theOne(List<String> choices, String choice) =>
    '''Out of ${choices.join(', ')}
*${choice}* has to be the one. 😉''';

final String githubMsg =
    '''@TheWiseBot is on [GitHub](https://github.com/DinoLeung/DartWiseBot)
    
    If you can make me more wise, please fork me!
    Pull reqiestes are highly welcome!
    ''';

String letMeGoogle(String keywords) {
  String query = keywords
      .trim()
      .split(' ')
      .map((String str) => Uri.encodeQueryComponent(str))
      .toList()
      .join('+');
  return '''Any fool can know. The point is to understand.
I found a lot regarding to *${keywords.trim()}* you could know [here](http://lmgtfy.com/?iie=1&q=${query})
But can you understand, it's entirely depends on you.''';
}

final String invalidSuggestions =
    'Huh? My hearing isn\'t too well. Try again with \/suggest and follow by your suggestions. The universe won\'t accept blank suggestions.';

final String validSuggestions =
    'May the universe be with you, I will look into this soon. 💪';

String suggestionMsg(String username, String suggestions) =>
    '@${username} suggested to ${suggestions}';
