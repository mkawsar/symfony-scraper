// scraper.js
const puppeteer = require('puppeteer');
const axios = require('axios');

(async () => {
    const url = process.argv[2];

    const browser = await puppeteer.launch({
        headless: 'new',
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
        ],
        executablePath: '/usr/bin/chromium'
    });
    const page = await browser.newPage();

    // Navigate to a web page
    await page.goto(url);

    // Perform any interactions with the page (e.g., fill out forms)

    // After interacting with the page, prepare the data for your POST request
    const postData = {
        code: '110721512',
        order: '1',
        resetFilter: 0
    };

    // Send a POST request using Axios
    try {
        const response = await axios.post(url, postData);
        console.log(response.data);
    } catch (error) {
        console.error(error);
    }

    // Close the Puppeteer browser when done
    await browser.close();
})();
