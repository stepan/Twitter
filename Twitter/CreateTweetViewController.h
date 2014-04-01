//
//  CreateTweetViewController.h
//  Twitter
//
//  Created by Stepan Grigoryan on 3/30/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateTweetViewController : UIViewController <UITextViewDelegate>
- (id)initWithInitialText:(NSString *)text;
@end
