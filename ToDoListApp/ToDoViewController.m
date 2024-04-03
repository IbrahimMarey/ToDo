//
//  ToDoViewController.m
//  ToDoListApp
//
//  Created by Khokha on 02/04/2024.
//

#import "ToDoViewController.h"
#import "AddTaskViewController.h"
#import "ToDoPonso.h"
#import "DatialsTaskViewController.h"
@interface ToDoViewController ()
{
    NSUserDefaults *myDefaults;
    NSData *defaultTasks;
    NSMutableArray *tasksArr;
    NSMutableArray *tableArr;
    NSMutableArray *searchArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ToDoViewController
- (void)insertedTask{
    [self getData];
}
- (IBAction)toDoPirioritySegment:(UISegmentedControl*) sender {
    tableArr = [NSMutableArray new];
    ToDoPonso*task = [ToDoPonso new];
    switch (sender.selectedSegmentIndex) {
        case 0:
            for (int i =0 ; i<tasksArr.count; i++) {
                task = tasksArr[i];
                if([task.periorty isEqualToString: @"0"])
                {
                    [tableArr addObject:task];
                }
            }
            break;
        case 1:
            for (int i =0 ; i<tasksArr.count; i++) {
                task = [tasksArr objectAtIndex:i];
                if([task.periorty isEqualToString: @"1"])
                {
                    [tableArr addObject:task];
                }
            }
            break;
        case 2:
            for (int i =0 ; i<tasksArr.count; i++) {
                task = [tasksArr objectAtIndex:i];
                if([task.periorty isEqualToString:@"2"])
                {
                    [tableArr addObject:task];
                }
            }
            break;
        case 3:
            tableArr =tasksArr;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

- (IBAction)addTask:(id)sender {
    AddTaskViewController *addTaskScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
    addTaskScreen.insertTask =self;
    [self presentViewController:addTaskScreen animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar.delegate=self;
    _searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
    searchArr = [NSMutableArray new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self getData];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(![searchBar.text isEqual:@""])
    {
        [searchArr removeAllObjects];
        for(ToDoPonso * task in tasksArr){
            if([task.name containsString:[searchText lowercaseString]]){
                [searchArr addObject:task];
            }
            [_tableView reloadData];
        }
     tableArr = searchArr;
     [_tableView reloadData];
    }else{
        [searchArr removeAllObjects];
        tableArr = tasksArr;
        [_tableView reloadData];
    }
       


}
- (void)viewWillAppear:(BOOL)animated{
    [self getData];
}
-(void)getData{
    tableArr = [NSMutableArray new];
    myDefaults = [NSUserDefaults standardUserDefaults];
    defaultTasks = [myDefaults objectForKey:@"tasks"];
    
    if (defaultTasks != nil) {
            tasksArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
        } else {
            tasksArr = [NSMutableArray new];
        }
    for (int i =0 ; i<tasksArr.count; i++) {
        ToDoPonso *task = tasksArr[i];
        if([task.periorty isEqualToString: @"0"])
        {
            [tableArr addObject:task];
        }
    }
//    [self segmentCelected];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count =0;
        if(![_searchBar.text isEqual:@""]){
            count = searchArr.count;
        }else{
            count = tableArr.count;
        }

    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoPonso *college;
    
    college = [tableArr objectAtIndex:indexPath.row];
      
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.layoutMargins = UIEdgeInsetsMake(16, 16, 16, 16);

    cell.textLabel.text = college.name;
    if([college.periorty isEqualToString:@"0"])
    {
        UIImage *img = [UIImage imageNamed:@"priorities"];
        cell.imageView.image = img;
    }else if ([college.periorty isEqualToString:@"1"])
    {
        UIImage *img = [UIImage imageNamed:@"badge"];
        cell.imageView.image = img;
    }else if ([college.periorty isEqualToString:@"2"])
    {
        UIImage *img = [UIImage imageNamed:@"toDo"];
        cell.imageView.image = img;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are You sure to delete" message:@" " preferredStyle:UIAlertControllerStyleAlert];
       
       UIAlertAction *yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           ToDoPonso * t = [tableArr objectAtIndex:indexPath.row];
           [tasksArr removeObject:t];
           [tableArr removeObject:t];
           defaultTasks = [NSKeyedArchiver archivedDataWithRootObject:tasksArr];
           [myDefaults setObject:defaultTasks forKey:@"tasks"];
           BOOL synchronizeResult = [myDefaults synchronize];
           [self.tableView reloadData];
       }];
       
       UIAlertAction *no = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
           printf("Cancel .....");
       }];
       
       
       [alert addAction:yes];
       [alert addAction:no];
           
       [self presentViewController:alert animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DatialsTaskViewController *detailsScreen =[self.storyboard instantiateViewControllerWithIdentifier:@"DatialsTaskViewController"];
    detailsScreen.taskDetails = tasksArr[indexPath.row];
    detailsScreen.index=indexPath.row;
    [self.navigationController pushViewController:detailsScreen animated:YES];
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
