import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BasicMaterialHeader extends MaterialHeader {
  BasicMaterialHeader({Color? color})
      : super(
            valueColor:
                AlwaysStoppedAnimation<Color>(color ?? Global().mainColor),
            backgroundColor: UCS.transparent);
}

class BasicList extends ScrollList {
  BasicList({
    super.key,
    required super.itemBuilder,
    super.itemCount,
    EasyRefreshController? refreshController,
    Widget? placeholder,
    Widget? header,
    Widget? footer,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    super.reverse = false,
    super.shrinkWrap = false,
    super.noScrollBehavior = false,
    super.primary,
    super.scrollDirection = Axis.vertical,
    super.clipBehavior = Clip.hardEdge,
    super.dragStartBehavior = DragStartBehavior.start,
    super.restorationId,
    super.physics,
    super.padding,
    super.controller,
    super.findChildIndexCallback,
    super.semanticIndexCallback = kDefaultSemanticIndexCallback,
    super.addAutomaticKeepALives = true,
    super.addRepaintBoundaries = true,
    super.addSemanticIndexes = true,
    super.gridStyle = GridStyle.none,
    super.separatorBuilder,

    /// use [SliverFixedExtentList]、[itemExtent] 优先 [prototypeItem]
    super.itemExtent,

    /// use [SliverPrototypeExtentList]、[itemExtent] 优先 [prototypeItem]
    super.prototypeItem,

    /// 横轴子元素的数量 自适应最大像素
    /// use [SliverGridDelegateWithFixedCrossAxisCount] or [SliverSimpleGridDelegateWithFixedCrossAxisCount]
    super.crossAxisCount = 1,

    /// 横轴元素最大像素 自适应列数
    /// use [SliverGridDelegateWithMaxCrossAxisExtent] or [SliverSimpleGridDelegateWithMaxCrossAxisExtent]
    super.maxCrossAxisExtent,

    /// 主轴方向子元素的间距
    super.mainAxisSpacing = 0,

    /// 横轴方向子元素的间距
    super.crossAxisSpacing = 0,

    /// 子元素在横轴长度和主轴长度的比例
    super.childAspectRatio = 1,

    /// 子元素在主轴上的长度。[mainAxisExtent] 优先 [childAspectRatio]
    super.mainAxisExtent,
    super.cacheExtent,
    RefreshConfig? refreshConfig,
  }) : super.builder(
            header: header?.toSliverBox,
            footer: footer?.toSliverBox,
            refreshConfig: refreshConfig ??
                ((onRefresh != null || onLoading != null)
                    ? RefreshConfig(
                        controller: refreshController,
                        header: Global().config.pullDownHeader,
                        footer: Global().config.pullUpFooter,
                        onLoading: onLoading == null
                            ? null
                            : () async => onLoading.call(),
                        onRefresh: onRefresh == null
                            ? null
                            : () async => onRefresh.call())
                    : null),
            placeholder: placeholder ?? Global().config.placeholder);

  BasicList.count({
    super.key,
    required super.children,
    EasyRefreshController? refreshController,
    Widget? placeholder,
    Widget? header,
    Widget? footer,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    super.reverse = false,
    super.shrinkWrap = false,
    super.noScrollBehavior = false,
    super.primary,
    super.scrollDirection = Axis.vertical,
    super.clipBehavior = Clip.hardEdge,
    super.dragStartBehavior = DragStartBehavior.start,
    super.restorationId,
    super.physics,
    super.padding,
    super.controller,
    super.semanticIndexCallback = kDefaultSemanticIndexCallback,
    super.addAutomaticKeepALives = true,
    super.addRepaintBoundaries = true,
    super.addSemanticIndexes = true,
    super.gridStyle = GridStyle.none,
    super.cacheExtent,

    /// use [SliverFixedExtentList]、[itemExtent] 优先 [prototypeItem]
    super.itemExtent,

    /// use [SliverPrototypeExtentList]、[itemExtent] 优先 [prototypeItem]
    super.prototypeItem,

    /// 横轴子元素的数量 自适应最大像素
    /// use [SliverGridDelegateWithFixedCrossAxisCount] or [SliverSimpleGridDelegateWithFixedCrossAxisCount]
    super.crossAxisCount = 1,

    /// 横轴元素最大像素 自适应列数
    /// use [SliverGridDelegateWithMaxCrossAxisExtent] or [SliverSimpleGridDelegateWithMaxCrossAxisExtent]
    super.maxCrossAxisExtent,

    /// 主轴方向子元素的间距
    super.mainAxisSpacing = 0,

    /// 横轴方向子元素的间距
    super.crossAxisSpacing = 0,

    /// 子元素在横轴长度和主轴长度的比例
    super.childAspectRatio = 1,

    /// 子元素在主轴上的长度。[mainAxisExtent] 优先 [childAspectRatio]
    super.mainAxisExtent,
    RefreshConfig? refreshConfig,
  }) : super.count(
            header: header?.toSliverBox,
            footer: footer?.toSliverBox,
            refreshConfig: refreshConfig ??
                ((onRefresh != null || onLoading != null)
                    ? RefreshConfig(
                        controller: refreshController,
                        header: Global().config.pullDownHeader,
                        footer: Global().config.pullUpFooter,
                        onLoading: onLoading == null
                            ? null
                            : () async => onLoading.call(),
                        onRefresh: onRefresh == null
                            ? null
                            : () async => onRefresh.call())
                    : null),
            placeholder: placeholder ?? Global().config.placeholder);

