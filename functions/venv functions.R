# renv/library, is a library that contains all packages 
# currently used by your project

# lockfile, renv.lock, records enough metadata about every package

# project R profile, .Rprofile. This file is run automatically every time you start R

# initialize virtual environment
renv::init()

# install packages
renv::install()

# check venv packages status
renv::status()

# update packages
renv::update()

# create snapshot - record packages and sources in lockfile
renv::snapshot()

# reinstall packages with specific versions and location from lockfile
# needed for sharing code, running on new machine, or fixing package update
renv::restore()

# check package history from Git
renv::history()

# revert back to previous version
renv::revert()

# download latest dev version or updgrade
# renv::upgrade()

# deactiate the venv - removes autoloader from project
# renv::deactivate()
# completely remove it
# renv::deactivate(clean = TRUE)

# completely remove all venv infrastucture and packages
# root <- renv::paths$root()
# unlink(root, recursive = TRUE)
# utils::remove.packages("renv")