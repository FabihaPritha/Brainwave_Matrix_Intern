import 'package:flutter/material.dart';
import '../data/questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int score = 0;
  List<String?> selectedAnswers = List.filled(sampleQuestions.length, null);

  void selectAnswer(int index, String selectedOption) {
    if (selectedAnswers[index] == null) {
      selectedAnswers[index] = selectedOption;
      if (selectedOption == sampleQuestions[index].answer) {
        score++;
      }
      setState(() {});
    }
  }

  bool get quizCompleted =>
      !selectedAnswers.contains(null); // All questions answered

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 70, 10, 86),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: quizCompleted
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Quiz Completed!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Score: $score/${sampleQuestions.length}",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          score = 0;
                          selectedAnswers =
                              List.filled(sampleQuestions.length, null);
                        });
                      },
                      child: const Text("Restart"),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: sampleQuestions.length,
                itemBuilder: (context, index) {
                  final question = sampleQuestions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: 4,
                    shadowColor: Colors.deepPurple,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            question.questionText,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          ...sampleQuestions[index].options.map((option) {
                            final selected = selectedAnswers[index];
                            final isSelected = selected == option;
                            final isCorrect = sampleQuestions[index].answer == option;

                            Icon? feedbackIcon;
                            if (selected != null) {
                              if (isSelected && isCorrect) {
                                feedbackIcon = const Icon(Icons.check, color: Colors.green);
                              } else if (isSelected && !isCorrect) {
                                feedbackIcon = const Icon(Icons.close, color: Colors.red);
                              }
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: ElevatedButton.icon(
                                icon: feedbackIcon ?? const SizedBox(width: 0),
                                label: Text(option),
                                onPressed: selected == null ? () => selectAnswer(index, option) : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isSelected
                                      ? (isCorrect ? Colors.green.shade100 : Colors.red.shade100)
                                      : null,
                                  foregroundColor: Colors.black,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                ),
                              ),
                            );
                          }),


                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
