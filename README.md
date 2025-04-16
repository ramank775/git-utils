# git-utils

A collection of useful Git utilities to streamline your workflow. This repo contains scripts for tasks like cleaning up merged branches, viewing branch-specific changes, and more.

## Features

- **`git purge-branch`**: Automatically purges local branches that have been deleted from the remote.
- **`git changes`**: Shows commits in your current branch that aren't in the base branch.
- **More tools coming soon**: Feel free to contribute new utilities for your Git workflow!

## Installation

To install and use these Git utilities, follow these steps:

1. **Run the installer script**:

   ```bash
   curl -sSL https://raw.githubusercontent.com/ramank775/git-utils/main/install-git-utils.sh | bash
   ```

   This will:
   - Install the utilities in `$HOME/.local/bin/`.
   - Add Git aliases for each utility (e.g., `git purge-branch`, `git changes`).
   - Check if `$HOME/.local/bin` is in your `PATH`. If not, it will notify you to add it.

2. **Optional**: If `$HOME/.local/bin` does not exist, the script will prompt you to create it.

3. **Run a utility**: After installation, you can use any of the utilities. For example:

   ```bash
   git purge-branch
   git changes
   ```

## Utilities

### `git purge-branch`

This utility helps you purge local branches that have already been deleted from the remote.

#### Usage

```bash
git purge-branch
```

This will:
- Fetch the latest changes from your remote repository.
- Identify local branches that no longer exist on the remote.
- Delete those branches if they are fully merged into your current base.

### `git changes`

This utility shows commits in your current branch that aren't in the base branch (e.g., `main`, `master`, or any branch you specify).

#### Usage

```bash
git changes                   # Compare with default remote HEAD
git changes --all            # Show commits from all authors
git changes develop          # Compare with a custom base branch
git changes develop --all    # Custom base + all authors
```

#### What it does:

- Automatically detects the base branch (`origin/HEAD`) and falls back to `main` if needed.
- Compares commits from base to your current branch.
- By default, filters by your Git user email. Use `--all` to show commits from everyone.

## Add More Utilities

If you want to add more utilities to this toolkit, you can:
1. Create a new script in the `scripts/` directory.
2. Add it to the `SCRIPTS` array in the `install-git-utils.sh` installer script.
3. Submit a pull request or simply use it locally!

## License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to contribute new utilities, fixes, or enhancements. Follow these steps to contribute:

1. Fork the repo.
2. Clone your fork:
   ```bash
   git clone https://github.com/{YOUR_USERNAME}/git-utils.git
   ```
3. Create a new branch for your changes.
4. Make your changes and commit them.
5. Push your changes to your fork.
6. Create a pull request.

## Acknowledgments

- Inspired by many open-source Git utilities.
