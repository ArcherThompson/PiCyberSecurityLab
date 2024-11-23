<?php
$dbPath = '/var/www/html/story_data/story.db';

// Hidden debug mode
if (isset($_GET['debug']) && $_GET['debug'] === 'showme') {
    echo "<h1>Debug Info</h1>";
    echo "<p>Database Path: $dbPath</p>";
    echo "<p>PHP Version: " . phpversion() . "</p>";
}

// Connect to the SQLite database
try {
    $db = new PDO("sqlite:$dbPath");
} catch (PDOException $e) {
    die("<h1>Error</h1><p>Database connection failed.</p>");
}

// Display a basic landing page
if (!isset($_GET['action'])) {
    include 'main.html';
    exit;
}

// Subtle SQL injection vulnerability (action=view&id=...)
if ($_GET['action'] === 'view' && isset($_GET['id'])) {
    $id = $_GET['id'];
    $query = "SELECT * FROM objects WHERE id = $id"; // No sanitization
    $result = $db->query($query);

    echo "<h1>Object Details</h1>";
    if ($result) {
        foreach ($result as $row) {
            echo "<p><strong>Name:</strong> " . htmlspecialchars($row['name']) . "</p>";
            echo "<p><strong>Description:</strong> " . htmlspecialchars($row['description']) . "</p>";
        }
    } else {
        echo "<p>No object found.</p>";
    }
}

// Hidden admin panel (accessed via action=admin&key=...)
if ($_GET['action'] === 'admin' && isset($_GET['key']) && $_GET['key'] === 'supersecret') {
    echo "<h1>Admin Panel</h1>";
    echo "<p>Welcome to the admin panel. Restricted access granted.</p>";
    echo "<ul>";
    $tables = $db->query("SELECT name FROM sqlite_master WHERE type='table'");
    foreach ($tables as $table) {
        echo "<li>Table: " . htmlspecialchars($table['name']) . "</li>";
    }
    echo "</ul>";
}
?>
