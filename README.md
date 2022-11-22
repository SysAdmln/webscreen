A Docker container that receives a screenshot of an entire web page. Based on Chrome 107.0.5304.62

How To Use
=========
```bash
docker run --rm -v `pwd`:/tmp/screenshot sysadmln/webscreen <URL> <output_image.png> [options]
docker run --rm -v `pwd`:/tmp/screenshot sysadmln/webscreen "https://dmin.pro/" dmin.png
```
or
```bash
./capture <URL> <output_image.png> [options]
./capture https://dmin.pro dmin.png
```

HELP
=========
```bash
docker run --rm -v $(pwd):/tmp/screenshot sysadmln/webscreen
usage: screenshot.py [-h] [-w WINDOW_SIZE] [--ua USER_AGENT] [--wait WAIT]
                     [-v] [--vv]
                     url filename

positional arguments:
  url              specify URL
  filename         specify capture image filename

optional arguments:
  -h, --help       show this help message and exit
  -w WINDOW_SIZE   specify window size like 1200x800
  --ua USER_AGENT  specify user-agent
  --wait WAIT      specify wait seconds after scroll
  -v               set LogLevel to INFO
  --vv             set LogLevel to DEBUG
```

