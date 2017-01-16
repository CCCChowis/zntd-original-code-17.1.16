//
//  ViewController.h
//  zntd
//
//  Created by x c on 16/7/14.
//  Copyright © 2016年 x c. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"

@interface ViewController : UIViewController<MZTimerLabelDelegate>{

}
@property (weak, nonatomic) IBOutlet UIImageView *circlebackground;
@property (weak, nonatomic) IBOutlet UILabel *aUIlabel;
@property (weak, nonatomic) IBOutlet UIButton *plantButton;
@property (weak, nonatomic) IBOutlet UILabel *plantnotice;
@property(strong,nonatomic) MZTimerLabel *stopwatch;
@property (weak, nonatomic) IBOutlet UIButton *relaxbutton;
//@property(nonatomic) NSInteger level;
@property(nonatomic)NSInteger seconds;
@property(nonatomic) NSInteger numofleaf;
@property(nonatomic) NSInteger numofbug;

@property (nonatomic)NSInteger cState;
@property (nonatomic)NSInteger mState;
@property (nonatomic)NSInteger fId;
@property (nonatomic)NSInteger transistFId;
@end

