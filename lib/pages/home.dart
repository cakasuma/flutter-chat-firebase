import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

import '../shared/constants.dart';

const String _name = "amam";

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  _handleSubmitted(String value) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    ChatMessage message = ChatMessage(
      text: value,
      animationController: AnimationController(
          duration: Duration(milliseconds: 300), vsync: this),
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  decoration:
                      InputDecoration.collapsed(hintText: 'Send message'),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.android ?
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null,
                ) :
                CupertinoButton(
                  child: Text('Send'),
                  onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null,
                )
              )
            ],
          )),
    );
  }

  void _logoutClick(String choice) {
    if(choice == Constants.Logout) {
      Navigator.of(context).pushNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _logoutClick,
            itemBuilder: (BuildContext context) {
              return Constants.menus.map((String menu) {
                return PopupMenuItem<String>(
                  value: menu,
                  child: Text(menu),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer(),
            )
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.android ? null : 
        BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[200]))
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final AnimationController animationController;
  ChatMessage({this.text, this.animationController});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 16.0),
                child: CircleAvatar(child: Text(_name[0])),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _name,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(text),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
