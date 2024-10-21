# Infrastructure

[![Build Status](https://github.com/ngoc-quoc-huynh/tft_guide/actions/workflows/infrastructure.yaml/badge.svg?branch=main)](https://github.com/ngoc-quoc-huynh/tft_guide/actions/workflows/infrastructure.yaml?query=branch%3Amain)
[![license](https://img.shields.io/github/license/ngoc-quoc-huynh/tft_guide)](https://raw.githubusercontent.com/ngoc-quoc-huynh/tft_guide/refs/heads/main/LICENSE)

This repository utilizes supabase as the backend database.
The project involdes managing data for assets, base items, full items, patch notes and their corresponding translations.
It is designed to enable seamless storage, retrieval, and translation of data across different languages.

## Getting Started

### Prerequisites

Before you can get started with the project, make sure the following dependencies are installed on your system:

- [Docker](https://docs.docker.com/engine/install/) for local development.
- [Supabase CLI](https://supabase.com/docs/guides/cli/getting-started) to manage the database.

### Project Setup

Follow these steps to set up the project with supabase and GitHub:

1. Create a new supabase project:
    - Go to the [supabase dashboard](https://supabase.com/dashboard/projects) and create a new project.
    - During setup, define a **database password**. You will need this password later for configuration.
2. Add the database password to GitHub secrets:
    - In your GitHub repository, navigate to **Settings > Secrets and variables > Actions > Secrets**.
    - Click **New repository secret** and add your supabase database password.
    - Use **SUPABASE_DB_PASSWORD** as the key name.
3. Add supabase Project ID to GitHub Variables:
    - In the same **Settings > Secrets and variables** section, go to Variables.
    - Click **New repository** variable and add your supabase project id.
    - Use **SUPABASE_PROJECT_ID** as the key name.
4. Create an access token:
    - Generate a new access token from your [supabase account settings](https://supabase.com/dashboard/account/tokens).
    - Go back to GitHub Secrets, create a new secret, and add the token.
    - Use **SUPABASE_ACCESS_TOKEN** as the key name.

By completing these steps, your supabase project will be securely connected with your GitHub repository, enabling
smooth deployment and CI/CD workflows.

### Local Development

To set up and run the supabase server locally for development, follow these steps:

1. Log in to Supabase:
   ```bash
   supabase login
   ```
2. Link the local project to your remote supabase project:
   ```bash
   supabase link --project-ref <project-ref>
   ```

3. Start the supabase server locally:
   ```bash
   supabase start
   ```

4. Access supabase locally:
   ```bash
   http://localhost:54323/project/default
   ````

5. Stop the supabase server:
   ```bash
   supabase stop
   ```

For detailed guidance on local development with supabase, visit the official
documentation: [Local Development](https://supabase.com/docs/guides/cli/local-development).

### Database Migrations

To manage changes to your database schema, you can use supabase migrations. Follow these steps to create, apply, and
push migrations.

1. Create a new migration:
   ```bash
   supabase migration new <migration-name>
   ```
   This will generate a new migration file in the migrations folder.

2. Apply the migration to the local database:
   ```bash
   supabase migration up
   supabase db reset
   ```
    - `supabase migration up`: Applies the migration to the local database.
    - `supabase db reset`: Resets the local database, applying all migrations from scratch.

3. Apply the migration to the remote database:
   ```bash
   supabase db push
   ```
   This will deploy the migration to your production environment, ensuring your remote database stays in sync with your
   local schema changes.

### Database structure

The project uses supabase’s PostgreSQL database to manage the game’s data. The database consists of several key tables,
which are categorized into core data tables, translation tables, and asset storage.

#### Main tables

- base_item
- full_item
- patch_note

#### Translation tables

- base_item_translation
- full_item_translation
- patch_note_translation

#### Asset Management

In addition to the database tables, the project also requires managing assets associated with base and full items.
These assets are stored in supabase's storage feature.

To manage assets, follow these steps:

1. Create an Assets Bucket:
    - Go to the supabase dashboard and navigate to the Storage section.
    - Create a new bucket called **assets*. This bucket will be used to store images related to your items.
2. Upload Assets:
    - Upload the assets from [base items](../design/assets/base_items) directory to the assets bucket you just created.
    - Upload the assets from [full items](../design/assets/full_items) directory to the assets bucket you just created.

#### Querying the Database with Language Support

To query data from the database and retrieve localized content based on a specific language (e.g., English), you can use
the following SQL query:

 ```sql
SELECT b.id, t.name, t.description
FROM base_item AS b
LEFT JOIN base_item_translation AS t
ON b.id = t.id
WHERE t.language_code = 'en';
 ```
