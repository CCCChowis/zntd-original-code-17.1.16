//
//  treeViewController.m
//  zntd
//
//  Created by 姚泽铭 on 9/10/16.
//  Copyright © 2016 x c. All rights reserved.
//

#import "treeViewController.h"
#import "TWLAlertView.h"

@interface treeViewController ()

////临时存储plist文件信息
//@property(copy,nonatomic)NSDictionary *names;
//@property(copy,nonatomic)NSArray *keys;
@property(nonatomic)NSInteger keys;
@end

@implementation treeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    //调用plist文件获取树的信息
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"sortednames" ofType:@"plist"];
//    self.names = [NSDictionary dictionaryWithContentsOfFile:path];
//    self.keys = [[self.names allKeys] sortedArrayUsingSelector:@selector(compare:)];

}


//弹出树详情的自定义框方法
- (IBAction)click:(id)sender {
    UIButton * clickedBtn = sender;
     NSInteger flowerkey = clickedBtn.tag;
    NSString *picName=[self getPictureNameFromPlist:flowerkey];
    NSString *introStr=[self getIntroductionFromPlist:flowerkey];

   // NSLog([NSString stringWithFormat:@"%ld",(long)flowerkey]);
    [self loadAlertView:picName contentStr:introStr btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"取消",@"种植", nil] type:10 parentBtnTag:flowerkey parentVC:self];

    
}
- (IBAction)click{
    
}
-(NSString *)getIntroductionFromPlist:(NSInteger)flowerkey
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"infoofflower" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSDictionary *tmpInfo = [data objectForKey: [NSString stringWithFormat:@"%ld",(long)flowerkey]];
    //设置当前花的图片
    NSString *introStr=[NSString stringWithFormat:@"%@", [tmpInfo objectForKey: @"introduction"]];
    return introStr;

}
-(NSString *)getPictureNameFromPlist:(NSInteger)flowerkey
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"infoofflower" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSDictionary *tmpInfo = [data objectForKey: [NSString stringWithFormat:@"%ld",(long)flowerkey]];
    //设置当前花的图片
    NSString *picStr=[NSString stringWithFormat:@"%@", [tmpInfo objectForKey: @"pictureName"]];
    return picStr;
    
}


-(IBAction)showLowestTree:(id)sender{
    
    //下次迭代这里应该改为用自带alertview
    
    [self loadAlertView:@"初级树" contentStr:@"这里已经是初级树了喔，别再点我啦，好害羞喔" btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"就要点你",@"知道啦", nil]type:10 parentBtnTag:1 parentVC:self];
}

-(IBAction)showMiddleTree:(id)sender{
    
    //下次迭代这里应该改为用自带alertview
    [self loadAlertView:@"中级树" contentStr:@"这里已经是中级树了喔，别再点我啦，好害羞喔" btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"就要点你",@"知道啦", nil]type:10 parentBtnTag:2 parentVC:self];
}

-(IBAction)showHighestTree:(id)sender{
    
    //下次迭代这里应该改为用自带alertview
    [self loadAlertView:@"高级树" contentStr:@"这里已经是高级树了喔，别再点我啦，好害羞喔" btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"就要点你",@"知道啦", nil]type:10 parentBtnTag:3 parentVC:self];
}

- (IBAction)backToLowerTree:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}


//自定义弹出框初始化
- (void)loadAlertView:(NSString *)title contentStr:(NSString *)content btnNum:(NSInteger)num btnStrArr:(NSArray *)array type:(NSInteger)typeStr parentBtnTag:(NSInteger)tag parentVC:(UIViewController*)pVC
{
    
    TWLAlertView *alertView = [[TWLAlertView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [alertView initWithTitle:title contentStr:content type:typeStr btnNum:num btntitleArr:array parentBtntag:tag parentVC:pVC];
    alertView.delegate = self;
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview: alertView];
    
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
