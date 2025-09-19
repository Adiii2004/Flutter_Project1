import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: QuizApp());
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Map<String, dynamic>> allQuestions = [
    {
      'questions': "Who is the Founder of Microsoft?",
      'options': ['Steve Jobs', 'Elon Musk', 'Bill Gates', 'James Gosling'],
      'correctAnswer': 2,
    },
    {
      'questions': "Who is the Founder of SpaceX?",
      'options': ['Steve Jobs', 'Elon Musk', 'Bill Gates', 'James Gosling'],
      'correctAnswer': 1,
    },
    {
      'questions': "Who is the Founder of Apple?",
      'options': ['Steve Jobs', 'Elon Musk', 'Bill Gates', 'James Gosling'],
      'correctAnswer': 0,
    },
    {
      'questions': "Who is the Founder of Java?",
      'options': ['Steve Jobs', 'Elon Musk', 'Bill Gates', 'James Gosling'],
      'correctAnswer': 3,
    },
    {
      'questions': "Who is the Founder of C?",
      'options': ['Steve Jobs', 'Elon Musk', 'Dennis Ritchie', 'James Gosling'],
      'correctAnswer': 2,
    },
  ];

  int currentQuestionIndex = 0;
  int selectAnswerIndex = -1;
  bool isQuestionPage = true;

  ButtonStyle checkAnswer(int answerIndex) {
    if (selectAnswerIndex != -1) {
      if (answerIndex == allQuestions[currentQuestionIndex]['correctAnswer']) {
        return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green));
      } else if (selectAnswerIndex == answerIndex) {
        return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red));
      }
    }
    return ButtonStyle();
  }

  @override
  Widget build(BuildContext context) {
    return isQuestionPage ? quizAppPage() : resultPage();
  }

  Scaffold quizAppPage() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "QuizApp",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 120),
              Text(
                "Question : ${currentQuestionIndex + 1}/${allQuestions.length}",
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: 380,
            child: Text(
              allQuestions[currentQuestionIndex]['questions'],
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < 4; i++) ...[
            const SizedBox(height: 15),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: checkAnswer(i),
                onPressed: () {
                  if (selectAnswerIndex == -1) {
                    setState(() {
                      selectAnswerIndex = i;
                    });
                  }
                },
                child: Text(
                  allQuestions[currentQuestionIndex]['options'][i],
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectAnswerIndex != -1) {
            setState(() {
              if (currentQuestionIndex < allQuestions.length - 1) {
                currentQuestionIndex++;
                selectAnswerIndex = -1;
              } else {
                isQuestionPage = false;
              }
            });
          }
        },
        backgroundColor: Colors.blue,
        child: const Text(
          "Next",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }

  Scaffold resultPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("Result Screen", style: TextStyle(fontSize: 30)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: NetworkImage(
                "https://www.usatoday.com/gcdn/authoring/authoring-images/2025/02/14/USAT/78617533007-2191503286.jpg?width=660&height=441&fit=crop&format=pjpg&auto=webp",
              ),
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 30),
            Text(
              "Congratulations",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
