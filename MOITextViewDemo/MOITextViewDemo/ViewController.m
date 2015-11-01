//
//  ViewController.m
//  MOITextViewDemo
//
//  Created by mconintet on 10/21/15.
//  Copyright © 2015 mconintet. All rights reserved.
//

#import "ViewController.h"
#import "MOITextView.h"

@interface ViewController ()
@property (nonatomic, strong) MOITextView* tv;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _tv = [[MOITextView alloc] initWithFont:[UIFont systemFontOfSize:16]
                                    padding:UIEdgeInsetsZero
                                placeholder:@"placeholder"
                                      width:self.view.bounds.size.width
                                  maxHeight:100];
    CGRect frame = _tv.frame;
    frame.origin.y = 100;
    _tv.frame = frame;
    [self.view addSubview:_tv];

    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleSingleTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)handleSingleTap:(UITapGestureRecognizer*)sender
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
