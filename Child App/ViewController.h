//
//  ViewController.h
//  Child App
//
//  Created by amir sankar on 4/20/16.
//  Copyright © 2016 amir sankar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

- (IBAction)reportLocationButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic)  NSString *childLatitude;
@property (strong, nonatomic)  NSString *childLongitude;


@end

