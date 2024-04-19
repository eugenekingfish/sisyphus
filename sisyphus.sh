#!/bin/bash

function check_dirs() {
   if [ ! -d ".tasks" ]; then
      mkdir .tasks;
   fi

   if [ ! -d ".task_bin" ]; then
      mkdir .task_bin;
   fi
}

check_dirs;


if [ "$#" -eq 0 ]; then
   echo "";
   echo "--> Run with flag -h for options.";
   echo "";
else
   inpt_flag=$1;

   if [ "$inpt_flag" = "-n" ]; then

      task_name=$2;

      if [ -f ".tasks/$task_name.task" ]; then
         echo "ERROR: Task with name '$task_name' already exists.";
      else
         date --iso-8601=minutes >> .tasks/$task_name.task;
         echo "Created task: '$task_name'";
      fi;

   elif [ "$inpt_flag" = "-remove" ]; then

      task_name=$2;

      if [ -f ".tasks/$task_name.task" ]; then
         mv .tasks/$task_name.task .task_bin/$task_name.task;
         echo "Moved task '$task_name' to the task bin.";
      else
         echo "ERROR: Task with name '$task_name' does not exist.";
      fi

   elif [ "$inpt_flag" = "-view" ]; then

      task_name=$2;
      if [ -z "$2" ]; then 
         echo "ERROR: -view must be supplied with a non-empty task name.";
      else
         if [ -f ".tasks/$task_name.task" ]; then
            echo $task_name;
            cat .tasks/$task_name.task;
         else
            echo "ERROR: Task with name '$task_name' does not exist.";
         fi
      fi

   elif [ "$inpt_flag" = "-tasks" ]; then
      echo "";
      ls -1 .tasks/*.task | sed -e "s/\.task$//";
      echo "";

   elif [ "$inpt_flag" = "-help" ]; then
      echo "";
      echo "-view   <TASK> -- View the contents of the task TASK.";
      echo "-n      <TASK> -- Create a new task named TASK.";
      echo "-remove <TASK> -- Delete the task named TASK.";
      echo "-tasks         -- View the names of all tasks.";
      echo "";
   else
      echo "ERROR: Unrecognised flag '$inpt_flag'.";
   fi
fi

