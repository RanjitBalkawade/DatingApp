//
//  LifestyleSelectionViewController.m
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

#import "LifestyleSelectionViewController.h"
#import "InnerCircleDatingApp-Swift.h"

@interface LifestyleSelectionViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LifestyleSelectionViewModel *viewModel;
@end

@implementation LifestyleSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor systemBackgroundColor];

    self.viewModel = [[LifestyleSelectionViewModel alloc] init];

    if (self.selectedLifestyles) {
        [self.viewModel loadSelectedLifestyles:self.selectedLifestyles];
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
    return self.viewModel.availableLifestyles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LifestyleCell" forIndexPath:indexPath];

    NSString *lifestyle = self.viewModel.availableLifestyles[indexPath.row];
    cell.textLabel.text = lifestyle;

    if ([self.viewModel isSelected:lifestyle]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *lifestyle = self.viewModel.availableLifestyles[indexPath.row];

    [self.viewModel toggleLifestyle:lifestyle];

    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    [self notifyDelegate];
}

- (void)notifyDelegate {
    NSArray<NSDictionary *> *lifestyles = [self.viewModel getSelectedLifestyles];

    if ([self.delegate respondsToSelector:@selector(lifestyleSelectionViewController:didSelectLifestyles:)]) {
        [self.delegate lifestyleSelectionViewController:self didSelectLifestyles:lifestyles];
    }
}

@end
