import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

Footer currentPullUpFooter = ClassicalFooter(
    showInfo: false,
    noMoreText: '我是有底线的~',
    loadText: 'Pull up to load more',
    loadingText: 'Being loaded',
    loadFailedText: 'Load failed',
    textColor: UCS.titleTextColor,
    infoColor: GlobalConfig().currentColor,
    loadedText: 'loaded',
    loadReadyText: '123123');

Header currentPullDownHeader = ClassicalHeader(
    refreshedText: 'Refresh to complete',
    refreshingText: 'refreshing',
    refreshText: 'The drop-down refresh',
    textColor: UCS.titleTextColor,
    infoColor: GlobalConfig().currentColor,
    refreshReadyText: 'Release Refresh now',
    showInfo: false);

class BaseMaterialHeader extends MaterialHeader {
  BaseMaterialHeader({Color color = UCS.white})
      : super(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            backgroundColor: UCS.transparent);
}

class BaseList extends ScrollList {
  BaseList({
    Key? key,
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    EasyRefreshController? refreshController,
    Widget? placeholder,
    ScrollPhysics? physics,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    bool? crossAxisFlex,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    int? crossAxisCount,
    double? childAspectRatio,
    double? maxCrossAxisExtent,
    bool? shrinkWrap = false,
    Widget? header,
    Axis? scrollDirection,
  }) : super.builder(
            key: key,
            scrollDirection: scrollDirection,
            cacheExtent: deviceHeight / 2,
            padding: padding,
            header: header == null ? null : SliverToBoxAdapter(child: header),
            controller: controller,
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    controller: refreshController,
                    header: currentPullDownHeader,
                    footer: currentPullUpFooter,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            physics: physics,
            crossAxisFlex: crossAxisFlex ?? false,
            maxCrossAxisExtent: maxCrossAxisExtent,
            crossAxisSpacing: crossAxisSpacing ?? 0,
            mainAxisSpacing: mainAxisSpacing ?? 0,
            crossAxisCount: crossAxisCount ?? 1,
            childAspectRatio: childAspectRatio ?? 1,
            shrinkWrap: shrinkWrap,
            placeholder: placeholder ?? const NoDataWidget());

  BaseList.separated({
    Key? key,
    required IndexedWidgetBuilder itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    required int itemCount,
    EasyRefreshController? refreshController,
    Widget? placeholder,
    ScrollPhysics? physics,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
    bool? shrinkWrap = false,
    Widget? header,
    Axis? scrollDirection,
  }) : super.separated(
            key: key,
            scrollDirection: scrollDirection,
            cacheExtent: deviceHeight / 2,
            header: header == null ? null : SliverToBoxAdapter(child: header),
            separatorBuilder: separatorBuilder,
            padding: padding,
            controller: controller,
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    controller: refreshController,
                    footer: currentPullUpFooter,
                    header: currentPullDownHeader,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            physics: physics,
            shrinkWrap: shrinkWrap,
            placeholder: placeholder ?? const NoDataWidget());

  BaseList.countBuilder({
    Key? key,
    required List<SliverListGrid> sliver,
    EasyRefreshController? refreshController,
    ScrollPhysics? physics,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
    bool? shrinkWrap = false,
    Widget? header,
    Axis? scrollDirection,
  }) : super(
            sliver: sliver,
            key: key,
            scrollDirection: scrollDirection,
            cacheExtent: deviceHeight / 2,
            header: header == null ? null : SliverToBoxAdapter(child: header),
            padding: padding,
            controller: controller,
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    controller: refreshController,
                    footer: currentPullUpFooter,
                    header: currentPullDownHeader,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            physics: physics,
            shrinkWrap: shrinkWrap);
}

/// 暂无数据
class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key, this.margin}) : super(key: key);

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ?? const EdgeInsets.all(100),
        child: Center(child: TextDefault('Not Data')));
  }
}
