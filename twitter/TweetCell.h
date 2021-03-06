//
//  TweetCell.h
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tweetUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetUserHandle;
@property (weak, nonatomic) IBOutlet UIImageView *tweetUserProfileImage;
@property (weak, nonatomic) IBOutlet UITextView *tweetContentTextView;
@property (weak, nonatomic) IBOutlet UILabel *tweetTimestampLabel;


@end
