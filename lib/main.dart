import 'package:flutter/material.dart';

void main() {
  runApp(const FamilyQuizParty());
}

// Ana uygulama widget'ı
class FamilyQuizParty extends StatelessWidget {
  const FamilyQuizParty({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aile Quiz Party',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// Ana ekran
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aile Quiz Party'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GameScreen(isLocalGame: true),
                    ),
                  ),
              child: const Text('Yerel Ağda Oyna'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GameScreen(isLocalGame: false),
                    ),
                  ),
              child: const Text('İnternette Oyna'),
            ),
          ],
        ),
      ),
    );
  }
}

// Oyun ekranı
class GameScreen extends StatefulWidget {
  final bool isLocalGame;
  const GameScreen({super.key, required this.isLocalGame});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _score = 0;
  int _currentQuestionIndex = 0;
  final List<Question> _questions = [
    Question(
      text: "Flutter'ın yaratıcısı kimdir?",
      options: ["Google", "Facebook", "Microsoft", "Apple"],
      correctAnswer: 0,
    ),
    Question(
      text: "Türkiye'nin başkenti neresidir?",
      options: ["İstanbul", "İzmir", "Ankara", "Bursa"],
      correctAnswer: 2,
    ),
    // Daha fazla soru eklenebilir
  ];

  void _answerQuestion(int selectedIndex) {
    if (_currentQuestionIndex < _questions.length) {
      if (selectedIndex == _questions[_currentQuestionIndex].correctAnswer) {
        setState(() => _score += 10);
      }

      setState(() {
        if (_currentQuestionIndex < _questions.length - 1) {
          _currentQuestionIndex++;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isLocalGame ? 'Yerel Oyun' : 'Online Oyun'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Puan: $_score',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (_currentQuestionIndex < _questions.length) ...[
              Text(
                _questions[_currentQuestionIndex].text,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ..._questions[_currentQuestionIndex].options.asMap().entries.map(
                (option) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => _answerQuestion(option.key),
                    child: Text(option.value),
                  ),
                ),
              ),
            ] else ...[
              const Text(
                'Oyun Bitti!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                'Toplam Puan: $_score',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Soru modeli
class Question {
  final String text;
  final List<String> options;
  final int correctAnswer;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
  });
}
