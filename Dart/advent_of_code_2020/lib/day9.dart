import 'dart:io';

class Day9 {
  static List parseInput(String input) {
    var lines = input.split('\r\n');
    return lines.map((e) => int.parse(e)).toList();
  }

  static Map<dynamic, dynamic> getSumCombination(List preamble, number) {
    var combination;
    preamble.forEach((number1) {
      preamble.forEach((number2) {
        if ((number1 + number2) == number && number1 != number2) {
          combination = {number1: number2};
        }
      });
    });
    return combination;
  }

  static int first() {
    var input = File('./lib/input/day9').readAsStringSync();
    var parsedInput = parseInput(input);

    var result = 0;

    for (var i = 25; i < parsedInput.length; i++) {
      /*var preamble = List.generate(parsedInput.length, (index) {
        if (index >= i - 25 && index < i) {
          return parsedInput[index];
        }
      });*/

      var preamble = List(25);
      List.copyRange(preamble, 0, parsedInput, i - 25, i);

      var combination = getSumCombination(preamble, parsedInput[i]);

      if (combination == null) {
        result = parsedInput[i];
        break;
      }
    }

    return result;
  }
}
