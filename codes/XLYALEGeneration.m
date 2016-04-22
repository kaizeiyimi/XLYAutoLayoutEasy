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

+ (void)load {
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
    XLYALEAttributeX *first = [left ale_generateX], *second = [right ale_generateX];
    [self adjustAttributesForFirst:first second:second];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:first.item attribute:first.attr relatedBy:relation toItem:second.item attribute:second.attr multiplier:second.multiplier constant:second.constant];
    constraint.priority = second.priority;
    constraint.active = self.autoActive;
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
    
    NSLayoutAttribute adjustFirstAttr = adjust(firstAttr), adjustSecondAttr = adjust(secondAttr);
    
    // constant convert. since pair is checked, here we only need to check firstAttr.
    if (firstAttr != adjustFirstAttr && self.direction == NSLayoutFormatDirectionRightToLeft) {
        constant = -constant;
    }
    
    // change
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

+ (NSArray<NSLayoutConstraint *> *)ale_make:(dispatch_block_t)block {
    return [self ale_makeWithDirection:NSLayoutFormatDirectionLeadingToTrailing autoActive:YES construction:block];
}

+ (NSArray<NSLayoutConstraint *> *)ale_makeWithDirection:(NSLayoutFormatOptions)direction construction:(dispatch_block_t)block {
    return [self ale_makeWithDirection:direction autoActive:YES construction:block];
}

+ (NSArray<NSLayoutConstraint *> *)ale_makeWithDirection:(NSLayoutFormatOptions)direction
                                              autoActive:(BOOL)autoActive
                                            construction:(dispatch_block_t)block {
    
    [stack addObject:[[XLYALEContext alloc] initWithDirection:direction autoActive:autoActive]];
    block == nil ? : block();
    XLYALEContext *context = stack.lastObject;
    [stack removeLastObject];
    return context.constraints;
}

@end



@implementation NSArray (XLYALECompositeEqualSupport)

- (NSArray<NSLayoutConstraint *> *(^)(NSArray *))ale_compositeEqual {
    return ^NSArray<NSLayoutConstraint *> *(NSArray *other) {
        return [self ale_compositeEqual:other];
    };
}
//- (NSArray<NSLayoutConstraint *> *(^)(NSArray *))ale_compositeEqual {
//    return ^NSArray<NSLayoutConstraint *> *(NSArray *other) {
- (NSArray<NSLayoutConstraint *> *)ale_compositeEqual:(NSArray *)other {
        NSMutableArray *result = [NSMutableArray new];
        for (NSInteger i = 0; i < MIN(self.count, other.count); ++i) {
            id<XLYALERelationMakeable> first = self[i];
            id<XLYALEAttributeContainer> second = other[i];
            BOOL firstValid = [first conformsToProtocol:@protocol(XLYALERelationMakeable)];
            BOOL secondValid = [second conformsToProtocol:@protocol(XLYALEAttributeContainer)];
            BOOL firstNull = [first isKindOfClass:[NSNull class]];
            BOOL secondNull = [second isKindOfClass:[NSNull class]];
            
            if (firstValid && secondValid) {
                [result addObject:first.ale_equal(second)];
            } else if ((!firstValid && !firstNull) || (!secondValid && !secondNull)) {
                NSAssert(NO, @"what do you put in array?");
            }
        }
        return result;
//    };
}

@end

NS_ASSUME_NONNULL_END
