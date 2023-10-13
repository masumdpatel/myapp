$pkg_name = "myapp"
$pkg_origin = "masumdpatel"
$pkg_version = "0.1.0"
$pkg_maintainer = "Maintainers <Masum>"
$pkg_deps = "core/python"

# An array of the package dependencies needed only at build time.
$pkg_build_deps = "core/python"

function do_build {
    return 0
}

function do_install {
    # Copy the one-file table-setting app plus requirements
    $app_dir = Join-Path -Path $pkg_prefix -ChildPath $pkg_name
    New-Item -ItemType Directory -Path $app_dir -Force
    Copy-Item -Path app.py -Destination $app_dir
    Copy-Item -Path requirements.txt -Destination $app_dir
    Copy-Item -Path templates -Destination $app_dir -Recurse

    # Install pip/virtualenv packages on top of python dependency (i.e. site packages)
    python -m ensurepip
    python -m pip install --upgrade pip
    python -m pip install virtualenv

    # Create a virtualenv for our dependencies and install them
    virtualenv $app_dir\tsenv
    . "$app_dir\tsenv\Scripts\activate"
    python -m pip install -r "$app_dir\requirements.txt"

    # Ensure hab user can activate the virtualenv
    Get-ChildItem -Path $app_dir -Recurse | ForEach-Object {
        Set-Acl -Path $_.FullName -AclObject (Get-Acl $_.FullName) -User "hab" -Permission FullControl
    }
}

# Call the functions
do_build
do_install

