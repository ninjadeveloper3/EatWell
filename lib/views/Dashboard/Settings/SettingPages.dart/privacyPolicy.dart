import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PrivacyPolicyPage extends StatelessWidget {
  PrivacyPolicyPage({Key? key}) : super(key: key);
  InAppWebViewController? _webViewController;
  InitialStatusController controller = Get.find<InitialStatusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Appbar(
            context: context,
            title: 'Privacy Policy',
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
                    url: Uri.parse(controller.privacyPolicyUrl.toString())),
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions()),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                // onLoadStart: (InAppWebViewController? controller, Uri? url) {
                //   setState(() {
                //     this.url = url;
                //     print('the url is $url');
                //   });
                // },
                // onLoadStop:
                //     (InAppWebViewController? controller, Uri? url) async {
                //   if (matchingurl == url.toString()) {
                //     Navigator.pop(context);

                //     deliverycon.verifyPayment(context);
                //   } else {
                //     setState(() {
                //       this.url = url;
                //     });
                //   }
                // },
                // onProgressChanged:
                //     (InAppWebViewController controller, int progress) {
                //   setState(() {
                //     this.progress = progress / 100;
                //   });
                // },
              ),
            ),
          ),
          // Wrap(
          //   children: const [
          //     Text(
          //         '1. Introduction\n Welcome to Eatwell. Eatwell (“us”, “we”, or “our”) operates EatWell.com (hereinafter referred to as “Service”).\n Our Privacy Policy governs your visit to EatWell.com, and explains how we collect, safeguard and disclose information that results from your use of our Service. We use your data to provide and improve Service. By using Service, you agree to the collection and use of information in accordance with this policy. Unless otherwise defined in this Privacy Policy, the terms used in this Privacy Policy have the same meanings as in our Terms and Conditions. Our Terms and Conditions (“Terms”) govern all use of our Service and together with the Privacy Policy constitutes your agreement with us (“agreement”). \n2. Definitions SERVICE means the EatWell.com website operated by Eatwell. PERSONAL DATA means data about a living individual who can be identified from those data (or from those and other information either in our possession or likely to come into our possession). USAGE DATA is data collected automatically either generated by the use of Service or from Service infrastructure itself (for example, the duration of a page visit). COOKIES are small files stored on your device (computer or mobile device). DATA CONTROLLER means a natural or legal person who (either alone or jointly or in common with other persons) determines the purposes for which and the manner in which any personal data are, or are to be, processed. For the purpose of this Privacy Policy, we are a Data Controller of your data. DATA PROCESSORS (OR SERVICE PROVIDERS) means any natural or legal person who processes the data on behalf of the Data Controller. We may use the services of various Service Providers in order to process your data more effectively. DATA SUBJECT is any living individual who is the subject of Personal Data. THE USER is the individual using our Service. The User corresponds to the Data Subject, who is the subject of Personal Data. \n3. Information Collection and Use We collect several different types of information for various purposes to provide and improve our Service to you. \n4. Types of Data Collected Personal Data While using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you (“Personal Data”). Personally identifiable information may include, but is not limited to: 0.1. Email address 0.2. First name and last name 0.3. Phone number 0.4. Address, Country, State, Province, ZIP/Postal code, City 0.5. Cookies and Usage Data We may use your Personal Data to contact you with newsletters, marketing or promotional materials and other information that may be of interest to you. You may opt out of receiving any, or all, of these communications from us by following the unsubscribe link. ')
          //   ],
          // ),
          const SizedBox(
            height: 22,
          )
        ]),
      ),
    );
  }
}
