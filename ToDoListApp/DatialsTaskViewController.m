//
//  DatialsTaskViewController.m
//  ToDoListApp
//
//  Created by Khokha on 02/04/2024.
//

#import "DatialsTaskViewController.h"
#import "EditTaskViewController.h"
@interface DatialsTaskViewController ()
{
    ToDoPonso *task;
    NSUserDefaults *myDefaults;
    NSData *defaultTasks;
    NSMutableArray *tasksArr;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UITextView *descLable;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegmented;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmented;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;

@end

@implementation DatialsTaskViewController
- (void)getEditPonso:(ToDoPonso *)ponso{
    _titleLable.text = ponso.name;
    _descLable.text =ponso.describtion;
    _dateLable.text = ponso.date;
    
    [_statusSegmented setSelectedSegmentIndex:[ponso.status intValue]];
    [_prioritySegmented setSelectedSegmentIndex:[ponso.periorty intValue]];
}
-(void)getDetailsData{
    myDefaults = [NSUserDefaults standardUserDefaults];
    defaultTasks = [myDefaults objectForKey:@"tasks"];
    if (defaultTasks != nil) {
            tasksArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
        } else {
            tasksArr = [NSMutableArray new];
        }
    task = [tasksArr objectAtIndex:_index];
    _titleLable.text = task.name;
    _descLable.text =task.describtion;
    _dateLable.text = task.date;
    
    [_statusSegmented setSelectedSegmentIndex:[task.status intValue]];
    [_prioritySegmented setSelectedSegmentIndex:[task.periorty intValue]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _statusSegmented.enabled =NO;
    _prioritySegmented.enabled =NO;
    task = [ToDoPonso new];
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editClicked)];
    [self.navigationItem setRightBarButtonItem:edit];
}
- (void)viewWillAppear:(BOOL)animated{
    [self getDetailsData];
}
-(void)editClicked
{
    EditTaskViewController *editTask = [self.storyboard instantiateViewControllerWithIdentifier:@"EditTaskViewController"];
    editTask.index =_index;
    editTask.editTask = self;
    [self presentViewController:editTask animated:YES completion:nil];
}


@end
