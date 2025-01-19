When you're working on your first project, don't go out of your way to set up your own architecture. This package will help you improve your setup architecture. If you have any architecture-related PRs, submit them to this GitHub repository.


[![codecov](https://codecov.io/github/anwar907/init_architecture/graph/badge.svg?token=C5AJQDOA15)](https://codecov.io/github/anwar907/init_architecture)

## Example

```md
my-project/
├── lib/
│ ├── app/
│ │ ├── data/
│ │ ├── modules/
│ │ ├── repository/
│ ├── core/
│ ├── utils/
│ ├── themes/
├── packages/
│ │ ├── app_repository
├── tests/
├── .gitignore
├── LICENSE
├── README.md
```

## Command usage


- hit `dart pub global activate init_architecture` in your commandline
- setup path environment in your local machine
- `init --init app` generate file, directory, and package repository
- `init --packages app` only generate package repository

for the first setup project use --init to get all structure and use --packages to create package repository for some feature

## Maintenance
The main target of this package to generate architecture base on state management want to use e.g bloc, getx, provider etc. when start new project from scratch this package will help you to organize the project