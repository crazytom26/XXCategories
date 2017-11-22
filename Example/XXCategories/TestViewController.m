//
//  TestViewController.m
//  XXCategories
//
//  Created by tom on 2017/11/22.
//Copyright © 2017年 acct<blob>=0xE7BE8AE5AD90. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()



@end

@implementation TestViewController

#pragma mark - life cycle
- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%s",__func__);
#endif
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%s  %@",__func__,self);
    
    [self setUpData];
    [self setUpSubView];
    [self setUpConstraint];
    
}
#pragma mark - private

- (void)setUpData {

    
}
- (void)setUpSubView {
    
    
}
- (void)setUpConstraint {
    
    
}

#pragma mark - public

#pragma mark - delegate

#pragma mark - event response

#pragma mark - getters and setters



@end
