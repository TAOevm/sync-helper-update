## sync-helper-update
This package will update your existing TAOevmCore pkg to use "sync-helper-plugin" which is responsible for ensuring seamless connection between all the peers. Follow the bellow given commands in the given order to apply this update.


# Usage

First of stop the running validator node/s after you have logged in as root user
```bash
./node-stop.sh --validator
```

Then clone this repo into your server's /root/ path
```bash
cd /root/
git clone https://github.com/TAOevm/sync-helper-update.git
```
Then cd to this repo
```bash
cd ./sync-helper-update
```
Then execute the update script
```bash
./runme.sh
```

Now after few minutes, you'll see a message that says "UPDATE COMPLETE". You'll notice that you have been already shifted to the /root/TAOevmCore/ directory. From here you need to enter below commands to start your validator node/s again:

Source the bashrc
```bash
source ~/.bashrc
```
Then execute the start script
```bash
./node-start.sh --validator
```