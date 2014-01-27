//
//  ComposeViewController.m
//  twitter
//
//  Created by Linkai Xi on 1/25/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ComposeViewController.h"
#import "User.h"

@interface ComposeViewController ()

-(IBAction)onCancelCompose:(id)sender;
-(IBAction)onTweet:(id)sender;

@end

@implementation ComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Compose Tweet";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.composeTweetTextView becomeFirstResponder];
    
    User *signedInUser = [User currentUser];
    [self.composeTweetUsernameLabel setText:signedInUser.currentUserName];
    NSString *handle = [@"@" stringByAppendingString:signedInUser.currentUserHandle];
    [self.composeTweetUserHandle setText:handle];
    
    NSData *imageData = [NSData dataWithContentsOfURL:signedInUser.currentUserImageURL];
    [self.composeTweetUserImage setImage:[UIImage imageWithData:imageData]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onCancelCompose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)onTweet:(id)sender
{
    NSLog(@"Tweet Button clicked!");
    [[TwitterClient instance]updateStatus:self.composeTweetTextView.text success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        [self dismissViewControllerAnimated:YES completion:nil];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}

@end
