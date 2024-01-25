## install if needed (do this exactly once):
# install.packages("usethis")

# renv::install('usethis')
library(usethis)
use_git_config(user.name = "glennartz3", user.email = "glennartz3@gmail.com")

# create new token, pulls up github webpage
usethis::create_github_token()

# prompts for token and stores it
gitcreds::gitcreds_set()

gitcreds::gitcreds_get()
