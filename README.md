# BioScore

Aplicativo Flutter para HealthTech focado em gestao de emagrecimento, com fluxo inicial de autenticacao (login e cadastro) e base visual padronizada.

## Tecnologias

- Flutter (Material 3)
- Dart
- Google Fonts (Poppins)

## Identidade Visual

- Cor primaria: `#1A365D` (Azul Petroleo)
- Cor de destaque: `#2A9D8F` (Verde Esmeralda)
- Cor de fundo: `#F8F9FA` (Off-White)

## Funcionalidades Atuais

- Tema global do aplicativo com Material Design
- Tela de login com validacoes e feedback visual via SnackBar
- Tela de cadastro com validacoes completas e mascara de telefone `(99) 99999-9999`
- Navegacao entre login e cadastro
- Validacao local de credenciais em memoria para fluxo de demonstracao

## Estrutura Principal

- `lib/main.dart`: configuracao global do app e tema
- `lib/login_screen.dart`: tela e regras de login
- `lib/register_screen.dart`: tela e regras de cadastro
- `lib/auth_store.dart`: armazenamento local em memoria para autenticacao

## Como Rodar

1. Instale dependencias:

	```bash
	flutter pub get
	```

2. Execute no navegador:

	```bash
	flutter run -d chrome
	```

3. Comandos uteis durante execucao:

- `r` para hot reload
- `R` para hot restart
- `q` para encerrar

## Qualidade e Validacao

Antes de qualquer commit, rode:

```bash
flutter analyze
flutter test
```

## Fluxo de Commit Validado

Padrao recomendado para este repositorio:

1. Crie branch de feature:

	```bash
	git checkout -b feat/nome-curto-da-feature
	```

2. Implemente e valide localmente com `flutter analyze` e `flutter test`.

3. Use Conventional Commits:

- `feat: adiciona cadastro de usuario`
- `fix: corrige validacao de login`
- `refactor: organiza viewmodel de autenticacao`

4. Abra Pull Request para `main`.

## Roadmap

- [x] RF001 - Tema base e tela de login
- [x] RF002 - Cadastro de usuario
- [x] RF006 - Feedback visual por SnackBar
- [ ] Persistencia real de usuario (backend/banco)
- [ ] Recuperacao de senha
- [ ] Dashboard inicial com metricas de progresso
- [ ] Arquitetura completa com Provider/Riverpod
- [ ] Testes de widget e integracao para autenticacao
