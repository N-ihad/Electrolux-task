//
//  Profile.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import Foundation

class Profile {
    
    var avatarURL: String
    var firstName: String
    var lastName: String
    var biography: String
    
    static let testProfile = Profile(avatarURL: "https://sun9-8.userapi.com/impg/SJccc2DIjGMdmQxyXIBPm-dlPvI0F1-VwRn1IQ/GJ_w7sVLso0.jpg?size=1072x1452&quality=96&proxy=1&sign=968b4e2e020385a4fc441abc72e9022d&type=album",
                                     firstName: "Nihad",
                                     lastName: "Samedovsdfsdfsdfsdf",
                                     biography: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.")
    
    init(avatarURL: String, firstName: String, lastName: String, biography: String) {
        self.avatarURL = avatarURL
        self.firstName = firstName
        self.lastName = lastName
        self.biography = biography
    }
    
    
}
