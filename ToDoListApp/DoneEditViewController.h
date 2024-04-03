//
//  DoneEditViewController.h
//  ToDoListApp
//
//  Created by Khokha on 03/04/2024.
//

#import <UIKit/UIKit.h>
#import "EditProtocal.h"
NS_ASSUME_NONNULL_BEGIN

@interface DoneEditViewController : UIViewController
@property int index;
@property id<EditProtocal> editTask;
@end

NS_ASSUME_NONNULL_END
