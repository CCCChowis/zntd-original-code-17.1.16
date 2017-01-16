//
//  PlantViewController.m
//  zntd
//
//  Created by x c on 16/8/1.
//  Copyright © 2016年 x c. All rights reserved.
//

#import "PlantViewController.h"
#import "MZTimerLabel.h"
@interface PlantViewController ()
@property (weak, nonatomic) IBOutlet UILabel *aUILabel;
@property (strong,nonatomic)IBOutlet MZTimerLabel *stopwatch;

@end

@implementation PlantViewController
//种花页面

- (void)viewDidLoad {
    [super viewDidLoad];
      //倒计时
    _stopwatch = [[MZTimerLabel alloc] initWithLabel:_aUILabel andTimerType:MZTimerLabelTypeTimer];
    [_stopwatch setCountDownTime:3600];//设置倒计时长
    _stopwatch.delegate = self;
    [_stopwatch start];//开始倒计

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startCountDownWithDelegate:(id)sender {
    //开始倒计的函数
    if(![_stopwatch counting]){
        [_stopwatch start];
    }
}
- (IBAction)pauseCountDownWithDelegate:(id)sender {
    //暂停倒计时
    if([_stopwatch counting]){
        [_stopwatch pause];
    }
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"现在要去休息吗？花会枯萎哦！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesaction=[UIAlertAction actionWithTitle:@"去玩耍" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        //点击去玩耍选项相应的代码。。
    }];
    
    UIAlertAction *noaction=[UIAlertAction actionWithTitle:@"坚持" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //坚持选项，倒计时继续倒计
        [_stopwatch start];
    }];
    [alert addAction:yesaction];
    [alert addAction:noaction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    //倒计时结束后。。。
    NSString *msg = [NSString stringWithFormat:@"Countdown of Example 6 finished!\nTime counted: %i seconds",(int)countTime];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles:nil];
    [alertView show];
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
