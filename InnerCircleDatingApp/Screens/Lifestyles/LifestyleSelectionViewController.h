//
//  LifestyleSelectionViewController.h
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LifestyleSelectionViewController;

@protocol LifestyleSelectionDelegate <NSObject>
- (void)lifestyleSelectionViewController:(LifestyleSelectionViewController *)controller
                     didSelectLifestyles:(NSArray<NSDictionary *> *)lifestyles;
@end

@interface LifestyleSelectionViewController : UIViewController

@property (nonatomic, weak, nullable) id<LifestyleSelectionDelegate> delegate;
@property (nonatomic, strong) NSArray<NSDictionary *> *selectedLifestyles;

@end

NS_ASSUME_NONNULL_END
