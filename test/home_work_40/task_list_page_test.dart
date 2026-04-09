import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_home_work/home_work_40/screens/task_list_page.dart';

import 'fake_task_list_controller.dart';
import 'test_app.dart';

void main() {
  group('TaskListPage widget tests', () {
    testWidgets('should show empty state', (tester) async {
      final controller = FakeTaskListController(scenario: FakeScenario.empty);

      await tester.pumpWidget(
        makeTestableApp(TaskListPage(controller: controller)),
      );

      await tester.pump();

      expect(find.byKey(const Key('empty_state_text')), findsOneWidget);
      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('should show loading then list items', (tester) async {
      final controller = FakeTaskListController(
        scenario: FakeScenario.loadingThenItems,
      );

      await tester.pumpWidget(
        makeTestableApp(TaskListPage(controller: controller)),
      );

      expect(find.byKey(const Key('loading_indicator')), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 120));

      expect(find.byKey(const Key('task_list')), findsOneWidget);
      expect(find.text('Task A'), findsOneWidget);
      expect(find.text('Task B'), findsOneWidget);
    });

    testWidgets('should add item after entering text and tapping button', (
      tester,
    ) async {
      final controller = FakeTaskListController(scenario: FakeScenario.empty);

      await tester.pumpWidget(
        makeTestableApp(TaskListPage(controller: controller)),
      );

      await tester.pump();

      await tester.enterText(find.byKey(const Key('task_input')), 'New task');

      await tester.tap(find.byKey(const Key('add_task_button')));
      await tester.pump();

      expect(find.text('New task'), findsOneWidget);
      expect(find.byKey(const Key('task_list')), findsOneWidget);
    });

    testWidgets('should show error text and snackbar when load fails', (
      tester,
    ) async {
      final controller = FakeTaskListController(scenario: FakeScenario.error);

      await tester.pumpWidget(
        makeTestableApp(TaskListPage(controller: controller)),
      );

      await tester.pump();

      expect(find.byKey(const Key('error_text')), findsOneWidget);
      expect(find.text('Failed to load items'), findsWidgets);
    });

    testWidgets('should show snackbar when add fails', (tester) async {
      final controller = FakeTaskListController(scenario: FakeScenario.empty);

      await tester.pumpWidget(
        makeTestableApp(TaskListPage(controller: controller)),
      );

      await tester.pump();

      await tester.enterText(find.byKey(const Key('task_input')), '');

      await tester.tap(find.byKey(const Key('add_task_button')));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Title cannot be empty'), findsOneWidget);
    });

    testWidgets('should navigate to details page when tapping item', (
      tester,
    ) async {
      final controller = FakeTaskListController(scenario: FakeScenario.items);

      await tester.pumpWidget(
        makeTestableApp(TaskListPage(controller: controller)),
      );

      await tester.pump();

      expect(find.text('Task 1'), findsOneWidget);

      await tester.tap(find.byKey(const Key('task_tile_1')));
      await tester.pumpAndSettle();

      expect(find.text('Task Details'), findsOneWidget);
      expect(find.byKey(const Key('details_title')), findsOneWidget);
      expect(find.text('Task 1'), findsWidgets);
    });
  });
}
