#!/bin/bash

# Fungsi untuk mengecek dan install ulang jika versi tidak sesuai
check_and_force_install() {
    PACKAGE=$1
    DESIRED_VERSION=$2

    echo "🔍 Mengecek versi $PACKAGE..."

    # Ambil versi yang terinstall (jika ada)
    INSTALLED_VERSION=$(btpip list | grep "^$PACKAGE " | awk '{print $2}')

    if [ -z "$INSTALLED_VERSION" ]; then
        echo "❌ $PACKAGE belum terpasang."
        INSTALL=true
    elif [ "$INSTALLED_VERSION" != "$DESIRED_VERSION" ]; then
        echo "⚠️  Versi $PACKAGE saat ini adalah $INSTALLED_VERSION, berbeda dari yang diminta ($DESIRED_VERSION)."
        INSTALL=true
    else
        echo "✅ $PACKAGE versi $DESIRED_VERSION sudah terpasang."
        INSTALL=false
    fi

    if [ "$INSTALL" = true ]; then
        echo "📦 Menginstall ulang $PACKAGE==$DESIRED_VERSION..."
        btpip install "$PACKAGE==$DESIRED_VERSION" --force-reinstall
        if [ $? -eq 0 ]; then
            echo "✅ Berhasil install $PACKAGE==$DESIRED_VERSION"
        else
            echo "❌ Gagal install $PACKAGE==$DESIRED_VERSION"
        fi
    fi
}

# Daftar paket dan versinya
check_and_force_install "boto3" "1.35.99"
check_and_force_install "botocore" "1.35.99"
check_and_force_install "s3transfer" "0.10.0"
