//
//  MAFDataPickerView.h
//  NineFromObject
//
//  Created by joy 尹 on 2019/12/16.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAFPickerDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@class MAFDataPickerView;
@protocol MAFDataPickerViewDelegate <NSObject>

- (void)didSelectModel:(MAFPickerDataModel *)model inView:(MAFDataPickerView *)picker indexPath:(NSIndexPath *)indexPath;

- (void)didSelectModel:(MAFPickerDataModel *)model inView:(MAFDataPickerView *)picker;

@end

@interface MAFDataPickerView : UIView

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) id <MAFDataPickerViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
