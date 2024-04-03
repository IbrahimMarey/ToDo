//
//  EditTaskViewController.h
//  ToDoListApp
//
//  Created by Khokha on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "EditProtocal.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditTaskViewController : UIViewController
@property int index;
@property id<EditProtocal> editTask;
@end

NS_ASSUME_NONNULL_END
