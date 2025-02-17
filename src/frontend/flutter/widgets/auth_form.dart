import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLogin = true;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (_isLogin) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email,
            password: _password,
          );
        } else {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email,
            password: _password,
          );
        }
      } on FirebaseAuthException catch (e) {
        print(e.message);
        // エラーハンドリング
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              key: ValueKey('email'),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'メールアドレス'),
              validator: (value) {
                if (value == null || !value.contains('@')) {
                  return '有効なメールアドレスを入力してください';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
            TextFormField(
              key: ValueKey('password'),
              obscureText: true,
              decoration: InputDecoration(labelText: 'パスワード'),
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'パスワードは6文字以上で入力してください';
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(_isLogin ? 'ログイン' : '新規登録'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin ? 'アカウントを作成' : 'ログイン'),
            ),
          ],
        ),
      ),
    );
  }
};