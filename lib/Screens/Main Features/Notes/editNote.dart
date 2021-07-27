import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Screens/Main%20Features/Notes/notes.dart';
import 'package:focus_app/Screens/introductory/note.dart';
import 'package:focus_app/Services/database_service.dart';

class EditNote extends StatefulWidget {
  final DocumentSnapshot? noteToEdit;
  const EditNote({Key? key, this.noteToEdit}) : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController? _titleController;

  TextEditingController? _contentController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleController = TextEditingController(
        text: widget.noteToEdit!.get(FieldPath(['title'])));
    _contentController = TextEditingController(
        text: widget.noteToEdit!.get(FieldPath(['content'])));
    super.initState();
  }

  @override
  void dispose() {
    _titleController!.dispose();
    _contentController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;

    Color getColor(Set<MaterialState> states) {
      return Colors.redAccent;
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 45),
              width: size.width,
              height: size.height,
              color: secondaryVariant,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Notes()));
                        },
                        icon: Image.asset(
                          'assets/Blue-button.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith(getColor)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            widget.noteToEdit!.reference.delete().whenComplete(
                                () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Notes())));
                          }
                        },
                        child: Text('Delete'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            widget.noteToEdit!.reference.update({
                              'title': _titleController!.text.trim(),
                              'content': _contentController!.text.trim(),
                            }).whenComplete(() => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Notes())));
                          }
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                        controller: _titleController,
                        validator: (val) =>
                            val!.isEmpty ? "Title should not be empty" : null,
                        autofocus: true,
                        maxLength: 25,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffBEACB3).withOpacity(0.5),
                          hintText: 'Title',
                          hintStyle: Theme.of(context)
                              .primaryTextTheme
                              .headline1!
                              .copyWith(
                                color: primary,
                              ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline1!
                            .copyWith(
                              color: primary,
                            )),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(color: secondary),
                      child: TextFormField(
                        controller: _contentController,
                        validator: (val) => val!.isEmpty
                            ? "This field should not be blank"
                            : null,
                        autofocus: true,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Notes here',
                          hintStyle: Theme.of(context)
                              .primaryTextTheme
                              .headline1!
                              .copyWith(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline1!
                            .copyWith(
                              color: primary,
                              fontSize: 20,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
