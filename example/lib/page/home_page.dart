import 'package:app/page/action_sheet_page.dart';
import 'package:app/page/animation_counter_page.dart';
import 'package:app/page/app_page.dart';
import 'package:app/page/bubble_button_page.dart';
import 'package:app/page/button_page.dart';
import 'package:app/page/date_picker_page.dart';
import 'package:app/page/dialog_page.dart';
import 'package:app/page/dio_page.dart';
import 'package:app/page/dotted_line_page.dart';
import 'package:app/page/elastic_page.dart';
import 'package:app/page/feedback_page.dart';
import 'package:app/page/flip_card_page.dart';
import 'package:app/page/gif_page.dart';
import 'package:app/page/icon_page.dart';
import 'package:app/page/image_page.dart';
import 'package:app/page/list_page.dart';
import 'package:app/page/multi_picker_page.dart';
import 'package:app/page/overlay_page.dart';
import 'package:app/page/page_view_page.dart';
import 'package:app/page/picker_page.dart';
import 'package:app/page/plugin/plugin_page.dart';
import 'package:app/page/preview_image_page.dart';
import 'package:app/page/privacy_page.dart';
import 'package:app/page/progress_page.dart';
import 'package:app/page/scaffold_page.dart';
import 'package:app/page/shimmery_page.dart';
import 'package:app/page/spinkit_page.dart';
import 'package:app/page/state_page.dart';
import 'package:app/page/style_page.dart';
import 'package:app/page/svg_page.dart';
import 'package:app/page/tab_page.dart';
import 'package:app/page/text_field_page.dart';
import 'package:app/page/text_page.dart';
import 'package:app/page/toast_page.dart';
import 'package:app/page/toggle_rotate_page.dart';
import 'package:app/page/universal_page.dart';
import 'package:app/page/utils_page.dart';
import 'package:app/page/wrapper_page.dart';
import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  String keyword = '';

  List<DemoGroup> get groups => [
    DemoGroup(
      title: '基础组件',
      description: '容器、文本、输入、按钮与状态类基础组件。',
      entries: [
        DemoEntry(
          'Universal 布局容器',
          Icons.dashboard_customize,
          'Container / Row / Column / Stack / Wrap',
          UniversalPage.new,
          '通用 容器 布局',
        ),
        DemoEntry('Text 文本', Icons.text_fields, 'BaseText / TextLarge / TStyle', TextPage.new, '文字 文本'),
        DemoEntry('TextField 输入框', Icons.input, '清除、密码、验证码、搜索、前后缀', TextFieldPage.new, '输入 表单'),
        DemoEntry('FlButton 按钮', Icons.smart_button, '五种类型、图标、禁用', ButtonPage.new, '按钮 点击'),
        DemoEntry('FlIcon 图标', Icons.emoji_symbols, 'IconData / SVG / 图片', IconPage.new, '图标 svg'),
        DemoEntry(
          '开关 / 复选 / 滑块',
          Icons.toggle_on,
          'BaseFlSwitch / BaseCheckbox / BaseSlider',
          StatePage.new,
          '开关 复选 滑块 缓存',
        ),
        DemoEntry(
          '占位与加载',
          Icons.hourglass_empty,
          'BaseError / BasePlaceholder / BaseLoading',
          FeedbackPage.new,
          '占位 加载 分割线 间距',
        ),
        DemoEntry('颜色 / 阴影 / 形状', Icons.palette, 'UIS / UCS / UStyle / BubbleShape', StylePage.new, '颜色 阴影 气泡 尖角'),
      ],
    ),
    DemoGroup(
      title: '布局与列表',
      description: '页面骨架、标签页、轮播与列表。',
      entries: [
        DemoEntry('BaseScaffold', Icons.web_asset, 'AppBar / Drawer / FAB / 底部导航', ScaffoldPage.new, '页面 骨架 scaffold'),
        DemoEntry('TabBar 与 TabPage', Icons.tab, 'BaseTabBar / TabPage / CustomTabBar', TabPagePage.new, '标签 tab'),
        DemoEntry('BasePageView 轮播', Icons.view_carousel, '自动轮播 / 无限循环 / 指示器', PageViewPage.new, '轮播 pageview'),
        DemoEntry('BaseList 列表', Icons.view_list, '下拉刷新 / 上拉加载 / 瀑布流', ListPage.new, '列表 list'),
      ],
    ),
    DemoGroup(
      title: '交互与弹层',
      description: '选择器、弹窗、Toast、进度与动画。',
      entries: [
        DemoEntry('列表选择器', Icons.list_alt, 'FlListWheel / 单列滚轮 / 列表选择', PickerPage.new, '选择器 picker 滚轮'),
        DemoEntry('多列与自定义选择器', Icons.linear_scale, '多列滚轮 / 联动 / 自定义内容', MultiPickerPage.new, '选择器 picker 联动'),
        DemoEntry(
          '日期与时间选择',
          Icons.calendar_month,
          'FlDatePicker / FlDateTimePicker',
          DatePickerPage.new,
          '日期 时间 picker',
        ),
        DemoEntry('ActionSheet', Icons.vertical_split, 'BaseCupertinoActionSheet', ActionSheetPage.new, '底部 操作 弹层'),
        DemoEntry('Dialog 弹窗', Icons.chat_bubble_outline, '确认 / 输入 / 自定义弹窗', DialogPage.new, '弹窗 dialog'),
        DemoEntry(
          'Toast 与 Loading',
          Icons.notifications_active,
          'Toast 样式 / 全局 Loading',
          ToastPage.new,
          '提示 toast loading',
        ),
        DemoEntry('底部弹层与 Overlay', Icons.layers, 'ModalBottomSheet / Overlay', OverlayPage.new, '弹层 overlay sheet'),
        DemoEntry('进度条', Icons.donut_large, '线性 / 环形 / 动画进度', ProgressPage.new, '进度 progress'),
        DemoEntry('骨架屏', Icons.blur_on, 'FlShimmery 扫光动画', ShimmeryPage.new, '骨架 加载 shimmery'),
        DemoEntry('SpinKit 加载动画', Icons.rotate_right, '全部加载动画样式', SpinKitPage.new, '加载 动画 spinkit'),
      ],
    ),
    DemoGroup(
      title: '动画与图形',
      description: '数字滚动、按压反馈、翻转等轻量动画与图片媒体。',
      entries: [
        DemoEntry('数字滚动', Icons.numbers, 'FlAnimationCounter', AnimationCounterPage.new, '动画 数字 counter'),
        DemoEntry('气泡按钮', Icons.bubble_chart, 'FlBubbleButton', BubbleButtonPage.new, '动画 气泡 bubble'),
        DemoEntry('弹性按压', Icons.touch_app, 'FlElasticBuilder', ElasticPage.new, '动画 按压 elastic'),
        DemoEntry('翻转卡片', Icons.flip, 'FlFlipCard', FlipCardPage.new, '动画 翻转 flip'),
        DemoEntry('旋转图标', Icons.sync, 'FlToggleRotate', ToggleRotatePage.new, '动画 旋转 rotate'),
        DemoEntry('尖角容器', Icons.chat, 'FlWrapper', WrapperPage.new, '动画 尖角 wrapper'),
        DemoEntry('虚线边框', Icons.border_style, 'FlDottedLineBorder', DottedLinePage.new, '图形 虚线 dotted'),
        DemoEntry('BaseImage 图片', Icons.image, '圆角 / 边框 / 填充模式', ImagePage.new, '图片 image'),
        DemoEntry('图片预览', Icons.zoom_in, 'PreviewImage 全屏预览', PreviewImagePage.new, '图片 预览 preview'),
        DemoEntry('SVG 图标', Icons.polyline, 'SVGAsset / SVGNetwork', SvgPage.new, '图标 svg'),
        DemoEntry('Gif 动图', Icons.gif_box, '循环 / 单次 / 动态切换', GifPage.new, '动图 gif'),
      ],
    ),
    DemoGroup(
      title: '数据、配置与插件',
      description: '网络请求、工具方法、全局配置与原生插件。',
      entries: [
        DemoEntry('网络请求', Icons.cloud, 'BaseDio / 请求方法 / 上传下载', DioPage.new, '网络 dio 请求'),
        DemoEntry('工具与扩展', Icons.build, 'FutureCancelable / TaskQueue / Decimal', UtilsPage.new, '工具 utils'),
        DemoEntry('App 与全局配置', Icons.settings_applications, 'BaseApp / UConfig / 窗口尺寸', AppPage.new, '应用 配置 app'),
        DemoEntry('隐私协议', Icons.privacy_tip, 'UserPrivacyDialog / 勾选组件', PrivacyPage.new, '隐私 privacy'),
        DemoEntry('原生插件', Icons.extension, '权限 / 设备信息 / 存储 / 网络', PluginPage.new, '插件 plugin 权限'),
      ],
    ),
  ];

  List<DemoGroup> get filteredGroups {
    if (keyword.isEmpty) return groups;
    return groups
        .map(
          (DemoGroup group) => DemoGroup(
            title: group.title,
            description: group.description,
            entries: group.entries
                .where(
                  (DemoEntry entry) =>
                      entry.title.toLowerCase().contains(keyword) ||
                      entry.description.toLowerCase().contains(keyword) ||
                      entry.keywords.toLowerCase().contains(keyword),
                )
                .toList(),
          ),
        )
        .where((DemoGroup group) => group.entries.isNotEmpty)
        .toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String version = PackageInfoPlus().version;
    return DemoScaffold(
      title: 'Universally',
      children: [
        Universal(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.theme.primaryColor.withValues(alpha: 0.18),
                context.theme.colorScheme.secondaryContainer.withValues(alpha: 0.35),
              ],
            ),
          ),
          child: Column(
            children: [
              SVGAsset('assets/universally.svg', size: 64),
              const SizedBox(height: 12),
              TextLarge('Universally 版本号', fontWeight: FontWeight.bold),
              const SizedBox(height: 6),
              TextSmall('v$version', color: context.theme.hintColor),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: searchController,
          onChanged: (String value) => setState(() => keyword = value.trim().toLowerCase()),
          decoration: InputDecoration(
            hintText: '搜索组件、能力或关键字',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: keyword.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      searchController.clear();
                      setState(() => keyword = '');
                    },
                    icon: const Icon(Icons.clear),
                  ),
            filled: true,
            fillColor: context.theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 8),
        if (filteredGroups.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: TextSmall('没有找到相关组件', textAlign: TextAlign.center, color: context.theme.hintColor),
          )
        else
          for (final DemoGroup group in filteredGroups) _DemoGroupCard(group: group),
      ],
    );
  }
}

