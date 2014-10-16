//
//  NoteDB.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "NoteDB.h"

static NoteDB *instance;

@implementation NoteDB

+(id) shareNoteDataInstance
{
    if(instance == nil)
    {
        instance = [[[self class] alloc] init];
    }
    return instance;
}

//创建Note表
-(void)createNoteTable
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS Note (content TEXT, time TEXT PRIMARY KEY)";
    [self createTable:sql];
}

//添加Note实例
-(BOOL) addNote:(NoteModel *)noteModel
{
    NSString *sql = @"INSERT OR REPLACE INTO Note (content ,time) VALUES(?,?)";
    
    NSArray *params = [NSArray arrayWithObjects:noteModel.content,noteModel.noteTime, nil];
    
    return [self dealData:sql paramsarray:params];
}

//查询Note
-(NSArray *)findNotes
{
    NSString *sql = @"SELECT content,time FROM Note";
    NSArray *data = [self selectData:sql columns:2];
    
    NSMutableArray *notes = [NSMutableArray array];
    
    for(NSArray *row in data)
    {
        NSString *content = [row objectAtIndex:0];
        NSString *time = [row objectAtIndex:1];
        
        NoteModel *note = [[NoteModel alloc] init];
        note.content = content;
        note.noteTime = time;
        
        [notes addObject:note];
    }
    
    return notes;
}

//条件查询 某一天
-(NSArray *)findDayNotes:(NSString *)dayTime
{
    NSString *sql = [NSString stringWithFormat:@"SELECT content,time FROM Note WHERE time like '%%%@%%'",dayTime];
    NSArray *data = [self selectData:sql columns:2];
    
    NSMutableArray *notes = [NSMutableArray array];
    
    for(NSArray *row in data)
    {
        NSString *content = [row objectAtIndex:0];
        NSString *time = [row objectAtIndex:1];
        
        NoteModel *note = [[NoteModel alloc] init];
        note.content = content;
        note.noteTime = time;
        
        [notes addObject:note];
    }
    
    return notes;
}

////修改Note
//-(BOOL)modifyNote:(NoteModel *)noteModel
//{
//    NSString *sql = @"UPDATE Note set content = ? where time = ?";
//    NSArray *params = [NSArray arrayWithObjects:noteModel.content,noteModel.noteTime, nil];
//    return [self dealData:sql paramsarray:params];
//}

//删除Note
-(BOOL)removeNote:(NoteModel *)noteModel
{
    NSString *sql = @"DELETE from Note where content = ? and time =?";
    NSArray *params = [NSArray arrayWithObjects:noteModel.content,noteModel.noteTime, nil];
    return [self dealData:sql paramsarray:params];
}

@end
