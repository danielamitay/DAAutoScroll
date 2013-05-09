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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Text View";
    
    textView.delegate = self;
    [textView startScrolling];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
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
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate && !textView.isFirstResponder)
    {
        [textView startScrolling];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!textView.isFirstResponder)
    {
        [textView startScrolling];
    }
}

@end
