import 'package:bloc_test/bloc_test.dart';
import 'package:client/application/pages/groups/bloc/group_bloc.dart';
import 'package:client/application/pages/groups/group_form_widget.dart';
import 'package:client/data/models/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGroupBloc extends MockBloc<GroupEvent, GroupState>
    implements GroupBloc {}

void main() {
  group('CreateGroupForm', () {
    late MockGroupBloc mockGroupBloc;

    setUp(() {
      mockGroupBloc = MockGroupBloc();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Scaffold(
          body: BlocProvider<GroupBloc>.value(
            value: mockGroupBloc,
            child: const CreateGroupForm(),
          ),
        ),
      );
    }

    testWidgets('renders form fields and button', (WidgetTester tester) async {
      when(() => mockGroupBloc.state).thenReturn(GroupInitial());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows validation error when form is empty',
        (WidgetTester tester) async {
      when(() => mockGroupBloc.state).thenReturn(GroupInitial());

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Please enter the group name'), findsOneWidget);
    });

    testWidgets('submits the form when valid', (WidgetTester tester) async {
      when(() => mockGroupBloc.state).thenReturn(GroupInitial());

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextFormField), 'group 1');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(() =>
              mockGroupBloc.add(AddGroup(GroupModel(id: 0, name: 'group 1'))))
          .called(1);

      expect(find.text('group 1'), findsNothing);
    });
  });
}
