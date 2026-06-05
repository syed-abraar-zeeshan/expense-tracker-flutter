import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String name;

  const DashboardHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: AppColors.avatarBackground,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person,
            color: AppColors.primary,
            size: 30,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $name 👋',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Good Morning',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_rounded,
            size: 28,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
