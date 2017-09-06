//
//  YMYindaoViewController.m
//  doctor_user
//
//  Created by kupurui on 17/2/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMYindaoViewController.h"

@interface YMYindaoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myBack;

@end

@implementation YMYindaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myBack.image = [UIImage imageNamed:@"yindao"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
