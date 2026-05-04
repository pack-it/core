# Packit Core

The Packit core repository which contains build, install and test instructions for system-packages.

## License
The Packit core repository is licensed under the Apache License 2.0. See [LICENSE](LICENSE) for the full license.


## Repository Structure
In the section below, all files in the repository are briefly described. For a full explanation of all files and all available files, please see [the documentation](https://github.com/pack-it/packit/blob/main/docs/metadata.md).

### `repository.toml`
This file should be present in every Packit repository, it quickly describes what the repository is for.

### `index.toml`
This file should be present in every Packit repository, it describes which packages are available.

### `packages`
The packages directory contains the metadata of all packages which are supported by this repository.

### `package.toml`
Each package contains this file, it describes the package as whole. It shows the name, a short description, the homepage url, available versions and supported versions for each target.

### `targets.toml`
Each package version directory contains a `targets.toml` file. This file describes version specific information. This information can be the same for all targets (global) or target specific. In some cases the target specific information will override the global information in other cases it's additive, so global and target specific will be used together.

### Scripts
The scripts define the specific behaviour to install, uninstall or test a specific package. They can be defined globally for a package, per version or per target. On unix systems the script are written in `sh` and have the `.sh` extension. On Windows the scripts are written in `batch` and have the `.bat` extension.

The available scripts are currently `preinstall`, `build`, `postinstall`, `test`, `uninstall`.

Scripts are run in an environment with Packit defined variables, see [the documentation](https://github.com/pack-it/packit/blob/main/docs/metadata.md) for a complete list of environment variables.
