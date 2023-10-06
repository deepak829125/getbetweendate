
old_branch_end=$(git rev-list --simplify-by-decoration -2 HEAD | tail -n 1)
#echo "hello"
old_branch_end="${old_branch_end:0:7}"
rev_commit=$(git log  --pretty=format:"%h" ) 
first_commit=""
#echo "Old branch:"$old_branch_end

for lscommit in $rev_commit
do

#echo "new branch:"$lscommit

if [[ $old_branch_end != $lscommit ]] ; then
first_commit=$lscommit
else
break
#echo "new branch:"$lscommit

#echo $lscommit
#echo $old_branch_end
fi
done

echo "Commit ID : "$first_commit
echo "Date of Branch Creation" $(git show --no-patch --format=%ci $first_commit)