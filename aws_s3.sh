#!/bin/bash

# Fungsi untuk mengecek dan menginstall paket jika belum ada
check_and_install() {
    PACKAGE=$1
    VERSION=$2

    echo "🔍 Mengecek $PACKAGE..."
    if btpip list | grep -q "$PACKAGE"; then
        echo "✅ $PACKAGE sudah terpasang."
    else
        echo "📦 Menginstall $PACKAGE==$VERSION..."
        btpip install "$PACKAGE==$VERSION"
        if [ $? -eq 0 ]; then
            echo "✅ Berhasil menginstall $PACKAGE==$VERSION"
        else
            echo "❌ Gagal menginstall $PACKAGE==$VERSION"
        fi
    fi
}

# Daftar paket dan versinya
check_and_install "boto3" "1.35.99"
check_and_install "botocore" "1.35.99"
check_and_install "s3transfer" "0.10.0"
