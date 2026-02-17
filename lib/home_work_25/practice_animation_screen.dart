import 'package:flutter/material.dart';

class PracticeAnimationScreen extends StatefulWidget {
  const PracticeAnimationScreen({super.key});

  @override
  State<PracticeAnimationScreen> createState() =>
      _PracticeAnimationScreenState();
}

class _PracticeAnimationScreenState extends State<PracticeAnimationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<Offset> _offset;

  bool _simulateLoading = false;
  bool _simulateError = false;
  bool _emptyList = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _scale = Tween<double>(begin: 0.90, end: 1.15).animate(curved);
    _offset = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0.18, -0.10),
    ).animate(curved);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _start() => _controller.forward();
  void _reverse() => _controller.reverse();
  void _stop() => _controller.stop();

  @override
  Widget build(BuildContext context) {
    final longText = 'Очень длинный текст для проверки переноса/обрезки. ' * 6;

    return Scaffold(
      appBar: AppBar(title: const Text('Practice: Offset + Scale')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: _CardContent(longText: longText),
              builder: (context, child) {
                // dx/dy тут в "долях". Переводим в пиксели.
                final px = Offset(
                  _offset.value.dx * 300,
                  _offset.value.dy * 300,
                );

                return Transform.translate(
                  offset: px,
                  child: Transform.scale(scale: _scale.value, child: child),
                );
              },
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(onPressed: _start, child: const Text('start')),
                ElevatedButton(onPressed: _stop, child: const Text('stop')),
                ElevatedButton(
                  onPressed: _reverse,
                  child: const Text('reverse'),
                ),
                OutlinedButton(
                  onPressed: () => _controller.forward(from: 0),
                  child: const Text('restart'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                FilterChip(
                  label: const Text('loading'),
                  selected: _simulateLoading,
                  onSelected: (v) => setState(() => _simulateLoading = v),
                ),
                FilterChip(
                  label: const Text('error'),
                  selected: _simulateError,
                  onSelected: (v) => setState(() => _simulateError = v),
                ),
                FilterChip(
                  label: const Text('empty list'),
                  selected: _emptyList,
                  onSelected: (v) => setState(() => _emptyList = v),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _simulateLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _simulateError
                  ? Center(
                      child: Text(
                        'Ошибка загрузки данных. Попробуйте ещё раз.',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : _emptyList
                  ? Center(
                      child: Text(
                        'Список пуст.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  : ListView.builder(
                      itemCount: 20,
                      itemBuilder: (ctx, i) {
                        return ListTile(
                          leading: CircleAvatar(child: Text('${i + 1}')),
                          title: Text('Item ${i + 1}'),
                          subtitle: Text(
                            i % 3 == 0 ? longText : 'Short subtitle',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({required this.longText});

  final String longText;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            const Icon(Icons.extension, size: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                longText,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
