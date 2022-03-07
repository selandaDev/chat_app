import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/helpers/mostrar_alerta.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/widgets/boton_azul.dart';

import '../widgets/custom_input.dart';
import '../widgets/labels.dart';
import '../widgets/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                    texto: 'Messenger',
                  ),
                  _Form(),
                  Labels(
                    ruta: 'register',
                    texto1: 'No tienes cuenta?',
                    texto2: 'Crear cuenta ahora',
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

// Widgets
class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
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
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text);

                    if (loginOk) {
                      // navegar a otra pantalla
                      Navigator.pushReplacementNamed(context, 'usuarios');

                      // ToDo Conectar al socket server
                    } else {
                      mostrarAlerta(context, 'Login incorrecto',
                          'Revise las credenciales');
                    }
                  },
          )
        ],
      ),
    );
  }
}
