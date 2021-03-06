//
//  ReactingToEventsTestCase.swift
//  DTCollectionViewManagerExample
//
//  Created by Denys Telezhkin on 24.08.15.
//  Copyright © 2015 Denys Telezhkin. All rights reserved.
//

import XCTest
import DTModelStorage
import Nimble
import DTCollectionViewManager

class ReactingToEventsTestCase: XCTestCase {
    
    var controller = DTTestCollectionController()
    
    override func setUp() {
        super.setUp()
        let _ = controller.view
        controller.manager.startManagingWithDelegate(controller)
        controller.manager.viewBundle = NSBundle(forClass: self.dynamicType)
        controller.manager.storage = MemoryStorage()
        let _ = controller.collectionView?.numberOfSections()
    }
    
    func testCellSelectionClosure()
    {
        controller.manager.registerCellClass(SelectionReactingCollectionCell)
        var reactingCell : SelectionReactingCollectionCell?
        controller.manager.whenSelected(SelectionReactingCollectionCell.self) { (cell, model, indexPath) in
            cell.indexPath = indexPath
            cell.model = model
            reactingCell = cell
        }
        
        controller.manager.memoryStorage.addItems([1,2], toSection: 0)
        controller.manager.collectionView(controller.collectionView!, didSelectItemAtIndexPath: indexPath(1, 0))
        
        expect(reactingCell?.indexPath) == indexPath(1, 0)
        expect(reactingCell?.model) == 2
    }
    
    func testCellConfigurationClosure()
    {
        controller.manager.registerCellClass(SelectionReactingCollectionCell)
        
        var reactingCell : SelectionReactingCollectionCell?
        
        controller.manager.configureCell(SelectionReactingCollectionCell.self, { (cell, model, indexPath) in
            cell.indexPath = indexPath
            cell.model = model
            cell.textLabel?.text = "Foo"
            reactingCell = cell
        })
        
        controller.manager.memoryStorage.addItem(2, toSection: 0)
        controller.manager.collectionView(controller.collectionView!, cellForItemAtIndexPath: indexPath(0, 0))
        
        expect(reactingCell?.indexPath) == indexPath(0, 0)
        expect(reactingCell?.model) == 2
        expect(reactingCell?.textLabel?.text) == "Foo"
    }
    
//    func testHeaderConfigurationClosure()
//    {
//        controller.manager.registerHeaderClass(ReactingHeaderFooterView)
//        
//        var reactingHeader : ReactingHeaderFooterView?
//        
//        controller.manager.configureHeader(ReactingHeaderFooterView.self) { (header, model, sectionIndex) in
//            header.model = "Bar"
//            header.sectionIndex = sectionIndex
//        }
//        controller.manager.memoryStorage.setSectionHeaderModels(["Foo"])
//        reactingHeader = controller.manager.tableView(controller.tableView, viewForHeaderInSection: 0) as? ReactingHeaderFooterView
//        
//        expect(reactingHeader?.sectionIndex) == 0
//        expect(reactingHeader?.model) == "Bar"
//    }
//    
//    func testFooterConfigurationClosure()
//    {
//        controller.manager.registerFooterClass(ReactingHeaderFooterView)
//        
//        var reactingFooter : ReactingHeaderFooterView?
//        
//        controller.manager.configureFooter(ReactingHeaderFooterView.self) { (footer, model, sectionIndex) in
//            footer.model = "Bar"
//            footer.sectionIndex = sectionIndex
//        }
//        controller.manager.memoryStorage.setSectionFooterModels(["Foo"])
//        reactingFooter = controller.manager.tableView(controller.tableView, viewForFooterInSection: 0) as? ReactingHeaderFooterView
//        
//        expect(reactingFooter?.sectionIndex) == 0
//        expect(reactingFooter?.model) == "Bar"
//    }
    
    func testCellRegisterSelectionClosure()
    {
        var reactingCell : SelectionReactingCollectionCell?
        
        controller.manager.registerCellClass(SelectionReactingCollectionCell.self, whenSelected: { (cell, model, indexPath) in
            cell.indexPath = indexPath
            cell.model = model
            reactingCell = cell
        })
        
        controller.manager.memoryStorage.addItems([1,2], toSection: 0)
        controller.manager.collectionView(controller.collectionView!, didSelectItemAtIndexPath: indexPath(1, 0))
        
        expect(reactingCell?.indexPath) == indexPath(1, 0)
        expect(reactingCell?.model) == 2
    }
    
}
