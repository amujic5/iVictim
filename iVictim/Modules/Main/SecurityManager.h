//
//  SecurityManager.h
//  iVictim
//
//  Created by Azzaro Mujic on 02/06/16.
//
//

#import <Foundation/Foundation.h>

@interface SecurityManager : NSObject
- (BOOL)isInSandbox;
- (BOOL)isJailbroken;
- (void)disableGDB;
@end
