//
//  TextViewController.m
//  DAAutoScrollExample
//
//  Created by Daniel Amitay on 2/13/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "TextViewController.h"
#import "DAAutoScroll.h"

@implementation TextViewController

@synthesize textView;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Text View";
    
    textView.delegate = self;
    [textView startScrolling];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)textViewDidBeginEditing:(UITextView *)aTextView
{
    [textView stopScrolling];
}

- (void)textViewDidEndEditing:(UITextView *)aTextView
{
    [textView startScrolling];
}

- (BOOL)textView:(UITextView *)aTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate && !textView.isFirstResponder) {
        [textView startScrolling];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!textView.isFirstResponder) {
        [textView startScrolling];
    }
}

@end
