//
//  ProjectType.swift
//  PumaiOS
//
//  Created by khoa on 17/12/2019.
//

import Foundation

public enum ProjectType {
    case project(String)
    case workspace(String)

    var name: String {
        switch self {
        case .project(let name):
            return name
        case .workspace(let name):
            return name
        }
    }
}
