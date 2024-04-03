//
//  AddTaskViewController.m
//  ToDoListApp
//
//  Created by Khokha on 02/04/2024.
//

#import "AddTaskViewController.h"
#import "ToDoPonso.h"
@interface AddTaskViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleInput;
@property (weak, nonatomic) IBOutlet UITextField *descriptionInput;
@property (weak, nonatomic) IBOutlet UISegmentedControl *perioritySegment;

@end

@implementation AddTaskViewController
{
    NSUserDefaults *myDefaults;
    NSData *defaultTasks;
    NSMutableArray <ToDoPonso *> *tasksArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    myDefaults = [NSUserDefaults standardUserDefaults];
    defaultTasks = [myDefaults objectForKey:@"tasks"];
    if (defaultTasks != nil) {
            tasksArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
        } else {
            tasksArr = [NSMutableArray new];
        }
    
}
- (IBAction)addingBtn:(id)sender {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    NSNumber *statusNum = [[NSNumber alloc] initWithInteger:0];
    int periortyNum = _perioritySegment.selectedSegmentIndex;
    
    ToDoPonso *task = [ToDoPonso new];
    task.name = _titleInput.text;
    task.describtion = _descriptionInput.text;
    task.date=dateString;
    task.status=[statusNum stringValue];
    task.periorty =@(periortyNum).stringValue;
    [tasksArr addObject:task];
    printf("p = %d \n",periortyNum);
    defaultTasks = [NSKeyedArchiver archivedDataWithRootObject:tasksArr];
    [myDefaults setObject:defaultTasks forKey:@"tasks"];
    BOOL synchronizeResult = [myDefaults synchronize];
    [self.insertTask insertedTask];
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
