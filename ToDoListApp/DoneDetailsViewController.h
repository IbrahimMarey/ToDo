//
//  DoneDetailsViewController.h
//  ToDoListApp
//
//  Created by Khokha on 03/04/2024.
//

#import <UIKit/UIKit.h>
#import "ToDoPonso.h"
#import "EditProtocal.h"
NS_ASSUME_NONNULL_BEGIN

@interface DoneDetailsViewController : UIViewController <EditProtocal>
@property ToDoPonso* taskDetails;
@property int index;
@end

NS_ASSUME_NONNULL_END
