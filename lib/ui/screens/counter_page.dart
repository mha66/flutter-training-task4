import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/cubit/app_cubit.dart';

TextEditingController input1Controller = TextEditingController();
TextEditingController input2Controller = TextEditingController();

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Counter',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              )),
        ),
        const SizedBox(height: 125),
        BlocBuilder<AppCubitA, AppStateA>(
          builder: (context, state) {
            return Text(
              'sum = ${context.read<AppCubitA>().sum.toString()}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            );
          },
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: input1Controller,
            style: const TextStyle(fontWeight: FontWeight.w700),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 20),
              border: InputBorder.none,
              fillColor: Color(0xFFD9D9D9),
              filled: true,
              hintText: 'input 1',
              hintStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: input2Controller,
            style: const TextStyle(fontWeight: FontWeight.w700),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 20),
              border: InputBorder.none,
              fillColor: Color(0xFFD9D9D9),
              filled: true,
              hintText: 'input 2',
              hintStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        BlocBuilder<AppCubitA, AppStateA>(
          builder: (context, state) {
            return ElevatedButton(
                onPressed: () {
                  context.read<AppCubitA>().getSum(
                      int.parse(input1Controller.text),
                      int.parse(input2Controller.text));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF330707),
                    minimumSize: const Size(120, 40),
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: const Text(
                  'get sum',
                  style: TextStyle(
                      fontFamily: 'Times', fontWeight: FontWeight.bold),
                ));
          },
        )
      ],
    );
  }
}
