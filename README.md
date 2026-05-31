# 🏦 Bank App — Persistência de Dados com SQLite

Aplicativo desenvolvido em **Flutter** com persistência de dados local via **SQLite**, simulando funcionalidades básicas de um banco digital.

---

## 📱 Funcionalidades

- Dashboard com saldo e navegação rápida
- Cadastro e listagem de transferências (formatação R$)
- Cadastro e listagem de contatos
- Navegação integrada entre contatos e transferências

---

## ▶️ Como executar

**Pré-requisitos:** Flutter SDK, Git e Google Chrome instalados.

```bash
# 1. Clone o repositório
git clone https://github.com/poxapath/Projeto_Bank.git
cd Projeto_Bank

# 2. Instale as dependências
flutter pub get

# 3. Configure o SQLite para web (necessário apenas uma vez)
dart run sqflite_common_ffi_web:setup

# 4. Execute no Chrome
flutter run -d chrome
```

---

## 🛠️ Tecnologias

Flutter • Dart • SQLite (sqflite) • intl (formatação pt_BR)

---

## 📌 Observação

Ao rodar no Chrome, os dados são salvos no IndexedDB do navegador. Em dispositivos Android, são salvos diretamente via SQLite.