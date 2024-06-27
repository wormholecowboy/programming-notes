# NPM

Created: March 2, 2022 9:29 PM
Updated: July 19, 2022 11:10 PM


# run a script inside package.json
npm run <scriptname>

# install dependencies from a cloned repo
npm install # will run install for all package.json

# change node_modules dir
The prefix config defaults to the location where node is installed. On most systems, this is /usr/local

# uninstall all
npm uninstall `ls -1 node_modules | tr '/\n' ' '`

# update lock file
npm i --package-lock-only

^	accept updates to minor and patch releases only.	^0.13.0: 0.13.1, 0.14.0
~	accept updates to patch releases only.	~0.13.0: 0.13.1 (not 0.14.0)
>	accept updates to any version greater than the one specified.	>0.13.0: 0.13.1, 0.14.1, 1.1.1
<	accept updates to any version less than the one specified.	<3.0.0: 2.0.0, 2.9.0
>=	accept any version greater than or equal to the one specified.	>=3.0.0: 3.0.0, 4.1.0
<=	accept any version less than or equal to the one specified.	<=3.0.0: 3.0.0, 4.1.0
=	accept only the exact specified version.	=3.0.0: 3.0.0, (not 3.0.1)
-	accept a range of versions.	1.0.0 - 1.10.10: 1.5.0 (not 1.11.0)
||	accept a combination of versions.	<2.1.0 || >2.6.0: 2.0.1, 3.1.0
x.x.x	accept only the specified version (no symbol).	=3.0.0: 3.0.0, (not 3.0.1)
latest	always get latest version available.	-
