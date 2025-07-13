# Update remotes
for r in $(git remote); do
	git fetch $r;
done

TAG=$(git for-each-ref --sort=-creatordate --format '%(refname:short)' refs/tags | head -n 1)
echo "Latest tag: $TAG"

git checkout $TAG
git checkout -b jdepedro/$TAG
echo "Now run: git rebase jdepedro/<previous_tag>; then solve errors and commit"
