import 'package:flutter/material.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello! How can I assist you today?',
      'isAgent': true,
      'timestamp': '10:30 AM',
    },
    {
      'text': 'Hi, I have a question about my recent booking.',
      'isAgent': false,
      'timestamp': '10:31 AM',
    },
    {
      'text':
          'Sure. I can help with that. Could you please provide your booking reference number?',
      'isAgent': true,
      'timestamp': '10:32 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2C3E50)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            const Text(
              'Support Agent',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Online',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7F8C8D),
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF2C3E50)),
            onPressed: () {
              // TODO: Show more options
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('More options coming soon'),
                  backgroundColor: Color(0xFF20B2AA),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Message Input Field
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isAgent = message['isAgent'] as bool;
    final text = message['text'] as String;
    final timestamp = message['timestamp'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isAgent
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAgent) ...[
            // Agent Avatar
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFF666666),
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
          ],

          // Message Bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isAgent
                    ? const Color(0xFFF5F5F5)
                    : const Color(0xFFFF6B35),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isAgent ? const Color(0xFF2C3E50) : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timestamp,
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: isAgent ? const Color(0xFF7F8C8D) : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (!isAgent) ...[
            const SizedBox(width: 8),
            // User Avatar
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFF666666),
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: Row(
        children: [
          // Emoji Button
          IconButton(
            onPressed: () {
              // TODO: Show emoji picker
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Emoji picker coming soon'),
                  backgroundColor: Color(0xFF20B2AA),
                ),
              );
            },
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              color: Color(0xFF2C3E50),
              size: 24,
            ),
          ),

          // Attachment Button
          IconButton(
            onPressed: () {
              // TODO: Show attachment options
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Attachment options coming soon'),
                  backgroundColor: Color(0xFF20B2AA),
                ),
              );
            },
            icon: const Icon(
              Icons.attach_file,
              color: Color(0xFF2C3E50),
              size: 24,
            ),
          ),

          // Message Input Field
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 14,
                    color: Color(0xFF7F8C8D),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 14,
                  color: Color(0xFF2C3E50),
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (value) => _sendMessage(),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send Button
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFFF6B35),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': text,
          'isAgent': false,
          'timestamp': _getCurrentTime(),
        });
        _messageController.clear();
      });

      // Auto-scroll to bottom
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });

      // Simulate agent response after a delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _messages.add({
              'text':
                  'Thank you for your message. I\'ll get back to you shortly.',
              'isAgent': true,
              'timestamp': _getCurrentTime(),
            });
          });

          // Auto-scroll to bottom
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }
      });
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
