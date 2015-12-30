//
//  RBWebAddressController.m
//  Retriever Browser
//
//  Created by Mark on 15/11/27.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBWebAddressController.h"
#import "RBWebViewController.h"

static CGFloat const RBHeaderViewMargin = 20;
@interface RBWebAddressController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *commonWebsites;
@property (nonatomic, strong) NSDictionary *subWebsites;
@property (nonatomic, strong) NSArray *allKeys;
@property (nonatomic, strong) UITableView *tableView;
@end

static NSInteger const RBWebsiteButtonTagOffset = 6250;
static CGFloat   const RBHeaderViewHeight = 150;
@implementation RBWebAddressController

#pragma mark - Lazy Load
- (NSDictionary *)commonWebsites {
    if (!_commonWebsites) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Website" ofType:@"plist"];
        _commonWebsites = [NSDictionary dictionaryWithContentsOfFile:filePath][@"Main"];
    }
    return _commonWebsites;
}

- (NSDictionary *)subWebsites {
    if (!_subWebsites) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Website" ofType:@"plist"];
        _subWebsites = [NSDictionary dictionaryWithContentsOfFile:filePath][@"Sub"];
    }
    return _subWebsites;
}

- (NSArray *)allKeys {
    if (!_allKeys) {
        _allKeys = self.subWebsites.allKeys;
    }
    return _allKeys;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadHeaderView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(RBHeaderViewMargin, RBHeaderViewHeight + 20, UI_SCREEN_WIDTH - 2*RBHeaderViewMargin, self.view.height - RBHeaderViewHeight - 20) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}

- (void)loadHeaderView {
    
    CGFloat headerWidth  = UI_SCREEN_WIDTH - 2*RBHeaderViewMargin;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(RBHeaderViewMargin, 10, headerWidth, RBHeaderViewHeight)];
    headerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    headerView.layer.borderWidth = 0.5;
    headerView.layer.cornerRadius = 2;
    [self.view addSubview:headerView];
    
    NSArray *keys = self.commonWebsites.allKeys;
    CGFloat buttonWidth = headerWidth / 4;
    CGFloat buttonHeight = RBHeaderViewHeight / ceilf(keys.count / 4 + 0.5);
    for (int i = 0; i < keys.count; i++) {
        CGFloat x = i % 4 * buttonWidth;
        CGFloat y = i / 4 * buttonHeight;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, buttonWidth, buttonHeight)];
        button.tag = i + RBWebsiteButtonTagOffset;
        [button setTitle:keys[i] forState:UIControlStateNormal];
        [button setTitleColor:RGBCOLOR(22, 22, 22) forState:UIControlStateNormal];
        [button setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(websiteClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [headerView addSubview:button];
    }
    
}

- (void)websiteClicked:(UIButton *)sender {
    NSString *strURL = self.commonWebsites[sender.titleLabel.text];
    RBWebViewController *webViewController = [[RBWebViewController alloc] initWithStrURL:strURL];
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.allKeys[indexPath.section];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) { return 44; }
    return 44;
}

@end
