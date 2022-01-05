// import 'package:fl_webview/fl_webview.dart';
// import 'package:flutter/material.dart';
// import 'package:universally/universally.dart';
//
// class BaseWebView extends StatefulWidget {
//   const BaseWebView.url(this.htmlUrl,
//       {Key? key,
//       this.isCalculateHeight = false,
//       this.javascriptChannel,
//       this.navigationDelegate,
//       this.onWebViewCreated,
//       this.onPageFinished,
//       this.onScrollChanged,
//       this.onContentSizeChanged})
//       : super(key: key);
//
//   /// 加载html url
//   final String htmlUrl;
//
//   /// 是否重新计算高度，当迁入页面有其他内容时 设置为 true
//   /// Whether to recalculate the height, set to true if the migration page has other content
//   final bool isCalculateHeight;
//
//   final List<JavascriptChannel>? javascriptChannel;
//   final NavigationDelegate? navigationDelegate;
//   final WebViewCreatedCallback? onWebViewCreated;
//   final WebViewCreatedCallback? onPageFinished;
//   final ScrollChangedCallback? onScrollChanged;
//   final ContentSizeCallback? onContentSizeChanged;
//
//   @override
//   _BaseWebViewState createState() => _BaseWebViewState();
// }
//
// class _BaseWebViewState extends State<BaseWebView> {
//   WebViewController? controller;
//   ValueNotifier<int> currentProgress = ValueNotifier<int>(0);
//
//   JavascriptMode get javascriptMode {
//     return JavascriptMode.unrestricted;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget current = widget.isCalculateHeight
//         ? FlAdaptHeightWevView(
//             initialSize: Size(double.infinity, deviceHeight / 3),
//             builder: (ContentSizeCallback onContentSizeChanged,
//                     ScrollChangedCallback onScrollChanged) =>
//                 webView(
//                     onContentSizeChanged: onContentSizeChanged,
//                     onScrollChanged: onScrollChanged))
//         : webView();
//     current = Column(mainAxisSize: MainAxisSize.min, children: [
//       ValueListenableBuilder(
//           valueListenable: currentProgress,
//           builder: (_, int value, __) {
//             return value == 100
//                 ? const SizedBox()
//                 : Container(
//                     width: deviceWidth,
//                     height: 2,
//                     color: UCS.background,
//                     alignment: Alignment.centerLeft,
//                     child: value == 0
//                         ? null
//                         : Container(
//                             height: 2,
//                             color: currentColor,
//                             width: deviceWidth * value / 100));
//           }),
//       if (widget.isCalculateHeight) current else current.expandedNull
//     ]);
//     return current;
//   }
//
//   Widget webView(
//           {ContentSizeCallback? onContentSizeChanged,
//           ScrollChangedCallback? onScrollChanged}) =>
//       FlWebView(
//           debuggingEnabled: false,
//           javascriptMode: javascriptMode,
//           initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.alwaysAllow,
//           onWebViewCreated: (WebViewController webViewController) async {
//             controller = webViewController;
//             if (widget.onWebViewCreated != null) {
//               widget.onWebViewCreated!(webViewController);
//             }
//           },
//           onPageStarted: (String url) {},
//           onContentSizeChanged: (Size size) {
//             if (onContentSizeChanged != null) {
//               onContentSizeChanged(size);
//             }
//             if (widget.onContentSizeChanged != null) {
//               widget.onContentSizeChanged!(size);
//             }
//           },
//           onScrollChanged: (Size frameSize, Size contentSize, Offset offset,
//               ScrollPositioned positioned) {
//             if (onScrollChanged != null) {
//               onScrollChanged(frameSize, contentSize, offset, positioned);
//             }
//             if (widget.onScrollChanged != null) {
//               widget.onScrollChanged!(
//                   frameSize, contentSize, offset, positioned);
//             }
//           },
//           onProgress: (int progress) async {
//             if (progress == currentProgress.value) return;
//             if (progress == 100) {
//               currentProgress.value = 98;
//               await 800.milliseconds.delayed(() {});
//             }
//             currentProgress.value = progress;
//           },
//           onPageFinished: (String url) {
//             if (widget.onPageFinished != null) {
//               widget.onPageFinished!(controller!);
//             }
//           },
//           onWebResourceError: (WebResourceError error) {
//             log('onWebResourceError domain = ${error.domain}');
//             // log('onWebResourceError description = ${error.description}');
//           },
//           gestureNavigationEnabled: false,
//           allowsInlineMediaPlayback: true,
//           javascriptChannels: widget.javascriptChannel?.toSet(),
//           initialUrl: widget.htmlUrl,
//           navigationDelegate: widget.navigationDelegate ??
//               (NavigationRequest navigation) async {
//                 return NavigationDecision.navigate;
//               });
//
//   @override
//   void dispose() {
//     super.dispose();
//     currentProgress.dispose();
//   }
// }
