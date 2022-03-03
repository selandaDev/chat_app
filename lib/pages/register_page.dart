import 'package:flutter/material.dart';
import 'package:realtime_chat/widgets/boton_azul.dart';
import 'package:realtime_chat/widgets/labels.dart';

import '../widgets/custom_input.dart';
import '../widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Logo(
                    texto: 'Registro',
                  ),
                  _Form(),
                  Labels(
                    ruta: 'login',
                    texto1: 'Ya tienes cuenta?',
                    texto2: 'Inicia sesión',
                  ),
                  Text('Térmnos y condiciones de uso.',
                      style: TextStyle(fontWeight: FontWeight.w200))
                ],
              ),
            ),
          ),
        ));
  }
}

// WIDGETS

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          Custominput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.emailAddress,
            textController: nameCtrl,
          ),
          Custominput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          Custominput(
            icon: Icons.password_outlined,
            placeholder: 'password',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
            text: 'Login',
            onPressed: () {
              return;
            },
          )
        ],
      ),
    );
  }
}
