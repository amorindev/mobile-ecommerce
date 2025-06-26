import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.add_box),
              ),
              Tab(
                icon: Icon(Icons.border_vertical),
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          ListView(
            padding: const EdgeInsets.only(
              top: 5.0,
              left: AppSizes.horizontalPadding,
              right: AppSizes.horizontalPadding,
            ),
            children: [
              CustomTextField(
                controller: _nameController,
                hintText: 'Product Name',
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
              const  SizedBox(height: 5),
              CustomTextField(
                controller: _descController,
                hintText: 'Product Description',
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
          ListView(),
        ]),
      ),
    );
  }
}
