//
//  UIViewController+Basic.h
//  SampleLayout
//
//  Created by Vinoth on 29/05/18.
//  Copyright © 2018 Cumulations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (Basic) <UITextFieldDelegate>
//@property (strong,nonatomic) MBProgressHUD *hud;
//@property (strong,nonatomic) MBProgressHUD *hudToast;
//@property (strong,nonatomic) UIStoryboard *mainStoryBoard;
//@property (strong,nonatomic) UIAlertController *alertController;
//-(void)showAlertWithTitle:(NSString*)title withAlertMessage:(NSString*)message andWithcancelTitle:(NSString*)cancelTitle andOtherActions:(NSArray<UIAlertAction*>*)otherActions;

-(void)setTextFielddelegate:(NSArray<UITextField *>*) array;
@end
