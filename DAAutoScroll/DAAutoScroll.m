//
//  DAAutoScroll.m
//  DAAutoScroll
//
//  Created by Daniel Amitay on 3/30/13.
//  Copyright (c) 2013 Daniel Amitay. All rights reserved.
//

#import "DAAutoScroll.h"
#import <objc/runtime.h>

static CGFloat UIScrollViewDefaultScrollPointsPerSecond = 15.0f;
static char UIScrollViewScrollPointsPerSecondNumber;
static char UIScrollViewAutoScrollTimer;

@interface UIScrollView (DAAutoScroll_Internal)

@property (nonatomic, strong) NSTimer *autoScrollTimer;

@end

@implementation UIScrollView (DAAutoScroll)

- (void)startScrolling
{
    [self stopScrolling];
    
    CGFloat scale = (self.window ? self.window.screen.scale : [UIScreen mainScreen].scale);
    CGFloat animationDuration = (1.0f / (self.scrollPointsPerSecond * scale));
    self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:animationDuration
                                                            target:self
                                                          selector:@selector(scrollTick)
                                                          userInfo:nil
                                                           repeats:YES];
}

- (void)stopScrolling
{
    [self.autoScrollTimer invalidate];
    self.autoScrollTimer = nil;
}

- (void)scrollTick
{
    if (self.window == nil) {
        [self stopScrolling];
    }
    
    CGFloat animationDuration = self.autoScrollTimer.timeInterval;
    CGFloat pointChange = self.scrollPointsPerSecond * animationDuration;
    CGPoint newOffset = (CGPoint) {
        .x = self.contentOffset.x,
        .y = self.contentOffset.y + pointChange
    };
    
    CGFloat maximumYOffset = self.contentSize.height - self.bounds.size.height;
    if (newOffset.y > maximumYOffset) {
        [self stopScrolling];
    } else {
        [UIView animateWithDuration:animationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.contentOffset = newOffset;
                         } completion:nil];
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
    return (self.autoScrollTimer != nil);
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

- (NSTimer *)autoScrollTimer
{
    return objc_getAssociatedObject(self, &UIScrollViewAutoScrollTimer);
}

- (void)setAutoScrollTimer:(NSTimer *)autoScrollTimer
{
    [self willChangeValueForKey:@"autoScrollTimer"];
    objc_setAssociatedObject(self,
                             &UIScrollViewAutoScrollTimer,
                             autoScrollTimer,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"autoScrollTimer"];
}

@end
