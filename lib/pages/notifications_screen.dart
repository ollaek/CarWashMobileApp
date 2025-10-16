import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 1,
      'title': 'Your car wash is complete!',
      'message': 'Photos of your clean car are now available in the app.',
      'icon': Icons.directions_car,
      'iconColor': Colors.red,
      'isRead': false,
      'time': '2 minutes ago',
    },
    {
      'id': 2,
      'title': 'The cleaner has started working',
      'message':
          'The cleaner has started working on your car – sit back and relax!',
      'icon': Icons.cleaning_services,
      'iconColor': Colors.orange,
      'isRead': true,
      'time': '15 minutes ago',
    },
    {
      'id': 3,
      'title': 'Flash Deal!',
      'message': 'Get 20% off on Premium Wash for the next 2 hours.',
      'icon': Icons.local_offer,
      'iconColor': Colors.blue,
      'isRead': true,
      'time': '1 hour ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0D4A58)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF0D4A58),
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: const Text(
              'Mark all as read',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFFE04703),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: _notifications.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return _buildNotificationItem(notification, index);
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No notifications yet',
            style: TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We\'ll notify you when something important happens',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification, int index) {
    final isUnread = !notification['isRead'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _markAsRead(notification['id']),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: notification['iconColor'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    notification['icon'],
                    color: notification['iconColor'],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notification['title'],
                              style: TextStyle(
                                fontFamily: 'Mulish',
                                fontWeight: isUnread
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                fontSize: 16,
                                color: const Color(0xFF0D4A58),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            notification['time'],
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification['message'],
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                // Unread indicator
                if (isUnread)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE04703),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _markAsRead(int notificationId) {
    setState(() {
      final index = _notifications.indexWhere((n) => n['id'] == notificationId);
      if (index != -1) {
        _notifications[index]['isRead'] = true;
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
  }
}
