//
//  NSObject+BreakPoint.h
//  NewProject
//
//  Created by admin on 2018/3/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForwardingProxy : NSObject
@property (nonatomic ,copy) NSString *codeMsg;
- (void)forwardingMsg;

@end

@interface NSObject (BreakPoint)

@end

@interface NSArray (BreakPoint)
@end
@interface NSMutableArray (BreakPoint)
@end
@interface NSMutableDictionary (BreakPoint)

@end


@interface NSDictionary (BreakPoint)

@end

@interface NSString (BreakPoint)

@end

//-----------------------------------------------------------------------------------------------------------------------------
// NSMutableString
@interface NSMutableString (BreakPoint)

@end
