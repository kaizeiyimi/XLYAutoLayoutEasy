//
//  XLYALECocoaExtension.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 16/4/21.
//  Copyright © 2016年 kaizei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLYALEProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutAnchor (XLYALELeftItemSupport) <XLYALELeftItem>
@end


@interface NSNumber (XLYALERightItemSupport) <XLYALERightItem>
@end


@protocol XLYALELayoutGuideWrapper <NSObject>

- (id<XLYALELeftItem>)ale_top;
- (id<XLYALELeftItem>)ale_bottom;
- (id<XLYALELeftItem>)ale_height;

@end


@interface UIViewController (XLYALESupport)

- (id<XLYALELayoutGuideWrapper>)ale_topGuide;
- (id<XLYALELayoutGuideWrapper>)ale_bottomGuide;

@end


@interface UIView (XLYALESupport)

- (NSArray<XLYALELeftItem> *)ale_size;
- (NSArray<XLYALELeftItem> *)ale_center;
- (NSArray<XLYALELeftItem> *)ale_edge;
- (NSArray<XLYALELeftItem> *)ale_edgeLR;

- (id<XLYALELeftItem>)ale_left;
- (id<XLYALELeftItem>)ale_right;
- (id<XLYALELeftItem>)ale_top;
- (id<XLYALELeftItem>)ale_bottom;
- (id<XLYALELeftItem>)ale_leading;
- (id<XLYALELeftItem>)ale_trailing;
- (id<XLYALELeftItem>)ale_width;
- (id<XLYALELeftItem>)ale_height;
- (id<XLYALELeftItem>)ale_centerX;
- (id<XLYALELeftItem>)ale_centerY;
- (id<XLYALELeftItem>)ale_baseline;

- (id<XLYALELeftItem>)ale_firstBaseline NS_AVAILABLE_IOS(8_0);
- (id<XLYALELeftItem>)ale_leftMargin NS_AVAILABLE_IOS(8_0);
- (id<XLYALELeftItem>)ale_rightMargin NS_AVAILABLE_IOS(8_0);
- (id<XLYALELeftItem>)ale_topMargin NS_AVAILABLE_IOS(8_0);
- (id<XLYALELeftItem>)ale_bottomMargin NS_AVAILABLE_IOS(8_0);
- (id<XLYALELeftItem>)ale_leadingMargin NS_AVAILABLE_IOS(8_0);
- (id<XLYALELeftItem>)ale_trailingMargin NS_AVAILABLE_IOS(8_0);
- (id<XLYALELeftItem>)ale_centerXWithinMargins NS_AVAILABLE_IOS(8_0);
- (id<XLYALELeftItem>)ale_centerYWithinMargins NS_AVAILABLE_IOS(8_0);

@end

NS_ASSUME_NONNULL_END
