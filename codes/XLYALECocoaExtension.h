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

@interface NSLayoutAnchor (XLYALERelationMakeableSupport) <XLYALERelationMakeable>
@end


@interface NSNumber (XLYALERelationMakeableSupport) <XLYALEAttributeContainer>
@end


@protocol XLYALELayoutGuideWrapper <NSObject>

- (id<XLYALERelationMakeable>)ale_top;
- (id<XLYALERelationMakeable>)ale_bottom;
- (id<XLYALERelationMakeable>)ale_height;

@end


@interface UIViewController (XLYALESupport)

- (id<XLYALELayoutGuideWrapper>)ale_topGuide;
- (id<XLYALELayoutGuideWrapper>)ale_bottomGuide;

@end


@interface UIView (XLYALESupport)

- (id<XLYALERelationMakeable>(^)(NSLayoutAttribute attr))ale_attribute;

- (NSArray<XLYALERelationMakeable> *)ale_size;
- (NSArray<XLYALERelationMakeable> *)ale_center;
- (NSArray<XLYALERelationMakeable> *)ale_edge;
- (NSArray<XLYALERelationMakeable> *)ale_edgeLR;

- (id<XLYALERelationMakeable>)ale_left;
- (id<XLYALERelationMakeable>)ale_right;
- (id<XLYALERelationMakeable>)ale_top;
- (id<XLYALERelationMakeable>)ale_bottom;
- (id<XLYALERelationMakeable>)ale_leading;
- (id<XLYALERelationMakeable>)ale_trailing;
- (id<XLYALERelationMakeable>)ale_width;
- (id<XLYALERelationMakeable>)ale_height;
- (id<XLYALERelationMakeable>)ale_centerX;
- (id<XLYALERelationMakeable>)ale_centerY;
- (id<XLYALERelationMakeable>)ale_baseline;

- (id<XLYALERelationMakeable>)ale_firstBaseline NS_AVAILABLE_IOS(8_0);
- (id<XLYALERelationMakeable>)ale_leftMargin NS_AVAILABLE_IOS(8_0);
- (id<XLYALERelationMakeable>)ale_rightMargin NS_AVAILABLE_IOS(8_0);
- (id<XLYALERelationMakeable>)ale_topMargin NS_AVAILABLE_IOS(8_0);
- (id<XLYALERelationMakeable>)ale_bottomMargin NS_AVAILABLE_IOS(8_0);
- (id<XLYALERelationMakeable>)ale_leadingMargin NS_AVAILABLE_IOS(8_0);
- (id<XLYALERelationMakeable>)ale_trailingMargin NS_AVAILABLE_IOS(8_0);
- (id<XLYALERelationMakeable>)ale_centerXWithinMargins NS_AVAILABLE_IOS(8_0);
- (id<XLYALERelationMakeable>)ale_centerYWithinMargins NS_AVAILABLE_IOS(8_0);

@end

NS_ASSUME_NONNULL_END