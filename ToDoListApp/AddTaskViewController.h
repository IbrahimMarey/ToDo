//
//  AddTaskViewController.h
//  ToDoListApp
//
//  Created by Khokha on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "AddingProtocal.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddTaskViewController : UIViewController
@property id<AddingProtocal> insertTask;
@end

NS_ASSUME_NONNULL_END
