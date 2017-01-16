//
//  ViewController.m
//  zntd
//
//  Created by x c on 16/7/14.
//  Copyright © 2016年 x c. All rights reserved.
//

#import "ViewController.h"
#import "MZTimerLabel.h"
#import "QuartzCore/QuartzCore.h"
#import "WBAlertView.h"

#define DBNAME @"flowerinfo.plist"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *bag;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"infoofflower" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@", data);
    NSDictionary *tmpInfo = [data objectForKey: @"11"];
     NSLog(@"%@",[NSString stringWithFormat:@"%@", [tmpInfo objectForKey: @"pictureName"]]);
    
    _circlebackground.layer.zPosition = -1;
    //初始化种花成功后的绿叶和虫子
    UILabel *labelforleaf=[[UILabel alloc] init];
    UILabel *labelforbug=[[UILabel alloc] init];
    labelforbug.text=[NSString stringWithFormat:@"%ld",(long)_numofbug];
    labelforleaf.text=[NSString stringWithFormat:@"%ld",(long)_numofleaf];
    
    
    [_circlebackground addSubview:labelforleaf];
    [_circlebackground addSubview:labelforbug];
    
    
    _plantButton.layer.zPosition=2;
    
    
    //数据持久化设置
    NSString *filePath=[self pathWithDatabase];

    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSArray *flowerinfo=[[NSArray alloc]initWithContentsOfFile:filePath];
        
        _fId=[flowerinfo[0] integerValue];
        _cState=[flowerinfo[1] integerValue];
        _mState=[flowerinfo[2] integerValue];
        
     
        
    }
    
    if(_transistFId!=0){
        _fId = _transistFId;
        [self saveflowerinfo];
    }
    UIApplication *app=[UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    //倒计时
    _stopwatch = [[MZTimerLabel alloc] initWithLabel:_aUIlabel andTimerType:MZTimerLabelTypeTimer];
   
    _stopwatch.delegate = self;
    //设置等级
    [self setFlowerImage];
  

    _seconds=5;//默认的倒计时时间

    
}
//数据存储路径返回
- (NSString *)pathWithDatabase{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents=[path objectAtIndex:0];
    NSString *db_path=[documents stringByAppendingPathComponent:DBNAME];
    
    return db_path;
}

-(void) applicationWillResignActive:(UIApplication *)application
{
    NSString *filePath=[self pathWithDatabase];
    NSArray *flowerinfo=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%ld",(long)_fId],[NSString stringWithFormat:@"%ld",(long)_cState],[NSString stringWithFormat:@"%ld",(long)_mState], nil];
    [flowerinfo writeToFile:filePath atomically:YES];
    
}

-(void) saveflowerinfo{
    NSString *filePath=[self pathWithDatabase];
    NSArray *flowerinfo=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%ld",(long)_fId],[NSString stringWithFormat:@"%ld",(long)_cState],[NSString stringWithFormat:@"%ld",(long)_mState], nil];
    [flowerinfo writeToFile:filePath atomically:YES];
}
- (IBAction)plantBtnPressed:(id)sender {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"" message:@"你确定要种花吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes=[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _aUIlabel.hidden=NO;
        _plantnotice.hidden=YES;
        _relaxbutton.hidden=NO;
        //将背景图切换为种花
        _circlebackground.image=[UIImage imageNamed:@"开始种植副本.png"];

        [_stopwatch setCountDownTime:_seconds];//设置倒计时长
        [_stopwatch start];//开始倒计
    }];
    UIAlertAction *no=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
    }];
    [alert addAction:yes];
    [alert addAction:no];
    
    [self presentViewController:alert animated:YES completion:^{
        
        
    }];

}
//实现页面间的传值
- (void)passFlowerKey:(NSInteger)value{
    _fId=value;
    NSLog(@"the get value is %ld", (long)value);
}
- (IBAction)setTimeFunction:(id)sender {
   
    
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
       // NSLog(@"%@",minuteString);
        int hour=[hourString intValue];
        int minute=[minuteString intValue];
        _seconds=hour*3600+minute*60;
        NSString *hourInt = [NSString stringWithFormat:@"%ld",(long)_seconds];
        
        NSLog(@"%@",hourInt);
        
        
        //显示标签
        _aUIlabel.hidden=NO;
        _plantnotice.hidden=YES;
        _relaxbutton.hidden=NO;
        //跳出picker选择倒计时间
        if(_seconds>0)
            
        { [_stopwatch setCountDownTime:_seconds];//设置倒计时长
            [_stopwatch start];//开始倒计
        }
        
        
    }];
    UIAlertAction *no=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        //设置默认的时间？
