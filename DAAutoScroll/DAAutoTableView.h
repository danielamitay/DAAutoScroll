//
//  DAAutoTableView.h
//  DAAutoScroll
//
//  Created by Daniel Amitay on 2/13/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAAutoTableView : UITableView
{
    NSTimer *_scrollTimer;
}

@property (nonatomic) CGFloat pointsPerSecond;

- (void)startScrolling;
- (void)stopScrolling;

@end
