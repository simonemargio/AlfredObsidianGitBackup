query="{query}"


# Check if there is an internet connection
checkInternetConnection () {
  echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1

  if [ ! $? -eq 0 ]; then
      echo "Oops, you are currently offline!"
      echo error
  fi
}


executeBackup () {
  # Check if there are any files to add
  if [[ -n $(git status -s) ]]; then
    # Add all files
    git add .

    # Create commit with current date and time
    commit_msg="Backup at $(date)"
    git commit -m "$commit_msg"

    # Push changes
    git push origin HEAD
  else
    echo true
  fi
}

cd "$query"
checkInternetConnection
executeBackup