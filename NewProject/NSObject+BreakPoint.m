//
//  NSObject+BreakPoint.m
//  NewProject
//
//  Created by admin on 2018/3/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "NSObject+BreakPoint.h"
#import <objc/runtime.h>

@implementation ForwardingProxy

- (void)forwardingMsg {
    NSLog(@"can not Found selector %@",self.codeMsg);
}

@end

@implementation NSObject (BreakPoint)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self setUp];
//    });
//}
//
//- (void)setUp {
//   // [self swizzInstance:objc_getClass("__NSDictionaryM") orignalSeletor:@selector(setObject:forKey:) replaceSelector:NSSelectorFromString(@"nb_setObject:forKey:")];
//
////    [self swizzInstance:objc_getClass("__NSArrayI") orignalSeletor:@selector(objectAtIndex:) replaceSelector:NSSelectorFromString(@"nb_objectAtIndex:")];
////
////    [self swizzInstance:objc_getClass("__NSArrayM") orignalSeletor:@selector(addObject:) replaceSelector:NSSelectorFromString(@"nb_addObject:")];
////
////    [self swizzInstance:objc_getClass("__NSArrayM") orignalSeletor:@selector(insertObject:atIndex:) replaceSelector:NSSelectorFromString(@"nb_insertObject:atIndex:")];
////
////    [self swizzInstance:objc_getClass("__NSArrayM") orignalSeletor:@selector(removeObjectAtIndex:) replaceSelector:NSSelectorFromString(@"nb_removeObjectAtIndex:")];
////
////    [self swizzInstance:objc_getClass("__NSArrayM") orignalSeletor:@selector(objectAtIndex:) replaceSelector:NSSelectorFromString(@"nb_objectAtIndex:")];
//}
//
//- (BOOL)swizzInstance:(Class)cls orignalSeletor:(SEL)orignalSeletor replaceSelector:(SEL)replaceSelector {
//    Method orignalMethod = class_getInstanceMethod(cls, orignalSeletor);
//    if (!orignalMethod) {
//        NSLog(@"Get class %@ selector %@ faild",NSStringFromClass(cls),NSStringFromSelector(orignalSeletor));
//        return NO;
//    }
//    Method replaceMethod = class_getInstanceMethod(cls, replaceSelector);
//    if (!replaceMethod) {
//        NSLog(@"Get selector %@ faild",NSStringFromSelector(replaceSelector));
//        return NO;
//    }
//    if (class_addMethod(cls, orignalSeletor, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod))) {
//        class_replaceMethod(cls,
//                            replaceSelector,
//                            method_getImplementation(orignalMethod),
//                            method_getTypeEncoding(orignalMethod));
//    } else {
//        method_exchangeImplementations(orignalMethod, replaceMethod);
//    }
//    return YES;
//}
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored"-Wobjc-protocol-method-implementation"
//
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    NSString *methodName = NSStringFromSelector(aSelector);
//    if ([NSStringFromClass([self class]) hasPrefix:@"_"] || [self isKindOfClass:NSClassFromString(@"UITextInputController")] || [NSStringFromClass([self class]) hasPrefix:@"UIKeyboard"] || [methodName isEqualToString:@"dealloc"]) {
//        return nil;
//    }
//    ForwardingProxy *proxy = [[ForwardingProxy alloc] init];
//    proxy.codeMsg = [NSString stringWithFormat:@"%@",NSStringFromSelector(aSelector)];
//    class_addMethod([ForwardingProxy class], aSelector, [proxy methodForSelector:@selector(forwardingMsg)], "v@:");
//    return proxy;
//}
//
//@end
//
//@implementation NSArray (BreakPoint)
//
//- (id)nb_objectAtIndex:(NSUInteger)index {
//    if (index < self.count) {
//        return [self nb_objectAtIndex:index];
//    } else {
//        NSLog(@"array bound");
//        return nil;
//    }
//}
//
//@end
//
//@implementation NSMutableArray (BreakPoint)
//
//- (id)nb_objectAtIndex:(NSUInteger)index {
//    if (index < self.count) {
//        return [self nb_objectAtIndex:index];
//    } else {
//        NSLog(@"array bound");
//        return nil;
//    }
//}
//
//- (void)nb_addObject:(id)object {
//    if (!object || [object isKindOfClass:[NSNull class]]) {
//    } else {
//        [self nb_addObject:object];
//    }
//}
//
//- (void)nb_removeObjectAtIndex:(NSUInteger)index {
//    if (index < self.count) {
//        [self nb_removeObjectAtIndex:index];
//    } else {
//        NSLog(@"index %lu beyond array count",index);
//        return;
//    }
//}
//
//- (void)nb_insertObject:(id)anObject atIndex:(NSUInteger)index {
//    if(nil == anObject || index > self.count){
//        NSLog(@"break");
//        return ;
//    }
//    [self nb_insertObject:anObject atIndex:index];
//}
//
//@end
//
//@implementation NSMutableDictionary (BreakPoint)
//
//- (void)nb_setObject:(nullable id)anObject forKey:(nullable id <NSCopying>)aKey{
//    if (!anObject || !aKey ) {
//        NSLog(@"need log msg");
//        return;
//    }
//    [self nb_setObject:anObject forKey:aKey];
//}

@end
