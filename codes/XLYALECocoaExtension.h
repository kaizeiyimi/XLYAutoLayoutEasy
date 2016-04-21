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


@interface NSNumber (XLYALERelationMakeableSupport) <XLYALERelationMakeable>
@end


@interface UIView (XLYALESupport)

- (id<XLYALERelationMakeable>)xly_layoutAttribute:(NSLayoutAttribute)attr;

- (NSArray<XLYALERelationMakeable> *)xly_size;
- (NSArray<XLYALERelationMakeable> *)xly_center;
- (NSArray<XLYALERelationMakeable> *)xly_edge;
- (NSArray<XLYALERelationMakeable> *)xly_edgeLR;

@end


@protocol XLYALELayoutGuideWrapper <NSObject>

- (id<XLYALERelationMakeable>)xly_top;
- (id<XLYALERelationMakeable>)xly_bottom;
- (id<XLYALERelationMakeable>)xly_height;

@end

@interface UIViewController (XLYALESupport)

@property(nonatomic, readonly, strong) id<XLYALELayoutGuideWrapper> xly_topGuide;
@property(nonatomic, readonly, strong) id<XLYALELayoutGuideWrapper> xly_bottomGuide;

@end

NS_ASSUME_NONNULL_END