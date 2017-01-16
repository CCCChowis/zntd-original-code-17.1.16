//
//  TestViewController.m
//  zntd
//
//  Created by x c on 16/8/6.
//  Copyright © 2016年 x c. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property(nonatomic)NSInteger seconds;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"infoofflower" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@", data);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnPressed:(id)sender {
    UIDatePicker *datePicker=[[UIDatePicker alloc] init];
    
    datePicker.datePickerMode=UIDatePickerModeCountDownTimer;
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert.view addSubview:datePicker];
    
    UIAlertAction *yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
   
        NSDateFormatter* dateFormathour = [[NSDateFormatter alloc] init];
        NSDateFormatter* dateFormatminute = [[NSDateFormatter alloc] init];
        //实例化一个NSDateFormatter对象
        [dateFormathour setDateFormat:@"HH"];//设定时间格式
        [dateFormatminute setDateFormat:@"mm"];//设定时间格式
        NSString *hourString = [dateFormathour stringFromDate:datePicker.date];
         NSString *minuteString = [dateFormatminute stringFromDate:datePicker.date];
        
        int hour=[hourString intValue];
        int minute=[minuteString intValue];
        _seconds=hour*3600+minute*60;
        NSString *hourInt = [NSString stringWithFormat:@"%ld",(long)_seconds];

        NSLog(@"%@",hourInt);
        

        
    }];
    UIAlertAction *no=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    //设置默认的时间？
        
    }];
    
    [alert addAction:yes];//添加按钮
    
    [alert addAction:no];//添加按钮
    //以modal的形式
    [self presentViewController:alert animated:YES completion:^{ }];

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
