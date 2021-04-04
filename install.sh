#!/bin/bash

# Basic script to set custom project hook and share it with other developpers
# original script from http://stackoverflow.com/questions/3462955/putting-git-hooks-into-repository/3464399#3464399
#
# cd [path-of-the-script]
# . install.sh
#
# Folders usecase
# /.git
# /.git/hooks
# /dev/install.sh <- this script
# /dev/git-hooks <- path of your hooks

# list of hooks the script will look for
HOOK_NAMES="applypatch-msg pre-applypatch post-applypatch pre-commit prepare-commit-msg commit-msg post-commit pre-rebase post-checkout post-merge pre-receive update post-receive post-update pre-auto-gc"

# relative folder path of the .git hook / current script
GIT_HOOK_DIR=./.git/hooks
# relative folder path of the custom hooks to deploy / current script
LOCAL_HOOK_DIR=./scripts/git
# relative folder path of the custom hooks to deploy / .git hook folder
LNS_RELATIVE_PATH=../../scripts/git

echo "Install project git hooks"

for hook in $HOOK_NAMES; do
	    # if we have a custom hook to set
	        if [ -f $LOCAL_HOOK_DIR/$hook ]; then
			      echo "> Hook $hook"
			            # If the hook already exists, is executable, and is not a symlink
				          if [ ! -h $GIT_HOOK_DIR/$hook -a -x $GIT_HOOK_DIR/$hook ]; then
						            echo " > Old git hook $hook disabled"
							              # append .local to disable it
								                mv $GIT_HOOK_DIR/$hook $GIT_HOOK_DIR/$hook.local
										      fi

										            # create the symlink, overwriting the file if it exists
											          echo " > Enable project git hook"
												        ln -s -f $LNS_RELATIVE_PATH/$hook $GIT_HOOK_DIR/$hook
													    fi
												    done
