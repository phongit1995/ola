package com.facebook.accountkit.internal;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.net.HttpCookie;

/* JADX INFO: loaded from: classes.dex */
final class SerializableHttpCookie implements Serializable {
    private static final long serialVersionUID = 2064381394822046912L;
    private transient HttpCookie cookie;
    private Field fieldHttpOnly;

    private String byteArrayToHexString(byte[] bArr) {
        StringBuilder sb = new StringBuilder(bArr.length * 2);
        for (byte b : bArr) {
            int i = b & 255;
            if (i < 16) {
                sb.append('0');
            }
            sb.append(Integer.toHexString(i));
        }
        return sb.toString();
    }

    private boolean getHttpOnly() {
        try {
            initFieldHttpOnly();
            return ((Boolean) this.fieldHttpOnly.get(this.cookie)).booleanValue();
        } catch (IllegalAccessException | IllegalArgumentException | NoSuchFieldException unused) {
            return false;
        }
    }

    private byte[] hexStringToByteArray(String str) {
        int length = str.length();
        byte[] bArr = new byte[length / 2];
        for (int i = 0; i < length; i += 2) {
            bArr[i / 2] = (byte) ((Character.digit(str.charAt(i), 16) << 4) + Character.digit(str.charAt(i + 1), 16));
        }
        return bArr;
    }

    private void initFieldHttpOnly() {
        this.fieldHttpOnly = this.cookie.getClass().getDeclaredField("httpOnly");
        this.fieldHttpOnly.setAccessible(true);
    }

    private void readObject(ObjectInputStream objectInputStream) {
        this.cookie = new HttpCookie((String) objectInputStream.readObject(), (String) objectInputStream.readObject());
        this.cookie.setComment((String) objectInputStream.readObject());
        this.cookie.setCommentURL((String) objectInputStream.readObject());
        this.cookie.setDomain((String) objectInputStream.readObject());
        this.cookie.setMaxAge(objectInputStream.readLong());
        this.cookie.setPath((String) objectInputStream.readObject());
        this.cookie.setPortlist((String) objectInputStream.readObject());
        this.cookie.setVersion(objectInputStream.readInt());
        this.cookie.setSecure(objectInputStream.readBoolean());
        this.cookie.setDiscard(objectInputStream.readBoolean());
        setHttpOnly(objectInputStream.readBoolean());
    }

    private void setHttpOnly(boolean z) {
        try {
            initFieldHttpOnly();
            this.fieldHttpOnly.set(this.cookie, Boolean.valueOf(z));
        } catch (IllegalAccessException | IllegalArgumentException | NoSuchFieldException unused) {
        }
    }

    private void writeObject(ObjectOutputStream objectOutputStream) throws IOException {
        objectOutputStream.writeObject(this.cookie.getName());
        objectOutputStream.writeObject(this.cookie.getValue());
        objectOutputStream.writeObject(this.cookie.getComment());
        objectOutputStream.writeObject(this.cookie.getCommentURL());
        objectOutputStream.writeObject(this.cookie.getDomain());
        objectOutputStream.writeLong(this.cookie.getMaxAge());
        objectOutputStream.writeObject(this.cookie.getPath());
        objectOutputStream.writeObject(this.cookie.getPortlist());
        objectOutputStream.writeInt(this.cookie.getVersion());
        objectOutputStream.writeBoolean(this.cookie.getSecure());
        objectOutputStream.writeBoolean(this.cookie.getDiscard());
        objectOutputStream.writeBoolean(getHttpOnly());
    }

    public HttpCookie decode(String str) {
        try {
            return ((SerializableHttpCookie) new ObjectInputStream(new ByteArrayInputStream(hexStringToByteArray(str))).readObject()).cookie;
        } catch (IOException | ClassNotFoundException unused) {
            return null;
        }
    }

    public String encode(HttpCookie httpCookie) {
        this.cookie = httpCookie;
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try {
            new ObjectOutputStream(byteArrayOutputStream).writeObject(this);
            return byteArrayToHexString(byteArrayOutputStream.toByteArray());
        } catch (IOException unused) {
            return null;
        }
    }
}
