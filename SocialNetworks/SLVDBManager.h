//
//  SLVDBManager.h
//  Social Networks
//
//  Created by Ostap R on 15.08.14.
//  Copyright (c) 2014 SoftServe Lv-120. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Users.h"


typedef enum Service
{
    FacebookService,
    TwitterService,
    VkontakteService,
    LinkedInService=4
    
        
} Service;

@interface SLVDBManager : NSObject

@property (nonatomic) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic) NSPersistentStore *store;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSManagedObjectModel *model;

+ (id)sharedManager;
-(void)saveChanges;
@end
