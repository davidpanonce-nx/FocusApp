import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';

class RegisterCredentials extends StatefulWidget {
  const RegisterCredentials({Key? key}) : super(key: key);

  @override
  _RegisterCredentialsState createState() => _RegisterCredentialsState();
}

class _RegisterCredentialsState extends State<RegisterCredentials> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  //toggles password obscure
  void _togglePassword1() {
    _obscureText1 = !_obscureText1;
  }

  void _togglePassword2() {
    _obscureText2 = !_obscureText2;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: primary),
          ),
          Image.asset(
            'assets/stack-2.png',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 30, 15, 45),
              // decoration: BoxDecoration(color: Colors.grey),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/pink-button.png',
                        height: size.height / 20, fit: BoxFit.contain),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Center(
                    child: Text(
                      'Register',
                      style: Theme.of(context).primaryTextTheme.headline1,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Text(
                    'What do you want to be known as?',
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Text(
                    'Username',
                    style:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: secondaryVariant,
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  SizedBox(
                    height: size.height / 70,
                  ),
                  Form(
                    child: TextFormField(
                      cursorColor: secondaryVariant,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .copyWith(
                              color: secondaryVariant,
                              fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                        labelText: "Enter username here",
                        labelStyle: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(
                                color: greenVariant,
                                fontWeight: FontWeight.w300),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryVariant),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Text(
                    'Password',
                    style:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: secondaryVariant,
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  SizedBox(
                    height: size.height / 70,
                  ),
                  TextFormField(
                    obscureText: _obscureText1,
                    cursorColor: secondaryVariant,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2!
                        .copyWith(
                            color: secondaryVariant,
                            fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                      labelText: "Enter password here",
                      labelStyle: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .copyWith(
                              color: greenVariant, fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _togglePassword1();
                          });
                        },
                        icon: Icon(
                          _obscureText1
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        color: secondaryVariant,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Text(
                    'Re-enter Password',
                    style:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: secondaryVariant,
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  SizedBox(
                    height: size.height / 70,
                  ),
                  TextFormField(
                    obscureText: _obscureText2,
                    cursorColor: secondaryVariant,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2!
                        .copyWith(
                            color: secondaryVariant,
                            fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                      labelText: "Re-enter password here",
                      labelStyle: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .copyWith(
                              color: greenVariant, fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _togglePassword2();
                          });
                        },
                        icon: Icon(
                          _obscureText2
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        color: secondaryVariant,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.pushNamed(context, '/registerEmail'),
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: buttonColor,
                          minimumSize: Size(size.width, 0)),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Submit',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(color: primary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
