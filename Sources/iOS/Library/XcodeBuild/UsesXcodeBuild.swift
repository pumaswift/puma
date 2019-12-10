//
//  XcodeBuildAware.swift
//  PumaiOS
//
//  Created by khoa on 30/11/2019.
//

import Foundation
import PumaCore

/// Any task that uses xcodebuild
public protocol UsesXcodeBuild: UsesCommandLine {
    var xcodebuildArguments: [String] { get set }
}

public extension UsesXcodeBuild {
    func `default`(project: String, scheme: String) {
        self.project(project)
        self.default(scheme: scheme)
    }

    func `default`(workspace: String, scheme: String) {
        self.workspace(workspace)
        self.default(scheme: scheme)
    }

    func `default`(scheme: String) {
        self.scheme(scheme)
        self.configuration(Configuration.debug)
        self.sdk(Sdk.iPhoneSimulator)
        self.usesModernBuildSystem(enabled: true)
    }

    func project(_ name: String) {
        let normalizedName = name
            .addingFileExtension("xcodeproj")
            .surroundingWithQuotes()
        xcodebuildArguments.append("-project \(normalizedName)")
    }

    func workspace(_ name: String) {
        let normalizedName = name
            .addingFileExtension("xcworkspace")
            .surroundingWithQuotes()

        xcodebuildArguments.append("-workspace \(normalizedName)")
    }

    func scheme(_ name: String) {
        let normalizedName = name
            .surroundingWithQuotes()
        xcodebuildArguments.append("-scheme \(normalizedName)")
    }

    func configuration(_ configuration: String) {
        xcodebuildArguments.append("-configuration \(configuration)")
    }

    func sdk(_ sdk: String) {
        xcodebuildArguments.append("-sdk \(sdk)")
    }

    func usesModernBuildSystem(enabled: Bool) {
        xcodebuildArguments.append("-UseModernBuildSystem=\(enabled ? "YES": "NO")")
    }
}

public extension UsesXcodeBuild {
    func runXcodeBuild(workflow: Workflow) throws {
        try runBash(
            workflow: workflow,
            program: "xcodebuild",
            arguments: xcodebuildArguments,
            processHandler: XcodeBuildProcessHandler()
        )
    }
}