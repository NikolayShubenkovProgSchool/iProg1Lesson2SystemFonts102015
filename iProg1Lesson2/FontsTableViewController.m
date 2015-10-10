//
//  FontsTableViewController.m
//  iProg1Lesson2
//
//  Created by Nikolay Shubenkov on 10/10/15.
//  Copyright © 2015 Nikolay Shubenkov. All rights reserved.
//

#import "FontsTableViewController.h"

@interface FontsTableViewController ()
//Пары ключ значение. Ключ - это название семейства, значение - это массив шрифтов
@property (nonatomic, strong) NSDictionary *familyNamesToFonts;

@end

@implementation FontsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Fonts controller loaded");
    [self setup];
}

- (void)setup {
    self.title = @"Все системные шрифты";
    [self setupModel];
}

- (void)setupModel {
    NSMutableDictionary *familyNamesToFonts = [NSMutableDictionary new];
    
    //Запросим все семейства шрифтов системы
    for (NSString *fontFamilyName in [UIFont familyNames]){
        //Добавим в массив название семейства шрифтов
        
        //Добавим щрифты конкретного семейства
        NSMutableArray *fontsForThisFamily = [NSMutableArray new];
        
        //Перебрать все шрифты семейства
        for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]) {
            //Добавим название шрифта
            [fontsForThisFamily addObject:fontName];
        }
        
        //Для ключа с названием семейства сделаем массив названий шрифтов
        familyNamesToFonts[fontFamilyName] = fontsForThisFamily;
    }
    
    self.familyNamesToFonts = [familyNamesToFonts copy];
    NSLog(@"self.allFonts %@",self.familyNamesToFonts);
}


#pragma mark - Table view data source

- (NSArray *)sortedFamilyNames {
    
    //Сортирует все ключи по алфавиту. Каждому элементу масс
    NSArray *allFamilyNames = self.familyNamesToFonts.allKeys;
    
    //Отсортинуем наш список семейств шрифтов.
    //Это работает так: в массиве объектам будет посылваться метод compare для сравнения
    //одного объекта А с другим объектом Б. Перебрав объекты таким образом можно их отсортировать
    NSArray *sortedNames = [allFamilyNames sortedArrayUsingSelector:@selector(compare:)];
    
    return sortedNames;
}

- (NSString *)familyNameForSection:(NSInteger)section {
    // Массив отсортированных семейств шрифтов
    NSArray *sortedFamilyNames = [self sortedFamilyNames];
    
    //вернуть название семейства с номером, равным section
    return sortedFamilyNames[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.familyNamesToFonts.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // получим семейство шрифтов для секции
    NSString *familyName = [self familyNameForSection:section];
    
    // получим все шрифты семейства
    NSArray *fonts = self.familyNamesToFonts[familyName];
    
    //вернем их количество
    return fonts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Запросили модель
    NSString *fontFamilyName = [self familyNameForSection:indexPath.section];
    
    NSArray *fonts = self.familyNamesToFonts[fontFamilyName];
    
    NSString *name = fonts[indexPath.row];
    
    //Запросили ячейку
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FontCellIdentifier"];
    
    //Настроили ячейку в соответствии с моделью
    cell.textLabel.text = name;
    cell.textLabel.font = [UIFont fontWithName:name size:20];
    
    //Вернули ячейку
    return cell;
}


@end
