cp indicators.pyx testindicators.pyx


function PYTHON3() {

version="$(python3 --version)"
version="${version//[[:space:]]/}"
version="${version:0:9}"
version="p${version:1:8}"
echo $version
}
 
if ! which $python3.6 &> /dev/null; then
echo "PYTHON 3"
run=$(PYTHON3)
echo $run
else

echo "vanilla python command"
run="python"

fi

errorCode=$?

if [ $errorCode -ne 0 ]; then
echo "Error caught trying to fetch python command"
exit $errorCode

fi

${run} setup.py build
${run} setup.py install --user

rm test_package.egg-info -r 
rm build -r 
rm dist -r 
rm testindicators.pyx
rm testindicators.c

