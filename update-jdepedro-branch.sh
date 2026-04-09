# Update remotes
for r in $(git remote); do
	git fetch $r;
done

git pull

TAG=$(git for-each-ref --sort=-creatordate --format '%(refname:short)' refs/tags | head -n 1)
echo "Latest tag: $TAG"

git checkout -b jdepedro/$TAG
git rebase $TAG

echo "Now solve errors and commit"
