//
//  ArticleCoreData.swift
//  CarsDeveloperTestApp
//
//  Created by somsak on 28/4/2564 BE.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
class ArticleCoreData {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let articleEntity = "ArticleEntity"
    let contentEntity = "ContentEntity"
    let idKey = "id"
    let createdKey = "created"
    let changedKey = "changed"
    let titleKey = "title"
    let ingressKey = "ingress"
    let imageKey = "image"
    let dateTimeKey = "dateTime"
    
    var articleArray: [ArticleEntity] = []
    var contentArray: [ContentEntity] = []
    
    func saveArticleEntity(data: Article){
        let newArticle = NSEntityDescription.insertNewObject(forEntityName: articleEntity, into: context)
        
            let url = URL(string: data.image)
            let imageData = try? Data(contentsOf: url!)
        
            newArticle.setValue(data.id, forKey: idKey)
            newArticle.setValue(data.created, forKey: createdKey)
            newArticle.setValue(data.changed, forKey: changedKey)
            newArticle.setValue(data.title, forKey: titleKey)
            newArticle.setValue(data.ingress, forKey: ingressKey)
            newArticle.setValue(imageData, forKey: imageKey)
            newArticle.setValue(data.dateTime, forKey: dateTimeKey)
        
            do {
                try context.save()
                
//                print("Save articleEntity success.")
            } catch  {
                print(error)
            }
    }
    
    func saveContentEntity(data: Content, relation: ArticleEntity){

        let content = ContentEntity(context: context)
        content.type = data.type
        content.subject = data.subject
        content.descriptionStr = data.description
        content.origin = relation

        do {
            try context.save()

//            print("Save contentEntity success.")
        } catch  {
            print(error)
        }
    }
    
    func fetchArticleEntity() -> [ArticleEntity]{

        do {
            self.articleArray = try self.context.fetch(ArticleEntity.fetchRequest())
        } catch  {
            print(error)
        }
        
        return self.articleArray
    }

    func deleteArticleEntity(){
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: articleEntity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}

