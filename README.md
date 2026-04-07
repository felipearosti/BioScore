# BioScore

BioScore e um aplicativo desenvolvido para o contexto de HealthTech, com foco na gestao de emagrecimento e no acompanhamento estruturado do usuario ao longo da jornada de saude.

## Visao do Projeto

O projeto foi concebido para oferecer uma base digital consistente para processos de autenticacao, evoluindo para modulos de acompanhamento clinico, metas e indicadores de progresso.

Nesta etapa, a aplicacao contempla as telas iniciais de acesso e cadastro, com validacoes essenciais de dados e feedback visual orientado a usabilidade.

## Objetivos

- Estruturar uma base confiavel para autenticacao de usuarios.
- Garantir experiencia de uso clara, objetiva e responsiva.
- Estabelecer padrao visual coeso para a evolucao das proximas funcionalidades.

## Escopo Implementado

- Tema global com Material 3 e tipografia padronizada.
- Tela de Login com validacao de campos e autenticacao local.
- Tela de Cadastro de Usuario com validacoes de formulario.
- Mascara de telefone no padrao nacional: (99) 99999-9999.
- Feedback visual por SnackBar para sucesso e tratamento de erros.
- Navegacao entre telas de login e cadastro.

## Identidade Visual

- Cor primaria: #1A365D (Azul Petroleo)
- Cor de destaque: #2A9D8F (Verde Esmeralda)
- Cor de fundo: #F8F9FA (Off-White)
- Tipografia: Poppins

## Arquitetura Inicial

- [lib/main.dart](lib/main.dart): configuracao do aplicativo e tema.
- [lib/login_screen.dart](lib/login_screen.dart): fluxo de autenticacao.
- [lib/register_screen.dart](lib/register_screen.dart): fluxo de cadastro.
- [lib/auth_store.dart](lib/auth_store.dart): persistencia local em memoria para o estado atual do projeto.

## Requisitos Funcionais Atendidos

- RF001: configuracao de tema e tela de login.
- RF002: cadastro de usuario com validacoes obrigatorias.
- RF006: feedback ao usuario por caixa de dialogo visual (SnackBar).

## Proximos Passos

- Integracao com backend para autenticacao e persistencia real.
- Implementacao de recuperacao de senha.
- Evolucao para dashboard com indicadores de progresso.
- Estruturacao da camada de estado para crescimento do produto.

## Execucao do Projeto

```bash
flutter pub get
flutter run -d chrome
```
