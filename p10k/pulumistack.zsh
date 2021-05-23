  #############[ pulumistack: current pulumi stack (https://www.pulumi.com/) ]#############
  # Show pulumistack only when the the command you are typing invokes one of these tools.
  # Tip: Remove the next line to always show pulumistack.
  typeset -g POWERLEVEL9K_PULUMISTACK_SHOW_ON_COMMAND='pulumi'

  function prompt_pulumistack() {
    # Check working directory is a pulumi project
    local ext
    if [ -f "./Pulumi.yaml" ]; then
      ext="yaml"
    elif [ -f "./Pulumi.yml" ]; then
      ext="yml"
    else
      return
    fi

    # Check pulumi workspace file exist
    local pjt_name=$(basename $PWD)
    local pjt_hash=$(echo -n $PWD/Pulumi.${ext} | sha1sum | head -c 40)
    local ws_path="$HOME/.pulumi/workspaces/${pjt_name}-${pjt_hash}-workspace.json"
    if [ ! -f ${ws_path} ]; then
      return
    fi

    # Print stack name
    local stack_name=$(cat ${ws_path} | jq ".stack" -r)
    if [ ! -z "${stack_name}" ]; then
      p10k segment -i '⏣' -f 13 -t ${stack_name}
    fi
  }

  function instant_prompt_pulumistack() {
    prompt_pulumistack
  }
