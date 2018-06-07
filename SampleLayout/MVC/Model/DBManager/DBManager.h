//
//  DBManager.h
//  SampleLayout
//
//  Created by Vinoth on 29/05/18.
//  Copyright © 2018 Cumulations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Userdetail+CoreDataClass.h"

@import CoreData;
typedef void (^CallbackBlock)(void);

@interface DBManager : NSObject
@property (strong, nonatomic, readonly) NSPersistentContainer *persistentContainer;
@property(strong,nonatomic) NSManagedObjectContext *managedObjectContext;
-(instancetype)shared;
-(void)saveUserDetail:(Userdetail*)user;
-(NSArray*)getUser;

@end
