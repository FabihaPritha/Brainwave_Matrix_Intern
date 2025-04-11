
import '../models/question.dart';

List<Question> sampleQuestions = [
  Question(
  questionText: "Q: What is 'overfitting' in machine learning?",
  options: ["Model performs well on unseen data", "Model learns the noise", "Model generalizes data well", "Model learns faster"],
  answer: "Model learns the noise",
),
  Question(
    questionText: "Q: What is Flutter?",
    options: ["IDE", "Programming Language", "SDK", "Database"],
    answer: "SDK",
  ),
  Question(
    questionText: "Q: Who is the founder of Microsoft?",
    options: ["Steve Jobs", "Elon Musk", "Larry Page", "Bill Gates"],
    answer: "Bill Gates",
  ),
  Question(
    questionText: "Q: What language is primarily used to build Android apps?",
    options: ["Swift", "java", "Kotlin", "Python"],
    answer: "Kotlin",
  ),
  Question(
  questionText: "Q: Which company operates the Starlink project?",
  options: ["NASA", "Blue Origin", "SpaceX", "ISRO"],
  answer: "SpaceX",
),
  Question(
  questionText: "Q: Which algorithm is primarily used for dimensionality reduction in AI?",
  options: ["SVM", "KNN", "PCA", "Random Forest"],
  answer: "PCA",
),
];
