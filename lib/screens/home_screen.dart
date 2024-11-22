import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'device_list_screen.dart';
import '../app_theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String _deviceName = '';
  String _connectionType = 'Bluetooth';
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    SizedBox(
                      height: 200,
                      child: Lottie.network(
                        'https://assets5.lottiefiles.com/packages/lf20_jcikwtux.json',
                        controller: _controller,
                        onLoaded: (composition) {
                          _controller
                            ..duration = composition.duration
                            ..forward();
                        },
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 32),

                    Text(
                      'IoT Device Manager',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppTheme.textColorPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[

                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Device Name',
                              filled: true,
                              labelStyle: TextStyle(color: AppTheme.textColorSecondary),
                              fillColor: AppTheme.backgroundColor.withOpacity(0.8),
                            ),
                            style: TextStyle(color: AppTheme.textColorPrimary),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a device name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _deviceName = value!;
                            },
                          ),
                          SizedBox(height: 20),

                          DropdownButtonFormField<String>(
                            value: _connectionType,
                            decoration: InputDecoration(
                              labelText: 'Connection Type',
                              labelStyle: TextStyle(color: AppTheme.textColorSecondary),
                              filled: true,
                              fillColor: AppTheme.backgroundColor.withOpacity(0.8),
                            ),
                            style: TextStyle(
                              color: AppTheme.textColorPrimary,
                              fontWeight: FontWeight.w400,
                            ),
                            items: <String>['Bluetooth', 'Wi-Fi']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: AppTheme.textColorPrimary),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _connectionType = newValue!;
                              });
                            },
                          ),
                          SizedBox(height: 32),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              child: Text(
                                'Connect to Device',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DeviceListScreen(
                                        deviceName: _deviceName,
                                        connectionType: _connectionType,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}