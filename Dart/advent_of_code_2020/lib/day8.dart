import 'dart:io';

import 'dart:isolate';

class Instruction {
  String instruction;
  final String ope;
  final int number;
  bool haveRunned;

  Instruction(this.instruction, this.ope, this.number) {
    haveRunned = false;
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

  static Map<int, int> getInnerAcc(int index, List<Instruction> instructions) {
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

    return {index: innerAccumulator};
  }

  static dynamic doTheThing(
    List<Instruction> instructions,
    int accumulator,
    int index,
    int previousIndex,
    bool errorFixed,
    SendPort sendPort,
  ) {
    try {
      print(
          'isolate start: ' + accumulator.toString() + ' ' + index.toString());
      while (true) {
        if (index == instructions.length - 1) {
          break;
        }

        previousIndex = index;

        var innerResult = getInnerAcc(index, instructions);
        index = innerResult.keys.first;
        accumulator = innerResult.values.first;

        // * here is checking the next instruction
        if (!errorFixed) {
          // * change previous instruction to fix error
          switch (instructions[previousIndex].instruction) {
            case 'jmp':
              instructions[previousIndex].instruction = 'nop';
              break;
            case 'nop':
              instructions[previousIndex].instruction = 'jmp';
              break;
            default:
              break;
          }
          Isolate.spawn(
              doTheThing(
                instructions,
                accumulator,
                index,
                previousIndex,
                errorFixed,
                sendPort,
              ),
              sendPort);
          errorFixed = true;
        }
      }
    } catch (e) {
      sendPort.send(e.toString());
    } finally {
      sendPort.send(accumulator);
    }
  }

  static int getAccValueAtProgEnd(List<Instruction> instructions) {
    var index = 0;
    var previousIndex = index;

    var errorFixed = false;

    var accumulator = 0;

    var receivePort = ReceivePort();
    receivePort.listen((data) {
      accumulator = data;
    });
    Isolate.spawn(
      doTheThing(
        instructions,
        accumulator,
        index,
        previousIndex,
        errorFixed,
        receivePort.sendPort,
      ),
      receivePort.sendPort,
    );

    print('result is ======>>>>  ' + accumulator.toString());

    return accumulator;
  }

  static int second() {
    var input = File('./lib/input/day8').readAsStringSync();
    var instructions = parseInput(input);

    return getAccValueAtProgEnd(instructions);
  }
}
