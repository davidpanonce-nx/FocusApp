import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Models/models.dart';
import 'package:focus_app/Screens/Main%20Features/Notes/addNote.dart';
import 'package:focus_app/Screens/Main%20Features/Notes/editNote.dart';
import 'package:focus_app/Screens/mainDashboard.dart';
import 'package:focus_app/Services/database_service.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AddNote()));
          },
          child: Icon(
            Icons.add,
            color: primary,
            size: 40,
          ),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(color: primary),
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 15, 45),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    },
                    icon: Image.asset(
                      'assets/pink-button.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Your Focus Notes',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline1!
                      .copyWith(color: secondary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: DatabaseService(uid: user!.uid).notesQuery,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: snapshot.hasData
                                ? snapshot.data!.docs.length
                                : 0,
                            itemBuilder: (_, index) {
                              return snapshot.hasData
                                  ? Container(
                                      margin: EdgeInsets.all(7),
                                      child: Card(
                                        color: secondaryVariant,
                                        elevation: 2,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditNote(
                                                  noteToEdit: snapshot
                                                      .data!.docs[index],
                                                ),
                                              ),
                                            );
                                          },
                                          splashColor: greenVariant,
                                          child: Container(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      .get(FieldPath(['title']))
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .headline1!
                                                      .copyWith(
                                                          color: primary,
                                                          fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      .get(FieldPath(
                                                          ['content']))
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                        color: Colors.black
                                                            .withOpacity(0.50),
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : CircularProgressIndicator(
                                      color: primary,
                                    );
                            });
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
