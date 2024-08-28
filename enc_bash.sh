#!/bin/bash

function show_menu {
    sleep 1.5
    echo "
    1. Encrypt
    2. Decrypt
    3. support admin
    0. Keluar
    "
}

function print_text_one_by_one {
    local text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.1  # jeda 0.1 detik antar karakter
    done
    echo
}

function encrypt_file {
    local input_file="$1"
    local output_file="$2"

    if [[ -f "$input_file" ]]; then
        echo "Encrypt by: REN9999"
        echo "Udah, script nya jangan di edit nanti error"
        echo "#!/bin/bash" > "$output_file"
        echo "eval \"\$(base64 -d <<EOF" >> "$output_file"
        base64 "$input_file" >> "$output_file"
        echo "EOF" >> "$output_file"
        echo ")\"" >> "$output_file"
       print_text_one_by_one  "File terenkripsi disimpan di: $output_file"
    else
        echo "File tidak ditemukan: $input_file"
    fi
}

function decrypt_file {
    local encrypted_file="$1"
    local output_file="$2"
    
    if [[ -f "$encrypted_file" ]]; then
        sed -n '/^eval "\$(base64 -d <<EOF$/,/^EOF$/p' "$encrypted_file" | \
        sed '1d;$d' | base64 -d > "$output_file"

        print_text_one_by_one "File berhasil didekripsi dan disimpan di: $output_file"
    else
        echo "File tidak ditemukan: $encrypted_file"
    fi
}

function open_website {
    termux-open-url https://saweria.co/Rensawer
}

while true; do
    show_menu
    read -p "Pilih opsi: " choice
    case $choice in
        1) 
            read -p "Masukkan input (misalnya /sdcard/script.sh): " input_file
            read -p "Masukkan output (misalnya /sdcard/enc_script.sh): " output_file
            encrypt_file "$input_file" "$output_file"
            ;;
        2) 
            read -p "Masukkan input file (misalnya /sdcard/encrypted_script.sh): " encrypted_file
            read -p "Masukkan output file (misalnya /sdcard/decrypted_script.sh): " output_file
            decrypt_file "$encrypted_file" "$output_file"
            ;;
        3)
            open_website
            ;;
        0) 
            print_text_one_by_one "Selamat tinggal 👋"
            sleep 1
            break
            ;;
        *) 
            echo "Pilih yang bener!"
            sleep 1
            ;;
    esac
done
