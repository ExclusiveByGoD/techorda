#bin/bash!

# Assylzhan Sailaubek
# asylzhan339346@gmail.com
# telegram: @nobilisanima

# Task 1
echo -e "\n###########################################################################"
mkdir -p task1/MyDirectory
touch task1/MyDirectory/Myfile.txt
echo -e "Task 1. List files in MyDirectory: \n"
ls -l task1/MyDirectory/


# Task 2
echo -e "\n###########################################################################"
echo -e "Task 2. Copied files list: \n"
mkdir -p task2/folder{1,2}
source_dir="task2/folder1"
touch "$source_dir"/file1.txt "$source_dir"/file2.pdf "$source_dir"/file3.doc "$source_dir"/file4.jpg "$source_dir"/file5.txt "$source_dir"/file6.sh "$source_dir"/file7.py "$source_dir"/file8.txt "$source_dir"/file9.pdf
target_dir="task2/folder2"
touch "$target_dir"/file0.txt "$target_dir"/file10.doc
cp -v "$source_dir"/*.txt "$target_dir"


# Task 3
echo -e "\n###########################################################################"
echo -e "Task 3. Find files with keyword 'client' in /etc/dhcp: \n"
keyword="client"
find /etc/dhcp -type f -name "*$keyword*"


# Task 4
echo -e "\n###########################################################################"
echo -e "Task 4. Pack and Unpack archive: \n"
mkdir -p task4/dir1
echo "content1" >> task4/file1.txt
echo "content2" >> task4/dir1/file2.txt
archive_file=task4/archive.tar
to_archive="task4/file1.txt task4/dir1"

# Pack
tar -cf "$archive_file" $to_archive
if [ -f "$archive_file" ]; then
    echo "Archive file $archive_file successfully created."
else
    echo "Error when create archive file"
fi

# Delete orig files
rm -rf $to_archive

# Unpack
tar -xf "$archive_file"

# Unpacking check
if [ -f "task4/file1.txt" ] && [ -f "task4/dir1/file2.txt" ]; then
    echo "Files have been successfully unpacked."
    echo -n "cat file1.txt:  " && cat task4/file1.txt
    echo -n "cat dir1/file2.txt:  " && cat task4/dir1/file2.txt
else
    echo "Unpacking failed."
fi


# Task 5
echo -e "\n###########################################################################"
echo -e "Task 5. Processing a text file:"
mkdir -p task5
echo -e "FirstLine\nSecondLine\nThirdLine" > task5/File.txt
cat task5/File.txt | rev


# Task 6
echo -e "\n###########################################################################"
echo -e "Task 6. Backup Automation:"
mkdir -p task6/dir1 task6/dir2 task6/backup_dir
DIRECTORIES="task6/dir1 task6/dir2"
BACKUP_DIR="task6/backup_dir"
CRON_JOB="0 2 * * 0 tar -czf $BACKUP_DIR/backup_\$(date +\%Y-\%m-\%d).tar.gz $DIRECTORIES"
(crontab -l | grep -F "$CRON_JOB") || (crontab -l ; echo "$CRON_JOB") | crontab -
echo "Cron job added: $CRON_JOB"


# Task 7
echo -e "\n###########################################################################"
echo -e "Task 7. Word count:"
mkdir -p task7
echo "content of file task7/words.txt:"
echo "There are different kinds of animals on our planet, and all of them are very important for it. For example, everyone knows that the sharks are dangerous for people, but they are useful for cleaning seawater." > task7/words.txt
echo "There are two types of animals: domestic (or pets) and wild. People keep pets in their homes. And some wild animals are very dangerous." >> task7/words.txt
echo "Domestic animals live next to people, whereas wild animals are forests, jungles, oceans and so on."  >> task7/words.txt
cat task7/words.txt
echo "The file task7/words.txt contains $(wc -w < task7/words.txt) words."


# Task 8
echo -e "\n###########################################################################"
echo -e "Task 8. Generate Password:"
mkdir -p task8
LENGTH=14

LOWERCASE="abcdefghijklmnopqrstuvwxyz"
UPPERCASE="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
NUMBERS="0123456789"
SPECIAL="!@#$%^&*()_+"
ALL_CHARACTERS="$LOWERCASE$UPPERCASE$NUMBERS$SPECIAL"

PASSWORD=$(< /dev/urandom tr -dc "$LOWERCASE" | head -c 1)
PASSWORD+=$(< /dev/urandom tr -dc "$UPPERCASE" | head -c 1)
PASSWORD+=$(< /dev/urandom tr -dc "$NUMBERS" | head -c 1)
PASSWORD+=$(< /dev/urandom tr -dc "$SPECIAL" | head -c 1)

REMAINING_LENGTH=$((LENGTH - 4))
PASSWORD+=$(< /dev/urandom tr -dc "$ALL_CHARACTERS" | head -c "$REMAINING_LENGTH")
PASSWORD=$(echo "$PASSWORD" | fold -w1 | shuf | tr -d '\n')

echo "$PASSWORD" > task8/pass.txt
echo -n "cat pass.txt:  " && cat task8/pass.txt


# Task 9
echo -e "\n###########################################################################"
echo -e "Task 9. File counting:"
mkdir -p task9/dir{1..7}
touch task9/file{1..13}
mkdir -p task9/dir4/dir{8..10}
touch task9/dir{3..5}/file{1..5}
touch task9/dir4/dir9/file{1..15}

file_count=0
dir_count=0

for item in $(find task9/ -type f -o -type d); do
  if [ -f "$item" ]; then
    file_count=$((file_count + 1))
  elif [ -d "$item" ]; then
    dir_count=$((dir_count + 1))
  fi
done

echo "Number of files: $file_count"
echo "Number of directories: $((dir_count - 1))"


echo -e "\n###########################################################################"
rm -rf task*
echo "Deleted all task Files"


# Task 10
echo -e "\n###########################################################################"
echo -e "Task 10. Automation of the system update task:"

if [ -f /etc/os-release ]; then
    . /etc/os-release
else
    echo "The os-release file was not found. Cannot detect system."
    exit 1
fi

case $ID in
    debian|ubuntu|linuxmint)
        sudo apt update 2>/dev/null
        echo "Upgradeable packages:"
        apt list --upgradable
        echo "Checking for updates is complete. Install them? (y/n)"
        read answer
        if [ "$answer" = "y" ]; then
                sudo apt upgrade -y
        fi
        ;;
    fedora)
        if [[ $VERSION_ID -ge 22 ]]; then
            sudo dnf check-update
            echo "Do you want to apply updates? (y/n)"
            read answer
            if [ "$answer" = "y" ]; then
                sudo dnf upgrade -y
            fi
        else
            sudo yum check-update
            echo "Do you want to apply updates? (y/n)"
            read answer
            if [ "$answer" = "y" ]; then
                sudo yum upgrade -y
            fi
        fi
        ;;
    centos)
        if [[ $VERSION_ID -ge 8 ]]; then
            sudo dnf check-update
            echo "Do you want to apply updates? (y/n)"
            read answer
            if [ "$answer" = "y" ]; then
                sudo dnf upgrade -y
            fi
        else
            sudo yum check-update
            echo "Do you want to apply updates? (y/n)"
            read answer
            if [ "$answer" = "y" ]; then
                sudo yum upgrade -y
            fi
        fi
        ;;
    opensuse*|suse|sles)
        sudo zypper verify
        sudo zypper list-updates --all
        echo "Do you want to apply updates? (y/n)"
        read answer
        if [ "$answer" = "y" ]; then
            sudo zypper up
        fi
        ;;
    arch|manjaro)
        sudo pacman -Sy 2>/dev/null
        echo "Available upgrades:"
        pacman -Qu
        echo "Do you want to apply these updates? (y/n)"
        read answer
        if [ "$answer" = "y" ]; then
            sudo pacman -Syu
        fi
        ;;
    *)
        echo "Unsupported or unidentified distribution."
        exit 1
        ;;
esac
