import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_progreess_page.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_queen_cargo/features/Pages/Register/Controller/create_customer_cubit.dart';
import 'package:mc_queen_cargo/features/Pages/Register/register_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
part 'register_widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(30.h, 30.h), child: _RegisterAppBar()),
        body: StackProgressWidget(
          visibility: visibilty,
          child: Container(
            margin: CustomPadding.onlyHorizontalInset(50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _RegisterPageColumnItems(
                    number: "1",
                    title: "Kişisel Bilgiler",
                    incoming: incoming),
                SizedBox(height: 20.h),
                _RegisterPageColumnItems(
                    number: "2", title: "E-Posta", incoming: incoming),
                SizedBox(height: 20.h),
                _RegisterPageColumnItems(
                    number: "3", title: "Cep Telefonu", incoming: incoming),
                SizedBox(height: 20.h),
                AtomicOrangeButton(
                    onPressed: () async {
                      await buttonProcess(context);
                      visibilty.value = false;
                    },
                    title: incoming.contains("entry")
                        ? "Başla"
                        : "Üyeliği İşlemini Tamamla")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
