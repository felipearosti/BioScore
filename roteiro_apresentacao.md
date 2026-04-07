# Roteiro de Apresentação - BioScore

Este arquivo foi preparado para ficar aberto durante a gravação e ajudar a localizar rapidamente os trechos do código.

> **Observação do snapshot atual:** o workspace está no último commit restaurado e, neste estado, **não há** `lib/bioimpedance_screen.dart` dentro de `lib`. As demais rubricas abaixo apontam para os arquivos presentes no projeto atual.

## RF001, RF002 e RF003 - Autenticação

| Rubrica | Arquivo / linhas | O que mostrar |
|---|---|---|
| Login - validação de e-mail | [lib/login_screen.dart](lib/login_screen.dart#L9), [lib/login_screen.dart](lib/login_screen.dart#L17), [lib/login_screen.dart](lib/login_screen.dart#L23) | Regex de e-mail e validação inicial das credenciais |
| Login - comparação de senha | [lib/login_screen.dart](lib/login_screen.dart#L30), [lib/auth_store.dart](lib/auth_store.dart#L40), [lib/auth_store.dart](lib/auth_store.dart#L42), [lib/auth_store.dart](lib/auth_store.dart#L51) | Autenticação com comparação de senha do admin e do usuário cadastrado |
| Login - chamada da validação | [lib/login_screen.dart](lib/login_screen.dart#L109), [lib/login_screen.dart](lib/login_screen.dart#L121) | Ponto de entrada do submit na tela de login |
| Cadastro - regex de e-mail | [lib/register_screen.dart](lib/register_screen.dart#L48), [lib/register_screen.dart](lib/register_screen.dart#L88), [lib/register_screen.dart](lib/register_screen.dart#L105) | Validação do e-mail no cadastro |
| Cadastro - comparação de senhas | [lib/register_screen.dart](lib/register_screen.dart#L125), [lib/register_screen.dart](lib/register_screen.dart#L126) | Confirmação de senha e validação de igualdade |
| Recuperação - regex e e-mail cadastrado | [lib/forgot_password_screen.dart](lib/forgot_password_screen.dart#L13), [lib/forgot_password_screen.dart](lib/forgot_password_screen.dart#L26), [lib/forgot_password_screen.dart](lib/forgot_password_screen.dart#L44), [lib/forgot_password_screen.dart](lib/forgot_password_screen.dart#L52), [lib/forgot_password_screen.dart](lib/forgot_password_screen.dart#L57) | Regex de e-mail, diálogo de validação e checagem de cadastro |

## RF004 - Sobre

| Arquivo / linhas | O que mostrar |
|---|---|
| [lib/about_screen.dart](lib/about_screen.dart#L3) | Tela `AboutScreen` |
| [lib/about_screen.dart](lib/about_screen.dart#L16) | AppBar com o título "Sobre o Projeto" |
| [lib/about_screen.dart](lib/about_screen.dart#L103) | Cabeçalho "BioScore Web" |
| [lib/about_screen.dart](lib/about_screen.dart#L114) | Versão 1.0.0 |

## RF005 - Funcionalidades específicas

### Agenda / Consultas da Semana
| Arquivo / linhas | O que mostrar |
|---|---|
| [lib/schedule_screen.dart](lib/schedule_screen.dart#L53) | Método `_menuItem` que controla a seleção da tela |
| [lib/schedule_screen.dart](lib/schedule_screen.dart#L135) | Item "Consultas" no menu lateral |
| [lib/schedule_screen.dart](lib/schedule_screen.dart#L136) | Item "Pacientes" no menu lateral |
| [lib/schedule_screen.dart](lib/schedule_screen.dart#L146) | Item "Nova Consulta" no menu lateral |
| [lib/schedule_screen.dart](lib/schedule_screen.dart#L156) | Item "Sobre" no menu lateral |
| [lib/schedule_screen.dart](lib/schedule_screen.dart#L166) | Item "Sair" no menu lateral |
| [lib/schedule_screen.dart](lib/schedule_screen.dart#L192) | Método `_buildConsultasContent()` |
| [lib/schedule_screen.dart](lib/schedule_screen.dart#L324) | Lista horizontal/vertical dos cards de consultas |
| [lib/schedule_screen.dart](lib/schedule_screen.dart#L403) | `IndexedStack` que alterna as telas |

### Lista de Pacientes
| Arquivo / linhas | O que mostrar |
|---|---|
| [lib/patients_list_screen.dart](lib/patients_list_screen.dart#L74) | `ListView.builder` com os pacientes cadastrados |
| [lib/patients_list_screen.dart](lib/patients_list_screen.dart#L96) | Botão de excluir no `trailing` |
| [lib/patients_list_screen.dart](lib/patients_list_screen.dart#L14) | Método de confirmação da exclusão |

### Cadastro de Paciente
| Arquivo / linhas | O que mostrar |
|---|---|
| [lib/patient_registration_screen.dart](lib/patient_registration_screen.dart#L65) | Método `_savePatient()` |
| [lib/patient_registration_screen.dart](lib/patient_registration_screen.dart#L78) | `SnackBar` de sucesso ao salvar |
| [lib/patient_registration_screen.dart](lib/patient_registration_screen.dart#L80) | Mensagem "Paciente cadastrado com sucesso!" |
| [lib/patient_registration_screen.dart](lib/patient_registration_screen.dart#L197) | Botão "Salvar Cadastro" |

### Cadastro de Consulta
| Arquivo / linhas | O que mostrar |
|---|---|
| [lib/appointment_registration_screen.dart](lib/appointment_registration_screen.dart#L83) | Método `_confirmAppointment()` |
| [lib/appointment_registration_screen.dart](lib/appointment_registration_screen.dart#L97) | `SnackBar` de sucesso ao salvar |
| [lib/appointment_registration_screen.dart](lib/appointment_registration_screen.dart#L99) | Mensagem "Consulta agendada com sucesso!" |
| [lib/appointment_registration_screen.dart](lib/appointment_registration_screen.dart#L133) | Dropdown de seleção de paciente |
| [lib/appointment_registration_screen.dart](lib/appointment_registration_screen.dart#L179) | Dropdown de tipo de atendimento |
| [lib/appointment_registration_screen.dart](lib/appointment_registration_screen.dart#L215) | Botão "Confirmar Agendamento" |

> **Nota:** a tela de bioimpedância não está presente neste snapshot atual do projeto. Se você voltar com esse arquivo no branch local, inclua-o aqui como parte das funcionalidades específicas.

## RF006 - Caixas de Diálogo

| Exemplo | Arquivo / linhas | O que mostrar |
|---|---|---|
| `SnackBar` - paciente salvo | [lib/patient_registration_screen.dart](lib/patient_registration_screen.dart#L78), [lib/patient_registration_screen.dart](lib/patient_registration_screen.dart#L80) | Feedback visual de sucesso ao cadastrar paciente |
| `SnackBar` - consulta salva | [lib/appointment_registration_screen.dart](lib/appointment_registration_screen.dart#L97), [lib/appointment_registration_screen.dart](lib/appointment_registration_screen.dart#L99) | Feedback visual de sucesso ao agendar consulta |
| `AlertDialog` - excluir paciente | [lib/patients_list_screen.dart](lib/patients_list_screen.dart#L14), [lib/patients_list_screen.dart](lib/patients_list_screen.dart#L18) | Confirmação antes de remover o paciente |
| `SnackBar` + exclusão em cascata | [lib/patients_list_screen.dart](lib/patients_list_screen.dart#L45), [lib/patients_list_screen.dart](lib/patients_list_screen.dart#L47) | Mensagem "Paciente e agendas removidos com sucesso" |

## RF007 - Listagem

| Arquivo / linhas | O que mostrar |
|---|---|
| [lib/patients_list_screen.dart](lib/patients_list_screen.dart#L74) | `ListView.builder` de pacientes |
| [lib/schedule_screen.dart](lib/schedule_screen.dart#L324) | `ListView.separated` dos cards de consultas |
| [lib/schedule_screen.dart](lib/schedule_screen.dart#L403) | `IndexedStack` alternando a visão principal |

## Gerenciamento de Estado

| Arquivo / linhas | O que mostrar |
|---|---|
| [lib/main.dart](lib/main.dart#L9), [lib/main.dart](lib/main.dart#L10), [lib/main.dart](lib/main.dart#L11) | `ChangeNotifierProvider` envolvendo o app |
| [lib/bioscore_provider.dart](lib/bioscore_provider.dart#L31) | Classe `BioScoreProvider` |
| [lib/bioscore_provider.dart](lib/bioscore_provider.dart#L32), [lib/bioscore_provider.dart](lib/bioscore_provider.dart#L45) | Listas em memória de pacientes e agendas |
| [lib/bioscore_provider.dart](lib/bioscore_provider.dart#L60), [lib/bioscore_provider.dart](lib/bioscore_provider.dart#L62) | Getters `patients` e `appointments` |
| [lib/bioscore_provider.dart](lib/bioscore_provider.dart#L64), [lib/bioscore_provider.dart](lib/bioscore_provider.dart#L69), [lib/bioscore_provider.dart](lib/bioscore_provider.dart#L74) | Métodos `addPatient`, `addAppointment` e `deletePatient` |

## Sequência sugerida para a apresentação

1. Abra o `main.dart` e mostre rapidamente o `ChangeNotifierProvider`.
2. Vá para `login_screen.dart`, `register_screen.dart` e `forgot_password_screen.dart` para mostrar as validações.
3. Abra `about_screen.dart` para o RF004.
4. Abra `schedule_screen.dart` para mostrar menu, `IndexedStack` e agenda.
5. Abra `patients_list_screen.dart` para listagem, exclusão e `AlertDialog`.
6. Abra `patient_registration_screen.dart` e `appointment_registration_screen.dart` para os fluxos de cadastro e os `SnackBars`.
7. Finalize em `bioscore_provider.dart` mostrando como os dados ficam em memória.
