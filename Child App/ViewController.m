//
//  ViewController.m
//  Child App
//
//  Created by amir sankar on 4/20/16.
//  Copyright © 2016 amir sankar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate=self;
    //self.locationManager.distanceFilter = kCLHeadingFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reportLocationButton:(id)sender {
    NSString *newUsername = [NSString stringWithFormat:@"https://turntotech.firebaseio.com/digitalleash/%@.json", self.usernameTextField.text];
    
    NSURL *url = [NSURL URLWithString:newUsername];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session= [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"PATCH";
    
    NSDictionary *userDetails =
    @{@"username":self.usernameTextField.text,@"childLatitude":self.childLatitude,@"childLongitude": self.childLongitude};
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:userDetails options:kNilOptions error:&error];
    if (!error) {     ///dataTaskWithRequest change
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"Update Complete");
            if(error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ERROR"
                                                                                             message:[error localizedDescription]
                                                                                      preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                       style:UIAlertActionStyleDefault
                                                                     handler:nil];
                    [alertController addAction:actionOk];
                    [self presentViewController:alertController animated:YES completion:nil];
                });
                return;
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"nowBeingReported"] animated:YES completion:nil];
                });
            }
        }];
        [uploadTask resume];
    }
}

//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    NSLog(@"%2",[error localizedDescription]);
//}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray*)locations
{
    CLLocation *currentLocation = [locations lastObject];
    self.childLongitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
    self.childLatitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    NSLog(@"%@ %@", self.childLongitude, self.childLatitude);
}

@end
