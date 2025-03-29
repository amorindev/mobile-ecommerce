/* import 'package:flu_go_jwt/services/branchio/todo/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Practice Screen"),
        ),
        body: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {
            _controller.clear();
          },
          builder: (context, state) {
            final invalidValue =
                (state is CounterStateInvalidNumber) ? state.invalidValue : "";
            return Column(
              children: [
                Text('Current value => ${state.value}'),
                Visibility(
                  visible: state is CounterStateInvalidNumber,
                  child: Text('Invalid input: $invalidValue'),
                ),
                TextField(
                  controller: _controller,
                  autocorrect: false,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(
                              DecrementEvent(_controller.text),
                            );
                      },
                      child: const Text('-'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(
                              IncrementEvent(_controller.text),
                            );
                      },
                      child: const Text('+'),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
 */