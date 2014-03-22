//
//  ViewController.m
//  BusOn
//
//  Created by Pedro Augusto Silva Lucena on 22/03/14.
//  Copyright (c) 2014 Pedro Augusto Silva Lucena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passText;
//@property (strong, nonatomic) NSString *email;
//@property (strong, nonatomic) NSString *password;

@end

@implementation ViewController

- (IBAction)LoginClick:(id)sender {
    NSString *email = _emailText.text;
    NSString *password = _passText.text;
    if (email && password){
        
    }
    
        

    }


@end
