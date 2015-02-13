echo $1
mkdir $1
cd $1
git init
git remote add origin git@bitbucket.org:sw561/$1.git
echo "Simon Wilkinson" >> contributors.txt
git add contributors.txt
git commit -m "Initial commit with contributors"
git push -u origin master
