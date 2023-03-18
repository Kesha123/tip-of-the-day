# Tip of the Day

Script that displays a different "Tip of the day" every time when entering the terminal of your own Linux host or taking a SSH connection to your personal Linux host.

## Instalation

### Clone git repository
```
git clone ssh://git@gitlab.tamk.cloud:1022/server-tech-2023-a-innokentii-kozlov/tip-of-the-day.git
cd tip-of-the-day
```

### Command line tool
```
chmod u+x linuxtips.sh
```

### Configure tips and configuration file
```
mkdir /etc/linuxtips
cp -r tips/ /var/tips/
```

### Configure script
```
chmod +x show-tip.sh
cp show-tip.sh /etc/profile.d/
source /etc/profile
```
