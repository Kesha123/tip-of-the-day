# Tip of the Day

A script that displays a different 'Tip of the Day' every time you enter the terminal on your own Linux host or establish an SSH connection with a remote Linux host. You can navigate forward and backward to read more tips. User can disable this feature as they wish.

## Instalation

### Clone git repository
```
git clone ssh://git@gitlab.tamk.cloud:1022/server-tech-2023-a-innokentii-kozlov/tip-of-the-day.git
```

```
cd tip-of-the-day
```

### Command line tool
```
chmod u+x linuxtips.sh
```

### Configure tips and configuration file
```
mkdir /etc/tip-of-the-day
cp config.sh /etc/tip-of-the-day
cp -r tips/ /var/
```

## Set necessary permissions
```
chmod -R 777 /etc/tip-of-the-day
```

### Configure script
```
chmod +x show-tip.sh
cp show-tip.sh /etc/profile.d/
source /etc/profile
```
