#
# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

# Required.
# Sets the name of the package. This will be used in along with `pkg_origin`,
# and `pkg_version` to define the fully-qualified package name, which determines
# where the package is installed to on disk, how it is referred to in package
# metadata, and so on.
pkg_name=myapp

# Required unless overridden by the `HAB_ORIGIN` environment variable.
# The origin is used to denote a particular upstream of a package.
pkg_origin=masumdpatel

# Required.
# Sets the version of the package
pkg_version="0.1.0"

# Optional.
# The name and email address of the package maintainer.
pkg_maintainer="Maintainers <Masum>"

# `origin/package/version/release`.
pkg_deps=(core/python)

# An array of the package dependencies needed only at build time.
pkg_build_deps=(core/python)

do_build() {
  return 0
}

do_install() {
  do_default_install
  # copy across the one-file table-setting app plus requirements
  app_dir=$pkg_prefix/$pkg_name
  mkdir $app_dir
  cp app.py $app_dir/
  cp requirements.txt $app_dir/
  cp templates/ $app_dir/ 
  #install pip/virtualenv packages on top of python dependency (i.e. site packages)
  pip install --upgrade pip
  pip install virtualenv
  # create virtualenv for our dependencies & install
  virtualenv $app_dir/tsenv
  source $app_dir/tsenv/bin/activate
  pip install -r $app_dir/requirements.txt
  # ensure hab user can activate the virtualenv
  chown -R hab:hab $app_dir

}
