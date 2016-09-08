//
//  NowReported.m
//  Child App
//
//  Created by amir sankar on 4/25/16.
//  Copyright © 2016 amir sankar. All rights reserved.
//

#import "NowReported.h"

@interface NowReported ()
-(IBAction)okButton:(id)sender;

@end

@implementation NowReported

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

-(IBAction)okButton:(id)sender{
    [self performSegueWithIdentifier:@"returnToMainView" sender:self];
}

@end
