//
//  EditInProsessViewController.m
//  ToDoListApp
//
//  Created by Khokha on 03/04/2024.
//

#import "EditInProsessViewController.h"
#import "ToDoPonso.h"
@interface EditInProsessViewController ()
{
    ToDoPonso *task;
    NSUserDefaults *myDefaults;
    NSData *defaultTasks;
    NSMutableArray* inProssesArr ;
    NSMutableArray* doneArr ;
}
@property (weak, nonatomic) IBOutlet UITextField *inputTitleInProsses;
@property (weak, nonatomic) IBOutlet UITextField *editDecInput;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editStatusSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editPirioritySegment;

@end

@implementation EditInProsessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    task = [ToDoPonso new];
    myDefaults = [NSUserDefaults standardUserDefaults];
    defaultTasks = [myDefaults objectForKey:@"tasksInProsses"];
    if (defaultTasks != nil) {
        inProssesArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
        } else {
            inProssesArr = [NSMutableArray new];
        }
    task = [inProssesArr objectAtIndex:_index];
    _inputTitleInProsses.text = task.name;
    _editDecInput.text = task.describtion;
    [_editStatusSegment setSelectedSegmentIndex:[task.status intValue]];
    [_editPirioritySegment setSelectedSegmentIndex:[task.periorty intValue]];
}
- (IBAction)saveBtn:(id)sender {
    task.name = _inputTitleInProsses.text;
    task.describtion=_editDecInput.text;
    NSNumber *statusNum = [[NSNumber alloc] initWithInteger:_editStatusSegment.selectedSegmentIndex];
    NSNumber *periortyNum = [[NSNumber alloc] initWithInteger:_editPirioritySegment.selectedSegmentIndex];
    printf("---------%d\n",_editStatusSegment.selectedSegmentIndex);
    if(_editStatusSegment.selectedSegmentIndex==0)
    {
        task.status = @"0";

    }else{
        task.status = @"1";

    }
    task.periorty = [periortyNum stringValue];
    NSLog(task.status);
    if([task.status isEqualToString:@"0"])
    {
        [inProssesArr replaceObjectAtIndex:_index withObject:task];
        defaultTasks = [NSKeyedArchiver archivedDataWithRootObject:inProssesArr];
        [myDefaults setObject:defaultTasks forKey:@"tasksInProsses"];
    }else if ([task.status isEqualToString:@"1"])
    {
        task.status = @"2";
        [inProssesArr replaceObjectAtIndex:_index withObject:task];
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
        
        [inProssesArr removeObjectAtIndex:_index];
        defaultTasks = [NSKeyedArchiver archivedDataWithRootObject:inProssesArr];
        [myDefaults setObject:defaultTasks forKey:@"tasksInProsses"];
    }
    [self.editTask getEditPonso:task];
    BOOL synchronizeResult = [myDefaults synchronize];
    [self dismissViewControllerAnimated:true completion:nil];
    
}

@end
