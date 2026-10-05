import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// ======================================================
// IDENTIDADE VISUAL
// ======================================================

class AppColors {
  static const Color primary = Color(0xFF163B3D);
  static const Color primaryLight = Color(0xFFE4F0EE);

  static const Color accent = Color(0xFF5FA99B);

  static const Color background = Color(0xFFF7F8F7);
  static const Color card = Colors.white;

  static const Color text = Color(0xFF172324);
  static const Color secondaryText = Color(0xFF718080);
  static const Color completed = Color(0xFF9AA8A7);

  static const Color border = Color(0xFFE4E9E8);
  static const Color danger = Color(0xFFD65C5C);
}

// ======================================================
// APLICAÇÃO PRINCIPAL
// ======================================================

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Minhas tarefas',

      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor:
            AppColors.background,

        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),

        fontFamily: 'Roboto',

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.text,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),

      home: const TarefaScreen(),
    );
  }
}

// ======================================================
// MODELO DA TAREFA
// ======================================================

class Tarefa {
  final String id;
  String titulo;
  bool concluida;

  Tarefa({
    required this.id,
    required this.titulo,
    this.concluida = false,
  });
}

// ======================================================
// TELA PRINCIPAL
// ======================================================

class TarefaScreen extends StatefulWidget {
  const TarefaScreen({super.key});

  @override
  State<TarefaScreen> createState() =>
      _TarefaScreenState();
}

class _TarefaScreenState extends State<TarefaScreen> {

  // ====================================================
  // LISTA INICIAL DE TAREFAS
  // ====================================================

  final List<Tarefa> _tarefas = [
    Tarefa(
      id: '1',
      titulo: 'Comprar pão, leite e ovo',
    ),

    Tarefa(
      id: '2',
      titulo: 'Responder e-mails do trabalho',
      concluida: true,
    ),

    Tarefa(
      id: '3',
      titulo: 'Academia às 18h',
    ),
  ];

  // Controla o campo de texto
  final TextEditingController _controller =
      TextEditingController();

  // ====================================================
  // CONTADOR DE TAREFAS PENDENTES
  // ====================================================

  int get _pendentes {
    return _tarefas
        .where((tarefa) => !tarefa.concluida)
        .length;
  }

  // ====================================================
  // CONTADOR DE TAREFAS CONCLUÍDAS
  // ====================================================

  int get _concluidas {
    return _tarefas
        .where((tarefa) => tarefa.concluida)
        .length;
  }

  // ====================================================
  // ABRIR FORMULÁRIO DE NOVA TAREFA
  // ====================================================

  void _abrirBottomSheet() {
    _controller.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),

      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 12,

            // Faz o formulário subir
            // quando o teclado aparece
            bottom:
                MediaQuery.of(context)
                    .viewInsets
                    .bottom +
                24,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // ------------------------------------------
              // BARRINHA DECORATIVA
              // ------------------------------------------

              Center(
                child: Container(
                  width: 38,
                  height: 4,

                  margin:
                      const EdgeInsets.only(
                    bottom: 24,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),
              ),

              // ------------------------------------------
              // TÍTULO
              // ------------------------------------------

              const Text(
                'Nova tarefa',

                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Adicione algo que você precisa fazer.',

                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------
              // CAMPO DE TEXTO
              // ------------------------------------------

              TextField(
                controller: _controller,
                autofocus: true,

                textCapitalization:
                    TextCapitalization.sentences,

                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 16,
                ),

                decoration: InputDecoration(
                  hintText:
                      'Ex.: Estudar para a prova',

                  hintStyle:
                      const TextStyle(
                    color:
                        AppColors.secondaryText,
                  ),

                  filled: true,

                  fillColor:
                      AppColors.background,

                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),

                    borderSide:
                        BorderSide.none,
                  ),

                  focusedBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),

