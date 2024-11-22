import 'package:flutter/material.dart';

class HealthCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final String unit;
  final IconData icon;
  final bool isConnected;
  final VoidCallback onToggleConnection;

  const HealthCard({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    required this.unit,
    required this.icon,
    required this.isConnected,
    required this.onToggleConnection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 160,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
                SizedBox(width: 4),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        color: color,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      unit,
                      style: TextStyle(
                        color: color,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: onToggleConnection,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isConnected ? Colors.red : color,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text(isConnected ? 'Disconnect' : 'Connect'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
