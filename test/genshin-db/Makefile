all:
	node runtests.js	

deps:
	npm install --save genshin-db
	npm install --save mucko

genshin-db:
	node -e 'require("./test-genshin-db.js"); UnitTest.run(Test)'
