import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskEditScreen extends StatefulWidget {
  final Task? task; // если null → создание

  const TaskEditScreen({super.key, this.task});

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  final _service = TaskService();
  final _auth = FirebaseAuth.instance;

  bool _completed = false;
  String _category = 'General';
  bool _loading = false;

  final List<String> _categories = ['General', 'Work', 'Study', 'Personal'];

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description ?? '';
      _completed = widget.task!.completed;
      _category = widget.task!.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final uid = _auth.currentUser!.uid;

    final task = Task(
      id: widget.task?.id ?? '',
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      completed: _completed,
      category: _category,
      userId: uid,
      createdAt: widget.task?.createdAt ?? DateTime.now(),
    );

    if (widget.task == null) {
      await _service.addTask(task);
    } else {
      await _service.updateTask(task);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Task' : 'Add Task')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Title
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Введите название'
                          : null,
                    ),

                    const SizedBox(height: 16),

                    // Description
                    TextFormField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),

                    const SizedBox(height: 16),

                    // Category
                    DropdownButtonFormField<String>(
                      value: _category,
                      items: _categories
                          .map(
                            (c) => DropdownMenuItem(value: c, child: Text(c)),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _category = value!),
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Completed
                    CheckboxListTile(
                      value: _completed,
                      onChanged: (value) =>
                          setState(() => _completed = value ?? false),
                      title: const Text('Completed'),
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: _save,
                      child: Text(isEditing ? 'Update' : 'Create'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
