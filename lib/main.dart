import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas TPM',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyTabs(),
    );
  }
}

class MyTabs extends StatefulWidget {
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Teknologi Pemrogramman Mobile')),
        bottom: TabBar(
          indicatorColor: Colors.amberAccent,
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.login), text: 'Login'),
            Tab(icon: Icon(Icons.calculate_outlined), text: 'Kalkulator'),
            Tab(icon: Icon(Icons.info), text: 'Anggota'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LoginScreen(),
          CalculatorScreen(),
          TableScreen(),
        ],
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Silahkan masukkan username';
                }
                return null;
              },
              onSaved: (value) {
                username = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Silahkan masukkan password';
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Email: $username\nPassword: $_password'),
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController _nomor1Controller = TextEditingController();
  TextEditingController _nomor2Controller = TextEditingController();
  double _result = 0;

  void _calculate() {
    setState(() {
      double nomor1 = double.parse(_nomor1Controller.text);
      double nomor2 = double.parse(_nomor2Controller.text);
      _result = nomor1 + nomor2;
    });
  }

  void _calculate2() {
    setState(() {
      double nomor1 = double.parse(_nomor1Controller.text);
      double nomor2 = double.parse(_nomor2Controller.text);
      _result = nomor1 - nomor2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _nomor1Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'First Number'),
          ),
          TextField(
            controller: _nomor2Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Second Number'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _calculate,
            child: Text('+'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _calculate2,
            child: Text('-'),
          ),
          SizedBox(height: 16),
          Text(
            'Result: $_result',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class TableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Nama')),
            DataColumn(label: Text('NIM')),
            DataColumn(label: Text('Kelas')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Arya Garda Perwira')),
              DataCell(Text('123190131')),
              DataCell(Text('Praktikum TPM IF-D')),
            ]),
          ],
        ),
      ),
    );
  }
}
