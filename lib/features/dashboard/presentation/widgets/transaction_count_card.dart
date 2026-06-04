import 'package:flutter/material.dart';

class TransactionCountCard extends StatelessWidget {
  final int count;

  const TransactionCountCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.receipt),
        title: const Text('Transactions'),
        trailing: Text(
          '$count',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
