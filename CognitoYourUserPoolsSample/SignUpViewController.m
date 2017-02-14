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

#import "SignUpViewController.h"
#import "AWSCognitoIdentityProvider.h"
#import "ConfirmSignUpViewController.h"
#import "JVFloatLabeledTextField.h"
#import "Constants.h"

@interface SignUpViewController () <UITextFieldDelegate> {
    IBOutlet UITextField *username;
    IBOutlet UITextField *email;
    IBOutlet UITextField *phone;
    IBOutlet UITextField *password;
    IBOutlet UITextField *retryPassword;
    IBOutlet UITextField *country;
    IBOutlet UITextField *firstname;
    IBOutlet UITextField *lastname;
    
    IBOutlet UIButton *btnSignUp;
}


@property (nonatomic, strong) AWSCognitoIdentityUserPool * pool;
@property (nonatomic, strong) NSString* sentTo;
@end

//const static CGFloat kJVFieldFontSize = 16.0f;
//
//const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;




@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
//    UIColor *floatingLabelColor = [UIColor colorWithRed:50.0/255.0 green:197.0/255.0 blue:210.0/255.0 alpha:1.0];
//    //    username.clearButtonMode = UITextFieldViewModeWhileEditing;
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
//    email.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//    email.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"", @"")
//                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
//    email.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//    email.floatingLabelTextColor = floatingLabelColor;
//    email.placeholder = @"Email";
//    email.keepBaseline = YES;
//    
//    phone.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//    phone.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"", @"")
//                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
//    phone.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//    phone.floatingLabelTextColor = floatingLabelColor;
//    phone.placeholder = @"Phone";
//    phone.keepBaseline = YES;
//    
//    password.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//    password.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"", @"")
//                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
//    password.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//    password.floatingLabelTextColor = floatingLabelColor;
//    password.placeholder = @"Password";
//    password.keepBaseline = YES;
//    
//    retryPassword.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//    retryPassword.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"", @"")
//                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
//    retryPassword.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//    retryPassword.floatingLabelTextColor = floatingLabelColor;
//    retryPassword.placeholder = @"Retry Password";
//    retryPassword.keepBaseline = YES;
//    
//    country.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//    country.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"", @"")
//                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
//    country.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//    country.floatingLabelTextColor = floatingLabelColor;
//    country.placeholder = @"Select Coubntry";
//    country.keepBaseline = YES;
//    
//    firstname.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//    firstname.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"", @"")
//                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
//    firstname.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//    firstname.floatingLabelTextColor = floatingLabelColor;
//    firstname.placeholder = @"First Name";
//    firstname.keepBaseline = YES;
//    
//    lastname.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//    lastname.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"", @"")
//                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
//    lastname.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//    lastname.floatingLabelTextColor = floatingLabelColor;
//    lastname.placeholder = @"Last Name";
//    lastname.keepBaseline = YES;
//    
//    btnSignUp.backgroundColor = themeBackGroundColor;
}

- (void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([@"confirmSignUpSegue" isEqualToString:segue.identifier]){
        ConfirmSignUpViewController *cvc = segue.destinationViewController;
        cvc.sentTo = self.sentTo;
        cvc.user = [self.pool getUser:username.text];
    }
}

- (IBAction)signUp:(id)sender {
    NSMutableArray * attributes = [NSMutableArray new];
    AWSCognitoIdentityUserAttributeType * phoneAtt = [AWSCognitoIdentityUserAttributeType new];
    phoneAtt.name = @"phone_number";
    phoneAtt.value = phone.text;
    AWSCognitoIdentityUserAttributeType * emailAtt = [AWSCognitoIdentityUserAttributeType new];
    emailAtt.name = @"email";
    emailAtt.value = email.text;
    
    if(![@"" isEqualToString:phoneAtt.value]){
        [attributes addObject:phone];
    }
    if(![@"" isEqualToString:emailAtt.value]){
        [attributes addObject:email];
    }
    
    //sign up the user
    [[self.pool signUp:username.text password:password.text userAttributes:attributes validationData:nil] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserPoolSignUpResponse *> * _Nonnull task) {
        NSLog(@"Successful signUp user: %@",task.result.user.username);
        dispatch_async(dispatch_get_main_queue(), ^{
            if(task.error){
                [[[UIAlertView alloc] initWithTitle:task.error.userInfo[@"__type"]
                                            message:task.error.userInfo[@"message"]
                                           delegate:nil
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil] show];
            }else if(task.result.user.confirmedStatus != AWSCognitoIdentityUserStatusConfirmed){
                self.sentTo = task.result.codeDeliveryDetails.destination;
                [self performSegueWithIdentifier:@"confirmSignUpSegue" sender:sender];
            }
            else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }});
        return nil;
    }];
}

/**
 Ensure phone number starts with country code i.e. (+1)
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; {
    if(textField == phone){
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\+(|\\d)*$" options:0 error:nil];
        NSString *proposedPhone = [phone.text stringByReplacingCharactersInRange:range withString:string];
        if(proposedPhone.length != 0){
            return [regex numberOfMatchesInString:proposedPhone options:NSMatchingAnchored range:NSMakeRange(0, proposedPhone.length)]== 1;
        }
    }
    return YES;
}

@end
