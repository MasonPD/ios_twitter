//
//  ComposeViewController.h
//  twitter
//
//  Created by Linkai Xi on 1/25/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBarButton;

@property (weak, nonatomic) IBOutlet UITextView *composeTweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *composeTweetUsernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *composeTweetUserImage;
@property (weak, nonatomic) IBOutlet UILabel *composeTweetUserHandle;
@property (weak, nonatomic) IBOutlet UILabel *charCounterLabel;


@end
