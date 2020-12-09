import 'dart:convert';
import 'dart:io';

import 'dart:isolate';

import 'dart:math';

class Instruction {
  String instruction;
  final String ope;
  final int number;
  bool haveRunned;

  Instruction(this.instruction, this.ope, this.number) {
    haveRunned = false;
  }

  dynamic toJson() {
    return {
      'instruction': instruction,
      'ope': ope,
      'number': number,
      'haveRunned': haveRunned
    };
  }

  static Instruction map(Map<String, dynamic> json) {
    return Instruction(json['instruction'], json['ope'], json['number']);
  }
}

class Day8 {
  static List<Instruction> parseInput(String input) {
    var lines = input.split('\r\n');
    var instructions = <Instruction>[];

    lines.forEach((line) {
      var parsedLine = line.split(' ');
      var ope = parsedLine[1].substring(0, 1);
      var number = parsedLine[1].substring(1, parsedLine[1].length);

      instructions.add(Instruction(parsedLine[0], ope, int.parse(number)));
    });

    return instructions;
  }

  static int getAccValueAtLoopEnd(List<Instruction> instructions) {
    var accumulator = 0;

    var index = 0;
    while (true) {
      if (instructions[index].haveRunned) {
        break;
      }

      var innerAccumulator = 0;

      switch (instructions[index].instruction) {
        case 'acc':
          instructions[index].haveRunned = true;
          if (instructions[index].ope == '+') {
            innerAccumulator += instructions[index].number;
          } else {
            innerAccumulator -= instructions[index].number;
          }
          index++;
          break;
        case 'jmp':
          instructions[index].haveRunned = true;
          if (instructions[index].ope == '+') {
            index += instructions[index].number;
          } else {
            index -= instructions[index].number;
          }
          break;
        case 'nop':
          instructions[index].haveRunned = true;
          index++;
          break;
        default:
          break;
      }

      accumulator += innerAccumulator;
    }

    return accumulator;
  }

  static int first() {
    var input = File('./lib/input/day8').readAsStringSync();
    var accumulator = 0;

    var instructions = parseInput(input);

    accumulator = getAccValueAtLoopEnd(instructions);

    return accumulator;
  }

  static Map<int, int> getInnerAcc(
      int index, List<Instruction> instructions, int accumulator) {
    switch (instructions[index].instruction) {
      case 'acc':
        instructions[index].haveRunned = true;
        if (instructions[index].ope == '+') {
          accumulator += instructions[index].number;
        } else {
          accumulator -= instructions[index].number;
        }
        index++;
        break;
      case 'jmp':
        instructions[index].haveRunned = true;
        if (instructions[index].ope == '+') {
          index += instructions[index].number;
        } else {
          index -= instructions[index].number;
        }
        break;
      case 'nop':
        instructions[index].haveRunned = true;
        index++;
        break;
      default:
        break;
    }

    return {index: accumulator};
  }

  static List<List<Instruction>> getPossibleInstructions(
    List<Instruction> instructions,
  ) {
    var listOfInstructions = <List<Instruction>>[];
    listOfInstructions.add(instructions);

    for (var i = 0; i < instructions.length; i++) {
      // * Creating a new list
      List<dynamic> newList = json
          .decode(json.encode((instructions.map((e) => e.toJson())).toList()));
      var tempinsts = newList.map((e) => Instruction.map(e)).toList();

      switch (tempinsts[i].instruction) {
        case 'jmp':
          tempinsts[i].instruction = 'nop';
          break;
        case 'nop':
          tempinsts[i].instruction = 'jmp';
          break;
        default:
          break;
      }
      listOfInstructions.add(tempinsts);
    }

    return listOfInstructions;
  }

  static int getAccValueAtProgEnd(List<Instruction> instructions) {
    var index = 0;
    var accumulator = 0;

    while (index < instructions.length - 1) {
      var innerResult = getInnerAcc(index, instructions, accumulator);
      index = innerResult.keys.first;
      accumulator = innerResult.values.first;

      if (instructions[index].haveRunned) {
        return -1;
      }
    }

    return accumulator;
  }

  static dynamic test(SendPort sendPort) {
    sendPort.send('test');
  }

  static int second() {
    var input = File('./lib/input/day8').readAsStringSync();
    var instructions = parseInput(input);

    var listOfPossibleSolutions = getPossibleInstructions(instructions);

    var result = 0;

    for (var e in listOfPossibleSolutions) {
      result = getAccValueAtProgEnd(e);
      if (result != -1) {
        break;
      }
    }

    return result;
  }
}

class Instructions {}
