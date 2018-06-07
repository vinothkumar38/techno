//
//  DBManager.m
//  SampleLayout
//
//  Created by Vinoth on 29/05/18.
//  Copyright © 2018 Cumulations. All rights reserved.
//

#import "DBManager.h"
static DBManager *shareManager = nil;

@implementation DBManager

-(instancetype)shared{
    if(shareManager){
        return shareManager;
    }
    else{
        return [self initWithCompletionBlock:^{
            NSLog(@"Creating new instance");
        }];

    }
}
- (id)initWithCompletionBlock:(CallbackBlock)callback;
{
    self = [super init];
    if (!self) return nil;

    //This resource is the same name as your xcdatamodeld contained in your project
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SampleLayout" withExtension:@"momd"];
//    NSLog(modelURL, @"Failed to locate momd bundle in application");
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
//    NSAssert(mom, @"Failed to initialize mom from URL: %@", modelURL);

    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];

    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [moc setPersistentStoreCoordinator:coordinator];
    [self setManagedObjectContext:moc];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSPersistentStoreCoordinator *psc = [[self managedObjectContext] persistentStoreCoordinator];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        ;
        ;
        NSURL *documentsURL =  [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        // The directory the application uses to store the Core Data store file. This code uses a file named "DataModel.sqlite" in the application's documents directory.
        NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"SampleLayout.sqlite"];

        NSError *error = nil;
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        if (!store) {
            NSLog(@"Failed to initalize persistent store: %@\n%@", [error localizedDescription], [error userInfo]);
//            abort();
            //A more user facing error message may be appropriate here rather than just a console log and an abort
        }
        if (!callback) {
            //If there is no callback block we can safely return
            return;
        }
        //The callback block is expected to complete the User Interface and therefore should be presented back on the main queue so that the user interface does not need to be concerned with which queue this call is coming from.
        dispatch_sync(dispatch_get_main_queue(), ^{
            callback();
        });
    });
    return self;
}
- (void)save{
    NSManagedObjectContext *context = [self managedObjectContext];

    // Create a new managed object
//    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Userdetail" inManagedObjectContext:context];

    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

}
#pragma mark Save UserDetails
-(void)saveUserDetail:(Userdetail*)user{

    NSManagedObjectContext *context = [self managedObjectContext];
//    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Userdetail" inManagedObjectContext:context];
    Userdetail *contact = [NSEntityDescription insertNewObjectForEntityForName:@"Userdetail" inManagedObjectContext:context];
    contact.name = @"Vinoth";
    contact.age = 25;
    [self save];

}
-(NSArray*)getUser{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSString *firstName = @"Vinoth";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name == %@", firstName];
    NSFetchRequest<Userdetail*> *request = [NSFetchRequest fetchRequestWithEntityName:@"Userdetail"];
    [request setPredicate:pred];
    [request setReturnsObjectsAsFaults:NO];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];



    NSMutableArray<Userdetail*> *formattedREsult = [NSMutableArray new];
    for(Userdetail *i in results){
        NSLog(@"%@",i.name);
        NSLog(@"%d",i.age);
        [formattedREsult addObject:i];
    }


    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
//        abort();
    }
    return formattedREsult;

}


@end
