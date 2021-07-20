import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Services/authentication_service.dart';
import 'package:provider/provider.dart';

class RegisterCredentials extends StatefulWidget {
  const RegisterCredentials({Key? key}) : super(key: key);

  @override
  _RegisterCredentialsState createState() => _RegisterCredentialsState();
}

class _RegisterCredentialsState extends State<RegisterCredentials> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _repassworController;
  TextEditingController? _usernameController;
  TextEditingController? _codeController;

  final _formKey = GlobalKey<FormState>();

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repassworController = TextEditingController();
    _usernameController = TextEditingController();
    _codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    _repassworController!.dispose();
    _usernameController!.dispose();
    _codeController!.dispose();
    super.dispose();
  }

  //toggles password to obscure
  void _togglePassword1() {
    _obscureText1 = !_obscureText1;
  }

  //toggle re-enter password to obscure
  void _togglePassword2() {
    _obscureText2 = !_obscureText2;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginProvider = Provider.of<AuthServices>(context);
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
              child: Form(
                key: _formKey,
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
                      controller: _usernameController,
                      validator: (val) =>
                          val!.isNotEmpty ? null : "Please enter a username",
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
                      controller: _passwordController,
                      validator: (val) => val!.length < 6
                          ? "Enter more than 6 characters"
                          : null,
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
                      controller: _repassworController,
                      validator: (val) => val == _passwordController!.text
                          ? null
                          : "Password doesn't match",
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
                    Text(
                      'Email',
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
                      controller: _emailController,
                      validator: (val) => val!.isNotEmpty
                          ? null
                          : "Please enter an email address",
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
                    SizedBox(
                      height: size.height / 70,
                    ),
                    ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: buttonColor,
                          minimumSize: Size(size.width - 300, 0)),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Send Code',
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
                    Container(
                      width: size.width - 150,
                      child: TextFormField(
                        cursorColor: secondaryVariant,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(
                                color: secondaryVariant,
                                fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          labelText: "Enter code here",
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
                      height: size.height / 70,
                    ),
                    ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: buttonColor,
                          minimumSize: Size(size.width - 300, 0)),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Verify Code',
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
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            print("Email: ${_emailController!.text}");
                            print("Password: ${_passwordController!.text}");
                            print("Username: ${_usernameController!.text}");
                            await loginProvider.register(
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
                                  'Submit',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2!
                                      .copyWith(color: primary),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    if (loginProvider.errorMessage != '')
                      Container(
                        color: Colors.amberAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
    );
  }
}
