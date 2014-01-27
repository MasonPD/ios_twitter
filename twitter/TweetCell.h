//
//  TweetCell.h
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell <UITextFieldDelegate>

@property ( nonatomic, weak ) IBOutlet UILabel *userName;
@property ( nonatomic, weak ) IBOutlet UITextView *tweetContextTextView;
@property ( nonatomic, weak ) IBOutlet UILabel *timeStamp;
@property ( nonatomic, weak ) IBOutlet UIImageView *tweetUserImage;
@property ( nonatomic, weak ) IBOutlet UILabel *tweetUserHandle;


@end
