import 'dart:io';
import 'dart:math';

class Quizz {
  Future<QuestionAnswer> getQuestion() async {
    final file = File("questions.txt");
    final lines = await file.readAsLines();
    final questions = <String>[];
    final answers = <String>[];
    for (final line in lines) {
      final parts = line.split("-%-");
      questions.add(parts[0]);
      answers.add(parts[1]);
    }
    final index = Random().nextInt(lines.length);
    return QuestionAnswer(questions[index], answers[index]);
  }

  Future<bool> verifyAnswer(QuestionAnswer QnA, String answer) async {
    return QnA.answer == answer;
  }

  Future<void> start() async {
    print(
        "Hi Welcome to RapDz Quizz Game\nWe have here some Lyrics to show\nGuess The Rapper !");
    String verif;
    do {
      final QA = await getQuestion();
      print("The Lyrics is :");
      print(QA.question);
      final answer = stdin.readLineSync();
      final isCorrect = await verifyAnswer(QA, answer!);
      if (isCorrect) {
        print("Congrats ! You answered right");
      } else {
        print("Wrong answer !");
      }
      print("Do You want to continue? Y/N");
      verif = stdin.readLineSync()!;
    } while (verif == "y" || verif == "Y");
  }
}

class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer(this.question, this.answer);
}

void main() async {
  String verif;
  do {
    final q = Quizz();
    await q.start();
    print("Do You want to play again? Y/N");
    verif = stdin.readLineSync()!;
  } while (verif == "y" || verif == "Y");
}
