import 'package:flutter/material.dart';
import 'dart:ui';

class Diary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keep App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: NoteListScreen(),
    );
  }
}

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Note> notes = [];

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    isDismissible: true,
                    builder: (BuildContext context) {
                      return NoteDetailsScreen(note: notes[index]);
                    },
                  );
                },
                child: Hero(
                  tag: 'note_$index',
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.up,
                    onDismissed: (_) {
                      _deleteNote(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _getImagePath(notes[index].mood),
                            width: 60.0,
                            height: 60.0,
                          ),
                          const SizedBox(height: 8.0),
                          Text(notes[index].moodnote),
                          //Text(notes[index].note),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showMoodDialog();
          },
          backgroundColor: Colors.black,
          label: const Text("今天日記了嗎?"),
          icon: const Icon(Icons.edit_note),
          elevation: 10,
        ));
  }

  String _getImagePath(String mood) {
    switch (mood) {
      case 'Happy':
        return 'assets/calender_page/1-Happy.png';
      case 'Sad':
        return 'assets/calender_page/2-Sad.png';
      case 'Angry':
        return 'assets/calender_page/3-Angry.png';
      case 'Upset':
        return 'assets/calender_page/4-Upset.png';
      case 'Nothing':
        return 'assets/calender_page/5-Nothing.png';
      default:
        return '';
    }
  }

  void _showMoodDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const Text(
              '嗨朋友，今天過得如何？',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _showAddNoteDialog('Happy');
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/calender_page/1-Happy.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 11),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _showAddNoteDialog('Sad');
                  },
                  child: Container(
                    width: 120,
                    height: 100,
                    child: Image.asset(
                      'assets/calender_page/2-Sad.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 1),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _showAddNoteDialog('Angry');
                  },
                  child: Container(
                    width: 110,
                    height: 110,
                    child: Image.asset(
                      'assets/calender_page/3-Angry.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _showAddNoteDialog('Upset');
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        'assets/calender_page/4-Upset.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 13),
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _showAddNoteDialog('Nothing');
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        'assets/calender_page/5-Nothing.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 110),
          ],
        );
      },
    );
  }

  void _showAddNoteDialog(String selectedMood) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String noteText = '';
        String moodtext = '';
        String q1 = '';
        String q2 = '';
        String q3 = '';

        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.width * 1.8,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('新增筆記',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10.0),
                      TextField(
                        onChanged: (value) {
                          moodtext = value;
                        },
                        decoration: const InputDecoration(
                          //  border: OutlineInputBorder(),
                          labelText: '心情定義',
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        onChanged: (value) {
                          q1 = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: '1. 我很感恩...'),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        onChanged: (value) {
                          q2 = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: '2. 我要讓這一天變得很棒的方法'),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        onChanged: (value) {
                          q3 = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: '3. 我今天做的好事'),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        onChanged: (value) {
                          noteText = value;
                        },
                        maxLines: 10,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '寫點什麼吧...',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            child: const Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('儲存'),
                            onPressed: () {
                              setState(() {
                                notes.add(Note(
                                  note: noteText,
                                  moodnote: moodtext,
                                  mood: selectedMood,
                                  question1: q1,
                                  question2: q2,
                                  question3: q3,
                                ));
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class Note {
  String note;
  String mood;
  String moodnote;
  String question1;
  String question2;
  String question3;
  Note(
      {required this.note,
      required this.moodnote,
      required this.mood,
      required this.question1,
      required this.question2,
      required this.question3});
}

class NoteDetailsScreen extends StatelessWidget {
  final Note note;

  const NoteDetailsScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Image.asset(
                            _getImagePath(note.mood),
                            width: 100.0,
                            height: 100.0,
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            '心情狀態',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            note.moodnote,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            '1. 我很感恩...',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            note.question1,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            '2. 我要讓這一天變得很棒的方法',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            note.question2,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            '3. 我今天做的好事',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            note.question3,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            '補充',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            note.note,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _editNote(context, note);
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _editNote(BuildContext context, Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteScreen(note: note),
      ),
    );
  }

  String _getImagePath(String mood) {
    switch (mood) {
      case 'Happy':
        return 'assets/calender_page/1-Happy.png';
      case 'Sad':
        return 'assets/calender_page/2-Sad.png';
      case 'Angry':
        return 'assets/calender_page/3-Angry.png';
      case 'Upset':
        return 'assets/calender_page/4-Upset.png';
      case 'Nothing':
        return 'assets/calender_page/5-Nothing.png';
      default:
        return '';
    }
  }
}

class EditNoteScreen extends StatefulWidget {
  final Note note;

  const EditNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController _moodNoteController = TextEditingController();
  TextEditingController _question1Controller = TextEditingController();
  TextEditingController _question2Controller = TextEditingController();
  TextEditingController _question3Controller = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _moodNoteController.text = widget.note.moodnote;
    _question1Controller.text = widget.note.question1;
    _question2Controller.text = widget.note.question2;
    _question3Controller.text = widget.note.question3;
    _noteController.text = widget.note.note;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: _moodNoteController,
            decoration: InputDecoration(labelText: '心情狀態'),
          ),
          TextField(
            controller: _question1Controller,
            decoration: InputDecoration(labelText: '1. 我很感恩...'),
          ),
          TextField(
            controller: _question2Controller,
            decoration: InputDecoration(labelText: '2. 我要讓這一天變得很棒的方法'),
          ),
          TextField(
            controller: _question3Controller,
            decoration: InputDecoration(labelText: '3. 我今天做的好事'),
          ),
          TextField(
            controller: _noteController,
            maxLines: null,
            decoration: InputDecoration(labelText: '補充'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveChanges();
        },
        child: Icon(Icons.save),
      ),
    );
  }

  void _saveChanges() {
    String updatedMoodNote = _moodNoteController.text;
    String updatedQuestion1 = _question1Controller.text;
    String updatedQuestion2 = _question2Controller.text;
    String updatedQuestion3 = _question3Controller.text;
    String updatedNote = _noteController.text;

    // Perform the save operation or update the note in your data source here
    // For simplicity, let's just print a log message for now
    //print('已更新貼文：${widget.note.id}');
    print('已更新心情狀態：$updatedMoodNote');
    widget.note.moodnote = updatedMoodNote;
    print('已更新問題 1：//$updatedQuestion1');
    widget.note.question1 = updatedQuestion1;
    print('已更新問題 2：$updatedQuestion2');
    widget.note.question2 = updatedQuestion2;
    print('已更新問題 3：$updatedQuestion3');
    widget.note.question3 = updatedQuestion3;
    print('已更新補充：$updatedNote');
    widget.note.note = updatedNote;
    Navigator.pop(context); // 返回前一個畫面以儲存變更
  }

  @override
  void dispose() {
    _moodNoteController.dispose();
    _question1Controller.dispose();
    _question2Controller.dispose();
    _question3Controller.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
