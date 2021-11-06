import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

Footer get pullUpFooter => ClassicalFooter(
    showInfo: false,
    noMoreText: '我是有底线的~',
    loadText: '上拉加载更多',
    loadingText: '正在加载',
    loadFailedText: '加载失败',
    textColor: UCS.titleTextColor,
    infoColor: currentColor,
    loadedText: '加载完成',
    loadReadyText: '123123');

Header get pullDownHeader => ClassicalHeader(
    refreshedText: '刷新完成',
    refreshingText: '正在刷新',
    refreshText: '下拉刷新',
    textColor: UCS.titleTextColor,
    infoColor: currentColor,
    refreshReadyText: '放开立即刷新',
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
  }) : super.builder(
            key: key,
            cacheExtent: deviceHeight / 2,
            padding: padding,
            header: header == null ? null : SliverToBoxAdapter(child: header),
            controller: controller,
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    controller: refreshController,
                    header: pullDownHeader,
                    footer: pullUpFooter,
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
  }) : super.separated(
            key: key,
            cacheExtent: deviceHeight / 2,
            header: header == null ? null : SliverToBoxAdapter(child: header),
            separatorBuilder: separatorBuilder,
            padding: padding,
            controller: controller,
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    controller: refreshController,
                    footer: pullUpFooter,
                    header: pullDownHeader,
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
  }) : super(
            sliver: sliver,
            key: key,
            cacheExtent: deviceHeight / 2,
            header: header == null ? null : SliverToBoxAdapter(child: header),
            padding: padding,
            controller: controller,
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    controller: refreshController,
                    footer: pullUpFooter,
                    header: pullDownHeader,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            physics: physics,
            shrinkWrap: shrinkWrap);
}

///暂无数据
class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key, this.margin}) : super(key: key);

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ?? const EdgeInsets.all(100),
        child: Center(child: TextDefault('暂无数据')));
  }
}
