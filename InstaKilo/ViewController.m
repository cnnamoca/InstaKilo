//
//  ViewController.m
//  InstaKilo
//
//  Created by Carlo Namoca on 2017-10-18.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import "ViewController.h"
#import "myCollectionViewCell.h"
#import "myCollectionReusableView.h"

@interface ViewController () <UICollectionViewDataSource>

//add collection view
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//setup UICollectionView layouts
@property (strong, nonatomic) UICollectionViewFlowLayout *myLayout;

//setup image arrays
//by subject
@property (nonatomic) NSArray<UIImage*> *rideImages;
@property (nonatomic) NSArray<UIImage*> *artImages;
@property (nonatomic) NSArray<UIImage*> *attractionImages;
//by location
@property (nonatomic) NSArray<UIImage*> *disneyLand;
@property (nonatomic) NSArray<UIImage*> *artDistrict;

@property (nonatomic) NSArray *imageCollectionArr;
@property (nonatomic) NSArray *locationArr;

@property (nonatomic) BOOL fakeSort;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Create arrays according to subject
    self.rideImages = @[[UIImage imageNamed:@"ride1"], [UIImage imageNamed:@"ride2"]];
    self.artImages = @[[UIImage imageNamed:@"art1"], [UIImage imageNamed:@"art2"], [UIImage imageNamed:@"art3"], [UIImage imageNamed:@"art4"], [UIImage imageNamed:@"art5"]];
    self.attractionImages = @[[UIImage imageNamed:@"attraction1"], [UIImage imageNamed:@"attraction2"], [UIImage imageNamed:@"attraction3"]];
    //Create arrays according to location
    self.disneyLand = @[[UIImage imageNamed:@"ride1"], [UIImage imageNamed:@"ride2"], [UIImage imageNamed:@"attraction1"], [UIImage imageNamed:@"attraction2"], [UIImage imageNamed:@"attraction3"]];
    self.artDistrict = self.artImages;
    
    //create array of image arrays
    self.imageCollectionArr = @[self.rideImages, self.artImages, self.attractionImages];
    self.locationArr = @[self.disneyLand, self.artDistrict];
    
    //set up datasource to this view controller *REMEMBER TO SET UP DELEGATE!*
    self.collectionView.dataSource = self;
    //easier to create your own method to layout your collectionView
    [self setupMyLayout];
    
    //set up collection view's layout
    self.collectionView.collectionViewLayout = self.myLayout;
    
    self.fakeSort = NO;
    
}

//SETUP SORT BUTTON
- (IBAction)sortButton:(id)sender {
    if (self.fakeSort == NO){
        self.fakeSort = YES;
        [self.collectionView reloadData];
    } else {
        self.fakeSort = NO;
        [self.collectionView reloadData];
    }
}


-(void)setupMyLayout
{
    self.myLayout = [UICollectionViewFlowLayout new];
    self.myLayout.itemSize = CGSizeMake(100, 100); // Set size of cell
    self.myLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);  // "Border around each section"
    self.myLayout.minimumInteritemSpacing = 15;  // Minimum horizontal spacing between cells
    self.myLayout.minimumLineSpacing = 10;  // Minimum vertical spacing
    
//     Add this line so headers will appear. If this line is not present, headers will not appear
    self.myLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 40);

    
    // Add this line so footers will appear. If this line is not present, footers will not appear
//    self.myLayout.footerReferenceSize = CGSizeMake(30, self.collectionView.frame.size.height);
}



//Collection view datasource protocols
//Set number of sections
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.fakeSort == NO){
        return [[self.imageCollectionArr objectAtIndex:section] count];
    } else {
        return [[self.locationArr objectAtIndex:section] count];
    }
}

//Set cell data
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.fakeSort == NO){
        myCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"myCell"
                                                                                    forIndexPath:indexPath];
        
        cell.imageView.image = [self.imageCollectionArr[indexPath.section] objectAtIndex:indexPath.row];
        
        return cell;
    } else {
        myCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"myCell"
                                                                                    forIndexPath:indexPath];
        
        cell.imageView.image = [self.locationArr[indexPath.section] objectAtIndex:indexPath.row];
        
        return cell;
        
    }
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.fakeSort == NO){
        return self.imageCollectionArr.count;
    } else {
        return self.locationArr.count;
    }
}

//Header view setup
-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (self.fakeSort == NO){
        switch (indexPath.section){
            case 0: {
                myCollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myHeader" forIndexPath:indexPath];
                headerView.label.text = @"RIDES";
                return headerView;
            }
            case 1: {
                myCollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myHeader" forIndexPath:indexPath];
                headerView.label.text = @"ART";
                return headerView;
            }
            case 2: {
                myCollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myHeader" forIndexPath:indexPath];
                headerView.label.text = @"ATTRACTIONS";
                return headerView;
            }
            default:
                return nil;
        }
    } else {
         switch (indexPath.section){
             case 0: {
                 myCollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myHeader" forIndexPath:indexPath];
                 headerView.label.text = @"DISNEYLAND";
                 return headerView;
             }
             case 1: {
                 myCollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myHeader" forIndexPath:indexPath];
                 headerView.label.text = @"ART DISTRICT";
                 return headerView;
             }
             default:
                 return nil;
         }
    }
    return nil;
}


@end
