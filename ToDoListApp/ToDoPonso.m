//
//  ToDoPonso.m
//  ToDoListApp
//
//  Created by Khokha on 02/04/2024.
//

#import "ToDoPonso.h"

@implementation ToDoPonso
- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_describtion forKey:@"dec"];
    [coder encodeObject:_status forKey:@"status"];
    [coder encodeObject:_periorty forKey:@"periorty"];
    [coder encodeObject:_date forKey:@"date"];
    
}
- (instancetype)initWithCoder:(NSCoder *)coder{
    self.name= [coder decodeObjectForKey:@"name"];
    self.describtion= [coder decodeObjectForKey:@"dec"];
    self.status= [coder decodeObjectForKey:@"status"];
    self.periorty= [coder decodeObjectForKey:@"periorty"];
    self.date= [coder decodeObjectForKey:@"date"];
    return self;
}
@end
