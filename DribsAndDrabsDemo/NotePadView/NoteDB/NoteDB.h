//
//  NoteDB.h
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "BaseDB.h"
#import "NoteModel.h"

@interface NoteDB : BaseDB

+(id) shareNoteDataInstance;

//创建Note表
-(void)createNoteTable;

//添加Note实例
-(BOOL) addNote:(NoteModel *)noteModel;

//查询Note
-(NSArray *)findNotes;

//条件查询NOTE
-(NSArray *)findDayNotes:(NSString *)dayTime;

//修改Note
//-(BOOL) modifyNote:(NoteModel *)noteModel;

//删除Note
-(BOOL) removeNote:(NoteModel *)noteModel;

@end
