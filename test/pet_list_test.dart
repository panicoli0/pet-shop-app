import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pets_shop/presentation/bloc/pet_list_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_event.dart';
import 'package:pets_shop/presentation/bloc/pet_list_state.dart';
import 'package:pets_shop/presentation/pages/pet_list_page.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

class MockPetListBloc extends MockBloc<PetListEvent, PetListState>
    implements PetListBloc {}

void main() {
  group('PetList Widget Tests', () {
    late MockPetListBloc mockBloc;

    setUp(() {
      mockBloc = MockPetListBloc();
    });

    testWidgets('shows loading indicator when loading',
        (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(PetListLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PetListBloc>.value(
            value: mockBloc,
            child: const PetListPage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message when error occurs',
        (WidgetTester tester) async {
      const errorMessage = 'Failed to load pets';
      when(() => mockBloc.state).thenReturn(PetListError(errorMessage));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PetListBloc>.value(
            value: mockBloc,
            child: const PetListPage(),
          ),
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('shows list of pets when loaded', (WidgetTester tester) async {
      final pets = [
        PetEntity(
          id: 1,
          name: 'Buddy',
          breed: 'Golden Retriever',
          age: 3,
          imageUrl: 'resources/images/buddy2.jpeg',
        ),
      ];

      when(() => mockBloc.state).thenReturn(PetListLoaded(pets));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<PetListBloc>.value(
              value: mockBloc,
              child: const PetListPage(),
            ),
          ),
        ),
      );

      expect(find.text('Buddy'), findsOneWidget);
      expect(find.text('Golden Retriever'), findsOneWidget);
    });
  });
}
