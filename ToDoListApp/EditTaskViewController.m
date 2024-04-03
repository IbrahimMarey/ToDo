//
//  EditTaskViewController.m
//  ToDoListApp
//
//  Created by Khokha on 02/04/2024.
//

#import "EditTaskViewController.h"
#import "ToDoPonso.h"
@interface EditTaskViewController ()
{
    ToDoPonso *task;
    NSUserDefaults *myDefaults;
    NSData *defaultTasks;
    NSMutableArray *tasksArr;
    NSMutableArray* inProssesArr ;
    NSMutableArray* doneArr ;
}
@property (weak, nonatomic) IBOutlet UITextField *tilteEdit;
@property (weak, nonatomic) IBOutlet UITextField *descEdit;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmentEdit;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegmentEdit;

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    task = [ToDoPonso new];
    myDefaults = [NSUserDefaults standardUserDefaults];
    defaultTasks = [myDefaults objectForKey:@"tasks"];
    if (defaultTasks != nil) {
            tasksArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
        } else {
            tasksArr = [NSMutableArray new];
        }
    task = [tasksArr objectAtIndex:_index];
    _tilteEdit.text = task.name;
    _descEdit.text = task.describtion;
    [_statusSegmentEdit setSelectedSegmentIndex:[task.status intValue]];
    [_prioritySegmentEdit setSelectedSegmentIndex:[task.periorty intValue]];
    
}
- (IBAction)saveEditBtn:(id)sender
{
    task.name = _tilteEdit.text;
    task.describtion=_descEdit.text;
    [tasksArr replaceObjectAtIndex:_index withObject:task];
    NSNumber *statusNum = [[NSNumber alloc] initWithInteger:_statusSegmentEdit.selectedSegmentIndex];
    NSNumber *periortyNum = [[NSNumber alloc] initWithInteger:_prioritySegmentEdit.selectedSegmentIndex];
    task.status = [statusNum stringValue];
    task.periorty = [periortyNum stringValue];
    if([task.status isEqualToString:@"0"])
    {
        defaultTasks = [NSKeyedArchiver archivedDataWithRootObject:tasksArr];
        [myDefaults setObject:defaultTasks forKey:@"tasks"];
    }else if ([task.status isEqualToString:@"1"])
    {
        myDefaults = [NSUserDefaults standardUserDefaults];
        defaultTasks = [myDefaults objectForKey:@"tasksInProsses"];
        if (defaultTasks != nil) {
               inProssesArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
            } else {
                inProssesArr = [NSMutableArray new];
            }
        [inProssesArr addObject:task];
        
        defaultTasks = [NSKeyedArchiver archivedDataWithRootObject:inProssesArr];
        [myDefaults setObject:defaultTasks forKey:@"tasksInProsses"];
        
        [tasksArr removeObjectAtIndex:_index];
        defaultTasks = [NSKeyedArchiver archivedDataWithRootObject:tasksArr];
        [myDefaults setObject:defaultTasks forKey:@"tasks"];
    }else if ([task.status isEqualToString:@"2"])
    {
        myDefaults = [NSUserDefaults standardUserDefaults];
        defaultTasks = [myDefaults objectForKey:@"tasksDone"];
        if (defaultTasks != nil) {
               doneArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
            } else {
                doneArr = [NSMutableArray new];
            }
        [doneArr addObject:task];
        
        defaultTasks = [NSKeyedArchiver archivedDataWithRootObject:doneArr];
        [myDefaults setObject:defaultTasks forKey:@"tasksDone"];
        
        [tasksArr removeObjectAtIndex:_index];
        defaultTasks = [NSKeyedArchiver archivedDataWithRootObject:tasksArr];
        [myDefaults setObject:defaultTasks forKey:@"tasks"];
    }
    [self.editTask getEditPonso:task];
    BOOL synchronizeResult = [myDefaults synchronize];
    [self dismissViewControllerAnimated:true completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
