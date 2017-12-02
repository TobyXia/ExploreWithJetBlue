//
//  FlightChooser.m
//  ExploreWithJetBlue
//
//  Created by Toby on 2017-12-02.
//  Copyright © 2017 YHACK17. All rights reserved.
//

#import "FlightChooser.h"

@interface FlightChooser ()

@end

@implementation FlightChooser

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray * labelsLight;
    keywordsArray = [[NSMutableArray alloc]init];
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *savedArray = [currentDefaults objectForKey:@"labels"];
    if (savedArray != nil)
    {
        NSArray *oldArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedArray];
        if (oldArray != nil) {
            labelsLight = [[NSMutableArray alloc] initWithArray:oldArray];
        } else {
            labelsLight = [[NSMutableArray alloc] init];
        }
    }
    
    for (int i = 0; i < [labelsLight count]; i++){
        [keywordsArray addObject:[labelsLight objectAtIndex:i]];
         if (i == 2){
             break;
         }
    }
    NSLog(@"%@",keywordsArray);
    
    NSString * landmarkName = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"landmarkName"];
    NSString * landmarkLong = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"landmarkLong"];
    NSString * landmarkLat = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"landmarkLat"];
    
    NSLog(@"%@",landmarkName);
    NSLog(@"%@",landmarkLong);
    NSLog(@"%@",landmarkLat);
    
    
    
    
    
    ///////////////////////////////////////////////////////////////////
    NSString *urlString = @"http://2835db01.ngrok.io/getFlights";
    NSString *requestString = [NSString stringWithFormat:@"%@", urlString];
    
    NSURL *url = [NSURL URLWithString: requestString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod: @"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Build model JSON
    NSString *e1 = @"origLong";
    NSString *e2 = @"origLat";
    NSString *e3 = @"destLong";
    NSString *e4 = @"destLat";
    NSString *e5 = @"departureDate";
    NSString *e6 = @"keywords";
    
    NSDictionary *paramsDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"-73", e1, @"40", e2, landmarkLat, e3,landmarkLat, e4, @"12/3/2017", e5, @"", e6, nil];
    
    NSLog(@"%@",paramsDictionary);
    
    NSError *error;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:paramsDictionary options:0 error:&error];
    
    //NSLog(@"%@",requestData);
    [request setHTTPBody: requestData];
    
    // Run the request on a background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self runRequestOnBackgroundThread: request];
    });
}
- (void)runRequestOnBackgroundThread: (NSMutableURLRequest*) request {
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^ (NSData *data, NSURLResponse *response, NSError *error) {
        [self analyzeResults:data];
    }];
    [task resume];
}
- (void)analyzeResults: (NSData*)dataToParse {
    
    // Update UI on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSError *e = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dataToParse options:kNilOptions error:&e];
        NSLog(@"UUUU%@",json);
        /*
        NSArray *responses = [json objectForKey:@"responses"];
        NSLog(@"%@", responses);
        NSDictionary *responseData = [responses objectAtIndex: 0];
        NSDictionary *errorObj = [json objectForKey:@"error"];
         */
        
        
        
        
    });
    
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
