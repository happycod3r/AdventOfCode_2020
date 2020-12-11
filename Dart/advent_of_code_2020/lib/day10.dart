import 'dart:io';

class Day10 {
  static int first() {
    var input = File('./lib/input/day10').readAsStringSync();
    var parsedInput = parseInput(input);
    parsedInput.sort();

    var seatJoltage = 0;
    var deviceJoltage = parsedInput.last + 3;

    var diffs = getJoltDiffs(seatJoltage, deviceJoltage, parsedInput);

    return diffs.keys.first * diffs.values.first;
  }

  static List<int> parseInput(String input) {
    var lines = input.split('\r\n');
    return lines.map((e) => int.parse(e)).toList();
  }

  static Map<int, int> getJoltDiffs(
      int seatJoltage, int deviceJoltage, List<int> input) {
    var oneJoltDiffs = 0;
    var threeJoltDiffs = 0;

    var i = 0;
    while (i < input.length - 1) {
      if (input[i + 1] - input[i] == 1) {
        oneJoltDiffs++;
      }
      if (input[i + 1] - input[i] == 3) {
        threeJoltDiffs++;
      }
      i++;
    }
    oneJoltDiffs++;
    threeJoltDiffs++;

    return {oneJoltDiffs: threeJoltDiffs};
  }
}
