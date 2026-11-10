import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const DoSDetectionApp());
}

class DoSDetectionApp extends StatelessWidget {
  const DoSDetectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoS Attack Detector',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF3E64FF),
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        cardColor: const Color(0xFF16213E),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFE0E0E0)),
          bodyMedium: TextStyle(color: Color(0xFFE0E0E0)),
          bodySmall: TextStyle(color: Color(0xFFBDBDBD)),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F3460),
          elevation: 0,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/login'),
          body: json.encode({
            'username': _usernameController.text,
            'password': _passwordController.text,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const TrafficAnalysisPage()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Successful!'),
              backgroundColor: Color(0xFF3E64FF),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid username or password.'),
              backgroundColor: Color(0xFFE94560),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: const Color(0xFFE94560),
          ),
        );
      }
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A2E), Color(0xFF0F3460)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3E64FF).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      size: 90,
                      color: Color(0xFF3E64FF),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'DoS Attack Detector',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Secure your network',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Card(
                    elevation: 8,
                    color: const Color(0xFF16213E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle:
                                    const TextStyle(color: Color(0xFFBDBDBD)),
                                prefixIcon: const Icon(
                                  Icons.person_outline,
                                  color: Color(0xFF3E64FF),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF3E64FF)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF3E64FF), width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: const Color(0xFF3E64FF)
                                          .withOpacity(0.3)),
                                ),
                                filled: true,
                                fillColor: const Color(0xFF0F3460),
                              ),
                              style: const TextStyle(color: Colors.white),
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter your username' : null,
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle:
                                    const TextStyle(color: Color(0xFFBDBDBD)),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFF3E64FF),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF3E64FF)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF3E64FF), width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: const Color(0xFF3E64FF)
                                          .withOpacity(0.3)),
                                ),
                                filled: true,
                                fillColor: const Color(0xFF0F3460),
                              ),
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              validator: (value) => value!.length < 6
                                  ? 'Password too short'
                                  : null,
                            ),
                            const SizedBox(height: 36),
                            _isLoading
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF3E64FF)),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF3E64FF),
                                          Color(0xFF5A78FF),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF3E64FF)
                                              .withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: _login,
                                      icon: const Icon(Icons.login,
                                          color: Colors.white),
                                      label: const Text(
                                        'LOG IN',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TrafficAnalysisPage extends StatefulWidget {
  const TrafficAnalysisPage({super.key});

  @override
  _TrafficAnalysisPageState createState() => _TrafficAnalysisPageState();
}

class _TrafficAnalysisPageState extends State<TrafficAnalysisPage> {
  int _loadingCount = 0;
  bool _isAnalyzing = false;
  String _predictionResult = "Not yet analyzed.";
  List<Map<String, dynamic>> _pollingData = [];
  bool _isPolling = false;

  Future<void> _fetchPrediction() async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/predict'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _predictionResult = data['prediction'] == 1
              ? "DoS Attack Detected"
              : "No DoS Attack Detected";
        });
      } else {
        setState(() {
          _predictionResult = "Prediction failed.";
        });
      }
    } catch (e) {
      setState(() {
        _predictionResult = "Error fetching prediction.";
      });
    }
  }

  void _startPolling() {
    _isPolling = true;

    Future.doWhile(() async {
      try {
        final response =
            await http.get(Uri.parse('http://127.0.0.1:8000/predict'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          setState(() {
            _pollingData.insert(0, {
              'timestamp': DateTime.now().toString().split('.')[0],
              'prediction':
                  data['prediction'], // Directly use the response string
            });

            // If the number of polling data exceeds 7, reset the polling data list
            if (_pollingData.length > 7) {
              _pollingData = _pollingData.sublist(0, 7);
            }
          });
        }
      } catch (e) {
        debugPrint('Polling error: $e');
      }

      await Future.delayed(const Duration(seconds: 5));
      return _isPolling;
    });
  }

  void _stopPolling() {
    setState(() {
      _isPolling = false;
    });
  }

  Future<void> _analyzeTraffic() async {
    setState(() {
      _isAnalyzing = true;
      _loadingCount = 0;
    });

    while (_loadingCount < 100) {
      await Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _loadingCount++;
        });
      });
    }

    setState(() {
      _isAnalyzing = false;
    });

    _fetchPrediction();
    _startPolling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Real-Time DoS Detection',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: const Icon(Icons.account_circle_outlined, size: 28),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1A1A2E),
              const Color(0xFF16213E).withOpacity(0.95),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: controls & result
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF16213E).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF3E64FF).withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: Color(0xFF3E64FF),
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Control Panel',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: _isAnalyzing
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF494964),
                                    Color(0xFF6E6E91),
                                  ],
                                )
                              : const LinearGradient(
                                  colors: [
                                    Color(0xFF3E64FF),
                                    Color(0xFF5A78FF),
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3E64FF).withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          onPressed: _isAnalyzing ? null : _analyzeTraffic,
                          icon: Icon(
                            _isAnalyzing ? Icons.hourglass_top : Icons.radar,
                            color: Colors.white,
                          ),
                          label: Text(
                            _isAnalyzing
                                ? 'Analyzing...'
                                : 'Start Traffic Analysis',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            disabledBackgroundColor: Colors.transparent,
                            disabledForegroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (_isAnalyzing)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3E64FF)
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.sync,
                                    color: Color(0xFF3E64FF),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Analyzing network...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black.withOpacity(0.2),
                              ),
                              child: LinearProgressIndicator(
                                value: _loadingCount / 100,
                                backgroundColor: Colors.transparent,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFF3E64FF),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Progress: $_loadingCount%',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Card(
                          color: Colors.black.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: _predictionResult.contains('DoS')
                                  ? const Color(0xFFE94560).withOpacity(0.5)
                                  : const Color(0xFF3AAFA9).withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: _predictionResult.contains('DoS')
                                        ? const Color(0xFFE94560)
                                            .withOpacity(0.2)
                                        : const Color(0xFF3AAFA9)
                                            .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    _predictionResult.contains('DoS')
                                        ? Icons.warning_amber_rounded
                                        : Icons.check_circle_outline,
                                    color: _predictionResult.contains('DoS')
                                        ? const Color(0xFFE94560)
                                        : const Color(0xFF3AAFA9),
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _predictionResult.contains('DoS')
                                            ? 'ALERT'
                                            : 'STATUS',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              _predictionResult.contains('DoS')
                                                  ? const Color(0xFFE94560)
                                                  : const Color(0xFF3AAFA9),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        _predictionResult,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      // Stop polling button
                      if (_isPolling)
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Container(
                            width: double.infinity,
                            height: 46,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE94560).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFE94560).withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: ElevatedButton.icon(
                              onPressed: _stopPolling,
                              icon: const Icon(
                                Icons.stop_circle_outlined,
                                color: Color(0xFFE94560),
                              ),
                              label: const Text(
                                'Stop Polling',
                                style: TextStyle(
                                  color: Color(0xFFE94560),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 40),

              // Right side: live table
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF16213E).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF3E64FF).withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.bar_chart,
                            color: Color(0xFF3E64FF),
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Live Predictions',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: _pollingData.isEmpty
                              ? const EdgeInsets.all(20)
                              : EdgeInsets.zero,
                          child: _pollingData.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.bar_chart_outlined,
                                        size: 60,
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No predictions yet.',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Start analysis to see results',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.3),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      headingRowColor:
                                          MaterialStateColor.resolveWith(
                                              (states) =>
                                                  const Color(0xFF0F3460)),
                                      dataRowColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.transparent),
                                      columns: const [
                                        DataColumn(
                                          label: Text(
                                            'Timestamp',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Prediction',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: _pollingData
                                          .map((e) => DataRow(cells: [
                                                DataCell(
                                                  Text(
                                                    e['timestamp'],
                                                    style: const TextStyle(
                                                      color: Color(0xFFE0E0E0),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 6,
                                                      horizontal: 10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: e['prediction']
                                                              .contains("DoS")
                                                          ? const Color(
                                                                  0xFFE94560)
                                                              .withOpacity(0.2)
                                                          : const Color(
                                                                  0xFF3AAFA9)
                                                              .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          e['prediction']
                                                                  .contains(
                                                                      "DoS")
                                                              ? Icons
                                                                  .warning_amber_rounded
                                                              : Icons
                                                                  .check_circle_outline,
                                                          color: e['prediction']
                                                                  .contains(
                                                                      "DoS")
                                                              ? const Color(
                                                                  0xFFE94560)
                                                              : const Color(
                                                                  0xFF3AAFA9),
                                                          size: 18,
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Text(
                                                          e['prediction'],
                                                          style: TextStyle(
                                                            color: e['prediction']
                                                                    .contains(
                                                                        "DoS")
                                                                ? const Color(
                                                                    0xFFE94560)
                                                                : const Color(
                                                                    0xFF3AAFA9),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ]))
                                          .toList(),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
