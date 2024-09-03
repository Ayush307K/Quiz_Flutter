import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primaryColor: Color(0xFFC79DD7), // pastel purple
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFFAD3E7), // soft pink
        ),
      ),
      home: StartScreen(),
      routes: {
        '/quiz': (context) => QuizPage(),
      },
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFAD3E7), // soft pink
              Color(0xFFBDE2D0), // light green
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quiz',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 5),
                        Text(
                          '20',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Popular Game 🔥',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                // Swipeable horizontal list of quiz cards
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildQuizCard(
                        context,
                        title: 'Technology',
                        description: 'Explore the world of technology...',
                        imageAsset: 'assets/quiz.png',
                      ),
                      _buildQuizCard(
                        context,
                        title: 'Social Sciences',
                        description: 'Dive into social sciences...',
                        imageAsset: 'assets/quiz.png',
                      ),
                      _buildQuizCard(
                        context,
                        title: 'Science',
                        description: 'Unravel the mysteries of science...',
                        imageAsset: 'assets/quiz.png',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Recent Played',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                // Recent played list with a single card (can be repeated as needed)
                _buildQuizCard(
                  context,
                  title: 'Social Sciences',
                  description: 'Played recently...',
                  imageAsset: 'assets/quiz.png',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(BuildContext context,
      {required String title,
      required String description,
      required String imageAsset}) {
    return Container(
      width: 160, // Smaller width for more compact swiping
      margin: EdgeInsets.only(right: 15), // Adds space between cards
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFBDE2D0), // light green
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imageAsset,
            height: 70, // Reduced height to fit content
            width: 140,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      QuizPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.white, // Use backgroundColor instead of primary
              foregroundColor: Color(0xFFC79DD7), // pastel purple
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
            child: Text(
              'Start Quiz',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Center(
        child: Text(
          'This is the quiz page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
