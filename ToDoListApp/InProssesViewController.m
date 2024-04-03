//
//  InProssesViewController.m
//  ToDoListApp
//
//  Created by Khokha on 02/04/2024.
//

#import "InProssesViewController.h"
#import "ToDoPonso.h"
#import "InProssesDetailsViewController.h"
@interface InProssesViewController ()
{
    NSUserDefaults *myDefaults;
    NSData *defaultTasks;
    NSMutableArray *inProssesArr;
    NSMutableArray *tableArr;
}
@property (weak, nonatomic) IBOutlet UITableView *inProssesTable;

@end

@implementation InProssesViewController
- (IBAction)filterInProsses:(UISegmentedControl*)sender {
    ToDoPonso*task = [ToDoPonso new];
    tableArr = [NSMutableArray new];
    switch (sender.selectedSegmentIndex) {
        case 0:
            for (int i =0 ; i<inProssesArr.count; i++) {
                task = inProssesArr[i];
                if([task.periorty isEqualToString: @"0"])
                {
                    [tableArr addObject:task];
                }
            }
            break;
        case 1:
            for (int i =0 ; i<inProssesArr.count; i++) {
                task = [inProssesArr objectAtIndex:i];
                if([task.periorty isEqualToString: @"1"])
                {
                    [tableArr addObject:task];
                }
            }
            break;
        case 2:
            for (int i =0 ; i<inProssesArr.count; i++) {
                task = [inProssesArr objectAtIndex:i];
                if([task.periorty isEqualToString:@"2"])
                {
                    [tableArr addObject:task];
                }
            }
            break;
        case 3:
            tableArr =inProssesArr;
            break;
        default:
            break;
    }
    [self.inProssesTable reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.inProssesTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"inprossesCell"];
    [self getData];
}

-(void)getData{
    tableArr = [NSMutableArray new];
    myDefaults = [NSUserDefaults standardUserDefaults];
    defaultTasks = [myDefaults objectForKey:@"tasksInProsses"];
    if (defaultTasks != nil) {
            inProssesArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
        } else {
            inProssesArr = [NSMutableArray new];
        }
    for (int i =0 ; i<inProssesArr.count; i++) {
        ToDoPonso *task = inProssesArr[i];
        if([task.periorty isEqualToString: @"0"])
        {
            [tableArr addObject:task];
        }
    }
    [self.inProssesTable reloadData];
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
      
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inprossesCell" forIndexPath:indexPath];
    
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
    InProssesDetailsViewController *detailsScreen =[self.storyboard instantiateViewControllerWithIdentifier:@"InProssesDetailsViewController"];
    detailsScreen.taskDetails = inProssesArr[indexPath.row];
    detailsScreen.index=indexPath.row;
    [self.navigationController pushViewController:detailsScreen animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are You sure to delete" message:@" " preferredStyle:UIAlertControllerStyleAlert];
       
       UIAlertAction *yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           ToDoPonso * t = [tableArr objectAtIndex:indexPath.row];
           [inProssesArr removeObject:t];
           [tableArr removeObject:t];
           defaultTasks = [NSKeyedArchiver archivedDataWithRootObject:inProssesArr];
           [myDefaults setObject:defaultTasks forKey:@"inprossesCell"];
           BOOL synchronizeResult = [myDefaults synchronize];
           [self.inProssesTable reloadData];
       }];
       
       UIAlertAction *no = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
           printf("Cancel .....");
       }];
       
       
       [alert addAction:yes];
       [alert addAction:no];
           
       [self presentViewController:alert animated:YES completion:nil];
}
@end
