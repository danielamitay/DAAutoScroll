//
//  DAAutoScroll.m
//  DAAutoScroll
//
//  Created by Daniel Amitay on 3/30/13.
//  Copyright (c) 2013 Daniel Amitay. All rights reserved.
//

#import "UIScrollView+DA.h"

static CGFloat UIScrollViewDefaultScrollPointsPerSecond = 15.0f;
static char UIScrollViewScrollPointsPerSecondNumber;
static char UIScrollViewAutoScrollTimer;

@interface UIScrollView (DAAutoScroll_Internal)

@property (nonatomic, strong) NSTimer *autoScrollTimer;

@end

@implementation UIScrollView (DAAutoScroll)

#pragma mark - Property Methods

- (void)setScrolling:(BOOL)scrolling
{
    if (scrolling)
    {
        //  Start scrolling
    }
    else
    {
        //  Stop scrolling
    }
}

- (BOOL)scrolling
{
    return FALSE;
}

- (CGFloat)scrollPointsPerSecond
{
    NSNumber *scrollPointsPerSecondNumber = objc_getAssociatedObject(self,
                                                                     &UIScrollViewScrollPointsPerSecondNumber);
    if (scrollPointsPerSecondNumber)
    {
        return [scrollPointsPerSecondNumber floatValue];
    }
    else
    {
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
    return objc_getAssociatedObject(self,
                                    &UIScrollViewAutoScrollTimer);
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
