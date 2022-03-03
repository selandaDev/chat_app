import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtime_chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Melisa Flores',
              style: TextStyle(color: Colors.black87, fontSize: 12),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            )),
            Divider(height: 1),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  //Metodos
  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              focusNode: _focusNode,
              decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
              onSubmitted: _handleSubmit,
              onChanged: (String texto) {
                setState(() {
                  if (texto.trim().length > 0) {
                    _estaEscribiendo = true;
                  } else {
                    _estaEscribiendo = false;
                  }
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: Platform.isIOS
                //Boton IOS
                ? CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                  )
                //Boton Android
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.send,
                        ),
                        onPressed: _estaEscribiendo
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  //Funciones
  _handleSubmit(String texto) {
    if (texto.length == 0) {
      return;
    }

    _focusNode.requestFocus();
    _textController.clear();

    final newMessage = ChatMessage(
      texto: texto,
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
      ),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: off del socket

    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }
}
