import 'dart:io' show Platform;

final Map<String, String> envVars = Platform.environment;

final String startMsg =
    '''Greetings! I am the Wise, I can help with all your decisions. 🧙

You can simply \/flip a 🌝, \/roll a 🎲, or even \/roll3 🎲 at a time.

You can also \/draw a 🃏 from a stack. If you wish you can enable \/singlestack mode to \/draw 🃏 from the same stack until you \/shuffle the stack.

Or I can help you \/pick the one from your choices

You can always \/learn stuff from me, just ask!

\/suggest your favourite decision making method if I can't provide you yet, the universe may accept your suggestions


Ask \/help for more.''';

final String helpMsg =
    '''Greetings! I am the Wise, I can help with all your decisions. 🧙

*Coins*
\/flip - flip a 🌝

*Dices*
\/roll - roll a 🎲
\/roll3 - roll 🎲🎲🎲

*Cards*
\/draw - draw a 🃏 from a stack
\/singlestack - toggle single stack mode
\/shuffle - reset the stack when \/singlestack is toggled

*Choices*
\/pick - make the decision from your choices

*Others*
\/learn - learn from the wise
\/suggest - suggest a decision making method, or sharenyour view of the universe
\/nerddrink - buy the wise a nerd drink, he needs energy to make decisions
\/github - check out how the wise looks like under the hood''';

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
