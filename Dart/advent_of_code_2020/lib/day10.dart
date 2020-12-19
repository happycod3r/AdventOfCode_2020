import 'dart:io';

class Day10 {
  static int first() {
    var input = File('./lib/input/day10').readAsStringSync();
    var parsedInput = parseInput(input);
    parsedInput.sort();

    var diffs = getJoltDiffs(parsedInput);

    return diffs.keys.first * diffs.values.first;
  }

  static List<int> parseInput(String input) {
    var lines = input.split('\r\n');
    return lines.map((e) => int.parse(e)).toList();
  }

  static Map<int, int> getJoltDiffs(List<int> input) {
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

  static List<int> createShorterArrangement(List<int> input) {
    var newList = [...input];
    var i = 0;
    while (i < newList.length - 1) {
      if (i < newList.length - 3 && newList[i + 3] - newList[i] == 3) {
        newList.removeAt(i + 1);
      }
      i++;
    }
    return newList;
  }

  static List<int> getDiffs(List<List<int>> arrangements) {
    var diffs = <int>[];
    var i = 0;
    while (i < arrangements[1].length - 1) {
      if (arrangements[1][i] != arrangements[0][i]) {
        diffs.add(arrangements[0][i]);
      }
      i++;
    }
    return diffs;
  }

  static List<List<int>> createArrangements(
      List<int> input, List<List<int>> arrangements, List<int> diffs) {
    var newList = [...input];
    for (var e in diffs) {
      newList.add(e);
      var arrg = arrangements.firstWhere((element) => element == newList,
          orElse: () => null);
      if (arrg != null) {
        break;
      } else {
        arrangements.add(newList);
      }
    }
    arrangements.addAll(createArrangements(newList, arrangements, diffs));
    return arrangements;
  }

  static List<List<int>> getArrangements(List<int> input) {
    var listOfArrangements = <List<int>>[];

    listOfArrangements.add(input);
    listOfArrangements.add(createShorterArrangement(input));
    var diffs = getDiffs(listOfArrangements);

    var list =
        createArrangements(listOfArrangements[1], listOfArrangements, diffs);

    return listOfArrangements;
  }

  static int second() {
    var input = File('./lib/input/day10').readAsStringSync();
    var parsedInput = parseInput(input);
    parsedInput.sort();

    var arrangements = getArrangements(parsedInput);

    return arrangements.length;
  }
}
