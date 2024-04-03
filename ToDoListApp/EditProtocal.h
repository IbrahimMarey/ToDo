//
//  EditProtocal.h
//  ToDoListApp
//
//  Created by Khokha on 03/04/2024.
//

#import <Foundation/Foundation.h>
#import "ToDoPonso.h"
NS_ASSUME_NONNULL_BEGIN

@protocol EditProtocal <NSObject>
-(void)getEditPonso: (ToDoPonso *) ponso;
@end

NS_ASSUME_NONNULL_END
