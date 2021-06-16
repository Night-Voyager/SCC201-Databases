mkdir .\out\production\main\
javac ./main/src/*.java -d ./out/production/main/
java -classpath ".\out\production\main;sqlite-jdbc-3.7.2.jar" Main
