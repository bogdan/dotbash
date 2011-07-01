_rake_does_task_list_need_generating () {
  if [ ! -f .rake_tasks ]; then return 0;
  else
    accurate=$(stat -c%m .rake_tasks)
    changed=$(stat -c%m Rakefile)
    return $(expr $accurate '>=' $changed)
  fi
}

_rake () {
  if [ -f Rakefile ]; then
    if _rake_does_task_list_need_generating; then
      rake --silent --tasks | cut -d " " -f 2 | sed "s/\[.*\]//g" > .rake_tasks
    fi
    compadd `cat .rake_tasks`
  fi
}

compdef _rake rake
