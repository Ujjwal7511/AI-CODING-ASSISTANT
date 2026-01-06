import 'package:flutter/material.dart';
import '../models/programming_language.dart';
import 'coding_help_screen.dart';
import 'debug_screen.dart';
import 'explain_code_screen.dart';
import 'improve_code_screen.dart';
import 'challenge_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E2E4E),
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.code, size: 28),
            SizedBox(width: 12),
            Text(
              'AI Coding Assistant',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Developer!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'What would you like help with today?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(height: 24),
              _buildFeatureCard(
                context,
                title: 'Ask Coding Questions',
                description: 'Get answers to your programming questions',
                icon: Icons.question_answer,
                color: Colors.blueAccent,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CodingHelpScreen()),
                ),
              ),
              _buildFeatureCard(
                context,
                title: 'Debug Your Code',
                description: 'Find and fix issues in your code',
                icon: Icons.bug_report,
                color: Colors.redAccent,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DebugScreen()),
                ),
              ),
              _buildFeatureCard(
                context,
                title: 'Explain Code',
                description: 'Get detailed explanations of how code works',
                icon: Icons.school,
                color: Colors.greenAccent,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExplainCodeScreen()),
                ),
              ),
              _buildFeatureCard(
                context,
                title: 'Improve Your Code',
                description: 'Get suggestions to enhance your code',
                icon: Icons.auto_fix_high,
                color: Colors.purpleAccent,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImproveCodeScreen()),
                ),
              ),
              _buildFeatureCard(
                context,
                title: 'Coding Challenges',
                description: 'Practice with challenges and get feedback',
                icon: Icons.fitness_center,
                color: Colors.orangeAccent,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChallengeScreen()),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Supported Languages',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              _buildLanguageGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF2E2E4E),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: ProgrammingLanguages.languages.length,
      itemBuilder: (context, index) {
        final language = ProgrammingLanguages.languages[index];
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFF2E2E4E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                language.icon,
                style: TextStyle(fontSize: 28),
              ),
              SizedBox(height: 8),
              Text(
                language.name,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
