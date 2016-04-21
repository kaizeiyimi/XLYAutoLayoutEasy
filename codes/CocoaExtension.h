//
//  CocoaExtension.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 16/4/21.
//  Copyright © 2016年 kaizei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLYALEProtocols.h"


@interface NSLayoutAnchor (XLYALERelationMakeableSupport) <XLYALERelationMakeable>
@end


@interface NSNumber (XLYALERelationMakeableSupport) <XLYALERelationMakeable>
@end