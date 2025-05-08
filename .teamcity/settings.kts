import jetbrains.buildServer.configs.kotlin.v2019_2.*
import jetbrains.buildServer.configs.kotlin.v2019_2.buildFeatures.swabra
import jetbrains.buildServer.configs.kotlin.v2019_2.buildSteps.exec
import jetbrains.buildServer.configs.kotlin.v2019_2.buildSteps.script
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.finishBuildTrigger
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.vcs

/*
The settings script is an entry point for defining a TeamCity
project hierarchy. The script should contain a single call to the
project() function with a Project instance or an init function as
an argument.

VcsRoots, BuildTypes, Templates, and subprojects can be
registered inside the project using the vcsRoot(), buildType(),
template(), and subProject() methods respectively.

To debug settings scripts in command-line, run the

    mvnDebug org.jetbrains.teamcity:teamcity-configs-maven-plugin:generate

command and attach your debugger to the port 8000.

To debug in IntelliJ Idea, open the 'Maven Projects' tool window (View
-> Tool Windows -> Maven Projects), find the generate task node
(Plugins -> teamcity-configs -> teamcity-configs:generate), the
'Debug' option is available in the context menu for the task.
*/
version = "2019.1"

class Version(val major: Int, val minor: Int, val maintenance: Int) {

	override fun toString(): String {
		return "%d.%d.%d".format(major, minor, maintenance)
	}

	val identifier: String
		get() {
			return "${major}_${minor}_${maintenance}"
		}

	val description: String
		get() {
			return toString()
		}
}

project {

	val version = Version(2025, 0, 0)

	val build = Build()
	val publish = Publish(version, build)

	buildType(build)
	buildType(publish)

}

class Build : BuildType({
	name = "Build And Test"

	vcs {
		root(DslContext.settingsRoot)
	}

	steps {
		exec {
			path = "./gradlew"
			arguments = "clean test"
		}
	}

	features {
		swabra { }
	}

	triggers {
		vcs {
		}
	}
})


class Publish(val version: Version, private val parentBuildType: Build) : BuildType({
	id("Publish_${version.identifier}".toId())
	name = "Publish ${version.description} "


	vcs {
		root(DslContext.settingsRoot)
	}


	steps {
		exec {
			path = "./create-xcframework.sh"
		}
	}

	features {
		swabra { }
	}

	triggers {
		finishBuildTrigger {
			buildType = "${parentBuildType.id}"
			successfulOnly = true
		}
	}

})
