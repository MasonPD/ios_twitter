//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Linkai Xi on 1/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface TweetDetailsViewController ()

-(IBAction)onRetweet:(id)sender;
-(IBAction)onFavorite:(id)sender;

@end

@implementation TweetDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tweet";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        NSLog(@"Load resources for iOS 6.1 or earlier");
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    } else {
        NSLog(@"Load resources for iOS 7 or later");
        self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    }
    
    [self.selectedTweetUsernameLabel setText:self.selectedTweet.username];
    NSString *userHandle = [@"@" stringByAppendingString:self.selectedTweet.userHandle];
    [self.selectedTweetUserHandleLabel setText:userHandle];
    [self.selectedTweetTimestampLabel setText:self.selectedTweet.tweetTimestamp];
    [self.selectedTweetTextView setText:self.selectedTweet.text];
    [self.selectedTweetUserImage setImageWithURL:self.selectedTweet.userImageURL];
    
   // NSData * imageData = [NSData dataWithContentsOfURL:self.selectedTweet.userImageURL];
   // [self.selectedTweetUserImage setImage:[UIImage imageWithData:imageData]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFavorite:(id)sender{
    NSLog(@"onFavorite button is clicked!");
    [[TwitterClient instance]favoriteTweet:self.selectedTweet.tweetId success:^(AFHTTPRequestOperation *operation, id response){
        NSLog(@"%@", response);
        //TODO
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (IBAction)onRetweet:(id)sender{
    NSLog(@"onRetweet button is clicked!");
    [[TwitterClient instance] retweet:self.selectedTweet.tweetId success:^(AFHTTPRequestOperation *operation, id response){
        NSLog(@"%@", response);
        //TODO
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}
@end
