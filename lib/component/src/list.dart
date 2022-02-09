import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BasicMaterialHeader extends MaterialHeader {
  BasicMaterialHeader({Color? color})
      : super(
            valueColor: AlwaysStoppedAnimation<Color>(
                color ?? GlobalConfig().currentColor),
            backgroundColor: UCS.transparent);
}

class BasicList extends ScrollList {
  BasicList({
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
                    header: GlobalConfig().config.pullDownHeader,
                    footer: GlobalConfig().config.pullUpFooter,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            physics: physics,
            crossAxisFlex: crossAxisFlex ?? false,
            maxCrossAxisExtent: maxCrossAxisExtent ?? 100,
            crossAxisSpacing: crossAxisSpacing ?? 0,
            mainAxisSpacing: mainAxisSpacing ?? 0,
            crossAxisCount: crossAxisCount ?? 1,
            childAspectRatio: childAspectRatio ?? 1,
            shrinkWrap: shrinkWrap,
            placeholder: placeholder ?? GlobalConfig().config.placeholder);

  BasicList.waterfall({
    Key? key,
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    EasyRefreshController? refreshController,
    Widget? placeholder,
    ScrollPhysics? physics,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    int? crossAxisCount,
    double? maxCrossAxisExtent,
    bool? shrinkWrap = false,
    Widget? header,
    Axis? scrollDirection,
  }) : super.waterfall(
            key: key,
            scrollDirection: scrollDirection,
            cacheExtent: deviceHeight / 2,
            padding: padding,
            header: header == null ? null : SliverToBoxAdapter(child: header),
            controller: controller,
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    controller: refreshController,
                    header: GlobalConfig().config.pullDownHeader,
                    footer: GlobalConfig().config.pullUpFooter,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            physics: physics,
            maxCrossAxisExtent: maxCrossAxisExtent,
            crossAxisSpacing: crossAxisSpacing ?? 0,
            mainAxisSpacing: mainAxisSpacing ?? 0,
            crossAxisCount: crossAxisCount,
            shrinkWrap: shrinkWrap,
            placeholder: placeholder ?? GlobalConfig().config.placeholder);

  BasicList.separated({
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
                    footer: GlobalConfig().config.pullUpFooter,
                    header: GlobalConfig().config.pullDownHeader,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            physics: physics,
            shrinkWrap: shrinkWrap,
            placeholder: placeholder ?? GlobalConfig().config.placeholder);

  BasicList.countBuilder({
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
                    footer: GlobalConfig().config.pullUpFooter,
                    header: GlobalConfig().config.pullDownHeader,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            physics: physics,
            shrinkWrap: shrinkWrap);
}
