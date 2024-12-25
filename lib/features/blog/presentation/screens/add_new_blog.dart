import 'package:flutter/material.dart';

class AddBlogScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (_) => const AddBlogScreen(),
      );
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Blog'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: const Center(
        child: Text('Add Blog '),
      ),
    );
  }
}
