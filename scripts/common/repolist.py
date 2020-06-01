#!/usr/bin/env python3
# Print a sorted list of the repos in kotzgroup org
#
# David Kotz, 2019

import os

# grab my GitHub token from file
with open(os.path.expanduser('~') + '/.github_token', "r") as f:
    token = f.read()

# fetch repo list from GitHub
from github import Github
gh = Github(token)
org = gh.get_organization('kotzgroup')
repos = org.get_repos()  # list of repos

for reponame in sorted(repo.name for repo in repos):
    print(reponame)

###########################
# references:
# https://github.com/PyGithub/PyGithub
# https://github.com/isaacs/github/issues/895. [pllim on Jan 24 2018]
# https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line
# https://www.guru99.com/reading-and-writing-files-in-python.html#3
