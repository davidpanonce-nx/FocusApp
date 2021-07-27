import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';

import 'package:focus_app/Services/authentication_service.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function? toggleScreen;
  const Login({Key? key, this.toggleScreen}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  void _togglePassword() {
    _obscureText = !_obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final loginProvider = Provider.of<AuthServices>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: Scaffold(
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
                  margin: EdgeInsets.fromLTRB(15, 50, 15, 45),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                color: secondaryVariant,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(
                          height: size.height / 70,
                        ),
                        TextFormField(
                          cursorColor: secondaryVariant,
                          controller: _emailController,
                          validator: (val) =>
                              val!.isNotEmpty ? null : "Please enter an email",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                  color: secondaryVariant,
                                  fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: secondaryVariant,
                            ),
                            errorStyle: TextStyle(color: Colors.amberAccent),
                            labelText: "Enter email here",
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
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amberAccent)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amberAccent)),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                        Text(
                          'Password',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                color: secondaryVariant,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(
                          height: size.height / 70,
                        ),
                        TextFormField(
                          obscureText: _obscureText,
                          controller: _passwordController,
                          validator: (val) => val!.isNotEmpty
                              ? null
                              : "Please enter a password",
                          cursorColor: secondaryVariant,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                  color: secondaryVariant,
                                  fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: secondaryVariant,
                            ),
                            errorStyle: TextStyle(color: Colors.amberAccent),
                            labelText: "Enter password here",
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
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amberAccent)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amberAccent)),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _togglePassword();
                                });
                              },
                              icon: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: secondaryVariant,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await loginProvider.login(
                                _emailController!.text.trim(),
                                _passwordController!.text.trim(),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              primary: buttonColor,
                              minimumSize: Size(size.width, 0)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: loginProvider.isLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    'Login',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText2!
                                        .copyWith(color: primary),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ?',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: secondaryVariant,
                                  ),
                            ),
                            TextButton(
                              onPressed: () => widget.toggleScreen!(),
                              child: Text(
                                'Register',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.amberAccent),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                        if (loginProvider.errorMessage != '')
                          Container(
                            color: Colors.amberAccent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: ListTile(
                              title: Text(loginProvider.errorMessage),
                              leading: Icon(Icons.error),
                              trailing: IconButton(
                                onPressed: () => loginProvider.setMessage(''),
                                icon: Icon(Icons.close),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
