import 'package:flutter/material.dart';
import '../services/gemini_service.dart';
import '../models/programming_language.dart';
import '../widgets/code_editor.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final GeminiService _geminiService = GeminiService();
  String _selectedLanguage = ProgrammingLanguages.languages.first.name;
  String _selectedDifficulty = 'Easy';
  String _challenge = '';
  String _solution = '';
  String _feedback = '';
  bool _isLoadingChallenge = false;
  bool _isLoadingFeedback = false;
  bool _challengeGenerated = false;

  List<String> difficultyLevels = ['Easy', 'Medium', 'Hard'];

  Future<void> _generateChallenge() async {
    setState(() {
      _isLoadingChallenge = true;
      _challenge = '';
      _solution = '';
      _feedback = '';
      _challengeGenerated = false;
    });

    try {
      final challenge = await _geminiService.getCodingChallenge(
          _selectedLanguage, _selectedDifficulty);

      setState(() {
        _challenge = challenge;
        _isLoadingChallenge = false;
        _challengeGenerated = true;
      });
    } catch (e) {
      setState(() {
        _challenge = "Error: ${e.toString()}";
        _isLoadingChallenge = false;
      });
    }
  }

  Future<void> _evaluateSolution() async {
    if (_solution.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your solution')),
      );
      return;
    }

    setState(() {
      _isLoadingFeedback = true;
      _feedback = '';
    });

    try {
      final feedback = await _geminiService.evaluateChallengeSolution(
          _challenge, _solution, _selectedLanguage);

      setState(() {
        _feedback = feedback;
        _isLoadingFeedback = false;
      });
    } catch (e) {
      setState(() {
        _feedback = "Error: ${e.toString()}";
        _isLoadingFeedback = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E2E4E),
        elevation: 0,
        title: Text('Coding Challenges'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select language:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFF2E2E4E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedLanguage,
                          dropdownColor: Color(0xFF2E2E4E),
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(color: Colors.white),
                          items: ProgrammingLanguages.languages
                              .map((lang) => DropdownMenuItem<String>(
                                    value: lang.name,
                                    child: Text(
                                      '${lang.icon} ${lang.name}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedLanguage = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Difficulty level:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFF2E2E4E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedDifficulty,
                          dropdownColor: Color(0xFF2E2E4E),
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(color: Colors.white),
                          items: difficultyLevels
                              .map((difficulty) => DropdownMenuItem<String>(
                                    value: difficulty,
                                    child: Text(
                                      difficulty,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedDifficulty = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoadingChallenge ? null : _generateChallenge,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: _isLoadingChallenge
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      'Generate Challenge',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _challenge.isEmpty && !_isLoadingChallenge
                  ? Center(
                      child: Text(
                        'Generate a challenge to get started',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFF2E2E4E),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: _isLoadingChallenge
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : SingleChildScrollView(
                                    child: Text(
                                      _challenge,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        if (_challengeGenerated) ...[
                          SizedBox(height: 16),
                          Text(
                            'Your Solution:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          CodeEditor(
                            language: _selectedLanguage,
                            onCodeChanged: (code) {
                              setState(() {
                                _solution = code;
                              });
                            },
                            height: 150,
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed:
                                _isLoadingFeedback ? null : _evaluateSolution,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: _isLoadingFeedback
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : Text(
                                    'Submit Solution',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                          if (_feedback.isNotEmpty) ...[
                            SizedBox(height: 16),
                            Text(
                              'Feedback:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2E2E4E),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: _isLoadingFeedback
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : SingleChildScrollView(
                                        child: Text(
                                          _feedback,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ]
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
