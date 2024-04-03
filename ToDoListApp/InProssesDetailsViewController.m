//
//  InProssesDetailsViewController.m
//  ToDoListApp
//
//  Created by Khokha on 03/04/2024.
//

#import "InProssesDetailsViewController.h"
#import "ToDoPonso.h"
#import "EditInProsessViewController.h"
@interface InProssesDetailsViewController ()
{
    ToDoPonso *task;
    NSUserDefaults *myDefaults;
    NSData *defaultTasks;
    NSMutableArray *tasksArr;
}
@property (weak, nonatomic) IBOutlet UILabel *inProssestitle;
@property (weak, nonatomic) IBOutlet UITextView *inProssesDesc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inProssesStatusSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inProssesPirioritySegment;
@property (weak, nonatomic) IBOutlet UILabel *inProssesDate;

@end

@implementation InProssesDetailsViewController
- (void)getEditPonso:(ToDoPonso *)ponso{
    _inProssestitle.text = ponso.name;
    _inProssesDesc.text =ponso.describtion;
    _inProssesDate.text = ponso.date;
    
    [_inProssesStatusSegment setSelectedSegmentIndex:[ponso.status intValue]];
    [_inProssesPirioritySegment setSelectedSegmentIndex:[ponso.periorty intValue]];
}

-(void)getDetailsData{
    myDefaults = [NSUserDefaults standardUserDefaults];
    defaultTasks = [myDefaults objectForKey:@"tasksInProsses"];
    if (defaultTasks != nil) {
            tasksArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
        } else {
            tasksArr = [NSMutableArray new];
        }
    task = [tasksArr objectAtIndex:_index];
    _inProssestitle.text = task.name;
    _inProssesDesc.text =task.describtion;
    _inProssesDate.text = task.date;
    
    [_inProssesStatusSegment setSelectedSegmentIndex:[task.status intValue]];
    [_inProssesPirioritySegment setSelectedSegmentIndex:[task.periorty intValue]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _inProssesStatusSegment.enabled =NO;
    _inProssesPirioritySegment.enabled =NO;
    task = [ToDoPonso new];
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editClicked)];
    [self.navigationItem setRightBarButtonItem:edit];
}
- (void)viewWillAppear:(BOOL)animated{
    [self getDetailsData];
}
-(void)editClicked
{
    EditInProsessViewController *editTask = [self.storyboard instantiateViewControllerWithIdentifier:@"EditInProsessViewController"];
    editTask.index =_index;
    editTask.editTask = self;
    [self presentViewController:editTask animated:YES completion:nil];
}

@end
