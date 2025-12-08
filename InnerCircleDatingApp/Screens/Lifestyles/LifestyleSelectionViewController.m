//
//  LifestyleSelectionViewController.m
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

#import "LifestyleSelectionViewController.h"

@interface LifestyleSelectionViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *availableLifestyles;
@property (nonatomic, strong) NSMutableSet<NSString *> *selectedItems;
@end

@implementation LifestyleSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor systemBackgroundColor];

    self.availableLifestyles = @[
        @"Yoga",
        @"Fitness",
        @"Travel",
        @"Cooking",
        @"Reading",
        @"Music",
        @"Art",
        @"Photography",
        @"Gaming",
        @"Hiking",
        @"Dancing",
        @"Movies"
    ];

    self.selectedItems = [NSMutableSet set];

    if (self.selectedLifestyles) {
        for (NSDictionary *lifestyle in self.selectedLifestyles) {
            NSString *name = lifestyle[@"name"];
            if (name) {
                [self.selectedItems addObject:name];
            }
        }
    }

    [self setupTableView];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LifestyleCell"];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.availableLifestyles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LifestyleCell" forIndexPath:indexPath];

    NSString *lifestyle = self.availableLifestyles[indexPath.row];
    cell.textLabel.text = lifestyle;

    if ([self.selectedItems containsObject:lifestyle]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *lifestyle = self.availableLifestyles[indexPath.row];

    if ([self.selectedItems containsObject:lifestyle]) {
        [self.selectedItems removeObject:lifestyle];
    } else {
        [self.selectedItems addObject:lifestyle];
    }

    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    [self notifyDelegate];
}

- (void)notifyDelegate {
    NSMutableArray<NSDictionary *> *lifestyles = [NSMutableArray array];

    for (NSString *item in self.selectedItems) {
        [lifestyles addObject:@{
            @"name": item,
            @"detail": [NSNull null]
        }];
    }

    if ([self.delegate respondsToSelector:@selector(lifestyleSelectionViewController:didSelectLifestyles:)]) {
        [self.delegate lifestyleSelectionViewController:self didSelectLifestyles:lifestyles];
    }
}

@end
