//
//  DoneEditViewController.m
//  ToDoListApp
//
//  Created by Khokha on 03/04/2024.
//

#import "DoneEditViewController.h"

@interface DoneEditViewController ()
{
    ToDoPonso *task;
    NSUserDefaults *myDefaults;
    NSData *defaultTasks;
    NSMutableArray* doneArr ;
}
@property (weak, nonatomic) IBOutlet UITextField *editTitle;
@property (weak, nonatomic) IBOutlet UITextField *descEdit;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;

@end

@implementation DoneEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    task = [ToDoPonso new];
    myDefaults = [NSUserDefaults standardUserDefaults];
    defaultTasks = [myDefaults objectForKey:@"tasksDone"];
    if (defaultTasks != nil) {
        doneArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
        } else {
            doneArr = [NSMutableArray new];
        }
    task = [doneArr objectAtIndex:_index];
    _editTitle.text = task.name;
    _descEdit.text = task.describtion;
    [_prioritySegment setSelectedSegmentIndex:[task.periorty intValue]];
}

- (IBAction)saveBtn:(id)sender
{
    task.name = _editTitle.text;
    task.describtion=_descEdit.text;
    
    NSNumber *periortyNum = [[NSNumber alloc] initWithInteger:_prioritySegment.selectedSegmentIndex];
    task.periorty = [periortyNum stringValue];
    [doneArr replaceObjectAtIndex:_index withObject:task];
    defaultTasks = [NSKeyedArchiver archivedDataWithRootObject:doneArr];
    [myDefaults setObject:defaultTasks forKey:@"tasksDone"];
    [self.editTask getEditPonso:task];
    BOOL synchronizeResult = [myDefaults synchronize];
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
