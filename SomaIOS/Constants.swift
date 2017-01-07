//
//  Constants.swift
//  SomaIOS
//
//  Created by ali ziwa on 9/17/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import Foundation


class Constants{

    struct urls {
        let audioImage:String = "https://lh3.googleusercontent.com/AzZHG9O_jgtrTBSHTjSG-a1mKEqYYlFPgVx5P2jR1nn8nespTG16sW-f0W7IyG4akQ=w300";
        let homeURL:String = "http://104.236.28.225/api/v1";
        let loginURL:String = "http://104.236.28.225/api/v1/userLogin";
        let registerURL:String = "http://104.236.28.225/api/v1/register";
        let weatherURL:String="http://api.openweathermap.org/data/2.5/weather?q=Kampala,ug&APPID=37596cdac03da664922e01b6f85126e8";
        let foreCastURL:String="http://api.openweathermap.org/data/2.5/forecast/daily?q=Kampala,ug&APPID=37596cdac03da664922e01b6f85126e8&units=metric";
            }
    
    struct constants {
        let userToken:String = "user_token";
        let loggedIn:String = "loggedIn";
        let level:String = "level";
        let quizExamId:String="QuizID";
        let quizSubject:String="QuizSubject";
        let examTeacher:String="examTeacher";
        let answerArray:String="AnswerArray";
        let title:String="title";
        let author:String="author";
        let photo:String="photo";
        let url:String="url";
        let summary:String="summary";
        let bookFileName:String = "bookFileName";
        let answersSubmissionArray:String="answersSubmissionArray";
        let student_ID:String="student_id";
        let local:String = "local";

    }

}
