//
//  MySqliteDB.m
//  zntd
//
//  Created by x c on 16/9/24.
//  Copyright © 2016年 x c. All rights reserved.
//

#import "MySqliteDB.h"

#define DBNAME @"flowerinfo.plist"
#define FLOWERID @"flowerId"
#define CURRENTSTATE @"currentState"
#define MAXSTATE @"maxState"



@interface MySqliteDB ()
@property (weak, nonatomic) IBOutlet UILabel *flowerId;
@property (weak, nonatomic) IBOutlet UILabel *currentState;
@property (weak, nonatomic) IBOutlet UILabel *maxState;
@property (nonatomic)NSInteger fId;
@property (nonatomic)NSInteger cState;
@property (nonatomic)NSInteger mState;


@end

@implementation MySqliteDB

- (void)viewDidLoad {
    [super viewDidLoad];
    _fId=1;
    _cState=1;
    _mState=1;
    NSString *filePath=[self pathWithDatabase];
   
    // Do any additional setup after loading the view.
   // NSString *filePath=[self pathWithDatabase];
    
    NSArray *flowerinfo=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%ld",(long)1],[NSString stringWithFormat:@"%ld",(long)0],[NSString stringWithFormat:@"%ld",(long)0], nil];
    [flowerinfo writeToFile:filePath atomically:YES];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSArray *flowerinfo=[[NSArray alloc]initWithContentsOfFile:filePath];
       // flowerinfo[0]=[NSString stringWithFormat:@"%d",1];
        
         _flowerId.text=flowerinfo[0];
        _currentState.text=flowerinfo[1];
        _maxState.text=flowerinfo[2];
        
    }
    UIApplication *app=[UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    
    
}
-(void) applicationWillResignActive:(NSNotification *)notification
{
    NSString *filePath=[self pathWithDatabase];
    NSArray *flowerinfo=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%ld",(long)_fId],[NSString stringWithFormat:@"%ld",(long)_cState],[NSString stringWithFormat:@"%ld",(long)_mState], nil];
    [flowerinfo writeToFile:filePath atomically:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)pathWithDatabase{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents=[path objectAtIndex:0];
    NSString *db_path=[documents stringByAppendingPathComponent:DBNAME];
    
    return db_path;
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
