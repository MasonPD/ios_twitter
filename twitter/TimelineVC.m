//
//  TimelineVC.m
//  twitter
//
//  Created by Timothy Lee on 8/4/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TimelineVC.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "TweetDetailsViewController.h"

@interface TimelineVC ()

@property (nonatomic, strong) NSMutableArray *tweets;

- (void)onSignOutButton;
- (void)onComposeButton;
- (void)reload;
- (NSString *) timeTransfer:(NSString *)timestamp;

@end

@implementation TimelineVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Twitter";
        
        [self reload];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onComposeButton)];


    UINib *tweetsNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
    [self.tableView registerNib:tweetsNib forCellReuseIdentifier:@"TweetCell"];
    
    self.tableView.rowHeight = 90;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
   TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil){
        cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    Tweet *tweet = self.tweets[indexPath.row];
    //cell.textLabel.text = tweet.text;
    [cell.tweetContentTextView setText:tweet.text];
    [cell.tweetUsernameLabel setText:tweet.username];

    [cell.tweetTimestampLabel setText:[self timeTransfer:tweet.tweetTimestamp]];
    NSString *tweetUserHandle = [@"@" stringByAppendingString:tweet.userHandle];
    [cell.tweetUserHandle setText:tweetUserHandle];
    
    NSData * imageData = [NSData dataWithContentsOfURL:tweet.userImageURL];
    [cell.tweetUserProfileImage setImage:[UIImage imageWithData:imageData]];
    
    return cell;
}

- (NSString *) timeTransfer:(NSString *)timestamp
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //[dateFormatter setLocale:usLocale];
    //[dateFormatter setDateStyle:NSDateFormatterLongStyle];
    //[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    
    // see http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns
    [dateFormatter setDateFormat: @"EEE MMM dd HH:mm:ss +zzzz yyyy"];
    
    NSDate *date = [dateFormatter dateFromString:timestamp];
    
    NSDate *now = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    NSTimeInterval deltaTime = [now timeIntervalSinceDate:date];
    NSString *deltaTimeString;
    
    if (deltaTime < 60) {
        deltaTimeString = [NSString stringWithFormat:@"%ds",(int) deltaTime];
    } else if (deltaTime < 3600) {
        deltaTimeString = [NSString stringWithFormat:@"%dm",(int) (deltaTime/60)];
    } else if (deltaTime < 3600*48) {
        deltaTimeString = [NSString stringWithFormat:@"%dh",(int) (deltaTime/3600)];
    } else {
        deltaTimeString = [NSString stringWithFormat:@"%dd",(int) (deltaTime/3600/24)];
    }
    return deltaTimeString;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *selectedTweet = self.tweets[indexPath.row];
    TweetDetailsViewController *tdvc = [[TweetDetailsViewController alloc]init];
    tdvc.selectedTweet = selectedTweet;
    [self.navigationController pushViewController:tdvc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - Private methods

- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

- (void)onComposeButton{
    [self.navigationController presentViewController:[[ComposeViewController alloc]init] animated:YES completion:nil];
}

- (void)reload {
    [[TwitterClient instance] homeTimelineWithCount:20 sinceId:0 maxId:0 success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        self.tweets = [Tweet tweetsWithArray:response];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
}

@end
