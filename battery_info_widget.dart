import 'dart:convert';
import 'package:device_info_null_safety/device_info_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class BatteryInfoWidget extends StatefulWidget {
  const BatteryInfoWidget({Key? key}) : super(key: key);

  @override
  State<BatteryInfoWidget> createState() => _BatteryInfoWidgetState();
}

class _BatteryInfoWidgetState extends State<BatteryInfoWidget> {
  Map<String, dynamic> _batteryInfo = {};

  @override
  void initState() {
    super.initState();
    _fetchBatteryInfo();
  }

  Future<void> _fetchBatteryInfo() async {
    final DeviceInfoNullSafety _deviceInfoNullSafety = DeviceInfoNullSafety();
    Map<String, dynamic> batteryInfo = await _deviceInfoNullSafety.batteryInfo;

    // Logic to save batteryInfo to JSON file
    await _saveBatteryInfoToJson(batteryInfo);

    setState(() {
      _batteryInfo = batteryInfo;
    });
  }

  Future<void> _saveBatteryInfoToJson(Map<String, dynamic> batteryInfo) async {
    // Get the documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Create a file path
    final File file = File('${directory.path}/battery_info.json');

    // Encode the data as JSON string
    final jsonString = json.encode(batteryInfo);

    // Write into the file.
    await file.writeAsString(jsonString);
  }

  // Function to read the saved JSON file
  Future<Map<String, dynamic>> _readBatteryInfoFromJson() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/battery_info.json');
      String jsonString = await file.readAsString();
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      print('Error reading JSON file: $e');
      return {};
    }
  }

  // Function to retrieve individual values
  Future<String> getBatteryInfoValue(String key) async {
    Map<String, dynamic> batteryInfo = await _readBatteryInfoFromJson();
    return batteryInfo[key]?.toString() ?? 'Data not available';
  }

  Future<void> _printBatteryInfo() async {
    Map<String, dynamic> batteryInfo = await _readBatteryInfoFromJson();
    print(jsonEncode(batteryInfo));
  }

  // Function to export the JSON (Android)
  Future<void> _exportBatteryInfo() async {
    Map<String, dynamic> batteryInfo = await _readBatteryInfoFromJson();
    final jsonString = jsonEncode(batteryInfo);

    final directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/battery_info.json';
    File file = File(filePath);
    await file.writeAsString(jsonString);

    print('Battery info saved to $filePath');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Info'),
      ),
      body: _batteryInfo.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                _buildBatteryInfoTile('Is Battery Present',
                    _batteryInfo['isBatteryPresent'].toString()),
                _buildBatteryInfoTile(
                    'Charging Source', _batteryInfo['chargingSource']),
                _buildBatteryInfoTile('Battery Temperature',
                    _batteryInfo['batteryTemperature'].toString()),
                _buildBatteryInfoTile('Battery Voltage',
                    _batteryInfo['batteryVoltage'].toString()),
                _buildBatteryInfoTile('Is Device Charging',
                    _batteryInfo['isDeviceCharging'].toString()),
                _buildBatteryInfoTile('Battery Percentage',
                    _batteryInfo['batteryPercentage'].toString() + '%'),
                _buildBatteryInfoTile(
                    'Battery Health', _batteryInfo['batteryHealth']),
                _buildBatteryInfoTile(
                    'Battery Technology', _batteryInfo['batteryTechnology']),
                ElevatedButton(
                  onPressed: _printBatteryInfo,
                  child: Text('Print Battery Info'),
                ),
                ElevatedButton(
                  onPressed: _exportBatteryInfo,
                  child: Text('Export Battery Info'),
                ),
                ElevatedButton(
                  onPressed: _requestStoragePermission,
                  child: Text('Request Storage Permission'),
                ),
              ],
            ),
    );
  }

  Future<void> _requestStoragePermission() async {
    print('Requesting storage permission...');
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      print('Storage permission not granted, requesting...');
      final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Storage Permission Required'),
            content: Text(
                'This app needs storage permission to export battery info.'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text('Allow'),
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );

      if (result == true) {
        final granted = await Permission.storage.request();
        if (granted.isGranted) {
          print('Storage permission granted');
          // If permission is granted, export battery info
          await _exportBatteryInfo();
        } else {
          print('Storage permission denied');
        }
      } else {
        print('Storage permission denied');
      }
    } else {
      print('Storage permission already granted');
      // If permission is already granted, export battery info
      await _exportBatteryInfo();
    }
  }

  ListTile _buildBatteryInfoTile(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
