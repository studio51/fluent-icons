# Automated Icon Updates

This repository uses GitHub Actions to automatically update icons from Microsoft's FluentUI System Icons repository daily.

## How It Works

The workflow runs daily at 2 AM UTC and:

1. ✅ Checks the latest FluentUI System Icons version
2. ✅ Compares with the current gem version
3. ✅ Downloads and processes new icons if available
4. ✅ Updates the gem version based on FluentUI version
5. ✅ Commits changes and creates a git tag
6. ✅ Builds and publishes the gem to RubyGems
7. ✅ Creates a GitHub release with changelog

## Setup Instructions

### 1. RubyGems API Key

To publish gems automatically, you need to add your RubyGems API key as a GitHub secret.

#### Get your RubyGems API key:

1. Go to [RubyGems.org](https://rubygems.org)
2. Sign in to your account
3. Go to [Edit Profile](https://rubygems.org/profile/edit)
4. Click on "API Keys" tab
5. Create a new API key with `push` permission
6. Copy the API key (you won't be able to see it again!)

#### Add the secret to GitHub:

1. Go to your GitHub repository
2. Click on **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `RUBYGEMS_API_KEY`
5. Value: Paste your RubyGems API key
6. Click **Add secret**

### 2. GitHub Token

The workflow uses the automatically provided `GITHUB_TOKEN` for creating releases. No additional setup needed!

### 3. Enable GitHub Actions

Make sure GitHub Actions are enabled for your repository:

1. Go to **Settings** → **Actions** → **General**
2. Under "Actions permissions", select **Allow all actions and reusable workflows**
3. Under "Workflow permissions", select **Read and write permissions**
4. Click **Save**

## Workflow File

The workflow is defined in `.github/workflows/auto-update-icons.yml`

## Manual Trigger

You can manually trigger the workflow:

1. Go to **Actions** tab in your repository
2. Select **Auto Update Icons** workflow
3. Click **Run workflow** button
4. Select the branch (usually `main`)
5. Click **Run workflow**

## Version Scheme

The gem uses a version scheme based on FluentUI's version:

```
FluentUI Version: 1.1.324
Gem Version:      2.0.0.324
                  ↑ ↑ ↑ ↑
                  │ │ │ └─ FluentUI patch number
                  │ │ └─── Gem patch version
                  │ └───── Gem minor version
                  └─────── Gem major version
```

Example:
- **FluentUI v1.1.324** → **Gem v2.0.0.324**
- **FluentUI v1.1.325** → **Gem v2.0.0.325**

## What Gets Updated

When a new version is detected, the workflow:

### Files Modified:
- `lib/fluent-icons/version.rb` - Version numbers
- `lib/build/data.json` - Icon data
- `lib/build/svg/*.svg` - SVG source files (excluded from gem)

### Git Activity:
- Creates commit with message format: `chore: update to FluentUI Icons vX.X.X`
- Creates git tag: `vX.X.X`
- Pushes to `main` branch

### RubyGems:
- Builds gem: `fluent-icons-X.X.X.gem`
- Publishes to RubyGems.org

### GitHub:
- Creates release with changelog
- Includes icon count and version info

## Monitoring

### Check Workflow Status

1. Go to **Actions** tab
2. Look for **Auto Update Icons** workflow runs
3. Green checkmark ✅ = Success
4. Red X ❌ = Failed (check logs)

### Workflow Logs

Click on any workflow run to see detailed logs for each step.

### Email Notifications

GitHub sends email notifications if the workflow fails. Configure in your GitHub notification settings.

## Troubleshooting

### Workflow Fails at "Publish to RubyGems"

**Possible causes:**
- Invalid or expired RubyGems API key
- API key doesn't have `push` permission
- Network issues with RubyGems

**Solution:**
1. Regenerate RubyGems API key
2. Update `RUBYGEMS_API_KEY` secret in GitHub
3. Re-run the workflow

### Workflow Fails at "Push changes and tags"

**Possible causes:**
- Insufficient GitHub permissions
- Branch protection rules blocking push

**Solution:**
1. Check GitHub Actions permissions (Settings → Actions → General)
2. Make sure "Read and write permissions" is selected
3. Check branch protection rules don't block Actions

### No New Icons Found

This is normal! The workflow checks daily but only publishes if there's a new FluentUI version.

### Duplicate Version Published

**Prevention:**
- The workflow checks current version before updating
- Only publishes if version changed

**If it happens:**
- RubyGems prevents duplicate versions
- Workflow will fail at publish step
- Manual intervention needed to fix version

## Disabling Automation

To disable automatic updates:

### Temporary:
1. Go to **Actions** tab
2. Select **Auto Update Icons** workflow
3. Click **Disable workflow**

### Permanent:
Delete or rename the workflow file:
```bash
git rm .github/workflows/auto-update-icons.yml
```

## Testing Locally

You can test the update process locally:

```bash
# Run the update script
bundle exec ruby bin/update

# Check what changed
git status
git diff

# Manually update version if needed
vi lib/fluent-icons/version.rb

# Build gem locally
gem build fluent-icons.gemspec
```

## Security Notes

- ✅ RubyGems API key is stored as encrypted GitHub secret
- ✅ Workflow only runs on `main` branch
- ✅ Requires write permissions (configured in workflow)
- ✅ All changes are committed with bot identity
- ⚠️ Protect your `main` branch with required reviews for manual commits

## Support

If you encounter issues with the automation:

1. Check workflow logs in Actions tab
2. Verify secrets are configured correctly
3. Check GitHub Actions permissions
4. Open an issue in the repository

---

🤖 **This automation ensures the gem stays up-to-date with Microsoft's latest icons!**