  BasicList.waterfall({
    super.key,
    required super.itemBuilder,
    required super.itemCount,
    EasyRefreshController? refreshController,
    Widget? placeholder,
    Widget? header,
    Widget? footer,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    super.reverse = false,
    super.shrinkWrap = false,
    super.noScrollBehavior = false,
    super.primary,
    super.scrollDirection = Axis.vertical,
    super.clipBehavior = Clip.hardEdge,
    super.dragStartBehavior = DragStartBehavior.start,
    super.restorationId,
    super.physics,
    super.padding,
    super.controller,
    super.findChildIndexCallback,
    super.semanticIndexCallback = kDefaultSemanticIndexCallback,
    super.addAutomaticKeepALives = true,
    super.addRepaintBoundaries = true,
    super.addSemanticIndexes = true,
    super.gridStyle = GridStyle.masonry,
    super.separatorBuilder,

    /// use [SliverFixedExtentList]、[itemExtent] 优先 [prototypeItem]
    super.itemExtent,

    /// use [SliverPrototypeExtentList]、[itemExtent] 优先 [prototypeItem]
    super.prototypeItem,

    /// 横轴子元素的数量 自适应最大像素
    /// use [SliverGridDelegateWithFixedCrossAxisCount] or [SliverSimpleGridDelegateWithFixedCrossAxisCount]
    super.crossAxisCount = 1,

    /// 横轴元素最大像素 自适应列数
    /// use [SliverGridDelegateWithMaxCrossAxisExtent] or [SliverSimpleGridDelegateWithMaxCrossAxisExtent]
    super.maxCrossAxisExtent,

    /// 主轴方向子元素的间距
    super.mainAxisSpacing = 0,

    /// 横轴方向子元素的间距
    super.crossAxisSpacing = 0,

    /// 子元素在横轴长度和主轴长度的比例
    super.childAspectRatio = 1,

    /// 子元素在主轴上的长度。[mainAxisExtent] 优先 [childAspectRatio]
    super.mainAxisExtent,
    super.cacheExtent,
    RefreshConfig? refreshConfig,
  }) : super.builder(
            header: header?.toSliverBox,
            footer: footer?.toSliverBox,
            refreshConfig: refreshConfig ??
                ((onRefresh != null || onLoading != null)
                    ? RefreshConfig(
                        controller: refreshController,
                        header: Global().config.pullDownHeader,
                        footer: Global().config.pullUpFooter,
                        onLoading: onLoading == null
                            ? null
                            : () async => onLoading.call(),
                        onRefresh: onRefresh == null
                            ? null
                            : () async => onRefresh.call())
                    : null),
            placeholder: placeholder ?? Global().config.placeholder);

  BasicList.custom({
    super.key,
    required super.sliver,
    EasyRefreshController? refreshController,
    Widget? header,
    Widget? footer,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    super.physics,
    super.controller,
    super.padding,
    super.shrinkWrap = false,
    super.scrollDirection = Axis.vertical,
    super.reverse,
    super.primary,
    super.clipBehavior,
    super.dragStartBehavior,
    super.noScrollBehavior,
    super.restorationId,
    super.cacheExtent,
    RefreshConfig? refreshConfig,
  }) : super(
            header: header?.toSliverBox,
            footer: footer?.toSliverBox,
            refreshConfig: refreshConfig ??
                ((onRefresh != null || onLoading != null)
                    ? RefreshConfig(
                        controller: refreshController,
                        footer: Global().config.pullUpFooter,
                        header: Global().config.pullDownHeader,
                        onLoading: onLoading == null
                            ? null
                            : () async => onLoading.call(),
                        onRefresh: onRefresh == null
                            ? null
                            : () async => onRefresh.call())
                    : null));
}
