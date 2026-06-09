package com.facebook.internal;

import android.net.Uri;
import com.facebook.LoggingBehavior;
import com.facebook.internal.FileLruCache;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;

/* JADX INFO: loaded from: classes.dex */
class UrlRedirectCache {
    private static FileLruCache urlRedirectCache;
    static final String TAG = "UrlRedirectCache";
    private static final String REDIRECT_CONTENT_TAG = TAG + "_Redirect";

    UrlRedirectCache() {
    }

    static void cacheUriRedirect(Uri uri, Uri uri2) throws Throwable {
        if (uri == null || uri2 == null) {
            return;
        }
        OutputStream outputStream = null;
        try {
            OutputStream outputStreamOpenPutStream = getCache().openPutStream(uri.toString(), REDIRECT_CONTENT_TAG);
            try {
                outputStreamOpenPutStream.write(uri2.toString().getBytes());
                Utility.closeQuietly(outputStreamOpenPutStream);
            } catch (IOException unused) {
                outputStream = outputStreamOpenPutStream;
                Utility.closeQuietly(outputStream);
            } catch (Throwable th) {
                th = th;
                outputStream = outputStreamOpenPutStream;
                Utility.closeQuietly(outputStream);
                throw th;
            }
        } catch (IOException unused2) {
        } catch (Throwable th2) {
            th = th2;
        }
    }

    static void clearCache() {
        try {
            getCache().clearCache();
        } catch (IOException e) {
            Logger.log(LoggingBehavior.CACHE, 5, TAG, "clearCache failed " + e.getMessage());
        }
    }

    static synchronized FileLruCache getCache() {
        if (urlRedirectCache == null) {
            urlRedirectCache = new FileLruCache(TAG, new FileLruCache.Limits());
        }
        return urlRedirectCache;
    }

    static Uri getRedirectedUri(Uri uri) throws Throwable {
        Throwable th;
        InputStreamReader inputStreamReader;
        FileLruCache cache;
        InputStreamReader inputStreamReader2;
        boolean z;
        if (uri == null) {
            return null;
        }
        String string = uri.toString();
        try {
            cache = getCache();
            inputStreamReader2 = null;
            z = false;
        } catch (IOException unused) {
            inputStreamReader = null;
        } catch (Throwable th2) {
            th = th2;
            inputStreamReader = null;
        }
        while (true) {
            try {
                InputStream inputStream = cache.get(string, REDIRECT_CONTENT_TAG);
                if (inputStream == null) {
                    break;
                }
                z = true;
                inputStreamReader = new InputStreamReader(inputStream);
                try {
                    char[] cArr = new char[128];
                    StringBuilder sb = new StringBuilder();
                    while (true) {
                        int i = inputStreamReader.read(cArr, 0, cArr.length);
                        if (i <= 0) {
                            break;
                        }
                        sb.append(cArr, 0, i);
                    }
                    Utility.closeQuietly(inputStreamReader);
                    inputStreamReader2 = inputStreamReader;
                    string = sb.toString();
                } catch (IOException unused2) {
                } catch (Throwable th3) {
                    th = th3;
                    Utility.closeQuietly(inputStreamReader);
                    throw th;
                }
            } catch (IOException unused3) {
                inputStreamReader = inputStreamReader2;
            } catch (Throwable th4) {
                th = th4;
                inputStreamReader = inputStreamReader2;
            }
            Utility.closeQuietly(inputStreamReader);
            return null;
        }
        if (!z) {
            Utility.closeQuietly(inputStreamReader2);
            return null;
        }
        Uri uri2 = Uri.parse(string);
        Utility.closeQuietly(inputStreamReader2);
        return uri2;
        Utility.closeQuietly(inputStreamReader);
        return null;
    }
}
