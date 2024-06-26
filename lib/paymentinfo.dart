import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentInfoWidget extends StatefulWidget {
  final String brand;
  final String year;
  final double totalPrice;
  final DateTime startDate;
  final DateTime endDate;

  const PaymentInfoWidget({
    Key? key,
    required this.brand,
    required this.year,
    required this.totalPrice,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  State<PaymentInfoWidget> createState() => _PaymentInfoWidgetState();
}

class _PaymentInfoWidgetState extends State<PaymentInfoWidget> {
  late String confirmationNumber;

  @override
  void initState() {
    super.initState();
    confirmationNumber = _generateConfirmationNumber();
    _storePaymentInfo(); // Store payment information when the widget is initialized
  }

  String _generateConfirmationNumber() {
    // Generate a random confirmation number
    final random = Random();
    return random.nextInt(999999).toString().padLeft(6, '0');
  }

  void _storePaymentInfo() async {
    // Store payment information in the "purchased" collection
    await FirebaseFirestore.instance.collection('purchased').add({
      'brand': widget.brand,
      'year': widget.year,
      'totalPrice': widget.totalPrice,
      'startDate': widget.startDate,
      'endDate': widget.endDate,
      // Add other fields as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Confirmation',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Urbanist',
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://images.unsplash.com/photo-1518306727298-4c17e1bf6942?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyMXx8Y2FyfGVufDB8fHx8MTcxMjYyMzkxOHww&ixlib=rb-4.0.3&q=80&w=1080',
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 360,
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color(0x411D2429),
                      offset: Offset(
                        0.0,
                        2,
                      ),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _buildInfoRow('Confirmation number', confirmationNumber),
                      SizedBox(height: 20),
                      _buildInfoRow('Car', '${widget.brand}, ${widget.year}'),
                      SizedBox(height: 20),
                      _buildInfoRow('Rent Date',
                          '${widget.startDate.year}/${widget.startDate.month}/${widget.startDate.day}'),
                      SizedBox(height: 20),
                      _buildInfoRow('Return Date',
                          '${widget.endDate.year}/${widget.endDate.month}/${widget.endDate.day}'),
                      SizedBox(height: 20),
                      _buildInfoRow('Total Price',
                          '\$${widget.totalPrice.toStringAsFixed(2)}'),
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

  Widget _buildInfoRow(String title, String value) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Urbanist',
                  fontSize: 18,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Urbanist',
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
