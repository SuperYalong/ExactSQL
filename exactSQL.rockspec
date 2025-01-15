rockspect = {
    package = "exactSQL",
    version = "0.0.1-1",
    description = "A light SQL builder",
    homepage = "https://github.com/SuperYalong/ExactSQL",
    dependencies = {
        "resty.template"
    },
    source = {
        url = "https://github.com/SuperYalong/ExactSQL"
    },
    build = {
        type = "builtin",
        modules = {
            mymodule = "src/exact.lua"
        }
    }
}