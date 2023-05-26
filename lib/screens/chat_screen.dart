import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<AnimationController> _animationControllers = [];
  List<String> _messages = [];

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.add(text);
      AnimationController animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      );
      _animationControllers.add(animationController);
      animationController.forward();
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 80,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                String message = _messages[index];
                bool isMe = index % 2 == 0;

                // 添加一个动画，将消息从屏幕左侧（对方消息）或右侧（我的消息）滑入。
                final offsetAnimation = Tween<Offset>(
                  begin: isMe ? Offset(1.0, 0.0) : Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _animationControllers[index],
                  curve: Curves.easeOut,
                ));

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isMe) Icon(Icons.account_circle, size: 40, color: Colors.grey),
                      SizedBox(width: 10),
                      Flexible(
                        child: SlideTransition(
                          position: offsetAnimation,
                          child: ScaleTransition(
                            scale: CurvedAnimation(
                              parent: _animationControllers[index],
                              curve: Curves.easeOut,
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.75,
                              ),
                              decoration: BoxDecoration(
                                color: isMe ? Colors.blue : Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Text(
                                message,
                                style: TextStyle(color: Colors.white, fontSize: 16),
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      if (isMe) Icon(Icons.account_circle, size: 40, color: Colors.blue),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(width: 2, color: Colors.blue),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    _handleSubmitted(_textController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}