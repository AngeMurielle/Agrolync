import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final Map<String, dynamic>? order;
  final String? farmerName;
  final String? farmerPhone;
  final bool isBuyer;

  const ChatPage({
    super.key,
    this.order,
    this.farmerName,
    this.farmerPhone,
    this.isBuyer = false,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late final List<Map<String, dynamic>> _messages;

  final Color brandGreen = const Color(0xFF026139);

  @override
  void initState() {
    super.initState();
    _messages = [
      {
        'text':
            'Hello! I\'m interested in your product. Is it still available?',
        'isMe': widget.isBuyer,
        'time': '10:30 AM',
        'sender': widget.isBuyer ? 'buyer' : 'farmer',
      },
      {
        'text':
            'Hi! Yes, the product is still available. What quantity are you looking for?',
        'isMe': !widget.isBuyer,
        'time': '10:32 AM',
        'sender': widget.isBuyer ? 'farmer' : 'buyer',
      },
      {
        'text': 'I need some quantity. Can you deliver to my location?',
        'isMe': widget.isBuyer,
        'time': '10:35 AM',
        'sender': widget.isBuyer ? 'buyer' : 'farmer',
      },
      {
        'text':
            'Absolutely! Delivery is available. Let me check the delivery schedule.',
        'isMe': !widget.isBuyer,
        'time': '10:37 AM',
        'sender': widget.isBuyer ? 'farmer' : 'buyer',
      },
    ];
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text.trim(),
        'isMe': true,
        'time': TimeOfDay.now().format(context),
        'sender': widget.isBuyer ? 'buyer' : 'farmer',
      });
    });

    _messageController.clear();

    // Simulate response after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'text': widget.isBuyer
                ? 'Thank you for the quick response! I\'ll confirm the order soon.'
                : 'Thank you for your interest! Let me know if you have any questions.',
            'isMe': false,
            'time': TimeOfDay.now().format(context),
            'sender': widget.isBuyer ? 'farmer' : 'buyer',
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: brandGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFE8F3EE),
              child: Icon(Icons.person, color: Color(0xFF026139)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isBuyer
                        ? (widget.farmerName ?? 'Farmer')
                        : (widget.order?['buyer'] ?? 'Buyer'),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.isBuyer
                        ? 'Product Inquiry'
                        : 'Order ${widget.order?['id'] ?? ''}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Call the other party
              final phoneNumber =
                  widget.isBuyer ? widget.farmerPhone : '+237 692 018 826';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Calling ${phoneNumber ?? 'contact'}...")),
              );
            },
            icon: const Icon(Icons.phone, color: Color(0xFF026139)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Order Summary or Product Inquiry
          if (!widget.isBuyer && widget.order != null)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.order!['image'] ?? 'assets/images/maize.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.order!['item'] ?? 'Product',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Order ${widget.order!['id']}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F3EE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        color: Color(0xFF026139),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F3),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF026139),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isMe = message['isMe'] as bool;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? brandGreen : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft:
                isMe ? const Radius.circular(16) : const Radius.circular(4),
            bottomRight:
                isMe ? const Radius.circular(4) : const Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['text'],
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message['time'],
              style: TextStyle(
                color:
                    isMe ? Colors.white.withOpacity(0.7) : Colors.grey.shade500,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
