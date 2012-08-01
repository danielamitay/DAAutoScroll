//
//  DAAutoScrollView.m
//  DAAutoScroll
//
//  Created by Daniel Amitay on 2/13/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "DAAutoScrollView.h"

@implementation DAAutoScrollView

@synthesize pointsPerSecond = _pointsPerSecond;
@synthesize scrolling = _scrolling;
- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if(newWindow) {
        [self.panGestureRecognizer addTarget:self action:@selector(gestureDidChange:)];
        [self.pinchGestureRecognizer addTarget:self action:@selector(gestureDidChange:)];
    }
    else {
        [self stopScrolling: YES];
        [self.panGestureRecognizer removeTarget:self action:@selector(gestureDidChange:)];
        [self.pinchGestureRecognizer removeTarget:self action:@selector(gestureDidChange:)];
    }
}

#pragma mark - Touch methods

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
    [self stopScrolling: YES];
    return [super touchesShouldBegin:touches withEvent:event inContentView:view];
}

- (void)gestureDidChange:(UIGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            if([self isScrolling]){
                [self stopScrolling: YES];
            }
            break;
        }
        default:
            break;
    }
}

- (BOOL)becomeFirstResponder {
    [self stopScrolling: YES];
    return [super becomeFirstResponder];
}

#pragma mark - Property methods

- (CGFloat)pointsPerSecond {
    if (!_pointsPerSecond)
     {
        _pointsPerSecond = 15.0f;
     }
    return _pointsPerSecond;
}

#pragma mark - Public methods

- (void)startScrolling {
    [self stopScrolling: NO];
    self.scrolling = YES;
    CGFloat animationDuration = (0.5f / self.pointsPerSecond);
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:animationDuration
                                                    target:self
                                                  selector:@selector(updateScroll)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)stopScrolling: (BOOL) postNotification {
    if(postNotification)
        [[NSNotificationCenter defaultCenter] postNotificationName:DAAutoScrollViewNotificationStoped
                                                            object:nil];
    [_scrollTimer invalidate];
    _scrollTimer = nil;
    self.scrolling = NO;
}

- (void)updateScroll {
    CGFloat animationDuration = _scrollTimer.timeInterval;
    CGFloat pointChange = self.pointsPerSecond * animationDuration;
    CGPoint newOffset = self.contentOffset;
    newOffset.y = newOffset.y + pointChange;
    
    if (newOffset.y > (self.contentSize.height - self.bounds.size.height)) {
        [self stopScrolling: YES];
    }
    else {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.contentOffset = newOffset;
        [UIView commitAnimations];
    }
}

@end
