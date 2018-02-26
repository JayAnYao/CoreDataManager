//
//  JAYCoreDataStackManager.m
//  CoreDataDemo
//
//  Created by Jay on 2018/2/26.
//  Copyright © 2018年 CM. All rights reserved.
//

#import "JAYCoreDataStackManager.h"

#define KJAYCoreManagerInstance [JAYCoreDataStackManager shareInstance]

@implementation JAYCoreDataStackManager

+ (instancetype)shareInstance
{
    static JAYCoreDataStackManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JAYCoreDataStackManager alloc] init];
    });
    return instance;
}

// 获取文件位置
- (NSURL *)getDocumentUrlPath
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// 懒加载managerContext
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 设置调度存储器
    [_managedObjectContext setPersistentStoreCoordinator:self.managedDinator];
    
    return _managedObjectContext;
}

// 懒加载模型对象
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    _managedObjectModel  = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

// 懒加载调度存储器
- (NSPersistentStoreCoordinator *)managedDinator
{
    if (_managedDinator != nil) {
        return _managedDinator;
    }
    
    _managedDinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    //添加存储器
    /**
     * type:一般使用数据库存储方式NSSQLiteStoreType
     * configuration:配置信息 一般无需配置
     * URL:要保存的文件路径
     * options:参数信息 一般无需设置
     */
    
    //拼接url路径
    NSURL *url = [[self getDocumentUrlPath]URLByAppendingPathComponent:@"sqlit.db" isDirectory:YES];
    
    [_managedDinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:nil];
    
    return _managedDinator;
}

// 保存数据
- (void)save
{
    NSError *error;
    
    [self.managedObjectContext save:&error];
    
    if (error) {
        NSLog(@"数据库在保存中出现了%@的问题", error);
    }else {
        NSLog(@"保存成功");
    }
}

@end
