import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class TermsAndConditionPage extends StatefulWidget {
  const TermsAndConditionPage({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {
  InAppWebViewController? _webViewController;

  InitialStatusController controller = Get.find<InitialStatusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Appbar(
            context: context,
            title: 'Terms And Conditions',
            lighttitle: 'hideCart',
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Col.darkgreen)),
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse(controller.termsAndConditionUrl.toString())),
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions()),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onLoadStart: (InAppWebViewController? controller, Uri? url) {},
                onLoadStop:
                    (InAppWebViewController? controller, Uri? url) async {},
                // onProgressChanged:
                //     (InAppWebViewController controller, int progress) {
                //   setState(() {
                //     this.progress = progress / 100;
                //   });
                // },
              ),
            ),
          ),
          const SizedBox(
            height: 22,
          )
        ]),
      ),
    );
  }
}
