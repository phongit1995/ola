package com.mg.ola.common.d;

import java.nio.charset.Charset;

/* JADX INFO: loaded from: classes2.dex */
public class a {
    public static final Charset a = Charset.forName("ISO-8859-1");
    public static final Charset b = Charset.forName("US-ASCII");
    public static final Charset c = Charset.forName("UTF-16");
    public static final Charset d = Charset.forName("UTF-16BE");
    public static final Charset e = Charset.forName("UTF-16LE");
    public static final Charset f = Charset.forName("UTF-8");

    public static Charset a(Charset charset) {
        return charset == null ? Charset.defaultCharset() : charset;
    }
}
