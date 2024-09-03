import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddTab extends StatefulWidget {
  @override
  _AddTabState createState() => _AddTabState();
}

class _AddTabState extends State<AddTab> {
  final _formKey = GlobalKey<FormState>();
  String? _quizTitle;
  String? _quizDescription;
  List<Question> _questions = [];

  void _addQuestion() {
    setState(() {
      _questions.add(Question());
    });
  }

  void _removeQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
  }

  void _submitQuiz() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Handle quiz submission logic here
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Quiz Submitted!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Quiz'),
        backgroundColor: Color(0xFF240046), // Match the theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Quiz Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quiz title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _quizTitle = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Quiz Description',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _quizDescription = value;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Questions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return QuestionForm(
                    question: _questions[index],
                    onRemove: () => _removeQuestion(index),
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addQuestion,
                child: Text('Add Question'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6A53A1), // Match the theme
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitQuiz,
                child: Text('Submit Quiz'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF240046), // Match the theme
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionForm extends StatefulWidget {
  final Question question;
  final VoidCallback onRemove;

  QuestionForm({required this.question, required this.onRemove});

  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  XFile? _videoFile;

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
      widget.question.imagePath = pickedFile?.path;
    });
  }

  void _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _videoFile = pickedFile;
      widget.question.videoPath = pickedFile?.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Question Text',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the question text';
                }
                return null;
              },
              onSaved: (value) {
                widget.question.text = value;
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<QuestionType>(
              value: widget.question.type,
              decoration: InputDecoration(
                labelText: 'Question Type',
                border: OutlineInputBorder(),
              ),
              items: QuestionType.values.map((QuestionType type) {
                return DropdownMenuItem<QuestionType>(
                  value: type,
                  child: Text(type == QuestionType.mcq
                      ? 'Multiple Choice (Single Answer)'
                      : 'Multiple Choice (Multiple Answers)'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  widget.question.type = value!;
                });
              },
            ),
            SizedBox(height: 16),
            _imageFile != null
                ? Image.network(
                    _imageFile!.path,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                : SizedBox.shrink(),
            _videoFile != null
                ? Container(
                    height: 150,
                    color: Colors.black26,
                    child: Center(
                      child: Text(
                        'Video Selected',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Add Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6A53A1), // Match the theme
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickVideo,
                  child: Text('Add Video'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6A53A1), // Match the theme
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Option 1',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                widget.question.options[0] = value;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Option 2',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                widget.question.options[1] = value;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Option 3',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                widget.question.options[2] = value;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Option 4',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                widget.question.options[3] = value;
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: widget.onRemove,
                  child: Text('Remove Question'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  String? text;
  QuestionType type = QuestionType.mcq;
  List<String?> options = List.filled(4, null);
  String? imagePath;
  String? videoPath;

  Question({this.text});
}

enum QuestionType { mcq, multipleAnswer }

void main() {
  runApp(MaterialApp(
    home: AddTab(),
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Color(0xFF240046), // Dark purple background
      textTheme: ThemeData.dark().textTheme.apply(
            fontFamily: 'Poppins', // If you have Poppins font installed
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
    ),
  ));
}
