-to do the full end to end conversion
	./port2brew.sh

-to get latest brew and port lists
	./listallbrews.sh
	./listactiveports.sh

-to create and initialize the db
	./initdb.sh

-to import the lists into sqlite3 tables
	./importlists.sh

-to export clean port list
	./exportcleanports.sh

-to get port dependencies
	python port-deps-list.py -f ports-clean.csv

-to import port dependencies into sqlite3 tables
	./importportdeps.sh

-to export conversion list
	./exportport2brew.sh

-TODO
	-include version info
