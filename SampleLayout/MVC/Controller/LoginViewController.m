//
//  LoginViewController.m
//  SampleLayout
//
//  Created by Vinoth on 29/05/18.
//  Copyright © 2018 Cumulations. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (strong,nonatomic) DBManager *dbManager;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dbManager = [[DBManager new] shared];
    [self setTextFielddelegate:_textFields];




    


    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
//    [_dbManager saveUserDetail:nil];
    NSArray *array = [self.dbManager getUser];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveAction:(id)sender {
    [_dbManager saveUserDetail:nil];
    
}
#pragma TextField delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
