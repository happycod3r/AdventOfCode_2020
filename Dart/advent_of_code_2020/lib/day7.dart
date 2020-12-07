import 'dart:io';

class Day7 {
  static List<Map<dynamic, dynamic>> parseList(List<String> list) {
    List<Map<dynamic, dynamic>> resultList = [];

    list.forEach((element) {
      var parsedElem = element.split(' bags contain ');
      var listOfContent = parsedElem[1].split(', ');

      listOfContent[listOfContent.length - 1] =
          listOfContent[listOfContent.length - 1].contains('.')
              ? listOfContent[listOfContent.length - 1].substring(
                  0, listOfContent[listOfContent.length - 1].length - 1)
              : listOfContent[listOfContent.length - 1];

      resultList.add({
        'bag': parsedElem[0],
        'content': listOfContent,
      });
    });

    return resultList;
  }

  static List<Map<dynamic, dynamic>> getMatches(
      List<Map<dynamic, dynamic>> input, String searchWord) {
    List<Map<dynamic, dynamic>> result = [];

    input.forEach((rule) {
      (rule['content'] as List).forEach((content) {
        if (content.toString().contains(searchWord)) {
          result.add(rule);
        }
      });
    });

    return result;
  }

  static int getBagCount() {
    var input = File('./lib/input/day7').readAsStringSync();

    var searchWord = 'shiny gold';
    // var counter = 0;

    var listOfRules = input.split('\r\n');

    var matchedRules = [];
    var level1 = [];
    var level2 = [];
    var level3 = [];

    var listParsed = parseList(listOfRules);

    // * contain at least one
    matchedRules = getMatches(listParsed, searchWord);

    level1.addAll(matchedRules);
    level2.addAll(matchedRules);
    level3.addAll(matchedRules);

    matchedRules.forEach((element) {
      level1.addAll(getMatches(listParsed, element['bag']));
    });

    level2.addAll(level1);
    level3.addAll(level1);

    level1.forEach((element) {
      level2.addAll(getMatches(listParsed, element['bag']));
    });

    level3.addAll(level2);

    level2.forEach((element) {
      level3.addAll(getMatches(listParsed, element['bag']));
    });

    // parsedList.forEach((rule) {
    //   (rule['content'] as List).forEach((content) {
    //     directRules.forEach((directRule) {
    //       if (content.toString().contains(directRule['bag'])) {
    //         counter++;
    //       }
    //     });
    //   });
    // });

    return 0;
  }
}
