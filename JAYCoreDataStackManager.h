//
//  JAYCoreDataStackManager.h
//  CoreDataDemo
//
//  Created by Jay on 2018/2/26.
//  Copyright © 2018年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface JAYCoreDataStackManager : NSObject

// 单例
+ (instancetype)shareInstance;

/** 管理对象上下文*/
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

/** 模型对象*/
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

/** 储存调度器*/
@property (nonatomic, strong) NSPersistentStoreCoordinator *managedDinator;

/** 保存数据的方法*/
- (void)save;

@end