//        _seconds=1800;
//        //显示标签
//        _aUIlabel.hidden=NO;
//        _plantnotice.hidden=YES;
//        _relaxbutton.hidden=NO;
//        //跳出picker选择倒计时间
//        if(_seconds>0)
//            
//        { [_stopwatch setCountDownTime:_seconds];//设置倒计时长
//            [_stopwatch start];//开始倒计
//        }
    }];
    
    [alert addAction:yes];//添加按钮
    
    [alert addAction:no];//添加按钮
    //以modal的形式
    [self presentViewController:alert animated:YES completion:^{
        
        
    }];
    
   
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
        [_stopwatch reset];
        _aUIlabel.hidden=YES;
        _plantnotice.hidden=NO;
        _relaxbutton.hidden=YES;
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
    //组件的显示和隐藏
    _aUIlabel.hidden=YES;
    _plantnotice.hidden=NO;
    _relaxbutton.hidden=YES;
    //将背景图切换为种花成功
    _circlebackground.image=[UIImage imageNamed:@"种植成功6副本.png"];
    //设置虫子数和绿叶数
    _numofleaf=3;
    _numofbug=1;
    _fId++;
    [self saveflowerinfo];
    [self setFlowerImage];
    
}

//背包
- (IBAction)showBag:(id)sender {
    WBAlertView *customAlert = [[WBAlertView alloc] initWithTitle:@""
                                                          message:@"\n\n\n\n魔法水"
                                                cancelButtonTitle:@"取消"
                                               confirmButtonTitle:@"确定"];
    
    customAlert.delegate = self;
    
    // UIView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 255, 196)];
    // view.backgroundColor = [UIColor redColor];
    // view.tag = 100;
    
    //UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0,0,382,382)];
    //UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"魔法水.png"]];
    //myView.backgroundColor = bgColor;
    
    
    UIImageView *subview = [[UIImageView alloc] initWithFrame:
                            CGRectMake(0, 0, 128.0f, 128.0f)];
    
    // UIView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 255, 196)];
    //view.backgroundColor = [UIColor redColor];
    
    //设定图片名称,myPic.png已经存在，拖放添加图片文件到image项目文件夹中
    [subview setImage:[UIImage imageNamed:@"魔法水副本.png"]];
    [subview setTintColor:[UIColor blueColor]];
    [subview setContentMode:UIViewContentModeScaleToFill];
    
    //在 View 中加入图片 subview ，
    [self.view addSubview:subview];
    
    //使用后释放subview
    //[subview release];
    
    customAlert.contentView = subview;
    customAlert.hideButton = NO;
    [customAlert show];
    
    
}

- (IBAction)setFlowerImage{
    //从plist里查询 level对应的花的图片信息。
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"infoofflower" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSDictionary *tmpInfo = [data objectForKey: [NSString stringWithFormat:@"%ld",(long)_fId]];
    //设置当前花的图片
    NSString *pictureStr=[NSString stringWithFormat:@"%@", [tmpInfo objectForKey: @"pictureName"]];
    [_plantButton setBackgroundImage:[UIImage imageNamed:pictureStr] forState:UIControlStateNormal];
    
    
    
    
    
    
    
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