class _DemoGroupCard extends StatelessWidget {
  const _DemoGroupCard({required this.group});

  final DemoGroup group;

  @override
  Widget build(BuildContext context) => DemoSection(
    title: group.title,
    description: group.description,
    children: [
      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double itemWidth = constraints.maxWidth > 520 ? (constraints.maxWidth - 12) / 2 : constraints.maxWidth;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final DemoEntry entry in group.entries)
                SizedBox(
                  width: itemWidth,
                  child: _DemoEntryCard(entry: entry),
                ),
            ],
          );
        },
      ),
    ],
  );
}

class _DemoEntryCard extends StatelessWidget {
  const _DemoEntryCard({required this.entry});

  final DemoEntry entry;

  @override
  Widget build(BuildContext context) => Universal(
    onTap: () => push(entry.builder()),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: context.theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: context.theme.dividerColor.withValues(alpha: 0.5)),
    ),
    child: Row(
      children: [
        Universal(
          width: 40,
          height: 40,
          isOval: true,
          color: context.theme.primaryColor.withValues(alpha: 0.12),
          alignment: Alignment.center,
          child: Icon(entry.icon, color: context.theme.primaryColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextMedium(entry.title, fontWeight: FontWeight.w600),
              const SizedBox(height: 4),
              TextSmall(entry.description, maxLines: 2, color: context.theme.hintColor, height: 1.3),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Icon(Icons.chevron_right, color: context.theme.hintColor, size: 20),
      ],
    ),
  );
}

class DemoEntry {
  const DemoEntry(this.title, this.icon, this.description, this.builder, this.keywords);

  final String title;
  final IconData icon;
  final String description;
  final Widget Function() builder;
  final String keywords;
}

class DemoGroup {
  const DemoGroup({required this.title, required this.description, required this.entries});

  final String title;
  final String description;
  final List<DemoEntry> entries;
}
