const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// Serve static files from the "public" directory
app.use(express.static('public'));

// Parse request bodies as JSON
app.use(bodyParser.json());

// Allow only marketing users Alice and Malory to add news
app.post('/add_news', (req, res) => {
	if (req.body.username === 'Alice' || req.body.username === 'Malory') {
		// Add news to the database
		res.send('News added successfully');
	} else {
		res.status(403).send('Forbidden');
	}
});

// Allow only Charlie from HR to update people
app.post('/update_people', (req, res) => {
	if (req.body.username === 'Charlie') {
		// Update people in the database
		res.send('People updated successfully');
	} else {
		res.status(403).send('Forbidden');
	}
});

// Start

