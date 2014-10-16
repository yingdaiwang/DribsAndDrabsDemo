//
//  BaseDB.h
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface BaseDB : NSObject

//创建表
-(void)createTable:(NSString *)sql;

/*
 *接口描述：增加数据，删除数据，修改数据
 *参数：sql：SQL语句
 *返回值；是否执行成功
 */
-(BOOL) dealData:(NSString *)sql paramsarray:(NSArray *)params;

/*
 *返回值：［
             ［“记事本内容1”，“时间1”］，
             ［“记事本内容1”，“时间1”］，
          ］
 */
-(NSMutableArray *)selectData:(NSString *)sql columns:(int)number;

-(NSString *)filePath;

@end
