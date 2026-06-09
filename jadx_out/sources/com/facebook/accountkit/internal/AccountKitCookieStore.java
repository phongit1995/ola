package com.facebook.accountkit.internal;

import android.content.Context;
import android.content.SharedPreferences;
import java.net.CookieStore;
import java.net.HttpCookie;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
final class AccountKitCookieStore implements CookieStore {
    private static final String SP_COOKIE_STORE = "cookieStore";
    private static final String SP_KEY_DELIMITER = "|";
    private static final String SP_KEY_DELIMITER_REGEX = "\\|";
    private final Map<URI, List<HttpCookie>> map = new HashMap();
    private final SharedPreferences sharedPreferences;
    private static final List<String> ALLOW_PERSIST_DOMAINS = new ArrayList();
    private static final List<String> ALLOW_PERSIST_COOKIE_NAMES = new ArrayList();

    static {
        ALLOW_PERSIST_DOMAINS.add(".accountkit.com");
        ALLOW_PERSIST_COOKIE_NAMES.add("aksb");
    }

    public AccountKitCookieStore(Context context) {
        this.sharedPreferences = context.getSharedPreferences(SP_COOKIE_STORE, 0);
        loadFromSharedPreferences();
    }

    private URI cookiesUri(URI uri) {
        if (uri == null) {
            return null;
        }
        try {
            return new URI("http", uri.getHost(), null, null);
        } catch (URISyntaxException unused) {
            return uri;
        }
    }

    private void loadFromSharedPreferences() {
        for (Map.Entry<String, ?> entry : this.sharedPreferences.getAll().entrySet()) {
            try {
                URI uri = new URI(entry.getKey().split(SP_KEY_DELIMITER_REGEX, 2)[0]);
                HttpCookie httpCookieDecode = new SerializableHttpCookie().decode((String) entry.getValue());
                if (httpCookieDecode != null) {
                    List<HttpCookie> arrayList = this.map.get(uri);
                    if (arrayList == null) {
                        arrayList = new ArrayList<>();
                        this.map.put(uri, arrayList);
                    }
                    arrayList.add(httpCookieDecode);
                }
            } catch (URISyntaxException unused) {
            }
        }
    }

    private void saveToSharedPreferences(URI uri, HttpCookie httpCookie) {
        if (ALLOW_PERSIST_DOMAINS.contains(httpCookie.getDomain()) && ALLOW_PERSIST_COOKIE_NAMES.contains(httpCookie.getName())) {
            SharedPreferences.Editor editorEdit = this.sharedPreferences.edit();
            editorEdit.putString(uri.toString() + SP_KEY_DELIMITER + httpCookie.getName(), new SerializableHttpCookie().encode(httpCookie));
            editorEdit.apply();
        }
    }

    @Override // java.net.CookieStore
    public synchronized void add(URI uri, HttpCookie httpCookie) {
        try {
            if (httpCookie == null) {
                throw new NullPointerException("cookie == null");
            }
            URI uriCookiesUri = cookiesUri(uri);
            List<HttpCookie> arrayList = this.map.get(uriCookiesUri);
            if (arrayList == null) {
                arrayList = new ArrayList<>();
                this.map.put(uriCookiesUri, arrayList);
            } else {
                arrayList.remove(httpCookie);
            }
            arrayList.add(httpCookie);
            saveToSharedPreferences(uriCookiesUri, httpCookie);
        } catch (Throwable th) {
            throw th;
        }
    }

    @Override // java.net.CookieStore
    public synchronized List<HttpCookie> get(URI uri) {
        ArrayList arrayList;
        try {
            if (uri == null) {
                throw new NullPointerException("uri == null");
            }
            arrayList = new ArrayList();
            List<HttpCookie> list = this.map.get(uri);
            if (list != null) {
                Iterator<HttpCookie> it2 = list.iterator();
                while (it2.hasNext()) {
                    HttpCookie next = it2.next();
                    if (next.hasExpired()) {
                        it2.remove();
                    } else {
                        arrayList.add(next);
                    }
                }
            }
            for (Map.Entry<URI, List<HttpCookie>> entry : this.map.entrySet()) {
                if (!uri.equals(entry.getKey())) {
                    Iterator<HttpCookie> it3 = entry.getValue().iterator();
                    while (it3.hasNext()) {
                        HttpCookie next2 = it3.next();
                        if (HttpCookie.domainMatches(next2.getDomain(), uri.getHost())) {
                            if (next2.hasExpired()) {
                                it3.remove();
                            } else if (!arrayList.contains(next2)) {
                                arrayList.add(next2);
                            }
                        }
                    }
                }
            }
        } catch (Throwable th) {
            throw th;
        }
        return Collections.unmodifiableList(arrayList);
    }

    @Override // java.net.CookieStore
    public synchronized List<HttpCookie> getCookies() {
        ArrayList arrayList;
        arrayList = new ArrayList();
        Iterator<List<HttpCookie>> it2 = this.map.values().iterator();
        while (it2.hasNext()) {
            Iterator<HttpCookie> it3 = it2.next().iterator();
            while (it3.hasNext()) {
                HttpCookie next = it3.next();
                if (next.hasExpired()) {
                    it3.remove();
                } else if (!arrayList.contains(next)) {
                    arrayList.add(next);
                }
            }
        }
        return Collections.unmodifiableList(arrayList);
    }

    @Override // java.net.CookieStore
    public synchronized List<URI> getURIs() {
        ArrayList arrayList;
        arrayList = new ArrayList(this.map.keySet());
        arrayList.remove((Object) null);
        return Collections.unmodifiableList(arrayList);
    }

    @Override // java.net.CookieStore
    public synchronized boolean remove(URI uri, HttpCookie httpCookie) {
        try {
            if (httpCookie == null) {
                throw new NullPointerException("cookie == null");
            }
            List<HttpCookie> list = this.map.get(cookiesUri(uri));
            if (list == null) {
                return false;
            }
            return list.remove(httpCookie);
        } catch (Throwable th) {
            throw th;
        }
    }

    @Override // java.net.CookieStore
    public synchronized boolean removeAll() {
        boolean z;
        z = !this.map.isEmpty();
        this.map.clear();
        return z;
    }
}
