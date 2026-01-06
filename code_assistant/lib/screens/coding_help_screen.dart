import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:math' as math;
import '../services/gemini_service.dart';
import '../models/programming_language.dart';

class CodingHelpScreen extends StatefulWidget {
  const CodingHelpScreen({Key? key}) : super(key: key);

  @override
  _CodingHelpScreenState createState() => _CodingHelpScreenState();
}

class _CodingHelpScreenState extends State<CodingHelpScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _questionController = TextEditingController();
  final GeminiService _geminiService = GeminiService();
  String _selectedLanguage = ProgrammingLanguages.languages.first.name;
  String _response = '';
  bool _isLoading = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _questionController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _getResponse() async {
    if (_questionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a question')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _response = '';
    });

    try {
      final prompt = """
You are an expert ${_selectedLanguage} developer. Provide a helpful, clear, and accurate response to the following question or request. Include code examples when appropriate:

${_questionController.text}

Provide detailed explanations and follow best practices for ${_selectedLanguage} development.
""";
      final response = await _geminiService.getCodingHelp(prompt);

      setState(() {
        _response = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _response = "Error: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E2E4E),
        elevation: 0,
        title: Text('Ask Coding Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Select language:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
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
            SizedBox(height: 16),
            Text(
              'What\'s your question?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              constraints: BoxConstraints(
                maxHeight: isPortrait ? screenHeight * 0.2 : screenHeight * 0.3,
                minHeight: 120,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF2E2E4E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _questionController,
                style: TextStyle(color: Colors.white),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'E.g., How do I implement a binary search tree?',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _getResponse,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: _isLoading
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2.0,
                      ),
                    )
                  : Text(
                      'Get Answer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            SizedBox(height: 24),
            ClipRect(
              child: Container(
                height: isPortrait
                    ? (screenHeight > 600 ? screenHeight * 0.4 : 200)
                    : screenHeight * 0.5,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF2E2E4E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _response.isEmpty && !_isLoading
                    ? Center(
                        child: Text(
                          'Ask a question to get started',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                      )
                    : _isLoading
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: CustomCodeLoader(
                                    animation: _animationController,
                                  ),
                                ),
                                SizedBox(height: 24),
                                Text(
                                  '${_selectedLanguage} AI is thinking...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Generating a detailed response',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: MarkdownBody(
                              data: _response,
                              selectable: true,
                              styleSheet: MarkdownStyleSheet(
                                p: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                                code: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  backgroundColor: Color(0xFF1E1E2E),
                                  fontSize: 14,
                                ),
                                codeblockDecoration: BoxDecoration(
                                  color: Color(0xFF1E1E2E),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Color(0xFF3E3E5E),
                                    width: 1,
                                  ),
                                ),
                                h1: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                h2: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                h3: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                blockquote: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                                strong: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCodeLoader extends StatelessWidget {
  final Animation<double> animation;

  const CustomCodeLoader({
    Key? key,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: CodePainter(
            progress: animation.value,
          ),
          child: Container(),
        );
      },
    );
  }
}

class CodePainter extends CustomPainter {
  final double progress;

  CodePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = math.min(centerX, centerY) - 5;

    // Draw outline
    final outlinePaint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawCircle(Offset(centerX, centerY), radius, outlinePaint);

    // Draw progress arc
    final progressPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );

    // Draw code symbols
    final codePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final symbols = ['{', '}', '<', '>', '(', ')', ';', '[', ']'];
    final codeRadius = radius * 0.7;

    for (int i = 0; i < 8; i++) {
      final angle = math.pi * 2 * i / 8 + progress * math.pi * 2;
      final x = centerX + codeRadius * math.cos(angle);
      final y = centerY + codeRadius * math.sin(angle);

      // Draw code symbol
      final textSpan = TextSpan(
        text: symbols[i % symbols.length],
        style: TextStyle(
          color: Colors.white
              .withOpacity(0.5 + 0.5 * math.sin(progress * math.pi * 2 + i)),
          fontSize: 12 + 4 * math.sin(progress * math.pi * 2 + i),
          fontWeight: FontWeight.bold,
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(canvas,
          Offset(x - textPainter.width / 2, y - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(CodePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
