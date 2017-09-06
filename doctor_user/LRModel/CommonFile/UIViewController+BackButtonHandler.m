//
//  UIViewController+BackButtonHandler.m
//
//  Created by Sergey Nikitenko on 10/1/13.
//  Copyright 2013 Sergey Nikitenko. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIViewController+BackButtonHandler.h"
#import <objc/runtime.h>
@implementation UIViewController (BackButtonHandler)

@end

@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar
        shouldPopItem:(UINavigationItem *)item {
    
    UIViewController* vc = [self topViewController];
    BOOL shouldPop = YES;

    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    // UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        NSInteger count = [self.viewControllers count];
        UIViewController *vc  = self.viewControllers[count - 1 -2];
        [self popToViewController:vc animated:YES];
    }

    
//    if ( [vc respondsToSelector:@selector(returnType)] && [vc returnType] == 1 ){
//        
//        if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
//            shouldPop = [vc navigationShouldPopOnBackButton];
//        }
//
//        if (shouldPop) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self popViewControllerAnimated:YES];
//            });
//        }
//        else {
//
//        }
//
//    
//    }
//    else {
//        
//        if([self.viewControllers count] < [navigationBar.items count]) {
//            return YES;
//        }
//       // UIViewController* vc = [self topViewController];
//        if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
//            shouldPop = [vc navigationShouldPopOnBackButton];
//        }
//        if(shouldPop) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self popViewControllerAnimated:YES];
//            });
//        } else {
//            NSInteger count = [self.viewControllers count];
//            UIViewController *vc  = self.viewControllers[count - 1 -2];
//            [self popToViewController:vc animated:YES];
//        }
//
//        
//    }
	
	return NO;
}

- (void)setReturnType:(NSInteger)type {
    
    objc_setAssociatedObject(self, "typeKey", @(type), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSInteger)getReturnType {
return [objc_getAssociatedObject(self, "typeKey") integerValue];
}

@end
