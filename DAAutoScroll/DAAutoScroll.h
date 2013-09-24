//
//  DAAutoScroll.h
//  DAAutoScroll
//
//  Created by Daniel Amitay on 3/30/13.
//  Copyright (c) 2013 Daniel Amitay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (DAAutoScroll)

@property (nonatomic) CGFloat scrollPointsPerSecond;
@property (nonatomic, getter = isScrolling) BOOL scrolling;

- (void)startScrolling;
- (void)stopScrolling;

@end
