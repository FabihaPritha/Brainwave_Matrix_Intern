
import '../models/question.dart';

List<Question> sampleQuestions = [
  Question(
  questionText: "1. What is 'overfitting' in machine learning?",
  options: ["Model performs well on unseen data", "Model learns the noise", "Model generalizes data well", "Model learns faster"],
  answer: "Model learns the noise",
),
  Question(
    questionText: "2. What is Flutter?",
    options: ["IDE", "Programming Language", "SDK", "Database"],
    answer: "SDK",
  ),
  Question(
    questionText: "3. Who is the founder of Microsoft?",
    options: ["Steve Jobs", "Elon Musk", "Larry Page", "Bill Gates"],
    answer: "Bill Gates",
  ),
  Question(
    questionText: "4. What language is primarily used to build Android apps?",
    options: ["Swift", "java", "Kotlin", "Python"],
    answer: "Kotlin",
  ),
  Question(
  questionText: "5. Which company operates the Starlink project?",
  options: ["NASA", "Blue Origin", "SpaceX", "ISRO"],
  answer: "SpaceX",
),
  Question(
  questionText: "6. Which algorithm is primarily used for dimensionality reduction in AI?",
  options: ["SVM", "KNN", "PCA", "Random Forest"],
  answer: "PCA",
),
];
