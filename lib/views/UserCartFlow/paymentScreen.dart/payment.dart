import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/UserCartFlow/DeliveryDetails/deliveryDetailController.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  InAppWebViewController? _webViewController;
  DeliveryDetailController deliverycon = Get.find<DeliveryDetailController>();
  Uri? url;

  String matchingurl =
      'http://192.168.1.47:8080/eatwell/#/dietplan/payement-authorized';
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Appbar(
            context: context,
            title: 'Payment',
          )),
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        Container(
            padding: const EdgeInsets.all(10.0),
            child: progress < 1.0
                ? LinearProgressIndicator(
                    value: progress,
                    color: Col.darkgreen,
                    backgroundColor: Col.green.withOpacity(.2),
                  )
                : Container()),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(border: Border.all(color: Col.darkgreen)),
            child: InAppWebView(
              initialUrlRequest:
                  URLRequest(url: Uri.parse(deliverycon.paymentUrl.toString())),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions()),
              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;
              },
              onLoadStart: (InAppWebViewController? controller, Uri? url) {
                setState(() {
                  this.url = url;
                  print('the url is $url');
                });
              },
              onLoadStop: (InAppWebViewController? controller, Uri? url) async {
                if (matchingurl == url.toString()) {
                  Navigator.pop(context);

                  deliverycon.verifyPayment(context);
                } else {
                  setState(() {
                    this.url = url;
                  });
                }
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController!.goBack();
                }
              },
              icon: const Icon(Icons.arrow_back),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController!.goForward();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController!.reload();
                }
              },
            ),
          ],
        ),
      ]),
    );
  }
}
