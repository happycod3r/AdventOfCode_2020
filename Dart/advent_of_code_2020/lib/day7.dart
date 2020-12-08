import 'dart:io';

class Bag {
  final String color;
  Map<Bag, int> children;
  List<Bag> parents;

  Bag(this.color, [this.children]) {
    children = {};
    parents = [];
  }
}

class Day7 {
  static List<Bag> getListOfBags(String input) {
    var list = input.split('\r\n');
    var bags = <Bag>[];

    list.forEach((line) {
      var parsedLine =
          line.replaceAll('bags', '').replaceAll('bag', '').replaceAll('.', '');
      var rule = parsedLine.split('contain');
      var rootColor = rule[0].substring(0).trim();

      Bag root;
      if (bags.isNotEmpty) {
        root = bags.firstWhere((bag) => bag.color == rootColor,
            orElse: () => null);
      }
      root ??= Bag(rootColor);
      bags.add(root);

      var bagsInside = rule[1].split(',');

      for (var i = 0; i < bagsInside.length; i++) {
        if (bagsInside[i].trim().startsWith('no other')) {
          continue;
        }

        var color = bagsInside[i].trim().substring(1).trim();
        var quant = int.parse(bagsInside[i].trim().substring(0, 1));

        Bag innerBag;
        if (bags.isNotEmpty) {
          innerBag =
              bags.firstWhere((bag) => bag.color == color, orElse: () => null);
        }
        innerBag ??= Bag(color);
        bags.add(innerBag);

        innerBag.parents.add(root);
        root.children.addAll({innerBag: quant});
      }
    });

    return bags;
  }

  static List<Bag> getTransitiveParents(Bag bag) {
    var p = <Bag>[];
    bag.parents.forEach((element) {
      p.add(element);
      p.addAll(getTransitiveParents(element));
    });

    var resul = <Bag>[];
    p.forEach((element) {
      if (!resul.contains(element)) {
        resul.add(element);
      }
    });

    return resul;
  }

  static int first() {
    var input = File('./lib/input/day7').readAsStringSync();

    var bags = getListOfBags(input);
    var key = 'shiny gold';

    Bag dummy;
    if (bags.isNotEmpty) {
      dummy = bags.firstWhere((element) => element.color == key);
    }

    var resList = getTransitiveParents(dummy);

    return resList.length;
  }

  static int countBags(Bag bag) {
    var total = 0;
    if (bag.children.isEmpty) {
      return 1;
    }

    bag.children.keys.forEach((b) {
      total += bag.children[b] * countBags(b);
    });

    if (!bag.color.contains('shiny gold')) {
      total += 1;
    }
    return total;
  }

  static int second() {
    var input = File('./lib/input/day7').readAsStringSync();

    var bags = getListOfBags(input);

    var resul = <Bag>[];
    bags.forEach((element) {
      if (!resul.contains(element)) {
        resul.add(element);
      }
    });

    var key = 'shiny gold';

    Bag dummy;
    if (resul.isNotEmpty) {
      dummy = resul.where((element) => element.color == key).toList().first;
    }

    var count = countBags(dummy);

    return count;
  }
}
