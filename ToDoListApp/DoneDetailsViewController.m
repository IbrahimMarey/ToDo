//
//  DoneDetailsViewController.m
//  ToDoListApp
//
//  Created by Khokha on 03/04/2024.
//

#import "DoneDetailsViewController.h"
#import "DoneEditViewController.h"
@interface DoneDetailsViewController ()
{
    ToDoPonso *task;
    NSUserDefaults *myDefaults;
    NSData *defaultTasks;
    NSMutableArray *tasksArr;
}
@property (weak, nonatomic) IBOutlet UILabel *titleDonbe;
@property (weak, nonatomic) IBOutlet UITextView *descDone;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;
@property (weak, nonatomic) IBOutlet UILabel *dateDone;

@end

@implementation DoneDetailsViewController
- (void)getEditPonso:(ToDoPonso *)ponso{
    _titleDonbe.text = ponso.name;
    _descDone.text =ponso.describtion;
    _dateDone.text = ponso.date;
    
    [_prioritySegment setSelectedSegmentIndex:[ponso.periorty intValue]];
}

-(void)getDetailsData{
    myDefaults = [NSUserDefaults standardUserDefaults];
    defaultTasks = [myDefaults objectForKey:@"tasksDone"];
    if (defaultTasks != nil) {
            tasksArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
        } else {
            tasksArr = [NSMutableArray new];
        }
    task = [tasksArr objectAtIndex:_index];
    _titleDonbe.text = task.name;
    _descDone.text =task.describtion;
    _dateDone.text = task.date;
    [_prioritySegment setSelectedSegmentIndex:[task.periorty intValue]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _prioritySegment.enabled =NO;
    task = [ToDoPonso new];
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editClicked)];
    [self.navigationItem setRightBarButtonItem:edit];
}
- (void)viewWillAppear:(BOOL)animated{
    [self getDetailsData];
}
-(void)editClicked
{
    DoneEditViewController *editTask = [self.storyboard instantiateViewControllerWithIdentifier:@"DoneEditViewController"];
    editTask.index =_index;
    editTask.editTask = self;
    [self presentViewController:editTask animated:YES completion:nil];
}
@end
