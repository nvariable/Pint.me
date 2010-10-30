//
//  Pint_meAppDelegate.h
//  Pint.me
//
//  Created by Mark Turner on 10/29/10.
//  Copyright 2010 Western Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Pint_meViewController;

@interface Pint_meAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Pint_meViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Pint_meViewController *viewController;

@end

