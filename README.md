# Cloudflare R2 Cache Purge Utility

This repository provides a utility and a GitHub Actions workflow to upload assets to Cloudflare R2 and automatically purge the Cloudflare cache for the uploaded assets. It ensures that users always receive the latest version of your files without waiting for the cache to expire naturally.

## Features

- **Uploads to R2:** Uses the AWS CLI to upload files directly to a Cloudflare R2 bucket.
- **Cache Purging:** Automatically calls the Cloudflare API to purge the exact URL of the uploaded file.
- **Verification:** Polls the URL after purging to ensure the cache has been cleared and it returns a 200 HTTP status code.

## GitHub Actions Workflow

The included GitHub Actions workflow (`.github/workflows/deploy.yml`) runs on pushes to the `main` branch. 

### Required GitHub Secrets

To use this workflow, you need to configure the following secrets in your GitHub repository:

#### Cloudflare R2 Secrets
- `R2_ACCESS_KEY_ID`: Your R2 API Access Key ID.
- `R2_SECRET_ACCESS_KEY`: Your R2 API Secret Access Key.
- `R2_ACCOUNT_ID`: Your Cloudflare Account ID.
- `R2_BUCKET_NAME`: The name of your R2 bucket.

#### Cloudflare Cache Purge Secrets
- `CF_API_TOKEN`: A Cloudflare API token with `Zone.Cache Purge` permissions.
- `CF_ZONE_ID`: The Zone ID of the domain associated with the cache.
- `CF_SCRIPT_URL`: The full URL of the uploaded asset to be purged (e.g., `https://example.com/xyz.js`).

## Usage

1. Add your files to the repository (e.g., by default, `xyz.js`).
2. Update the `deploy.yml` workflow to match the files you want to upload and purge if they differ from the default script.
3. Push to the `main` branch to trigger the deployment and cache purge.