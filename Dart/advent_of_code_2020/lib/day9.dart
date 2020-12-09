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

  static List getSetOfNumbers(List<int> parsedInput, int invalidNumber) {
    List<int> result;
    var i = 0;
    var d = 2;
    while (true) {
      result = List<int>(d);
      List.copyRange(result, 0, parsedInput, i, d);
      var sum = 0;
      result.forEach((element) {
        if (element != null) {
          sum += element;
        }
      });
      if (sum < invalidNumber) {
        d++;
      }
      if (sum > invalidNumber) {
        i++;
        d = i + 1;
      }
      if (sum == invalidNumber) {
        break;
      }
    }
    return result.where((element) => element != null).toList();
  }

  static Map<int, int> getMinMax(List<int> list) {
    var min = list[0];
    var max = list[0];
    list.forEach((element) {
      if (element < min) {
        min = element;
      }
      if (element > max) {
        max = element;
      }
    });

    return {min: max};
  }

  static int second() {
    var input = File('./lib/input/day9').readAsStringSync();
    var parsedInput = parseInput(input);

    var invalidNumber = first();
    var setOfNumbers = getSetOfNumbers(parsedInput, invalidNumber);

    var minmax = getMinMax(setOfNumbers);

    return minmax.keys.first + minmax.values.first;
  }
}
