import 'package:bloc_test/bloc_test.dart';
import 'package:client/application/pages/users/widgets/user_form_widget.dart';
import 'package:client/domain/entities/group_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:client/application/pages/groups/bloc/group_bloc.dart';
import 'package:client/application/pages/users/bloc/users_bloc.dart';

import 'package:client/data/models/user_model.dart';

class MockGroupBloc extends MockBloc<GroupEvent, GroupState>
    implements GroupBloc {}

class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

void main() {
  group('CreateUserForm', () {
    late MockGroupBloc mockGroupBloc;
    late MockUserBloc mockUserBloc;

    setUp(() {
      mockGroupBloc = MockGroupBloc();
      mockUserBloc = MockUserBloc();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Scaffold(
          body: BlocProvider<GroupBloc>.value(
            value: mockGroupBloc,
            child: BlocProvider<UserBloc>.value(
              value: mockUserBloc,
              child: CreateUserForm(),
            ),
          ),
        ),
      );
    }

    testWidgets('renders form fields and buttons', (WidgetTester tester) async {
      when(() => mockGroupBloc.state).thenReturn(GroupLoaded([
        GroupEntity(id: 1, name: 'Group 1'),
        GroupEntity(id: 2, name: 'Group 2'),
      ]));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);

      expect(find.text('Group'), findsOneWidget);
    });

    testWidgets('fills and submits the form', (WidgetTester tester) async {
      when(() => mockGroupBloc.state).thenReturn(GroupLoaded([
        GroupEntity(id: 1, name: 'Group 1'),
        GroupEntity(id: 2, name: 'Group 2'),
      ]));

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
      await tester.enterText(
          find.byType(TextFormField).at(1), 'john.doe@example.com');

      await tester.tap(find.byType(DropdownButtonFormField<int>));
      await tester.pump();
      await tester.tap(find.text('Group 1').last);
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(() => mockUserBloc.add(PostUser(
            UserModel(
              id: 0,
              firstName: 'John Doe',
              email: 'john.doe@example.com',
              group: {"id": 1},
            ),
          ))).called(1);

      expect(find.text('John Doe'), findsNothing);
      expect(find.text('john.doe@example.com'), findsNothing);
    });
  });
}
