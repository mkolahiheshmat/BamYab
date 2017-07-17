//
//  MenuViewController.m
//  yarima
//
//  Created by sina on 12/28/15.
//  Copyright © 2015 sina. All rights reserved.
//

#import "MenuViewController.h"
#import "SVProgressHUD.h"
@interface MenuViewController ()

@end

@implementation MenuViewController
-(void)viewDidAppear:(BOOL)animated{
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    [SVProgressHUD dismiss];
//    if ([[defualt1 objectForKey:@"login"] isEqualToString:@"1"])
//    {
//        self.exitBtn.hidden=NO;
//        self.loginBtn.hidden=YES;
//        self.myHomesBtn.hidden=NO;
//        self.exiticonBtn.hidden=NO;
//        self.loginiconBtn.hidden=YES;
//        self.myHomesiconBtn.hidden=NO;
//        self.exitlabel.hidden=NO;
//        self.loginlabel.hidden=YES;
//        self.myHomeslabel.hidden=NO;
//    }
//    else
//    {
//        self.exitBtn.hidden=YES;
//        self.exiticonBtn.hidden=YES;
//        self.exitlabel.hidden=YES;
//        self.myHomesBtn.hidden=YES;
//        self.myHomesiconBtn.hidden=YES;
//        self.myHomeslabel.hidden=YES;
//        self.loginBtn.hidden=NO;
//        self.loginiconBtn.hidden=NO;
//        self.loginlabel.hidden=NO;
//    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    if ([[defualt1 objectForKey:@"login"] isEqualToString:@"1"])
    {
        self.exitBtn.hidden=NO;
        self.loginBtn.hidden=YES;
        self.myHomesBtn.hidden=NO;
        self.exiticonBtn.hidden=NO;
        self.loginiconBtn.hidden=YES;
        self.myHomesiconBtn.hidden=NO;
        self.exitlabel.hidden=NO;
        self.loginlabel.hidden=YES;
        self.myHomeslabel.hidden=YES;
    }
    else
    {
        self.exitBtn.hidden=YES;
        self.exiticonBtn.hidden=YES;
        self.exitlabel.hidden=YES;
    }
}
-(IBAction)Exit{
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    [defualt1 setObject:@"0" forKey:@"login"];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *Entity = [[NSFetchRequest alloc] init];
    [Entity setEntity:[NSEntityDescription entityForName:@"Entity" inManagedObjectContext:context]];
    [Entity setIncludesPropertyValues:NO];
    NSError *error = nil;
    NSArray *Entityarray = [context executeFetchRequest:Entity error:&error];
    for (NSManagedObject *car in Entityarray) {
        [context deleteObject:car];
    }
    NSError *saveError = nil;
    [context save:&saveError];

    NSManagedObjectContext *context2 = [self managedObjectContext];
    NSFetchRequest *Entity2 = [[NSFetchRequest alloc] init];
    [Entity2 setEntity:[NSEntityDescription entityForName:@"Users" inManagedObjectContext:context2]];
    [Entity2 setIncludesPropertyValues:NO];
    NSError *error2 = nil;
    NSArray *Entityarray2 = [context2 executeFetchRequest:Entity2 error:&error2];
    for (NSManagedObject *car2 in Entityarray2) {
        [context2 deleteObject:car2];
    }
    NSError *saveError2 = nil;
    [context2 save:&saveError2];
    
    
    NSManagedObjectContext *context3 = [self managedObjectContext];
    NSFetchRequest *Entity3 = [[NSFetchRequest alloc] init];
    [Entity3 setEntity:[NSEntityDescription entityForName:@"Detail" inManagedObjectContext:context2]];
    [Entity3 setIncludesPropertyValues:NO];
    NSError *error3 = nil;
    NSArray *Entityarray3 = [context3 executeFetchRequest:Entity3 error:&error3];
    for (NSManagedObject *car3 in Entityarray3) {
        [context3 deleteObject:car3];
    }
    NSError *saveError3 = nil;
    [context3 save:&saveError3];
    
    
    
    [self saveContext];
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