                    borderSide:
                        const BorderSide(
                      color:
                          AppColors.accent,
                      width: 1.5,
                    ),
                  ),
                ),

                // Permite adicionar apertando Enter
                onSubmitted: (_) {
                  _adicionarTarefa();
                },
              ),

              const SizedBox(height: 14),

              // ------------------------------------------
              // BOTÃO ADICIONAR
              // ------------------------------------------

              SizedBox(
                width: double.infinity,
                height: 54,

                child: ElevatedButton(
                  onPressed: _adicionarTarefa,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.primary,

                    foregroundColor:
                        Colors.white,

                    elevation: 0,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                    ),
                  ),

                  child: const Text(
                    'Adicionar tarefa',

                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ====================================================
  // ADICIONAR TAREFA
  // ====================================================

  void _adicionarTarefa() {
    final texto =
        _controller.text.trim();

    // Não permite adicionar tarefa vazia
    if (texto.isEmpty) {
      return;
    }

    setState(() {
      _tarefas.add(
        Tarefa(
          id: DateTime.now()
              .millisecondsSinceEpoch
              .toString(),

          titulo: texto,
        ),
      );
    });

    // Limpa o campo
    _controller.clear();

    // Fecha o formulário
    Navigator.pop(context);
  }

  // ====================================================
  // MARCAR / DESMARCAR TAREFA
  // ====================================================

  void _alternarStatus(String id) {
    setState(() {
      final tarefa =
          _tarefas.firstWhere(
        (tarefa) => tarefa.id == id,
      );

      tarefa.concluida =
          !tarefa.concluida;
    });
  }

  // ====================================================
  // EXCLUIR TAREFA
  // ====================================================

  void _deletarTarefa(String id) {
    final index =
        _tarefas.indexWhere(
      (tarefa) => tarefa.id == id,
    );

    if (index == -1) {
      return;
    }

    setState(() {
      _tarefas.removeAt(index);
    });
  }

  // ====================================================
  // CARD DE ESTATÍSTICA
  // ====================================================

  Widget _estatistica({
    required String numero,
    required String texto,
    required IconData icone,
  }) {
    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(18),

          border: Border.all(
            color: AppColors.border,
          ),
        ),

        child: Row(
          children: [

            // Ícone
            Container(
              width: 38,
              height: 38,

              decoration: BoxDecoration(
                color:
                    AppColors.primaryLight,

                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),

              child: Icon(
                icone,
                size: 19,
                color:
                    AppColors.primary,
              ),
            ),

            const SizedBox(width: 10),

            // Número e descrição
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  numero,

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w700,
                    color:
                        AppColors.text,
                  ),
                ),

                Text(
                  texto,

                  style:
                      const TextStyle(
                    fontSize: 11,
                    color:
                        AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ====================================================
  // ESTADO VAZIO
  // ====================================================

  Widget _estadoVazio() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 40,
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            // Ícone
            Container(
              width: 76,
              height: 76,

              decoration: BoxDecoration(
                color:
                    AppColors.primaryLight,

                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.check_rounded,
                size: 38,
                color:
                    AppColors.primary,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Tudo em dia',

              style: TextStyle(
                fontSize: 21,
                fontWeight:
                    FontWeight.w700,
                color:
                    AppColors.text,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Você não tem tarefas pendentes.\nAproveite o momento.',

              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color:
                    AppColors.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ====================================================
  // INTERFACE PRINCIPAL
  // ====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:
          AppColors.background,

      // ==================================================
      // CABEÇALHO
      // ==================================================

      appBar: AppBar(
        backgroundColor:
            AppColors.background,

        titleSpacing: 24,

        title: const Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              'Minhas tarefas',

              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.w800,
                color:
                    AppColors.text,
                letterSpacing: -0.5,
              ),
            ),

            SizedBox(height: 2),

            Text(
              'ORGANIZE. FAÇA. CONCLUA.',

              style: TextStyle(
                fontSize: 8,
                fontWeight:
                    FontWeight.w600,
                letterSpacing: 1.1,
                color:
                    AppColors.secondaryText,
              ),
            ),
          ],
        ),

        actions: [

          // Contador de tarefas
          Container(
            margin:
                const EdgeInsets.only(
              right: 24,
            ),

            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),

            decoration: BoxDecoration(
              color:
                  AppColors.primaryLight,

              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),

            child: Text(
              '$_pendentes pendentes',

              style: const TextStyle(
                fontSize: 11,
                fontWeight:
                    FontWeight.w600,
                color:
                    AppColors.primary,
              ),
            ),
          ),
        ],
      ),

      // ==================================================
      // CONTEÚDO
      // ==================================================

      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const SizedBox(height: 22),

          // ----------------------------------------------
          // TÍTULO
          // ----------------------------------------------

          const Padding(
            padding:
                EdgeInsets.symmetric(
              horizontal: 24,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  'Suas tarefas',

                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.w800,
                    letterSpacing: -1,
                    color:
                        AppColors.text,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Um passo de cada vez.',

                  style: TextStyle(
                    fontSize: 14,
                    color:
                        AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ----------------------------------------------
          // ESTATÍSTICAS
          // ----------------------------------------------

          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 24,
            ),

            child: Row(
              children: [

                _estatistica(
                  numero:
                      '$_pendentes',
                  texto:
                      'Pendentes',
                  icone:
                      Icons.radio_button_unchecked,
                ),

                const SizedBox(width: 10),

                _estatistica(
                  numero:
                      '$_concluidas',
                  texto:
                      'Concluídas',
                  icone:
                      Icons.check_circle_outline,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ----------------------------------------------
          // LISTA DE TAREFAS
          // ----------------------------------------------

          Expanded(
            child: _tarefas.isEmpty
                ? _estadoVazio()

                : ListView.builder(
                    padding:
                        const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: 100,
                    ),

                    itemCount:
                        _tarefas.length,

                    itemBuilder:
                        (context, index) {

                      final tarefa =
                          _tarefas[index];

                      return _cardTarefa(
                        tarefa,
                      );
                    },
                  ),
          ),
        ],
      ),

      // ==================================================
      // BOTÃO NOVA TAREFA
      // ==================================================

      floatingActionButton:
          FloatingActionButton.extended(

        onPressed:
            _abrirBottomSheet,

        backgroundColor:
            AppColors.primary,

        foregroundColor:
            Colors.white,

        elevation: 4,

        icon: const Icon(
          Icons.add_rounded,
        ),

        label: const Text(
          'Nova tarefa',

          style: TextStyle(
            fontWeight:
                FontWeight.w600,
          ),
        ),

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),
        ),
      ),
    );
  }

  // ====================================================
  // CARD DE CADA TAREFA
  // ====================================================

  Widget _cardTarefa(Tarefa tarefa) {
    return Dismissible(

      // Identifica a tarefa
      key: ValueKey(tarefa.id),

      // Também permite excluir arrastando
      direction:
          DismissDirection.endToStart,

      // -----------------------------------------------
      // FUNDO AO ARRASTAR
      // -----------------------------------------------

      background: Container(
        margin:
            const EdgeInsets.only(
          bottom: 10,
        ),

        padding:
            const EdgeInsets.only(
          right: 24,
        ),

        decoration: BoxDecoration(
          color: AppColors.danger,

          borderRadius:
              BorderRadius.circular(
            18,
          ),
        ),

        alignment:
            Alignment.centerRight,

        child: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),

      // Quando termina de arrastar
      onDismissed: (_) {
        _deletarTarefa(tarefa.id);
      },

      // -----------------------------------------------
      // CARD
      // -----------------------------------------------

      child: Container(
        margin:
            const EdgeInsets.only(
          bottom: 10,
        ),

        decoration: BoxDecoration(
          color: AppColors.card,

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          border: Border.all(
            color: AppColors.border,
          ),
        ),

        child: Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),

          child: Row(
            children: [

              // =========================================
              // CHECKBOX
              // =========================================

              GestureDetector(
                onTap: () {
                  _alternarStatus(
                    tarefa.id,
                  );
                },

                child: AnimatedContainer(
                  duration:
                      const Duration(
                    milliseconds: 180,
                  ),

                  width: 25,
                  height: 25,

                  decoration:
                      BoxDecoration(
                    color:
                        tarefa.concluida
                            ? AppColors.accent
                            : Colors.transparent,

                    borderRadius:
                        BorderRadius.circular(
                      8,
                    ),

                    border: Border.all(
                      color:
                          tarefa.concluida
                              ? AppColors.accent
                              : AppColors.secondaryText,

                      width: 1.5,
                    ),
                  ),

                  child: tarefa.concluida
                      ? const Icon(
                          Icons.check_rounded,
                          size: 17,
                          color:
                              Colors.white,
                        )
                      : null,
                ),
              ),

              const SizedBox(width: 14),

              // =========================================
              // TEXTO DA TAREFA
              // =========================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      tarefa.titulo,

                      style: TextStyle(
                        fontSize: 15,
                        height: 1.3,

                        fontWeight:
                            FontWeight.w600,

                        color:
                            tarefa.concluida
                                ? AppColors.completed
                                : AppColors.text,

                        decoration:
                            tarefa.concluida
                                ? TextDecoration
                                    .lineThrough
                                : TextDecoration
                                    .none,

                        decorationThickness:
                            1.5,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      tarefa.concluida
                          ? 'Concluída'
                          : 'Pendente',

                      style: TextStyle(
                        fontSize: 11,

                        fontWeight:
                            FontWeight.w500,

                        color:
                            tarefa.concluida
                                ? AppColors.accent
                                : AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),

              // =========================================
              // BOTÃO EXCLUIR
              // =========================================

              IconButton(
                onPressed: () {
                  _deletarTarefa(
                    tarefa.id,
                  );
                },

                tooltip: 'Excluir tarefa',

                splashRadius: 22,

                icon: const Icon(
                  Icons.delete_outline_rounded,
                  size: 21,
                ),

                color:
                    AppColors.secondaryText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ====================================================
  // DESCARTAR CONTROLADOR
  // ====================================================

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}