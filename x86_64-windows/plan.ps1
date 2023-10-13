$pkg_name = "myappwindows"
$pkg_origin = "masumdpatel"
$pkg_version = "0.1.0"
$pkg_maintainer = "Maintainers <Masum>"
$pkg_deps = @("core/python")

# An array of the package dependencies needed only at build time.
$pkg_build_deps = @("core/python")

# Define a function for the build step (you can customize it as needed).
function Invoke-Build {
    return 0
}

# Define a function for the installation step.
function Invoke-Install {
    $app_dir = "$HAB_CACHE_SRC_PATH\$pkg_name"	
    $sourceDir = "c:\Users\Administrator\Document\myapp\"

    New-Item -ItemType Directory -Path $app_dir | Out-Null
    Copy-Item -Path "$sourceDir\app.py" -Destination "$app_dir\"
    Copy-Item -Path "$sourceDir\requirements.txt" -Destination "$app_dir\"
    Copy-Item -Path "$sourceDir\templates\" -Destination "$app_dir\" -Recurse

    # Install pip/virtualenv packages on top of Python dependency (i.e. site packages)
    python -m ensurepip --upgrade:
    python -m pip install --upgrade pip
    python -m pip install virtualenv

    # Create virtualenv for our dependencies & install
    virtualenv "$app_dir\tsenv"
    & "$app_dir\tsenv\Scripts\Activate"
    python -m pip install -r "$app_dir\requirements.txt"
}

