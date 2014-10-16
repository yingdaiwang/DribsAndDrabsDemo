//
//  BaseDB.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "BaseDB.h"

@implementation BaseDB

-(NSString *)filePath
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/NoteData.sqlite"];
    return filePath;
}

//创建表
-(void)createTable:(NSString *)sql
{
    sqlite3 *sqlite = nil;
    
    //打开数据库
    if(sqlite3_open([self.filePath UTF8String], &sqlite) != SQLITE_OK)
    {
        NSLog(@"打开数据库失败1");
        sqlite3_close(sqlite);
        return ;
    }
    
    char *errmsg;
    if(sqlite3_exec(sqlite, [sql UTF8String], NULL, NULL, &errmsg) != SQLITE_OK)
    {
        NSLog(@"创建表失败: %s",errmsg);
        sqlite3_close(sqlite);
    }
    
    //关闭数据库
    sqlite3_close(sqlite);
}

-(BOOL)dealData:(NSString *)sql paramsarray:(NSArray *)params
{
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    //打开数据库
    if(sqlite3_open([self.filePath UTF8String], &sqlite) != SQLITE_OK)
    {
        NSLog(@"打开数据库失败2");
        sqlite3_close(sqlite);
        return NO;
    }
    
    //编译SQL语句,预处理SQL语句
    if(sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL) != SQLITE_OK)
    {
        NSLog(@"SQL语句编译失败1");
        sqlite3_close(sqlite);
        return NO;
    }
    
    //绑定数据库
    for(int i = 0;i < params.count; i++)
    {
        NSString *value = [params objectAtIndex:i];
        sqlite3_bind_text(stmt, i+1, [value UTF8String], -1, NULL);
    }
    
    //执行SQL语句
    if(sqlite3_step(stmt) == SQLITE_ERROR)
    {
        NSLog(@"SQL语句执行失败");
        sqlite3_close(sqlite);
        return NO;
    }
    
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
    return YES;
    
}

-(NSMutableArray *)selectData:(NSString *)sql columns:(int)number
{
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    //打开数据库
    if(sqlite3_open([self.filePath UTF8String], &sqlite) != SQLITE_OK)
    {
        NSLog(@"打开数据库失败3");
        sqlite3_close(sqlite);
        return nil;
    }
    
    //编译SQL语句,预处理SQL语句
    if(sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL) != SQLITE_OK)
    {
        NSLog(@"SQL语句编译失败2");
        sqlite3_close(sqlite);
        return nil;
    }
    
    //查询数据语句
    int result = sqlite3_step(stmt);
    
    NSMutableArray *data = [NSMutableArray array];
    
    while (result == SQLITE_ROW) 
    {
        NSMutableArray *row = [NSMutableArray arrayWithCapacity:2];
        
        for(int i = 0;i < number;i++)
        {
            //取出查询到的内容
            char *columnText = (char *)sqlite3_column_text(stmt, i);
            
            //转换成字符串
            NSString *string = [NSString stringWithCString:columnText encoding:NSUTF8StringEncoding];
            
            [row addObject:string];
        }
        [data addObject: row];
        
        result = sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
    return data;
    
}

@end
