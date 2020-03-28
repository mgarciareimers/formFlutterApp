import 'package:flutter/material.dart';

import 'package:formflutterapp/src/blocs/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          this._createBackground(context),
          this._createLoginForm(context),
        ],
      ),
    );
  }

  // Method that creates the top background.
  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final background = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 178, 1),
          ],
        )
      ),
    );

    final circle = Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    return Stack(
      children: <Widget>[
        background,
        Positioned(child: circle, top: 90, left: 30),
        Positioned(child: circle, top: -40, right: -30),
        Positioned(child: circle, bottom: -50, right: -10),
        Positioned(child: circle, bottom: -50, left: -20),
        Positioned(child: circle, bottom: 120, right: 20),
        Container(
          padding: EdgeInsets.only(top: size.height * 0.08),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle,color: Colors.white, size: 90),
              SizedBox(height: 10, width: double.infinity),
              Text('Name Surname', style: TextStyle(color: Colors.white, fontSize: 22)),
            ],
          ),
        )
      ],
    );
  }

  // Method that creates the login form.
  Widget _createLoginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(height: size.height * 0.23)),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: <BoxShadow> [
                  BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 2), spreadRadius: 2),
                ],
            ),
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: <Widget>[
                Text('Enter Data', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                this._createEmail(bloc),
                SizedBox(height: 20),
                this._createPassword(bloc),
                SizedBox(height: 20),
                this._createLoginButton(bloc),
              ],
            ),
          ),
          Text('Forgot Password?'),
          SizedBox(height: 80),
        ],
      ),
    );
  }

  // Method that creates the email widget.
  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                hintText: 'email@email.com',
                labelText: 'Email',
                counterText: snapshot.data,
                errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  // Method that creates the password widget.
  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Password',
                counterText: snapshot.data,
                errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changePassword(value),
          ),
        );
      },
    );
  }

  // Method that creates the login button.
  Widget _createLoginButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formIsValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: Text('Login'),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          elevation: 0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          disabledTextColor: Colors.white,
          onPressed: !snapshot.hasData ? null : () => this._login(context, bloc),
        );
      },
    );
  }

  _login(BuildContext context, LoginBloc bloc) {
    Navigator.pushReplacementNamed(context, 'home');
  }
}