import 'dart:io';

const outputDiff = 3;
const inputDiff = [1, 2, 3];

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
    var counter = seatJoltage;
    while (i < input.length - 1) {
      counter = input[i];
      var d = 1;
      while (d <= 3) {
        i = input.indexWhere((element) => element == counter + d);
        if (i != -1 && d == 1) {
          oneJoltDiffs++;
          break;
        }
        if (i != -1 && d == 3) {
          threeJoltDiffs++;
          break;
        }
        d++;
      }
    }

    return {oneJoltDiffs: threeJoltDiffs};
  }
}
