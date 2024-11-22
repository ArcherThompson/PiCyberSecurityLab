import sqlite3
import os

def parse_markup(file_path):
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"Markup file '{file_path}' not found.")
    with open(file_path, 'r') as f:
        markup = f.read()
    sections = {}
    current_section = None
    for line in markup.splitlines():
        line = line.strip()
        if line.startswith('[') and line.endswith(']'):
            current_section = line[1:-1]
            sections[current_section] = []
        elif current_section and line:  # Only add non-empty lines
            sections[current_section].append(line)
    return sections

def insert_data_to_db(db_path, data):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # Create tables if not exist
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS story (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            hint TEXT
        )
    """)
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS locations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT
        )
    """)
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS objects (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT
        )
    """)
    
    # Insert story
    story = data.get('story', [])
    if story:
        title = story[0].split(': ', 1)[1] if len(story) > 0 else "Unknown Title"
        description = story[1].split(': ', 1)[1] if len(story) > 1 else "No Description"
        hint = story[2].split(': ', 1)[1] if len(story) > 2 else "No Hint"
        cursor.execute("INSERT INTO story (title, description, hint) VALUES (?, ?, ?)", (title, description, hint))
    
    # Insert locations
    for location in data.get('locations', []):
        try:
            key, value = location.split(': ', 1)
            name, desc = value.split('|', 1)
            cursor.execute("INSERT INTO locations (name, description) VALUES (?, ?)", (name.strip(), desc.strip()))
        except ValueError:
            print(f"Skipping malformed location: {location}")
    
    # Insert objects
    for obj in data.get('objects', []):
        try:
            key, value = obj.split(': ', 1)
            name, desc = value.split('|', 1)
            cursor.execute("INSERT INTO objects (name, description) VALUES (?, ?)", (name.strip(), desc.strip()))
        except ValueError:
            print(f"Skipping malformed object: {obj}")
    
    # Insert secrets (if applicable)
    for secret in data.get('secrets', []):
        try:
            key, value = secret.split(': ', 1)
            name, desc = value.split('|', 1)
            cursor.execute("INSERT INTO objects (name, description) VALUES (?, ?)", (name.strip(), desc.strip()))
        except ValueError:
            print(f"Skipping malformed secret: {secret}")
    
    conn.commit()
    conn.close()

if __name__ == "__main__":
    markup_file = "/var/www/html/story_data/story.markup"
    db_path = "/var/www/html/story_data/story.db"
    print("Processing markup file...")
    data = parse_markup(markup_file)
    insert_data_to_db(db_path, data)
    print("Data successfully added to the database!")
