function prompt_aws_vault() {
  if [[ -n $AWS_VAULT ]]; then
    echo -n "$AWS_VAULT \u2601 "
  fi
}

alias av='aws-vault --backend=pass --pass-prefix=aws'
