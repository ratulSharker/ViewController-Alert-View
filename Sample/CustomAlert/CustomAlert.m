//
//  CustomAlert.m
//  ViewControllerAlertView
//
//  Created by Ratul Sharker on 3/29/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "CustomAlert.h"

#define CUSTOM_ALERT_TABLE_CELL_REUSING_ID  @"custom_alert_table_cell"

@interface CustomAlert () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation CustomAlert
{
    IBOutlet UILabel *mViewSliderLabel;
    IBOutlet UIActivityIndicatorView *mViewActivityIndicator;
    
    NSArray<NSArray*> *tableData;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    tableData = @[
                  @[@"Section 1, cell 1", @"Section 1, cell 2", @"Section 1, cell 3"],
                  @[@"Section 2, cell 1"],
                  @[@"Section 3, cell 1", @"Section 3, cell 2"],
                  @[@"Section 4, cell 1", @"Section 4, cell 2", @"Section 4, cell 3", @"Section 4, cell 4"]
                  ];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
    return tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return tableData[section].count;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //
    //  getting the table cell
    //
    UITableViewCell *tbCell = [tableView dequeueReusableCellWithIdentifier:CUSTOM_ALERT_TABLE_CELL_REUSING_ID];
    
    //
    //  getting the necessary data
    //
    NSString *cellString = tableData[indexPath.section][indexPath.row];
    
    //
    //  cusotmizing the table cell
    //
    tbCell.textLabel.text = cellString;
    
    //
    //  returning the tablecell to be shown
    //
    return tbCell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
{
    return [NSString stringWithFormat:@"Section %ud", (unsigned int)section];
    
    
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[[UIAlertView alloc] initWithTitle:@"Table View"
                                message:tableData[indexPath.section][indexPath.row]
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil, nil] show];
}


#pragma mark IBAction
-(IBAction)onDismissPressed:(id)sender
{
    //
    //  hiding the customAlert, it's a method from the super class
    //
    [self hideWithAnimation:HIDE_WITH_DAMPING onComplete:nil];
}

-(IBAction)onSwitchValueChanged:(UISwitch*)sender
{
    NSString *msg = (sender.isOn) ? @"Turned on" : @"Turned off" ;
    
    [[[UIAlertView alloc] initWithTitle:@"Switch"
                                message:msg
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil, nil] show];
}

-(IBAction)onSliderValueChangeS:(UISlider*)sender
{
    mViewSliderLabel.text = [NSString stringWithFormat:@"Slider Changed :: %f", sender.value ];
}

-(IBAction)onButtonStartAnimation:(id)sender
{
    if(mViewActivityIndicator.isAnimating == NO)
    {
        [mViewActivityIndicator startAnimating];
    }
}

-(IBAction)onButtonStopAnimation:(id)sender
{
    if(mViewActivityIndicator.isAnimating == YES)
    {
        [mViewActivityIndicator stopAnimating];
    }
}

@end
