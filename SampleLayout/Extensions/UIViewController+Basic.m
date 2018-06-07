//
//  UIViewController+Basic.m
//  SampleLayout
//
//  Created by Vinoth on 29/05/18.
//  Copyright © 2018 Cumulations. All rights reserved.
//

#import "UIViewController+Basic.h"

@implementation UIViewController (Basic)
#pragma mark - Text field methods
-(void)setTextFielddelegate:(NSArray<UITextField *>*) array{

    for (UITextField *i in array){
        i.delegate = self;
    }
    

}

@end
