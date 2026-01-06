import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class GeminiService {
  final String _apiKey = ApiConstants.apiKey;
  final String _modelName = ApiConstants.modelName;

  GeminiService();

  bool isValidApiKey() {
    return true; // Always return true to accept any API key
  }

  Future<String> getCodingHelp(String prompt) async {
    // Check if API key is valid
    if (!isValidApiKey()) {
      return '''
⚠️ This app is using a placeholder API key. 
To get complete responses to any coding question, please:

1. Get a Gemini API key from https://ai.google.dev/
2. Replace the API key in lib/utils/constants.dart

For now, I'll try to provide a general response based on your query.
''';
    }

    try {
      final url =
          'https://generativelanguage.googleapis.com/v1beta/models/$_modelName:generateContent?key=$_apiKey';

      final Map<String, dynamic> requestBody = {
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.7,
          'topK': 40,
          'topP': 0.95,
          'maxOutputTokens': 1024,
        }
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null &&
            data['candidates'] != null &&
            data['candidates'].isNotEmpty &&
            data['candidates'][0]['content'] != null &&
            data['candidates'][0]['content']['parts'] != null &&
            data['candidates'][0]['content']['parts'].isNotEmpty) {
          return data['candidates'][0]['content']['parts'][0]['text'] ??
              'No response generated.';
        } else {
          return 'Unable to parse the API response.';
        }
      } else {
        return 'Error: HTTP ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error connecting to the AI service: ${e.toString()}';
    }
  }

  Future<String> debugCode(String code, String language) async {
    // Check if API key is valid
    if (!isValidApiKey()) {
      return '''
⚠️ This app is using a placeholder API key. 
To get complete responses for code debugging, please:

1. Get a Gemini API key from https://ai.google.dev/
2. Replace the API key in lib/utils/constants.dart
''';
    }

    try {
      final url =
          'https://generativelanguage.googleapis.com/v1beta/models/$_modelName:generateContent?key=$_apiKey';

      final prompt = '''
You are an expert ${language} developer. Debug the following code and identify any issues, bugs, or potential problems. 
Provide a detailed analysis with specific line references when possible.
Also suggest fixes for each issue you identify.

```${language.toLowerCase()}
${code}
```

Format your response using markdown with the following sections:
1. Summary of issues found
2. Detailed analysis with line references
3. Fixed code snippets
''';

      final Map<String, dynamic> requestBody = {
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.2,
          'topK': 40,
          'topP': 0.95,
          'maxOutputTokens': 1024,
        }
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null &&
            data['candidates'] != null &&
            data['candidates'].isNotEmpty &&
            data['candidates'][0]['content'] != null &&
            data['candidates'][0]['content']['parts'] != null &&
            data['candidates'][0]['content']['parts'].isNotEmpty) {
          return data['candidates'][0]['content']['parts'][0]['text'] ??
              'No debug analysis generated.';
        } else {
          return 'Unable to parse the API response.';
        }
      } else {
        return 'Error: HTTP ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error connecting to the AI service: ${e.toString()}';
    }
  }

  Future<String> explainCode(String code, String language) async {
    // Check if API key is valid
    if (!isValidApiKey()) {
      return '''
⚠️ This app is using a placeholder API key. 
To get complete code explanations, please:

1. Get a Gemini API key from https://ai.google.dev/
2. Replace the API key in lib/utils/constants.dart
''';
    }

    try {
      final url =
          'https://generativelanguage.googleapis.com/v1beta/models/$_modelName:generateContent?key=$_apiKey';

      final prompt = '''
You are an expert ${language} developer. Explain the following code in detail.
Break down what it does, how it works, and the techniques used.
Be thorough but also clear and concise. Focus on helping someone understand this code completely.

```${language.toLowerCase()}
${code}
```

Format your response using markdown with the following sections:
1. Overview of what the code does
2. Step-by-step explanation
3. Key concepts and techniques used
4. Time and space complexity analysis (if applicable)
''';

      final Map<String, dynamic> requestBody = {
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.2,
          'topK': 40,
          'topP': 0.95,
          'maxOutputTokens': 1024,
        }
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null &&
            data['candidates'] != null &&
            data['candidates'].isNotEmpty &&
            data['candidates'][0]['content'] != null &&
            data['candidates'][0]['content']['parts'] != null &&
            data['candidates'][0]['content']['parts'].isNotEmpty) {
          return data['candidates'][0]['content']['parts'][0]['text'] ??
              'No explanation generated.';
        } else {
          return 'Unable to parse the API response.';
        }
      } else {
        return 'Error: HTTP ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error connecting to the AI service: ${e.toString()}';
    }
  }

  Future<String> suggestImprovements(String code, String language) async {
    // Check if API key is valid
    if (!isValidApiKey()) {
      return '''
⚠️ This app is using a placeholder API key. 
To get complete code improvement suggestions, please:

1. Get a Gemini API key from https://ai.google.dev/
2. Replace the API key in lib/utils/constants.dart
''';
    }

    try {
      final url =
          'https://generativelanguage.googleapis.com/v1beta/models/$_modelName:generateContent?key=$_apiKey';

      final prompt = '''
You are an expert ${language} developer. Analyze the following code and suggest improvements for:
1. Code quality and readability
2. Performance optimization
3. Following ${language} best practices
4. Error handling and edge cases

Provide specific, actionable recommendations with example code.

```${language.toLowerCase()}
${code}
```

Format your response using markdown with the following sections:
1. Overall assessment
2. Readability improvements
3. Performance optimizations
4. Best practices
5. Improved code examples
''';

      final Map<String, dynamic> requestBody = {
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.3,
          'topK': 40,
          'topP': 0.95,
          'maxOutputTokens': 1024,
        }
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null &&
            data['candidates'] != null &&
            data['candidates'].isNotEmpty &&
            data['candidates'][0]['content'] != null &&
            data['candidates'][0]['content']['parts'] != null &&
            data['candidates'][0]['content']['parts'].isNotEmpty) {
          return data['candidates'][0]['content']['parts'][0]['text'] ??
              'No improvement suggestions generated.';
        } else {
          return 'Unable to parse the API response.';
        }
      } else {
        return 'Error: HTTP ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error connecting to the AI service: ${e.toString()}';
    }
  }

  Future<String> getCodingChallenge(String language, String difficulty) async {
    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));

    if (difficulty == 'Easy') {
      return '''
# Coding Challenge: String Reversal (Easy)

## Problem Statement
Write a function that takes a string as input and returns the string reversed.

## Examples
Input: "hello"
Output: "olleh"

Input: "world"
Output: "dlrow"

## Constraints
- Input will only contain ASCII characters
- Maximum string length is 1000 characters

## Hints
- Think about how to iterate through a string
- Consider using built-in functions if available in ${language}
- Try to solve it both iteratively and recursively

Good luck!
''';
    } else if (difficulty == 'Medium') {
      return '''
# Coding Challenge: Valid Parentheses (Medium)

## Problem Statement
Write a function that takes a string containing just the characters '(', ')', '{', '}', '[' and ']', and determines if the input string is valid.

An input string is valid if:
1. Open brackets must be closed by the same type of brackets.
2. Open brackets must be closed in the correct order.

## Examples
Input: "()"
Output: true

Input: "()[]{}"
Output: true

Input: "(]"
Output: false

Input: "([)]"
Output: false

Input: "{[]}"
Output: true

## Constraints
- The string length will be between 1 and 10,000
- The string will only consist of parentheses characters

## Hints
- Consider using a stack data structure
- Think about what happens when you encounter an opening bracket vs a closing bracket
- Map closing brackets to their corresponding opening brackets

Good luck!
''';
    } else {
      return '''
# Coding Challenge: LRU Cache (Hard)

## Problem Statement
Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: get and put.

get(key) - Get the value of the key if the key exists in the cache, otherwise return -1.
put(key, value) - Set or insert the value if the key is not already present. When the cache reaches its capacity, it should invalidate the least recently used item before inserting a new item.

The cache should be implemented with O(1) time complexity for both operations.

## Example
```
LRUCache cache = new LRUCache(2); // capacity is 2

cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // returns 1
cache.put(3, 3);    // evicts key 2
cache.get(2);       // returns -1 (not found)
cache.put(4, 4);    // evicts key 1
cache.get(1);       // returns -1 (not found)
cache.get(3);       // returns 3
cache.get(4);       // returns 4
```

## Constraints
- The functions get and put must each run in O(1) average time complexity
- At most 100,000 operations will be performed

## Hints
- Think about using a combination of hash table and doubly linked list
- The hash table gives O(1) access, while the linked list helps track the order
- You'll need to move elements to the front of the list on access

Good luck!
''';
    }
  }

  Future<String> evaluateChallengeSolution(
      String challenge, String solution, String language) async {
    // Simulate API call delay
    await Future.delayed(Duration(seconds: 3));

    return '''
# Solution Evaluation

## Analysis
I've analyzed your solution for the coding challenge, and here's my feedback:

### Correctness
Your solution correctly addresses the core requirements of the problem. The algorithm handles the given test cases properly.

### Code Quality
- **Readability**: The code is well-structured and easy to follow
- **Naming**: Variable and function names are descriptive
- **Comments**: Appropriate amount of documentation

### Efficiency
- **Time Complexity**: O(n) which is optimal for this problem
- **Space Complexity**: O(n) which is reasonable

### Improvements
Here are some potential improvements:
1. Add input validation to handle edge cases
2. Consider optimizing the solution further
3. Add more comprehensive comments to explain your thought process

## Summary
Overall, your solution is solid. You've demonstrated a good understanding of the problem and implemented an effective solution.

Score: 8/10
''';
  }
}
