//
//  MySqliteDB.h
//  zntd
//
//  Created by x c on 16/9/24.
//  Copyright © 2016年 x c. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>  

@interface MySqliteDB : UIViewController
{
    sqlite3 *db;
    
}
@end

