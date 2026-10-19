# 📱 Catálogo Dinâmico Multi-Telas

Projeto desenvolvido durante as aulas da disciplina de **Programação para Dispositivos Móveis I** em 10/2026. 

O objetivo deste laboratório prático é realizar a transição da modelagem teórica para a prática de engenharia de software mobile, convertendo dados brutos em formato **JSON** em uma interface fluida, reativa e escalável utilizando **Flutter** e **Dart**.

---

## 🎯 Objetivos e Níveis do Laboratório

O projeto foi dividido em 3 níveis progressivos de complexidade:

### 🔹 Nível 1: Estruturação e Tipagem Estrita
* **Arquitetura modular:** Separação limpa em diretórios `/models`, `/widgets` e `/screens`.
* **Modelagem OO:** Criação da classe `Produto` no arquivo `produto.dart`.
* **Segurança de Tipos:** Aplicação rigorosa de *Null Safety* e atributos `final` com construtores `required`.
* **Regra de Negócio Crítica:** Implementação do getter `temEstoqueCritico` que retorna `true` caso a quantidade de estoque seja inferior a 5 unidades.
* **Desserialização Segura:** Implementação do método `factory Produto.fromJson(Map<String, dynamic> json)`.

### 🔹 Nível 2: Montagem da Esteira Dinâmica
* **Design System:** Configuração do `Scaffold` com suporte ao **Material Design 3** (`useMaterial3: true`).
* **Componentização:** Isolamento do widget customizado `ProdutoCard` (utilizando `Card` e `ListTile`).
* **Performance:** Utilização do construtor otimizado `ListView.builder` para renderização sob demanda (*lazy loading*), evitando estouro de memória RAM.
* **Gatilho de Atualização:** Botão de recarga na `AppBar` e `FloatingActionButton`.

### 🔹 Nível 3: Polimento Profissional e Versionamento
* **Lógica Visual Reativa:** Alerta de estoque crítico reativo no `ProdutoCard`, alterando dinamicamente ícone e cores para destaque visual imediato (feedback em vermelho com `Icons.warning_amber_rounded`).
* **Tratamento de Estado (HUD):** Gerenciamento do estado assíncrono com a variável `_isLoading` e o widget `CircularProgressIndicator` enquanto os dados via `jsonDecode` são processados.
* **Versionamento:** Boas práticas de commits estruturados via Git/GitHub.

---

## 🛠️ Tecnologias e Ferramentas

* **Linguagem:** [Dart](https://dart.dev/)
* **Framework:** [Flutter](https://flutter.dev/) (Material Design 3)
* **IDE Recomendada:** Visual Studio Code / Android Studio
* **Versionamento:** Git & GitHub

---

## 📁 Estrutura do Projeto

```text
lib/
├── models/
│   └── produto.dart          # Modelagem de dados e conversão de JSON
├── widgets/
│   └── produto_card.dart     # Widget de cartão de produto otimizado
├── screens/
│   └── catalogo_screen.dart  # Tela principal com estado e ListView
└── main.dart                 # Ponto de entrada e configuração do tema
```

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
Certifique-se de ter o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e configurado em sua máquina.

1. **Clonar o repositório:**
   ```bash
   git clone https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
   cd catalogo_dinamico
   ```

2. **Obter as dependências:**
   ```bash
   flutter pub get
   ```

3. **Executar a aplicação:**
   * No navegador (Google Chrome):
     ```bash
     flutter run -d chrome
     ```
   * Em um emulador ou dispositivo físico:
     ```bash
     flutter run
     ```

---


Desenvolvido para a disciplina de **Programação para Dispositivos Móveis I**.