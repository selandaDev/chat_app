import 'package:flutter/material.dart';
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
            physics: BouncingScrollPhysics(),
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

// WIDGETS

// class _Logo extends StatelessWidget {
//   const _Logo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: 170,
//         margin: EdgeInsets.only(top: 50),
//         child: Column(
//           children: const [
//             Image(image: AssetImage('assets/tag-logo.png')),
//             SizedBox(height: 20),
//             Text('Messenger', style: TextStyle(fontSize: 30))
//           ],
//         ),
//       ),
//     );
//   }
// }

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
            onPressed: () {
              print(emailCtrl.text);
              return;
            },
          )
        ],
      ),
    );
  }
}

// class _Labels extends StatelessWidget {
//   const _Labels({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           const Text(
//             '¿No tienes cuenta?',
//             style: TextStyle(
//                 color: Colors.black54,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w300),
//           ),
//           const SizedBox(height: 10),
//           Text('Crea una ahora!',
//               style: TextStyle(
//                   color: Colors.blue[600],
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold))
//         ],
//       ),
//     );
//   }
// }
