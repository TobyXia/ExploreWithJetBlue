//
//  FlightChooser.h
//  ExploreWithJetBlue
//
//  Created by Toby on 2017-12-02.
//  Copyright © 2017 YHACK17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightChooser : UIViewController{
    float origLong;
    float destLong;
    float destLat; 
    
    NSString * departureDate;
    NSMutableArray * keywordsArray;
}




@end
