from setuptools import find_packages, setup
from setuptools.dist import Distribution

class BinaryDistribution(Distribution):
  def is_pure(self):
    return False
  def has_ext_modules(self):
    return True

from setuptools.command.install import install
class InstallPlatlib(install):
    def finalize_options(self):
        install.finalize_options(self)
        self.install_lib=self.install_platlib

def get_long_description():
    with open("README.md", "r", encoding="utf-8") as fh:
        long_description = fh.read()
    return long_description

setup(
    name="myfibopy", # TODO: try using '@PACKAGE_NAME@'
    version="0.0.1", # TODO: try using '@PROJECT_VERSION@'
    author="Fabien Ors",
    author_email="fabien.ors@mines-paristech.fr",
    description="Fibonacci",
    long_description=get_long_description(),
    # TODO license file
    url="https://github.com/fabien-ors/myfibo", # TODO Project URL
    project_urls={
        "Bug Tracker": "https://github.com/fabien-ors/myfibo/issues", # TODO Project URLs
    },
    distclass=BinaryDistribution, # TODO: Really needed?
    cmdclass={"install": InstallPlatlib}, # TODO: Really needed?
    packages={"myfibopy"}, # TODO: try using '@PACKAGE_NAME@'
    package_data={"myfibopy":["*.so", "*.pyd"]}, # GCC and MSVC swig library extension # TODO: try using '@PACKAGE_NAME@':['$<TARGET_FILE_NAME:@PACKAGE_NAME@>']
    include_package_data=True,
    classifiers=[
        "Programming Language :: Python :: 3",
        "Programming Language :: C++",
        "Development Status :: 4 - Beta",
        "Environment :: Other Environment",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Operating System :: POSIX :: Linux",
        "Operating System :: MacOS :: MacOS X",
        "Operating System :: Microsoft :: Windows",
        "Topic :: Software Development :: Libraries :: Python Modules",
    ],
)
