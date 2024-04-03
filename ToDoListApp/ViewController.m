//
//  ViewController.m
//  ToDoListApp
//
//  Created by Khokha on 02/04/2024.
//

#import "ViewController.h"
#import "ToDoPonso.h"
#import "DoneDetailsViewController.h"
@interface ViewController ()
{
    NSUserDefaults *myDefaults;
    NSData *defaultTasks;
    NSMutableArray *doneArr;
    NSMutableArray *tableArr;

}
@property (weak, nonatomic) IBOutlet UITableView *doneTable;

@end

@implementation ViewController
- (IBAction)donePriority:(UISegmentedControl*)sender {
    tableArr = [NSMutableArray new];
    ToDoPonso*task = [ToDoPonso new];
    switch (sender.selectedSegmentIndex) {
        case 0:
            for (int i =0 ; i<doneArr.count; i++) {
                task = doneArr[i];
                if([task.periorty isEqualToString: @"0"])
                {
                    [tableArr addObject:task];
                }
            }
            break;
        case 1:
            for (int i =0 ; i<doneArr.count; i++) {
                task = [doneArr objectAtIndex:i];
                if([task.periorty isEqualToString: @"1"])
                {
                    [tableArr addObject:task];
                }
            }
            break;
        case 2:
            for (int i =0 ; i<doneArr.count; i++) {
                task = [doneArr objectAtIndex:i];
                if([task.periorty isEqualToString:@"2"])
                {
                    [tableArr addObject:task];
                }
            }
            break;
        case 3:
            tableArr =doneArr;
            break;
        default:
            break;
    }
    [self.doneTable reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.doneTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"doneCell"];
    [self getData];
}
-(void)getData{
    myDefaults = [NSUserDefaults standardUserDefaults];
    defaultTasks = [myDefaults objectForKey:@"tasksDone"];
    if (defaultTasks != nil) {
            doneArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
        } else {
            doneArr = [NSMutableArray new];
        }
    for (int i =0 ; i<doneArr.count; i++) {
        ToDoPonso *task = doneArr[i];
        if([task.periorty isEqualToString: @"0"])
        {
            [tableArr addObject:task];
        }
    }
    [self.doneTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [tableArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoPonso *college;
    
    college = [tableArr objectAtIndex:indexPath.row];
      
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doneCell" forIndexPath:indexPath];
    
    cell.textLabel.text = college.name;
    cell.contentView.layoutMargins = UIEdgeInsetsMake(16, 16, 16, 16);
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
- (void)viewWillAppear:(BOOL)animated{
    [self getData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DoneDetailsViewController *detailsScreen =[self.storyboard instantiateViewControllerWithIdentifier:@"DoneDetailsViewController"];
    detailsScreen.taskDetails = doneArr[indexPath.row];
    detailsScreen.index=indexPath.row;
    [self.navigationController pushViewController:detailsScreen animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are You sure to delete" message:@" " preferredStyle:UIAlertControllerStyleAlert];
       
       UIAlertAction *yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           ToDoPonso * t = [tableArr objectAtIndex:indexPath.row];
           [doneArr removeObject:t];
           [tableArr removeObject:t];
           defaultTasks = [NSKeyedArchiver archivedDataWithRootObject:doneArr];
           [myDefaults setObject:defaultTasks forKey:@"tasksDone"];
           BOOL synchronizeResult = [myDefaults synchronize];
           [self.doneTable reloadData];
       }];
       
       UIAlertAction *no = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
           printf("Cancel .....");
       }];
       
       
       [alert addAction:yes];
       [alert addAction:no];
           
       [self presentViewController:alert animated:YES completion:nil];
}

@end
