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
    name="myfibopy",
    version="0.0.1",
    author="Fabien Ors",
    author_email="fabien.ors@mines-paristech.fr",
    description="Fibonacci",
    long_description=get_long_description(),
    # TODO license file
    url="https://github.com/fabien-ors/myfibo", # TODO
    project_urls={
        "Bug Tracker": "https://github.com/fabien-ors/myfibo/issues",  # TODO
    },
    distclass=BinaryDistribution,
    cmdclass={"install": InstallPlatlib},
    packages={"myfibopy"},
    package_data={"myfibopy": ["*.so"]}, # Otherwise _myfibopy.so is not installed 
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
