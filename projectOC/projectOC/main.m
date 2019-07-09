//
//  main.m
//  projectOC
//
//  Created by 杨剑 on 2019/6/11.
//  Copyright © 2019 杨剑. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        printf("%d\n",argc);
        
        printf("%s\n",&argv);

        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
