//
//  ToDoPonso.h
//  ToDoListApp
//
//  Created by Khokha on 02/04/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoPonso : NSObject <NSCoding>
@property NSString *name;
@property NSString *describtion;
@property NSString *status;
@property NSString *periorty;
@property NSString *date;

-(void)encodeWithCoder:(NSCoder *)coder;
-(nullable instancetype)initWithCoder:(NSCoder *)coder;
@end

NS_ASSUME_NONNULL_END
