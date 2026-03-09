# Contributing to the Packit core repository

Thank you for considering to contribute to Packit! This file will help you in understanding how to contribute to our core packages repository.

## Getting started

The steps below guide you through the process of forking the repository, commiting changes and opening a pull request.

1. **Fork the repository** <br>
Click the `Fork` button on the top-right corner of the repository page. This creates your own copy of the core repository, where you can make your changes.

2. **Clone your fork locally** <br>
To start working, you need the repository on your local machine. To do this, you need to clone it.
<br><br>
Run the commands below to clone your fork locally, replace `<your-username>` with your GitHub username.
```
git clone https://github.com/<your-username>/core.git
cd core
```

3. **Create a new branch** <br>
Now you have a local copy of the repository, you need to create a new branch where you can make your changes.
<br><br>
Please use a name which describes your changes for the branch.
```
git checkout -b <branch-name>
```

4. **Add your changes** <br>
On the new branch, you can now add your own changes. Please see the sections below for instructions of several types of contributions.

5. **Pushing your changes** <br>
After you added your changes, you first need to create a commit and push your changes.
<br><br>
<a id="commit-naming" name="commit-naming"></a>
Please follow the commit naming conventions:
- Adding a new package: `Add package: <package-name>`
- Adding a package version: `Add version: <package-name> <version>`
- Adding support for a new target: `Add target: <package-name> <target>`
- Fixing a broken package: `Fix package: <package-name> <version>`
- Another change? Please ensure your commit message describes the changes correctly
<br><br>
You can add, commit and push by running the command below:
```
git add packages/<package-name>
git commit -m <message>
git push origin <branch-name>
```

6. **Open a pull request** <br>
Now all your changes are on your own fork of the core repository, you can open a pull request to submit your changes to the official Packit core repository.
<br><br>
To create a pull request you need to go to the official repository (https://github.com/pack-it/core), at the top a yellow banner is shown with the button `Compare & pull request`. Click on this button and ensure the `base` branch is set to `main` and the `compare` branch is set to the branch you created.
<br><br>
Ensure the titles describes clearly what changes you made, ideally this matches with the [commit naming conventions](#commit-naming). Add a good description, including all details of your changes.
<br><br>
After you have done all steps above, click on the `Create pull request` button. Your pull request is now created and one of the Packit maintainers will review it as soon as possible.

## Adding a new package

Before adding a new package, please first look through the open pull requests to prevent adding something that is already in progress.

To add a package, you first need to create the directory with the name of the package in the `packages` folder. Inside this folder you need to create several files:
- `package.toml`: Contains global information about the package
- `build.sh` or `build.bat` (or both): Script which builds the package. You can also define version specific or even target specific scripts, see the README for more information.

You also need to add a new directory inside this directory, which has the version of the package as name. Inside you need to add a `targets.toml` file, this file contains the information about the specific package version and the behaviour for each target.

A simple example of these files can be found in the [`htop`](https://github.com/pack-it/core/tree/main/packages/htop) package.
See the README for an explanation of all possible fields in these files.

After you added the package, push it to your fork and create a pull request, see [Getting started](#getting-started).

## Adding a new version to a package

Before adding a new version to a package, please first look through the open pull requests to prevent adding something that is already in progress.

To add a new version to an existing package, first go to the directory of the package. Inside create a new directory which has the version you're adding as name. Inside this directory you need to create a `targets.toml` file, this file contains the information about the specific package version and the behaviour for each target.

Most of the times, you can copy the `targets.toml` file from another version and only change the source. Please make sure the other metadata did not change between versions.
<br>
If the package uses version specific scripts, you also need a new script for the new version, otherwise check thoroughly if the already existing global build script is still valid for the new version.

You then also need to update the `package.toml` file to correctly register the new version of the package and update the supported versions for the targets.

After you added the version, push it to your fork and create a pull request, see [Getting started](#getting-started).

## Adding support for a new target to a package

Before adding support for a new target to a package, please first look through the open pull requests to prevent adding something that is already in progress.

To add a new target to an existing package, you need to adjust the `targets.toml` file for the version you're adding the target to, and change the `package.toml` file to correctly register that the package supports the target for the package version. 

Most of the times, the source is the same for all targets, but sometimes you need to add a new source. The currently existing source then needs to be named, and you will need to define which source to use for each target, see the README for more information on this.

Also make sure the scripts are compatible between the different targets, if this is not the case, you can define to use a different script for a specific target. Please see the README for more information, or take a look at [`libtool`](https://github.com/pack-it/core/tree/main/packages/libtool) for an example.

After you added the target, push it to your fork and create a pull request, see [Getting started](#getting-started).
