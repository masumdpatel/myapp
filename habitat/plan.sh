pkg_name=myapp
pkg_origin=masumdpatel
pkg_version="0.1.0"
pkg_maintainer="Maintainers <Masum>"
pkg_deps=(core/python)

# An array of the package dependencies needed only at build time.
pkg_build_deps=(core/python)

do_build() {
  return 0
}

do_install() {
  # copy across the one-file table-setting app plus requirements
  app_dir=$pkg_prefix/$pkg_name
  mkdir $app_dir
  cp app.py $app_dir/
  cp requirements.txt $app_dir/
  cp -r templates/ $app_dir/ 
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
