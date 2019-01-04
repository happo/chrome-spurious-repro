# chrome-spurious-repro
An attempt at creating a repro case for the spurious image diffs we're seeing in Chrome on linux in Happo

## What we're seeing

We use Puppeteer to take screenshots in Chrome for Happo, a screenshot testing
service. We're seeing inconsistently produced screenshots for certain elements
with rounded corners.

![Overlay](overlay.png)

This is a diff we're seeing on a component that didn't change its html and css
output/usage.

Raw pngs, as produced by Chrome:
![Screenshot A](https://happo-io.s3-us-west-1.amazonaws.com/040faf86427608421781df58b9870f91)
![Screenshot B](https://happo-io.s3-us-west-1.amazonaws.com/453fd319bead7170bef3c930e1033766)

## More information

- This happens on Linux, I've tried both Debian and Centos, same issue
- I haven't been able to repro this in Mac OSX
- The `--disable-gpu` flag does not fix it
