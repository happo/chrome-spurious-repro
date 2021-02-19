const puppeteer = require('puppeteer');
const crypto = require('crypto');
const fs = require('fs');

function createHash(data) {
  return crypto.createHash('md5').update(data).digest('hex');
}

async function takeScreenshot(page) {
  await page.setContent(fs.readFileSync('./airbnb.html', 'utf-8'));
  const main = await page.$('div');
  const pngBuf = await main.screenshot();
  const hash = createHash(pngBuf);
  fs.writeFileSync(`${hash}.png`, pngBuf);
  return hash;
}

async function run() {
  const browser = await puppeteer.launch({
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--hide-scrollbars'],
  });

  const page = await browser.newPage();
  const firstHash = await takeScreenshot(page);

  for (let i = 0; i < 2; i++) {
    const hash = await takeScreenshot(page);
    console.log(`${hash}.png`);
  }
  await browser.close();
}

run().then(() => {
  console.log(
    'Press a key to exit (or leave open while you copy screenshots to your local machine using `docker cp <container_id>:/usr/src/app/<file_name.png> .`)',
  );
  process.stdin.setRawMode(true);
  process.stdin.resume();
  process.stdin.on('data', process.exit.bind(process, 0));
});
