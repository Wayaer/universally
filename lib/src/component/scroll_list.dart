import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BaseMaterialHeader extends MaterialHeader {
  BaseMaterialHeader({Color? color})
    : super(
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Universally.get.getTheme()?.primaryColor ?? Colors.transparent,
        ),
        backgroundColor: UCS.transparent,
      );
}

/// 带下拉刷新 / 上拉加载的列表组件
class BaseList extends FlScrollListGrid {
  /// 大量数据时使用，按需构建子项
  BaseList({
    super.key,
    required super.itemBuilder,
    super.itemCount,
    EasyRefreshController? refreshController,
    Widget? placeholder,
    Widget? header,
    Widget? footer,
    FlEasyRefreshCallback? onRefresh,
    FlEasyRefreshCallback? onLoad,
    super.reverse,
    super.shrinkWrap,
    super.noScrollBehavior,
    super.primary,
    super.scrollDirection,
    super.clipBehavior,
    super.dragStartBehavior,
    super.restorationId,
    super.cacheExtent,
    super.physics,
    super.padding,
    super.controller,
    super.findChildIndexCallback,
    super.addRepaintBoundaries,
    super.addSemanticIndexes,
    ListGridLayout? layout,
    super.separatorBuilder,
    super.placeholderFill,
    double? itemExtent,
    Widget? prototypeItem,
    FlEasyRefreshConfig? refreshConfig,
  }) : super.builder(
         header: header?.toSliverBox,
         footer: footer?.toSliverBox,
         refreshConfig: builderRefreshConfig(
           refreshConfig: refreshConfig,
           controller: refreshController,
           onRefresh: onRefresh,
           onLoad: onLoad,
         ),
         placeholder: placeholder ?? Universally.get.config.placeholder,
         layout: layout ?? ListGridLayout.list(itemExtent: itemExtent, prototypeItem: prototypeItem),
       );

  /// 少量数据时使用，直接传入子组件列表
  BaseList.count({
    super.key,
    required super.children,
    EasyRefreshController? refreshController,
    Widget? placeholder,
    Widget? header,
    Widget? footer,
    FlEasyRefreshCallback? onRefresh,
    FlEasyRefreshCallback? onLoad,
    super.reverse,
    super.shrinkWrap,
    super.noScrollBehavior,
    super.primary,
    super.scrollDirection,
    super.clipBehavior,
    super.dragStartBehavior,
    super.restorationId,
    super.cacheExtent,
    super.physics,
    super.padding,
    super.controller,
    super.addRepaintBoundaries,
    super.addSemanticIndexes,
    ListGridLayout? layout,
    super.placeholderFill,
    double? itemExtent,
    Widget? prototypeItem,
    FlEasyRefreshConfig? refreshConfig,
  }) : super.count(
         header: header?.toSliverBox,
         footer: footer?.toSliverBox,
         refreshConfig: builderRefreshConfig(
           refreshConfig: refreshConfig,
           controller: refreshController,
           onRefresh: onRefresh,
           onLoad: onLoad,
         ),
         placeholder: placeholder ?? Universally.get.config.placeholder,
         layout: layout ?? ListGridLayout.list(itemExtent: itemExtent, prototypeItem: prototypeItem),
       );

  /// 瀑布流
  BaseList.waterfall({
    super.key,
    required super.itemBuilder,
    required int super.itemCount,
    EasyRefreshController? refreshController,
    Widget? placeholder,
    Widget? header,
    Widget? footer,
    FlEasyRefreshCallback? onRefresh,
    FlEasyRefreshCallback? onLoad,
    int crossAxisCount = 2,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    double? maxCrossAxisExtent,
    super.reverse,
    super.shrinkWrap,
    super.noScrollBehavior,
    super.primary,
    super.scrollDirection,
    super.clipBehavior,
    super.dragStartBehavior,
    super.restorationId,
    super.cacheExtent,
    super.physics,
    super.padding,
    super.controller,
    super.findChildIndexCallback,
    super.addRepaintBoundaries,
    super.addSemanticIndexes,
    super.placeholderFill,
    FlEasyRefreshConfig? refreshConfig,
  }) : super.builder(
         header: header?.toSliverBox,
         footer: footer?.toSliverBox,
         refreshConfig: builderRefreshConfig(
           refreshConfig: refreshConfig,
           controller: refreshController,
           onRefresh: onRefresh,
           onLoad: onLoad,
         ),
         placeholder: placeholder ?? Universally.get.config.placeholder,
         layout: ListGridLayout.masonry(
           crossAxisCount: crossAxisCount,
           maxCrossAxisExtent: maxCrossAxisExtent,
           mainAxisSpacing: mainAxisSpacing,
           crossAxisSpacing: crossAxisSpacing,
         ),
       );

  /// 自行组合多个 sliver
  BaseList.custom({
    super.key,
    required super.sliver,
    EasyRefreshController? refreshController,
    Widget? header,
    Widget? footer,
    FlEasyRefreshCallback? onRefresh,
    FlEasyRefreshCallback? onLoad,
    super.reverse,
    super.shrinkWrap,
    super.noScrollBehavior,
    super.primary,
    super.scrollDirection,
    super.clipBehavior,
    super.dragStartBehavior,
    super.restorationId,
    super.cacheExtent,
    super.physics,
    super.padding,
    super.controller,
    FlEasyRefreshConfig? refreshConfig,
  }) : super(
         header: header?.toSliverBox,
         footer: footer?.toSliverBox,
         refreshConfig: builderRefreshConfig(
           refreshConfig: refreshConfig,
           controller: refreshController,
           onRefresh: onRefresh,
           onLoad: onLoad,
         ),
       );

  /// 构建刷新配置
  static FlEasyRefreshConfig? builderRefreshConfig({
    FlEasyRefreshConfig? refreshConfig,
    EasyRefreshController? controller,
    FlEasyRefreshCallback? onRefresh,
    FlEasyRefreshCallback? onLoad,
  }) {
    if (refreshConfig == null && controller == null && (onRefresh == null && onLoad == null)) return null;
    return (refreshConfig ?? const FlEasyRefreshConfig()).copyWith(
      controller: controller,
      onRefresh: onRefresh,
      onLoad: onLoad,
    );
  }
}
