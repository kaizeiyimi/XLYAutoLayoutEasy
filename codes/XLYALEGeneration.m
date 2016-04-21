//
//  XLYALEGeneration.m
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 16/4/21.
//  Copyright © 2016年 kaizei. All rights reserved.
//

#import "XLYALEGeneration.h"
#import "XLYALEPrivate.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLYALEContext ()

@property(nonatomic, assign) NSLayoutFormatOptions direction;
@property(nonatomic, assign) BOOL autoActive;
@property(nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *constraints;

@end


@implementation XLYALEContext

static NSMutableArray<XLYALEContext *> *stack = nil;

+ (void)initialize {
    if (stack == nil) {
        stack = [@[[[XLYALEContext alloc] initWithDirection:NSLayoutFormatDirectionLeadingToTrailing autoActive:NO]] mutableCopy];
    }
}


- (instancetype)initWithDirection:(NSLayoutFormatOptions)direction autoActive:(BOOL)autoActive  {
    if (self = [super init]) {
        self.direction = direction;
        self.autoActive = autoActive;
        self.constraints = [NSMutableArray new];
    }
    return self;
}

+ (NSLayoutConstraint *)constraintWithFirst:(id<XLYALERelationMakeable>)first relation:(NSLayoutRelation)relation second:(id<XLYALEAttributeContainer>)second {
    return [stack.lastObject makeForFirst:first relation:relation second:second];
}

- (NSLayoutConstraint *)makeForFirst:(id<XLYALERelationMakeable>)left relation:(NSLayoutRelation)relation second:(id<XLYALEAttributeContainer>)right {
    XLYALEAttributeX *first = [left xly_generateX], *second = [right xly_generateX];
    [self adjustAttributesForFirst:first second:second];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:first.item attribute:first.attr relatedBy:relation toItem:second.item attribute:second.attr multiplier:second.multiplier constant:second.constant];
    constraint.priority = second.priority;
    [self.constraints addObject:constraint];
    return constraint;
}

- (void)adjustAttributesForFirst:(XLYALEAttributeX *)first second:(XLYALEAttributeX *)second {
    [self crashIfNeededWithFirstAttr:first.attr secondAttr:second.attr direction:self.direction];
    
    id firstItem = first.item;  // can never be nil
    id _Nullable secondItem = second.item;
    NSLayoutAttribute firstAttr = first.attr, secondAttr = second.attr;
    CGFloat constant = second.constant;
    
    // number
    if (firstAttr != NSLayoutAttributeWidth && firstAttr != NSLayoutAttributeHeight
        && secondItem == nil && secondAttr == NSLayoutAttributeNotAnAttribute) {
        if ([firstItem isKindOfClass:[UIView class]]) {
            secondItem = ((UIView *)firstItem).superview;
            secondAttr = firstAttr;
        }
    }
    
    // direction
    
    NSLayoutAttribute(^adjust)(NSLayoutAttribute) = ^NSLayoutAttribute(NSLayoutAttribute attr) {
        switch (attr) {
            case NSLayoutAttributeLeading:
                if(self.direction == NSLayoutFormatDirectionLeftToRight) {
                    return NSLayoutAttributeLeft;
                } else if (self.direction == NSLayoutFormatDirectionRightToLeft) {
                    return NSLayoutAttributeRight;
                }
                break;
                
            case NSLayoutAttributeLeadingMargin:
                if(self.direction == NSLayoutFormatDirectionLeftToRight) {
                    return NSLayoutAttributeLeftMargin;
                } else if (self.direction == NSLayoutFormatDirectionRightToLeft) {
                    return NSLayoutAttributeRightMargin;
                }
                break;
                
            case NSLayoutAttributeTrailing:
                if(self.direction == NSLayoutFormatDirectionLeftToRight) {
                    return NSLayoutAttributeRight;
                } else if (self.direction == NSLayoutFormatDirectionRightToLeft) {
                    return NSLayoutAttributeLeft;
                }
                break;
                
            case NSLayoutAttributeTrailingMargin:
                if(self.direction == NSLayoutFormatDirectionLeftToRight) {
                    return NSLayoutAttributeRightMargin;
                } else if (self.direction == NSLayoutFormatDirectionRightToLeft) {
                    return NSLayoutAttributeLeftMargin;
                }
                break;
                
            default:
                break;
        }
        return attr;
    };
    
    NSLayoutAttribute adjustFirstAttr = adjust(first.attr), adjustSecondAttr = adjust(second.attr);
    
    // constant convert. since pair is checked, here we only need to check firstAttr.
    if (firstAttr != adjustFirstAttr && self.direction == NSLayoutFormatDirectionRightToLeft) {
        constant = -constant;
    }
    
    //
    first.attr = adjustFirstAttr;
    second.item = secondItem;
    second.attr = adjustSecondAttr;
    second.constant = constant;
}

- (void)crashIfNeededWithFirstAttr:(NSLayoutAttribute)firstAttr secondAttr:(NSLayoutAttribute)secondAttr direction:(NSLayoutFormatOptions)direction {
    // TODO: crash
}

@end



@implementation NSLayoutConstraint (XLYALEGeneration)

+ (NSArray<NSLayoutConstraint *> *)xly_make:(dispatch_block_t)block {
    return [self xly_makeWithDirection:NSLayoutFormatDirectionLeadingToTrailing autoActive:YES construction:block];
}

+ (NSArray<NSLayoutConstraint *> *)xly_makeWithDirection:(NSLayoutFormatOptions)direction construction:(dispatch_block_t)block {
    return [self xly_makeWithDirection:direction autoActive:YES construction:block];
}

+ (NSArray<NSLayoutConstraint *> *)xly_makeWithDirection:(NSLayoutFormatOptions)direction
                                              autoActive:(BOOL)autoActive
                                            construction:(dispatch_block_t)block {
    
    [stack addObject:[[XLYALEContext alloc] initWithDirection:direction autoActive:autoActive]];
    block == nil ? : block();
    XLYALEContext *context = stack.lastObject;
    [stack removeLastObject];
    return context.constraints;
}

@end

NS_ASSUME_NONNULL_END
