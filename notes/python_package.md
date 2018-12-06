steps:
create package with cookie cutter
git init add commit
tox tests
set up travis https://travis-ci.org/ (or travis enable)
push to github repo
set up documnetation hosting (read the docs free service)
create account on PyPI (https://pypi.python.org/) (use testpypi instead)
create a $HOME/.pypirc file
	```
	[distutils]
	index-servers=pypi
	[pypi]
	repository = https://pypi.python.org/pypi
	username = <username>
	password = <password>
	```
virtualenv (pew or virtualenvwrapper)
install packaging tools (wheel, twine)
build distribution files
./setup.py sdist
./setup.py bdist_wheel
or 
make dist
twin upload dist/*
***
can now install with pip
continue in development

pip install -e . (install in current virtualenv, changes will be reflected immediately)

versions (bumpversion, versioneer)












Reference https://packaging.python.org/
1) use cookiecutter

	'''
	pip3 install cookiecutter
	cookiecutter https://github.com/xuanluong/cookiecutter-python-cli
	'''

2) setup.py
	contains information about installation and what the package is doing.
	contains setuptools import

	setup.cfg
	config file to go with setup.py
	settings for building & packaging plugins
	wheel & test frameworks etc	

	example:

'''
from setuptools import setup, find_packages

setup(
    name='sadboisck',
    version='0.1',
    packages=find_packages(exclude=['docs', 'tests']),
    include_package_data=True,
		license='MIT',
    install_requires=[
        'Click',
    ],
    entry_points='''
      [console_scripts]
      yourscript=scripts.yourscript:sb
      ''',
)
'''



3) Manifest 
	data files
	configuration
	documentation
	any other files to be included other than your code

4) README.rst
	github docs

5) ./tests >> use tox
	./docs

6) Continuous Integration (CI)
	travis.yml

7) requirements.txt



