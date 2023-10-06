branchpointfun() {
  CURB=`git rev-parse --abbrev-ref HEAD`
  BRANCHPOINTVAR=BRANCHPOINT_OF_${CURB}
  # If a branchpoint variable exists for the current branch
  if [[ -v ${BRANCHPOINTVAR} ]]; then
    echo ${!BRANCHPOINTVAR}
  else
    git rev-list --simplify-by-decoration -2 HEAD | tail -n 1
  fi
}
alias branchpoint=branchpointfun

branchfun() {
  NAME="$@";
  if [ "$NAME" != "" ]; then
    # Record where this branchpoint started in order to do diffs and linting with it later
    CURCOMMIT=`git rev-parse HEAD`
    export declare BRANCHPOINT_OF_${NAME}=$CURCOMMIT
    echo "export BRANCHPOINT_OF_${NAME}=$CURCOMMIT" >> $VARSFILE
    # Now create the branch
    git checkout -b $NAME;
  fi
}
alias branch=branchfun

closefun() {
  CURB=`git rev-parse --abbrev-ref HEAD`;
  SELBR=`git branch --merged | grep -E "^  $@" | cut -d " " -f 3`;
  git branch -d $SELBR;
  BRANCHPOINTVAR=BRANCHPOINT_OF_${SELBR}
  # If a branchpoint variable exists for the branch being removed
  if [[ -v ${BRANCHPOINTVAR} ]]; then
    unset ${BRANCHPOINTVAR}
    grep -v "^${BRANCHPOINTVAR}=" $VARSFILE > $VARSFILE
  fi
}
alias close=closefun


branchpointfun
