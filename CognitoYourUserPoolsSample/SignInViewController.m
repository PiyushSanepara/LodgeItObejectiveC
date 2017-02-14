//
// Copyright 2014-2016 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Amazon Software License (the "License").
// You may not use this file except in compliance with the
// License. A copy of the License is located at
//
//     http://aws.amazon.com/asl/
//
// or in the "license" file accompanying this file. This file is
// distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, express or implied. See the License
// for the specific language governing permissions and
// limitations under the License.
//

#import "SignInViewController.h"
#import "JVFloatLabeledTextField.h"
#import "Constants.h"

@interface SignInViewController () {
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    
    IBOutlet UIButton *btnSignIn;
}



//@property (weak, nonatomic) IBOutlet UITextField *password;
//@property (weak, nonatomic) IBOutlet UITextField *username;
@property (nonatomic, strong) AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails*>* passwordAuthenticationCompletion;
@end

//const static CGFloat kJVFieldFontSize = 16.0f;
//
//const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@implementation SignInViewController

-(void)viewDidLoad {
//    UIColor *floatingLabelColor = [UIColor colorWithRed:50.0/255.0 green:197.0/255.0 blue:210.0/255.0 alpha:1.0];
//    
//    username.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//    username.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"", @"")
//                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
//    username.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//    username.floatingLabelTextColor = floatingLabelColor;
//    username.placeholder = @"Username";
//    username.keepBaseline = YES;
//    
//    password.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//    password.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"", @"")
//                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
//    password.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//    password.floatingLabelTextColor = floatingLabelColor;
//    password.placeholder = @"Password";
//    password.keepBaseline = YES;
    
//    btnSignIn.backgroundColor = themeBackGroundColor;
}

- (void) viewWillAppear:(BOOL)animated {
    password.text = nil;
    username.text = self.usernameText;
//    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)signInPressed:(id)sender {
    self.passwordAuthenticationCompletion.result = [[AWSCognitoIdentityPasswordAuthenticationDetails alloc] initWithUsername:username.text password:password.text];
}


-(void) getPasswordAuthenticationDetails: (AWSCognitoIdentityPasswordAuthenticationInput *) authenticationInput  passwordAuthenticationCompletionSource: (AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails *> *) passwordAuthenticationCompletionSource {
    self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.usernameText)
            self.usernameText = authenticationInput.lastKnownUsername;
    });
    
}

-(void) didCompletePasswordAuthenticationStepWithError:(NSError*) error {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(error){
            [[[UIAlertView alloc] initWithTitle:error.userInfo[@"__type"]
                                        message:error.userInfo[@"message"]
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"Retry", nil] show];
        }else{
            self.usernameText = nil;
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

@end
