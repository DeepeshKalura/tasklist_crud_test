import 'package:flutter/material.dart';

class ContainerUseWidget extends StatelessWidget {
  const ContainerUseWidget({
    super.key,
    required this.title,
    required this.priority,
    required this.date,
    this.isCompleted = false,
  });

  final String title;
  final bool isCompleted;
  final String priority;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0, top: 8),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            '$priority Priority',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Icon(
                Icons.dashboard,
                size: 16.0,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4.0),
              Text(
                'task',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 4.0),
              if (isCompleted)
                Text(
                  'Completed',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                )
              else
                Text(
                  'Not Completed',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              const SizedBox(width: 4.0),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            date,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
