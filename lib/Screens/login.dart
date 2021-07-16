import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/pink-button.png',
                        height: size.height / 20, fit: BoxFit.contain),
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Center(
                    child: Image.asset('assets/Logo.png',
                        width: size.width - 120, fit: BoxFit.contain),
                  ),
                  SizedBox(
                    height: size.height / 15,
                  ),
                  Text(
                    'Email Address',
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
                    cursorColor: secondaryVariant,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2!
                        .copyWith(
                            color: secondaryVariant,
                            fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                      labelText: "Enter email here",
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
                          borderSide: BorderSide(color: Colors.grey)),
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
                    obscureText: true,
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
                        onPressed: () {},
                        icon: Icon(Icons.visibility),
                        color: secondaryVariant,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  ElevatedButton(
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
                        'Login',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(color: primary),
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
