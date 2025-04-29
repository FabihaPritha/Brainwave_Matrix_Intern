
import 'package:flutter/material.dart';
import '../data/questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;

  void checkAnswer(String selected) {
    if (selected == sampleQuestions[currentQuestion].answer) {
      score++;
    }
    setState(() {
      currentQuestion++;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool quizOver = currentQuestion >= sampleQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: quizOver
            ? Center(
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Quiz Completed!", style: TextStyle(fontSize: 24)),
                    Text("Score: $score/${sampleQuestions.length}"),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentQuestion = 0;
                          score = 0;
                        });
                      },
                      child: Text("Restart"),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    sampleQuestions[currentQuestion].questionText,
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: 20),
                  ...sampleQuestions[currentQuestion].options.map((option) {
                    return ElevatedButton(
                      onPressed: () => checkAnswer(option),
                      child: Text(option),
                    );
                  }),
                ],
              ),
      ),
    );
  }
}
