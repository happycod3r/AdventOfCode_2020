import 'dart:io';

const alphabet = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
];

class Day6 {
  static int getYesSum() {
    var input = File('./lib/input/day6').readAsStringSync();

    var groups = input.split('\r\n\r\n');
    var groupCounters = [];

    groups.forEach((group) {
      var tempPeople = group.split('\r\n');

      var unifiedArray = [];

      tempPeople.forEach((person) {
        var personArray = parseToAlphaArray(person);

        personArray.forEach((element) {
          if (!unifiedArray.contains(element) && element != '') {
            unifiedArray.add(element);
          }
        });
      });

      groupCounters.add(unifiedArray.length);
    });

    var sum = 0;
    groupCounters.forEach((element) {
      sum += element;
    });

    return sum;
  }

  static int getYesSum2() {
    var input = File('./lib/input/day6').readAsStringSync();

    var groups = input.split('\r\n\r\n');
    var groupCounters = [];

    groups.forEach((group) {
      var tempPeople = group.split('\r\n');

      var unifiedArray = [];

      var peopleArray = tempPeople.map((e) => parseToAlphaArray(e));

      alphabet.forEach((letter) {
        var counter = 0;
        peopleArray.forEach((person) {
          if (person.contains(letter)) {
            counter++;
          }
        });

        if (counter == peopleArray.length) {
          unifiedArray.add(letter);
        }
      });

      groupCounters.add(unifiedArray.length);
    });

    var sum = 0;
    groupCounters.forEach((element) {
      sum += element;
    });

    return sum;
  }

  static List parseToAlphaArray(String input) {
    List inputArray = input.split('');
    inputArray.sort();

    var result = [];

    var index = 0;
    for (var value in alphabet) {
      if (value == inputArray[index]) {
        result.add(value);
        index++;
      } else {
        result.add('');
      }

      if (index >= inputArray.length) {
        break;
      }
    }

    return result;
  }
}
