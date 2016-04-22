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

- (id<XLYALERelationMakeable>(^)(NSLayoutAttribute attr))ale_layoutAttribute;

- (NSArray<XLYALERelationMakeable> *)ale_size;
- (NSArray<XLYALERelationMakeable> *)ale_center;
- (NSArray<XLYALERelationMakeable> *)ale_edge;
- (NSArray<XLYALERelationMakeable> *)ale_edgeLR;

@end

NS_ASSUME_NONNULL_END