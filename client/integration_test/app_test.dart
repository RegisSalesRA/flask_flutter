import 'package:client/application/pages/users/create_users_or_grup_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:client/main.dart'; // Importa seu arquivo principal
import 'package:flutter/material.dart';

void main() {
  testWidgets("Test de integração da UserPage", (WidgetTester tester) async {
    // Inicia o app
    await tester.pumpWidget(const MyApp());

    // Aguarda a renderização completa
    await tester.pumpAndSettle();

    // Verifica se o botão com o ícone de adicionar está presente
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Interage com o botão "Adicionar Usuário"
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Aqui você pode adicionar verificações adicionais para o comportamento após o clique
    // Por exemplo: verificar se a página de criação de usuário/grupo foi aberta
    expect(find.byType(CreateUserOrGroupPage), findsOneWidget);
  });
}
