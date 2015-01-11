//
//  ViewController.m
//  bridge
//
//  Created by Hashim Shafique on 1/8/15.
//  Copyright (c) 2015 Hashim Shafique. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MyLogInViewController.h"

@interface ViewController () <PFLogInViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *loggedInLabel;
- (IBAction)logoutButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *logout;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginTouch:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.logout.hidden = YES;
    self.loggedInLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) {
        // Customize the Log In View Controller
        MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
        [logInViewController setDelegate:self];
        [logInViewController setFacebookPermissions:[NSArray arrayWithObjects:@"friends_about_me", nil]];
        [logInViewController setFields:PFLogInFieldsUsernameAndPassword
         | PFLogInFieldsFacebook
         | PFLogInFieldsSignUpButton
         | PFLogInFieldsDismissButton
         | PFLogInFieldsLogInButton
         | PFLogInFieldsPasswordForgotten
         | PFLogInFieldsTwitter];
    
        // Present Log In View Controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    else
    {
        self.logout.hidden = NO;
        self.loggedInLabel.hidden = NO;
        self.loginButton.hidden = YES;
    }
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    NSLog(@"did log in");
    [self dismissViewControllerAnimated:YES completion:nil];
    self.loggedInLabel.hidden = NO;
    self.loginButton.hidden = YES;
    self.logout.hidden = NO;
}

- (IBAction)logoutButton:(id)sender
{
    [PFUser logOut];
    self.loggedInLabel.hidden = YES;
    self.loginButton.hidden = NO;
    self.logout.hidden =YES;

}

- (IBAction)loginTouch:(id)sender
{
    if (![PFUser currentUser]) {
        // Customize the Log In View Controller
        MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
        
        [logInViewController setDelegate:self];
        [logInViewController setFacebookPermissions:[NSArray arrayWithObjects:@"friends_about_me", nil]];
        [logInViewController setFields:PFLogInFieldsUsernameAndPassword
         | PFLogInFieldsFacebook
         | PFLogInFieldsSignUpButton
         | PFLogInFieldsDismissButton
         | PFLogInFieldsLogInButton
         | PFLogInFieldsPasswordForgotten
         | PFLogInFieldsTwitter];
        
        // Present Log In View Controller
        [self presentViewController:logInViewController animated:YES completion:nil];
    }
}

@end
