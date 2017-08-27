//
//  DAAutoScroll.m
//  DAAutoScroll
//
//  Created by Daniel Amitay on 3/30/13.
//  Copyright (c) 2013 Daniel Amitay. All rights reserved.
//

#import "DAAutoScroll.h"
#import <objc/runtime.h>
#import <QuartzCore/CADisplayLink.h>

static CGFloat UIScrollViewDefaultScrollPointsPerSecond = 15.0f;
static char UIScrollViewScrollPointsPerSecondNumber;
static char UIScrollViewAutoScrollDisplayLink;

@interface UIScrollView (DAAutoScroll_Internal)

@property (nonatomic, strong) CADisplayLink *autoScrollDisplayLink;

@end

@implementation UIScrollView (DAAutoScroll)

- (void)startScrolling
{
    [self stopScrolling];

    self.autoScrollDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_displayTick:)];
    [self.autoScrollDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)stopScrolling
{
    [self.autoScrollDisplayLink invalidate];
    self.autoScrollDisplayLink = nil;
}

- (void)_displayTick:(CADisplayLink *)displayLink
{
    if (self.window == nil) {
        [self stopScrolling];
    }

    CGFloat animationDuration = displayLink.duration;
    CGFloat pointChange = self.scrollPointsPerSecond * animationDuration;
    CGPoint newOffset = (CGPoint) {
        .x = self.contentOffset.x,
        .y = self.contentOffset.y + pointChange
    };
    CGFloat maximumYOffset = self.contentSize.height - self.bounds.size.height;
    if (newOffset.y > maximumYOffset) {
        [self stopScrolling];
    } else {
        self.contentOffset = newOffset;
    }
}

#pragma mark - Property Methods

- (void)setScrolling:(BOOL)scrolling
{
    if (scrolling) {
        [self startScrolling];
    } else {
        [self stopScrolling];
    }
}

- (BOOL)isScrolling
{
    return (self.autoScrollDisplayLink != nil);
}

- (CGFloat)scrollPointsPerSecond
{
    NSNumber *scrollPointsPerSecondNumber = objc_getAssociatedObject(self, &UIScrollViewScrollPointsPerSecondNumber);
    if (scrollPointsPerSecondNumber) {
        return [scrollPointsPerSecondNumber floatValue];
    } else {
        return UIScrollViewDefaultScrollPointsPerSecond;
    }
}

- (void)setScrollPointsPerSecond:(CGFloat)scrollPointsPerSecond
{
    [self willChangeValueForKey:@"scrollPointsPerSecond"];
    objc_setAssociatedObject(self,
                             &UIScrollViewScrollPointsPerSecondNumber,
                             [NSNumber numberWithFloat:scrollPointsPerSecond],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"scrollPointsPerSecond"];
}

- (CADisplayLink *)autoScrollDisplayLink
{
    return objc_getAssociatedObject(self, &UIScrollViewAutoScrollDisplayLink);
}

- (void)setAutoScrollDisplayLink:(CADisplayLink *)autoScrollDisplayLink
{
    [self willChangeValueForKey:@"autoScrollDisplayLink"];
    objc_setAssociatedObject(self,
                             &UIScrollViewAutoScrollDisplayLink,
                             autoScrollDisplayLink,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"autoScrollDisplayLink"];
}

@end
