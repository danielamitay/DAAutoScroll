//
//  TextViewController.h
//  DAAutoScrollExample
//
//  Created by Daniel Amitay on 2/13/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DAAutoTextView.h"

@interface TextViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) IBOutlet DAAutoTextView *textView;

@end
