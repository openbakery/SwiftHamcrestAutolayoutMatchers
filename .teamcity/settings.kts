import jetbrains.buildServer.configs.kotlin.v2019_2.*
import jetbrains.buildServer.configs.kotlin.v2019_2.buildFeatures.swabra
import jetbrains.buildServer.configs.kotlin.v2019_2.buildSteps.exec
import jetbrains.buildServer.configs.kotlin.v2019_2.buildSteps.script
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.finishBuildTrigger
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.vcs

version = "2025.03"

class Version(val major: Int, val minor: Int) {

	override fun toString(): String {
		return "%d.%d".format(major, minor)
	}

	val identifier: String
		get() {
			return "${major}_${minor}"
		}

	val description: String
		get() {
			return toString()
		}
}

project {

	val version = Version(2025, 0)

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
			path = "./test"
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
	id("Publish".toId())
	name = "Publish"

	vcs {
		root(DslContext.settingsRoot)
	}

	steps {
		script {
			scriptContent = "chmod +x create-xcframework.sh"
		}

		exec {
			path = "./create-xcframework.sh ${version}.%build.counter%"
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
