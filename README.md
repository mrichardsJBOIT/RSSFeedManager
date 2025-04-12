# RSS Feed Manager with Madmin

A simple Rails application to manage RSS feeds using the Madmin admin interface gem.

## Features

- Add, edit, and delete RSS feeds
- Fetch and store entries from RSS feeds
- View all entries in a clean admin interface
- Sort and filter entries

## Requirements

- Ruby 3.2.2+
- Rails 8.0.2+
- SQLite 2.1+

## Setup

1. Clone the repository
2. Install dependencies:

```
bundle install
```

3. Set up the database:

```
rails db:create db:migrate
```

4. Start the Rails server:

```
rails server
```

5. Visit [http://localhost:3000](http://localhost:3000) in your browser

## Usage

1. Add a new RSS feed by clicking "New Feed" in the admin interface
2. Enter the feed URL and name
3. View the feed and click "Fetch Entries" to download the latest entries
4. Browse entries in the "Entries" section

## Technologies Used

- Rails 8.0.2
- Madmin 2.0.1
- Feedjira (RSS/Atom feed parser)
- SQLite
- Tailwind CSS
