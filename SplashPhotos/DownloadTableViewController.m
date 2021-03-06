//
//  DownloadViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "DownloadTableViewController.h"
#import "DownloadPhoto.h"
#import "SplashControllerAccess.h"
#import "DownloadTableViewCell.h"
#import "ToastService.h"
#import "UITableView+NoData.h"
#import "SPPhotoBrowserDelegate.h"
#import "ArrayDataSource.h"
#import "DownloadTableViewCell+ConfigureCell.h"
#import "PhotoController.h"

@interface DownloadTableViewController ()
{
    PhotoController* _photoController;
}

@property SPPhotoBrowserDelegate* photoBrowserDelegate;
@property ArrayDataSource* arrayDataSource;

@end

@implementation DownloadTableViewController

static NSString * const reuseIdentifier = @"downloadTableViewCell";

#pragma mark view setup
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setup
{
    self.tableView.rowHeight = 62;

    _photoBrowserDelegate = [[SPPhotoBrowserDelegate alloc]initWithItems:self.navigationController
                                                    actionButtonCallback:nil actionButton:false];
    
    // init
    _photoController = SplashControllerAccess.photoController;

    // get photos data
    NSArray* data  = [_photoController getDownloadPhotos];
    
    // configure cell
    CellConfigureBlock configureCell = ^(DownloadTableViewCell *cell, DownloadPhoto *photo)
    {
        [cell configureForPhoto:photo delegate: self];
    };
    
    // data source
    self.arrayDataSource = [[ArrayDataSource alloc] initWithItems:data
                                                         cellIdentifier:reuseIdentifier
                                                     configureCellBlock:configureCell
                                                              noDataTip:@"go download a photo"];
    self.tableView.dataSource = self.arrayDataSource;
    
    // notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name: DownloadPhotosChangedNotification
                                               object:nil];
}

#pragma mark notification
- (void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:  DownloadPhotosChangedNotification])
    {
        [self insertNewItems];
    }
}

#pragma mark data
-(void)insertNewItems
{
    NSInteger count = [self.tableView numberOfRowsInSection:0];
    NSInteger max = ((NSArray*)[self.arrayDataSource allItems]).count - count;
    
    NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
    for (NSInteger i = 0; i <  max; i++)
    {
        [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow: i inSection:0]];
    }
    [self.tableView  insertRowsAtIndexPaths:arrayWithIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark redownload
- (void)restartClickedWithCell:(DownloadTableViewCell*)cell sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if(indexPath != nil)
    {
        DownloadPhoto* downloadPhoto = [self.arrayDataSource itemAtIndexPath:indexPath];
        if(downloadPhoto)
        {
            [_photoController restartDownload:downloadPhoto];
        }
    }
    else
    {
        assert(0);
    }
}

#pragma mark ui helper
-(void)topBarMsg:(NSString*)text
{
     [ToastService showToastWithStatus:text];
}

-(void)navBarTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

#pragma mark <UITableViewDelegate>, open photo browser
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DownloadPhoto * photo = [self.arrayDataSource itemAtIndexPath:indexPath];
    if(!photo.downloadSucceed )
    {
        [self topBarMsg:@"not now"];
        return;
    }
    
    NSMutableArray* photos = [NSMutableArray new];
    for (DownloadPhoto* photo in [self.arrayDataSource allItems])
    {
        if( photo.downloadSucceed)
        {
            NSString* url = photo.filepath;
            [photos addObject: [MWPhoto photoWithURL:[NSURL URLWithString:  url]]];
        }
    }
    
    [_photoBrowserDelegate showPhotoBroswerWithArray:photos startIndex:indexPath.item];
}

#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
