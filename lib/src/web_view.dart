import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BaseWebView extends StatefulWidget {
  const BaseWebView.url(
    this.htmlUrl, {
    Key key,
    this.onWebViewCreated,
    this.isCalculateHeight = false,
    this.shouldOverrideUrlLoading,
    this.initialOptions,
    this.pullToRefreshController,
    this.initialUserScripts,
    this.contextMenu,
    this.windowId,
  })  : htmlData = null,
        htmlFile = null,
        super(key: key);

  const BaseWebView.data(
    this.htmlData, {
    Key key,
    this.onWebViewCreated,
    this.isCalculateHeight = false,
    this.shouldOverrideUrlLoading,
    this.initialOptions,
    this.pullToRefreshController,
    this.initialUserScripts,
    this.contextMenu,
    this.windowId,
  })  : htmlUrl = null,
        htmlFile = null,
        super(key: key);

  const BaseWebView.file(
    this.htmlFile, {
    Key key,
    this.onWebViewCreated,
    this.isCalculateHeight = false,
    this.shouldOverrideUrlLoading,
    this.initialOptions,
    this.pullToRefreshController,
    this.initialUserScripts,
    this.contextMenu,
    this.windowId,
  })  : htmlUrl = null,
        htmlData = null,
        super(key: key);

  /// 加载html 文件地址
  final String htmlFile;

  /// 加载html url
  final String htmlUrl;

  /// 加载html 字符串
  final String htmlData;

  /// 是否重新计算高度，当迁入页面有其他内容时 设置为 true
  final bool isCalculateHeight;

  /// 创建webView
  final ValueCallback<InAppWebViewController> onWebViewCreated;

  final Future<NavigationActionPolicy> Function(
          InAppWebViewController controller, NavigationAction navigationAction)
      shouldOverrideUrlLoading;

  /// 初始化WebView 参数
  final InAppWebViewGroupOptions initialOptions;

  final PullToRefreshController pullToRefreshController;

  final UnmodifiableListView<UserScript> initialUserScripts;

  /// 表示 WebView 上下文菜单的类。它由 WebView.contextMenu
  final ContextMenu contextMenu;

  final int windowId;

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<BaseWebView> {
  InAppWebViewGroupOptions options;

  PullToRefreshController pullToRefreshController;
  UnmodifiableListView<UserScript> initialUserScripts;

  /// 表示 WebView 上下文菜单的类。它由 WebView.contextMenu
  ContextMenu contextMenu;

  int windowId;

  /// webView高度
  double webViewHeight = deviceHeight;

  /// html 的三种加载方式
  InAppWebViewInitialData initialData;
  URLRequest initialUrlRequest;
  String initialFile;

  @override
  void initState() {
    super.initState();
    if (widget.htmlData != null)
      initialData = InAppWebViewInitialData(data: widget.htmlData);

    if (widget.htmlUrl != null)
      initialUrlRequest = URLRequest(url: Uri.parse(widget.htmlUrl));

    if (widget.htmlFile != null) initialFile = widget.htmlFile;
    pullToRefreshController = widget.pullToRefreshController;
    initialUserScripts = widget.initialUserScripts;
    contextMenu = widget.contextMenu;
    options = widget.initialOptions ??
        InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              /// 设置是否允许JavaScript在文件计划URL上下文中运行，以便访问来自其他文件计划URL的内容。默认值为 false
              /// allowFileAccessFromFileURLs:  ,
              ///
              /// 设置是否允许JavaScript在文件计划URL上下文中运行，以便访问来自任何来源的内容。默认值为 false
              /// allowUniversalAccessFromFileURLs:  ,
              ///
              /// 现有用户代理的附录。设置用户代理将覆盖此。
              /// applicationNameForUserAgent:  ,
              ///
              /// 设置WebView是否应该使用浏览器缓存。默认值为 true
              /// cacheEnabled:  ,
              ///
              /// 设置为在新的 WebView 打开之前清除浏览器的所有缓存。默认值为 false
              /// clearCache:  ,
              ///
              /// 列表是用于阻止浏览器窗口中的内容的一组规则。ContentBlocker
              /// contentBlockers:  ,
              ///
              /// 设置为禁用上下文菜单。默认值为 false
              /// disableContextMenu:  ,
              ///
              /// 设置为禁用水平滚动。默认值为 false
              /// disableHorizontalScroll:  ,
              ///
              /// 设置为禁用垂直滚动。默认值为 false
              /// disableVerticalScroll:  ,
              ///
              /// 定义是否应绘制水平滚动条。默认值为 true
              /// horizontalScrollBarEnabled:  ,
              ///
              /// 设置为以隐身模式打开浏览器窗口。默认值为 false
              /// incognito:  ,
              ///
              /// 设置为允许JavaScript在没有用户交互的情况下打开窗口。默认值为 false
              /// javaScriptCanOpenWindowsAutomatically:  ,
              ///
              /// 设置为启用 javaScript 脚本。默认值为 true
              javaScriptEnabled: true,

              ///
              /// 设置为防止HTML5音频或视频自动播放。默认值为 true
              mediaPlaybackRequiresUserGesture: true,

              /// 设置最小字体大小。默认值用于android=8 ios=0
              /// minimumFontSize:  ,
              ///
              /// 设置 WebView 在加载和渲染网页时需要使用的内容模式。默认值为 UserPreferredContentMode.RECOMMENDED
              preferredContentMode: UserPreferredContentMode.RECOMMENDED,

              ///
              /// WebView必须处理的自定义方案列表。使用该事件使用自定义方案拦截资源请求。onLoadResourceCustomScheme
              /// resourceCustomSchemes:  ,
              ///
              /// 设置为WebView是否支持使用其屏幕上的缩放控制和手势进行缩放。默认值为 true
              supportZoom: false,

              ///
              /// 设置为使 WebView 的背景透明化。如果您的应用有一个黑暗的主题，这可以防止初始化时出现白色闪光。默认值为 false
              /// transparentBackground:  ,
              ///
              /// 设置为能获得监听。默认值为 false
              /// useOnDownloadStart:  ,
              ///
              /// 设置为能获得监听。默认值为 false
              /// useOnLoadResource:  ,
              ///
              /// 设置为能获得监听。默认值为 false
              useShouldInterceptAjaxRequest: true,

              ///
              /// 设置为能获得监听。默认值为 false
              useShouldInterceptFetchRequest: true,

              ///
              /// 设置为能获得监听。默认值为 false
              useShouldOverrideUrlLoading: true,

              /// 为 WebView 设置用户代理。
              /// userAgent:  ,
              ///
              /// 定义是否应绘制垂直滚动栏。默认值为 true
              verticalScrollBarEnabled: true,
            ),
            android: AndroidInAppWebViewOptions(
              /// 启用或禁用 WebView 中的内容 URL 访问。内容 URL 访问允许 WebView
              /// 加载来自系统中安装的内容提供商的内容。默认值为 true
              allowContentAccess: true,

              ///
              /// 启用或禁用 WebView 中的文件访问。请注意，这仅启用或禁用文件系统访问。默认值为 true
              allowFileAccess: true,

              ///
              /// 设置应用程序缓存文件的路径。要启用应用程序缓存 API，必须设置此选项，以便应用程序可以编写路径。
              /// appCachePath:  ,
              ///
              /// 设置 WebView 是否从网络加载图像资源（通过 http 和 https URI 计划访问的资源）。默认值为 false
              /// blockNetworkImage: false,
              ///
              /// 设置 WebView 是否从网络加载资源。默认值为 false
              /// blockNetworkLoads:  ,
              ///
              /// 设置为WebView是否应该使用其内置的缩放机制。默认值为 true
              /// builtInZoomControls:  ,
              ///
              /// 覆盖缓存的使用方式。缓存的使用方式基于导航类型。对于正常的页面加载，将检查缓存并根据需要重新验证内容。
              /// cacheMode:  ,
              ///
              /// 设置为在新窗口打开之前清除会话cookie缓存。true
              /// clearSessionCache:  ,
              ///
              /// 设置草书字体姓氏。默认值为 "cursive"
              /// cursiveFontFamily:  ,
              ///
              /// 设置为如果您希望启用数据库存储API。默认值为 true
              /// databaseEnabled:  ,
              ///
              /// 设置默认固定字体大小。默认值为 16
              /// defaultFixedFontSize:  ,
              ///
              /// 设置默认字体大小。默认值为 16
              /// defaultFontSize:  ,
              ///
              /// 在解码html页面时设置默认文本编码名称。默认值为 "UTF-8"
              /// defaultTextEncodingName:  ,
              ///
              /// 设置是否应禁用默认的安卓错误页面。默认值为 false
              /// disableDefaultErrorPage:  ,
              ///
              /// 根据菜单网站标志禁用操作模式菜单项。
              /// disabledActionModeMenuItems:  ,
              ///
              /// 设置为使用内置缩放机制时，WebView 是否应显示屏幕上的缩放控制。默认值为 true
              /// displayZoomControls:  ,
              ///
              /// 设置为如果需要，则启用 DOM 存储 API。默认值为 true
              /// domStorageEnabled:  ,
              ///
              /// 设置幻想字体姓氏。默认值为 "fantasy"
              /// fantasyFontFamily:  ,
              ///
              /// 设置固定字体姓氏。默认值为 "monospace"
              /// fixedFontFamily:  ,
              ///
              /// 为此 WebView 设置DARK模式。默认值为 AndroidInAppWebViewForceDark.FORCE_DARK_OFF
              /// forceDark:  ,
              ///
              /// 设置是否启用地理位置 API。默认值为 true
              /// geolocationEnabled:  ,
              ///
              /// 在WebView中启用硬件加速的布尔价值。*：设置水平滚动条拇指颜色。*：设置水平滚动条轨道颜色。
              /// horizontalScrollbarThumbColor horizontalScrollbarTrackColor
              /// hardwareAcceleration:  ,
              ///
              /// 设置此 Web 视图的初始规模。0 表示默认值。默认量表的行为取决于状态和。
              /// useWideViewPort loadWithOverviewMode
              /// initialScale:  ,
              ///
              /// 设置基础布局算法。这将导致网络视图的重新布局。
              /// layoutAlgorithm:  ,
              ///
              /// 设置 WebView 是否在概述模式下加载页面，即缩小内容以适应屏幕的宽度。
              /// loadWithOverviewMode:  ,
              ///
              /// 设置 WebView 是否应该加载图像资源。请注意，此方法控制所有图像的加载，包括使用数据 URI 方案嵌入的图像。
              /// loadsImagesAutomatically:  ,
              ///
              /// 设置最小逻辑字体大小。默认值是。8
              /// minimumLogicalFontSize:  ,
              ///
              /// 当安全源试图从不安全的源加载资源时，配置 WebView 的行为。
              mixedContentMode:
                  AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,

              ///
              /// 告诉 WebView 是否需要设置节点。默认值为 true
              /// needInitialFocus:  ,
              ///
              /// 通知网络状态的 Web 视图。
              /// networkAvailable:  ,
              ///
              /// 设置此 WebView 是否应在屏幕外但连接到窗口时设置栅格磁贴。
              /// offscreenPreRaster
              /// 设置WebView的过滚动模式。默认值为 AndroidOverScrollMode.OVER_SCROLL_IF_CONTENT_SCROLLS
              /// overScrollMode:  ,
              ///
              /// 事件用于取消主帧的导航的常规表达式。如果子帧的 url 请求与常规表达式匹配，则该子帧的请求将被取消。shouldOverrideUrlLoading
              /// regexToCancelSubFramesLoading:  ,
              ///
              /// 为此 WebView 设置渲染器优先级策略。
              /// rendererPriorityPolicy:  ,
              ///
              /// 设置是否启用安全浏览。安全浏览允许 WebView 通过验证链接来防止恶意软件和网络钓鱼攻击。
              /// safeBrowsingEnabled:  ,
              ///
              /// 设置无衬线字体姓氏。默认值为 "sans-serif"
              /// sansSerifFontFamily:  ,
              ///
              /// 设置 WebView 是否应保存表单数据。在 Android O 中，该平台实现了全功能自动填充功能，以存储窗体数据。
              /// saveFormData:  ,
              ///
              /// 定义滚动栏在淡出之前等待的毫秒延迟。
              /// scrollBarDefaultDelayBeforeFade:  ,
              ///
              /// 在毫秒内定义滚动栏褪色持续时间。
              /// scrollBarFadeDuration:  ,
              ///
              /// 指定滚动栏的样式。滚动栏可以覆盖或插入。默认值为 AndroidScrollBarStyle.SCROLLBARS_INSIDE_OVERLAY
              /// scrollBarStyle:  ,
              ///
              /// 定义当视图未滚动时滚动栏是否会褪色。默认值为 true
              /// scrollbarFadingEnabled:  ,
              ///
              /// 设置衬线字体姓氏。默认值为 "sans-serif"
              /// serifFontFamily:  ,
              ///
              /// 设置标准字体姓氏。默认值为 "sans-serif"
              /// standardFontFamily:  ,
              ///
              /// 设置WebView是否支持多个窗口。
              /// supportMultipleWindows:  ,
              ///
              /// 将页面的文本缩放百分比设置为百分比。默认值为 100
              /// textZoom:  ,
              ///
              /// 布尔价值，使第三方饼干在网络视图中。
              /// thirdPartyCookiesEnabled:  ,
              ///
              ///
              /// 设置为使用Flutter的新混合组合渲染方法，它在这里解决所有问题。 请注意，此选项需要
              /// Flutter v1.20+，并且仅应在 Android 10+ 上用于发布应用程序，因为动画将删除 < Android 10 上的帧（参见混合组合#性能）
              useHybridComposition: true,

              ///
              /// 设置为能够在活动中收听。默认值为 true androidOnRenderProcessGone false
              /// useOnRenderProcessGone:  ,
              ///
              /// 设置为能够在活动中收听。默认值为 true androidShouldInterceptRequest false
              /// useShouldInterceptRequest:  ,
              ///
              /// 设置为WebView是否应启用对"视图端口"HTML元标记的支持，或应使用宽视场。true
              /// useWideViewPort:  ,
              ///
              /// 设置垂直滚动条的位置。默认值为 AndroidVerticalScrollbarPosition.SCROLLBAR_POSITION_DEFAULT
              /// verticalScrollbarPosition:  ,
              ///
              /// 设置垂直滚动条拇指颜色。
              /// verticalScrollbarThumbColor:  ,
              ///
              /// 设置垂直滚动栏跟踪颜色。
              /// verticalScrollbarTrackColor:  ,
            ),
            ios: IOSInAppWebViewOptions(
              /// 显示视图是否忽略可访问性请求以反转其颜色的布尔值。默认值为 false
              /// 与（与计划）一起使用，它代表从中读取 Web 内容的 URL。此 URL 必须是基于文件的 URL（带计划）。WebView
              /// .initialUrl file://file://
              /// accessibilityIgnoresInvertColors:,

              /// allowingReadAccessTo:  ,
              ///
              /// 设置为允许播放。默认值为 true
              allowsAirPlayForMediaPlayback: true,

              ///
              /// 设置为允许水平轻扫手势触发后进列表导航。默认值为 true
              /// allowsBackForwardNavigationGestures:  ,
              ///
              /// 设置为允许HTML5媒体播放在屏幕布局中内联显示，使用浏览器提供的控件，而不是原生控件。true
              allowsInlineMediaPlayback: true,

              ///
              /// 设置为允许在链接上按下该链接显示该链接的目的地预览。默认值为 true
              /// allowsLinkPreview:  ,
              ///
              /// 设置为允许HTML5视频播放。默认值为 true
              allowsPictureInPictureMediaPlayback: true,

              ///
              /// 当水平滚动到达内容视图的末尾时，确定弹跳是否总是发生的Boolean值。默认值为 false
              /// alwaysBounceHorizontal:  ,
              ///
              /// 当垂直滚动到达内容末尾时，确定弹跳是否总是发生的Boolean值。默认值为 false
              /// alwaysBounceVertical:  ,
              ///
              /// 设置为启用苹果支付API的WebView
              /// 在其第一页加载或下一页加载（使用）。有关详细信息，请参阅文档，并了解启用此选项的缺点。默认值为 true
              /// InAppWebViewController.setOptions=false
              /// applePayAPIEnabled:  ,
              ///
              /// 配置系统是否自动调整滚动指示器插座。默认值为 false
              /// automaticallyAdjustsScrollIndicatorInsets:  ,
              ///
              /// 配置如何将安全区域内集添加到调整后的内容集中。默认值为 IOSUIScrollViewContentInsetAdjustmentBehavior.NEVER
              /// contentInsetAdjustmentBehavior:  ,
              ///
              /// 指定数据 12 型值会增加与该值匹配的 Web 内容的交互性。
              /// dataDetectorTypes:  ,
              ///
              /// 决定用户抬起手指后减速速度的值。默认值为 IOSUIScrollViewDecelerationRateIOSUIScrollViewDecelerationRate.NORMAL
              /// decelerationRate:  ,
              ///
              /// 设置为禁用用户在 HTML 链接上发布长新闻事件时显示的上下文菜单（复制、选择等）true
              /// disableLongPressContextMenuOnLinks:  ,
              ///
              /// 设置为在滚动达到内容边缘时禁用 WebView 的弹跳。默认值为 true
              /// disallowOverScroll:  ,
              ///
              /// 设置为允许视图端口元标记禁用或限制用户缩放范围。默认值为 true
              /// enableViewportScale:  ,
              ///
              /// 设置为，如果你想，WebView应始终允许缩放网页，无论作者的意图。true
              /// ignoresViewportScaleLimits:  ,
              ///
              /// 显示是否应针对可疑欺诈内容（如网络钓鱼或恶意软件）显示警告
              /// isFraudulentWebsiteWarningEnabled:  ,
              ///
              /// 确定是否为滚动视图启用寻呼的布尔值。默认值为 false
              /// isPagingEnabled:  ,
              ///
              /// 决定滚动是否在特定方向禁用的布尔值。默认值为 false
              /// isDirectionalLockEnabled:  ,
              ///
              /// 显示 Web 视图是否将导航限制在应用域内的页面。默认值为 false
              /// limitsNavigationsToAppBoundDomains:  ,
              ///
              /// 指定可应用于滚动视图内容的最大比例因子的浮点值。默认值为 1.0
              /// maximumZoomScale:  ,
              ///
              /// 网络视图内容的媒体类型。默认值为 null
              /// mediaType:  ,
              ///
              /// 指定可应用于滚动视图内容的最小刻度因子的浮点值。默认值为 1.0
              /// minimumZoomScale:  ,
              ///
              /// 视图相对于其边界缩放内容的规模因子。默认值为 1.0
              /// pageZoom:  ,
              ///
              /// 控制是否启用滚动到顶部手势的布尔值。默认值为 true
              /// scrollsToTop:  ,
              ///
              /// 用户可以在 Web 视图中以交互式选择内容的粒度水平。
              /// selectionGranularity:  ,
              ///
              /// 设置如果共享的cookie应该用于WebView中的每一个负载请求。trueHTTPCookieStorage.shared
              /// sharedCookiesEnabled:  ,
              ///
              /// 设置为"如果你想要WebView"，它会抑制内容渲染，直到它完全加载到内存中。默认值为 true
              /// suppressesIncrementalRendering:  ,
              ///
              /// 设置为能够收听事件。默认值为 true ,iosOnNavigationResponse=false
              /// useOnNavigationResponse:  ,
              ///
            ));
  }

  @override
  Widget build(BuildContext context) {
    final InAppWebView webView = InAppWebView(
        windowId: windowId,
        initialFile: initialFile,
        initialData: initialData,
        initialUserScripts: initialUserScripts,
        initialUrlRequest: initialUrlRequest,
        initialOptions: options,
        pullToRefreshController: pullToRefreshController,
        contextMenu: contextMenu,
        onWebViewCreated:
            widget.onWebViewCreated ?? (InAppWebViewController controller) {},
        onLoadStart: (InAppWebViewController controller, Uri url) {
          /// WebView 开始加载
          log('开始加载的url=> ' + widget.htmlUrl);
        },
        onLoadStop: (InAppWebViewController controller, Uri url) async {
          /// WebView 加载完成
          if (widget.isCalculateHeight) {
            final int y = await controller.getContentHeight();
            webViewHeight = y.toDouble();
            setState(() {});
          }
        },
        onLoadError: (InAppWebViewController controller, Uri url, int code,
            String message) {
          /// WebView 加载失败
        },
        onLoadHttpError: (InAppWebViewController controller, Uri url, int code,
            String message) {
          /// 当InAppWebView主页收到HTTP错误时，事件被激发。
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
          /// 加载页面的当前进度
        },
        onConsoleMessage:
            (InAppWebViewController controller, ConsoleMessage consoleMessage) {
          /// 收到控制台信息时
          // log('WebView收到控制台信息=>' + consoleMessage.message);
        },
        shouldOverrideUrlLoading: widget.shouldOverrideUrlLoading ??
            (InAppWebViewController controller,
                NavigationAction navigationAction) async {
              /// 当网址即将在当前 WebView 中加载时，给主机应用程序一个控制的机会（要使用此事件，选项必须是）。此事件在 WebView
              /// 的初始负载上不调用。useShouldOverrideUrlLoading=true
              final String uri = navigationAction.request.url.toString();
              log('shouldOverrideUrlLoading==' + uri);

              /// 通过uri 实现交互
              /// if (uri.startsWith('js://webView')) {
              ///
              ///   return NavigationActionPolicy.CANCEL;
              /// }
              return NavigationActionPolicy.ALLOW;
            },
        onUpdateVisitedHistory:
            (InAppWebViewController controller, Uri url, bool androidIsReload) {
          /// 当主机应用程序更新其访问链接数据库时，事件被激发。当 InAppWebView 的导航状
          /// 态发生变化时，例如通过使用 javascript历史 API功能，也会激发此事件
        },
        onLoadResource:
            (InAppWebViewController controller, LoadedResource resource) {
          /// 当 InAppWebView 加载资源时（要使用此事件，选项必须是）时，事件就会被激发。
          /// useOnLoadResource=true
        },
        onScrollChanged: (InAppWebViewController controller, int x, int y) {
          /// 当 InAppWebView 滚动时，事件已激发。
        },
        onDownloadStart: (InAppWebViewController controller, Uri url) {
          /// 当 InAppWebView 识别可下载文件时（要使用此事件，选项必须是）时，事件就会被
          /// 激发。要下载该文件
        },
        onLoadResourceCustomScheme:
            (InAppWebViewController controller, Uri url) async {
          /// 当 InAppWebView 在加载资源时发现时，事件被激发。在这里，您可以处理网址请求
          /// 并返回自定义化学响应以加载编码到的特定资源。custom-schemebase64
          return null;
        },
        onCreateWindow: (InAppWebViewController controller,
            CreateWindowAction createWindowAction) async {
          /// 当 InAppWebView 请求主机应用程序创建新窗口时（例如，尝试打开与 JavaScript
          /// 侧的链接或何时调用链接时）时，事件被激发。target="_blank"window.open()
          /// log('onCreateWindow');
          return true;
        },
        onCloseWindow: (InAppWebViewController controller) {
          /// 主机应用程序应关闭给定的 WebView 并在必要时将其从视图系统中删除时，事件被激发。
        },
        onJsAlert:
            (InAppWebViewController controller, JsAlertRequest jsAlertRequest) {
          /// 当javascript调用显示警报对话的方法时，事件被激发。alert()
          return null;
        },
        onJsConfirm: (InAppWebViewController controller,
            JsConfirmRequest jsConfirmRequest) {
          /// 当javascript调用显示确认对话的方法时，事件被激发。confirm()
          return null;
        },
        onJsPrompt: (InAppWebViewController controller,
            JsPromptRequest jsPromptRequest) {
          /// 当javascript调用显示提示对话的方法时，事件被激发。prompt()
          return null;
        },
        onReceivedHttpAuthRequest: (InAppWebViewController controller,
            URLAuthenticationChallenge challenge) {
          /// 当 WebView 收到 HTTP 身份验证请求时，事件被激发。默认行为是取消请求。
          return null;
        },
        onReceivedServerTrustAuthRequest: (InAppWebViewController controller,
            URLAuthenticationChallenge challenge) {
          /// 当WebView需要执行服务器信任认证（证书验证）时启动的事件。
          return null;
        },
        onReceivedClientCertRequest: (InAppWebViewController controller,
            URLAuthenticationChallenge challenge) {
          /// 通知主机申请以处理 SSL 客户端证书请求。
          return null;
        },
        onFindResultReceived: (InAppWebViewController controller,
            int activeMatchOrdinal, int numberOfMatches, bool isDoneCounting) {
          /// 随着页面查找操作进度而激发的事件
          return null;
        },
        shouldInterceptAjaxRequest:
            (InAppWebViewController controller, AjaxRequest ajaxRequest) {
          /// 事件被发送到服务器时（要使用此事件，选项必须是）。
          return null;
        },
        onAjaxReadyStateChange:
            (InAppWebViewController controller, AjaxRequest ajaxRequest) {
          /// 每当更改属性时（要使用此事件，选项必须是）时，事件就会被激发。readyState
          /// XMLHttpRequest useShouldInterceptAjaxRequest=true
          return null;
        },
        onAjaxProgress:
            (InAppWebViewController controller, AjaxRequest ajaxRequest) {
          /// 事件发射作为一个进度（要使用此事件，选项必须是）。
          return null;
        },
        shouldInterceptFetchRequest:
            (InAppWebViewController controller, FetchRequest fetchRequest) {
          /// 当请求通过获取API发送到服务器时（要使用此事件，选项必须是）时，事件被激发。
          /// useShouldInterceptFetchRequest=true
          /// log('shouldInterceptFetchRequest');
          return null;
        },
        onPrint: (InAppWebViewController controller, Uri url) {
          /// 从JavaScript调用时的事件。window.print()
          /// log('从JavaScript调用时的事件');
        },
        onLongPressHitTestResult: (InAppWebViewController controller,
            InAppWebViewHitTestResult hitTestResult) {
          /// 当网络视图的 HTML 元素被单击并保持时，事件被激发。
        },
        onEnterFullscreen: (InAppWebViewController controller) {
          /// 当前页面已进入全屏模式时，事件已激发。
        },
        onExitFullscreen: (InAppWebViewController controller) {
          /// 当前页面已退出全屏模式时，事件已激发。
        },
        onPageCommitVisible: (InAppWebViewController controller, Uri url) {
          /// 当 Web 视图开始接收 Web 内容时调用。
        },
        onTitleChanged: (InAppWebViewController controller, String title) {
          /// 当文档标题发生更改时，事件被激发。
        },
        onWindowFocus: (InAppWebViewController controller) {
          /// 当 WebView 的 JavaScript 对象获得焦点时， 事件被激发。
          /// log(' JavaScript 对象获得焦点');
        },
        onWindowBlur: (InAppWebViewController controller) {
          /// 当 WebView 的 JavaScript 对象失去焦点时， 事件被激发。
          /// log(' JavaScript 对象失去焦点时');
        },
        androidOnSafeBrowsingHit: (InAppWebViewController controller, Uri url,
            SafeBrowsingThreat threatType) {
          /// 当 WebView 通知加载的 URL 已通过安全浏览标记时（仅在 Android 上可用），则事件被激发。
          return null;
        },
        androidOnPermissionRequest: (InAppWebViewController controller,
            String origin, List<String> resources) {
          /// 当 WebView 请求访问指定资源的权限且当前未授予或拒绝权限时（仅在 Android 上可用）时，事件被激发。
          return null;
        },
        androidOnGeolocationPermissionsShowPrompt:
            (InAppWebViewController controller, String origin) {
          /// 通知主机应用程序来自指定来源的 Web 内容正在尝试使用 Geolocation API 的事件，
          /// 但当前未为该源设置任何权限状态（仅在 Android 上可用）。
          return null;
        },
        androidOnGeolocationPermissionsHidePrompt:
            (InAppWebViewController controller) {
          /// 通知主机应用程序，使用之前呼叫的地理定位权限请求已被取消（仅在 Android 上提供）
          /// androidOnGeolocationPermissionsShowPrompt
        },
        androidShouldInterceptRequest:
            (InAppWebViewController controller, WebResourceRequest request) {
          /// 通知资源请求的主机应用程序，并允许应用程序返回数据（仅在 Android 上可用）。
          /// 要使用此事件，选项必须是。useShouldInterceptRequest=true
          return null;
        },
        androidOnRenderProcessGone: (InAppWebViewController controller,
            RenderProcessGoneDetail detail) {
          /// 当给定 WebView 的渲染过程退出时（仅在 Android 上可用）时，事件被激发。
        },
        androidOnRenderProcessResponsive:
            (InAppWebViewController controller, Uri url) {
          /// 当前与 WebView 关联的无响应渲染器响应（仅在 Android 上可用）时，称为一次事件。
          return null;
        },
        androidOnRenderProcessUnresponsive:
            (InAppWebViewController controller, Uri url) {
          /// 当前与 WebView 关联的渲染器由于长期运行的阻止任务（如执行 JavaScript）
          /// （仅在 Android 上可用）而无响应时调用的事件。
          return null;
        },
        androidOnFormResubmission:
            (InAppWebViewController controller, Uri url) {
          /// 作为主机应用程序，如果浏览器应该重新发送数据，因为请求的页面是POST的结果。
          /// 默认情况下是不要重新发送数据（仅在安卓系统上提供）。
          return null;
        },
        androidOnScaleChanged: (InAppWebViewController controller,
            double oldScale, double newScale) {
          /// 当应用于 WebView 的刻度发生更改时，事件被激发（仅在 Android 上可用）。
        },
        androidOnReceivedIcon:
            (InAppWebViewController controller, Uint8List icon) {
          /// 当前页面有新的法维肯时（仅在Android上可用）时，事件就会被激发。
        },
        androidOnReceivedTouchIconUrl:
            (InAppWebViewController controller, Uri url, bool precomposed) {
          /// 当有一个苹果触摸图标的网址时（仅在Android上可用）时，事件就会被激发。
        },
        androidOnJsBeforeUnload: (InAppWebViewController controller,
            JsBeforeUnloadRequest jsBeforeUnloadRequest) {
          /// 当客户端应显示对话框以确认导航远离当前页面时，事件被激发。这是 javascript
          /// 事件的结果（仅在安卓系统上提供）
          return null;
        },
        androidOnReceivedLoginRequest:
            (InAppWebViewController controller, LoginRequest loginRequest) {
          /// 处理自动登录用户的请求时（仅在 Android 上可用）时，事件被激发。
        },
        iosOnWebContentProcessDidTerminate: (InAppWebViewController controller) {
          /// 当Web视图的Web内容进程终止时（仅在iOS上可用）。
        },
        iosOnDidReceiveServerRedirectForProvisionalNavigation: (InAppWebViewController controller) {
          /// /当 Web 视图收到服务器重定向时调用（仅在 iOS 上可用）。
        },
        iosOnNavigationResponse: (InAppWebViewController controller, IOSWKNavigationResponse navigationResponse) {
          /// 当网络视图在已知对导航请求的响应（仅在 iOS 上可用）后请求导航到新内容的权限时，
          /// 请致电。要使用此事件，必须是针对 iOS 的选项
          return null;
        },
        iosShouldAllowDeprecatedTLS: (InAppWebViewController controller, URLAuthenticationChallenge challenge) {
          /// 当 Web 视图询问是否继续使用废弃版本的 TLS（v1.0 和 v1.1）的连接时调用（仅在 iOS 上可用）
          return null;
        });
    if (!widget.isCalculateHeight) return webView;
    return SizedBox(
        height: webViewHeight, width: double.infinity, child: webView);
  }
}
