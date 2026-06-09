package com.facebook.internal;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Handler;
import android.os.Looper;
import com.facebook.internal.ImageRequest;
import com.facebook.internal.WorkQueue;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class ImageDownloader {
    private static final int CACHE_READ_QUEUE_MAX_CONCURRENT = 2;
    private static final int DOWNLOAD_QUEUE_MAX_CONCURRENT = 8;
    private static Handler handler;
    private static WorkQueue downloadQueue = new WorkQueue(8);
    private static WorkQueue cacheReadQueue = new WorkQueue(2);
    private static final Map<RequestKey, DownloaderContext> pendingRequests = new HashMap();

    private static class CacheReadWorkItem implements Runnable {
        private boolean allowCachedRedirects;
        private Context context;
        private RequestKey key;

        CacheReadWorkItem(Context context, RequestKey requestKey, boolean z) {
            this.context = context;
            this.key = requestKey;
            this.allowCachedRedirects = z;
        }

        @Override // java.lang.Runnable
        public void run() {
            ImageDownloader.readFromCache(this.key, this.context, this.allowCachedRedirects);
        }
    }

    private static class DownloadImageWorkItem implements Runnable {
        private Context context;
        private RequestKey key;

        DownloadImageWorkItem(Context context, RequestKey requestKey) {
            this.context = context;
            this.key = requestKey;
        }

        @Override // java.lang.Runnable
        public void run() throws Throwable {
            ImageDownloader.download(this.key, this.context);
        }
    }

    private static class DownloaderContext {
        boolean isCancelled;
        ImageRequest request;
        WorkQueue.WorkItem workItem;

        private DownloaderContext() {
        }
    }

    private static class RequestKey {
        private static final int HASH_MULTIPLIER = 37;
        private static final int HASH_SEED = 29;
        Object tag;
        Uri uri;

        RequestKey(Uri uri, Object obj) {
            this.uri = uri;
            this.tag = obj;
        }

        public boolean equals(Object obj) {
            if (obj == null || !(obj instanceof RequestKey)) {
                return false;
            }
            RequestKey requestKey = (RequestKey) obj;
            return requestKey.uri == this.uri && requestKey.tag == this.tag;
        }

        public int hashCode() {
            return ((1073 + this.uri.hashCode()) * 37) + this.tag.hashCode();
        }
    }

    public static boolean cancelRequest(ImageRequest imageRequest) {
        boolean z;
        RequestKey requestKey = new RequestKey(imageRequest.getImageUri(), imageRequest.getCallerTag());
        synchronized (pendingRequests) {
            DownloaderContext downloaderContext = pendingRequests.get(requestKey);
            z = true;
            if (downloaderContext == null) {
                z = false;
            } else if (downloaderContext.workItem.cancel()) {
                pendingRequests.remove(requestKey);
            } else {
                downloaderContext.isCancelled = true;
            }
        }
        return z;
    }

    public static void clearCache(Context context) {
        ImageResponseCache.clearCache(context);
        UrlRedirectCache.clearCache();
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Failed to find 'out' block for switch in B:6:0x001f. Please report as an issue. */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:47:0x00b9  */
    /* JADX WARN: Removed duplicated region for block: B:56:? A[RETURN, SYNTHETIC] */
    /* JADX WARN: Type inference failed for: r0v0 */
    /* JADX WARN: Type inference failed for: r0v1, types: [java.io.Closeable] */
    /* JADX WARN: Type inference failed for: r0v4 */
    /* JADX WARN: Type inference failed for: r0v7 */
    /* JADX WARN: Type inference failed for: r10v0, types: [android.content.Context] */
    /* JADX WARN: Type inference failed for: r10v1 */
    /* JADX WARN: Type inference failed for: r10v2, types: [java.io.Closeable] */
    /* JADX WARN: Type inference failed for: r10v3 */
    /* JADX WARN: Type inference failed for: r10v6 */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static void download(com.facebook.internal.ImageDownloader.RequestKey r9, android.content.Context r10) throws java.lang.Throwable {
        /*
            r0 = 0
            r1 = 0
            r2 = 1
            java.net.URL r3 = new java.net.URL     // Catch: java.lang.Throwable -> La2 java.io.IOException -> Lab
            android.net.Uri r4 = r9.uri     // Catch: java.lang.Throwable -> La2 java.io.IOException -> Lab
            java.lang.String r4 = r4.toString()     // Catch: java.lang.Throwable -> La2 java.io.IOException -> Lab
            r3.<init>(r4)     // Catch: java.lang.Throwable -> La2 java.io.IOException -> Lab
            java.net.URLConnection r3 = r3.openConnection()     // Catch: java.lang.Throwable -> La2 java.io.IOException -> Lab
            java.net.HttpURLConnection r3 = (java.net.HttpURLConnection) r3     // Catch: java.lang.Throwable -> La2 java.io.IOException -> Lab
            r3.setInstanceFollowRedirects(r1)     // Catch: java.lang.Throwable -> L9d java.io.IOException -> L9f
            int r4 = r3.getResponseCode()     // Catch: java.lang.Throwable -> L9d java.io.IOException -> L9f
            r5 = 200(0xc8, float:2.8E-43)
            if (r4 == r5) goto L8e
            switch(r4) {
                case 301: goto L5b;
                case 302: goto L5b;
                default: goto L22;
            }     // Catch: java.lang.Throwable -> L9d java.io.IOException -> L9f
        L22:
            java.io.InputStream r10 = r3.getErrorStream()     // Catch: java.lang.Throwable -> L9d java.io.IOException -> L9f
            java.lang.StringBuilder r4 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
            r4.<init>()     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
            if (r10 == 0) goto L45
            java.io.InputStreamReader r5 = new java.io.InputStreamReader     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
            r5.<init>(r10)     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
            r6 = 128(0x80, float:1.794E-43)
            char[] r6 = new char[r6]     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
        L36:
            int r7 = r6.length     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
            int r7 = r5.read(r6, r1, r7)     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
            if (r7 <= 0) goto L41
            r4.append(r6, r1, r7)     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
            goto L36
        L41:
            com.facebook.internal.Utility.closeQuietly(r5)     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
            goto L4a
        L45:
            java.lang.String r5 = "Unexpected error while downloading an image."
            r4.append(r5)     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
        L4a:
            com.facebook.FacebookException r5 = new com.facebook.FacebookException     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
            java.lang.String r4 = r4.toString()     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
            r5.<init>(r4)     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
            r4 = r0
            r0 = r5
            goto L96
        L56:
            r9 = move-exception
            r0 = r10
            goto La4
        L59:
            r4 = move-exception
            goto Lae
        L5b:
            java.lang.String r10 = "location"
            java.lang.String r10 = r3.getHeaderField(r10)     // Catch: java.io.IOException -> L8a java.lang.Throwable -> L9d
            boolean r2 = com.facebook.internal.Utility.isNullOrEmpty(r10)     // Catch: java.io.IOException -> L8a java.lang.Throwable -> L9d
            if (r2 != 0) goto L86
            android.net.Uri r10 = android.net.Uri.parse(r10)     // Catch: java.io.IOException -> L8a java.lang.Throwable -> L9d
            android.net.Uri r2 = r9.uri     // Catch: java.io.IOException -> L8a java.lang.Throwable -> L9d
            com.facebook.internal.UrlRedirectCache.cacheUriRedirect(r2, r10)     // Catch: java.io.IOException -> L8a java.lang.Throwable -> L9d
            com.facebook.internal.ImageDownloader$DownloaderContext r2 = removePendingRequest(r9)     // Catch: java.io.IOException -> L8a java.lang.Throwable -> L9d
            if (r2 == 0) goto L86
            boolean r4 = r2.isCancelled     // Catch: java.io.IOException -> L8a java.lang.Throwable -> L9d
            if (r4 != 0) goto L86
            com.facebook.internal.ImageRequest r2 = r2.request     // Catch: java.io.IOException -> L8a java.lang.Throwable -> L9d
            com.facebook.internal.ImageDownloader$RequestKey r4 = new com.facebook.internal.ImageDownloader$RequestKey     // Catch: java.io.IOException -> L8a java.lang.Throwable -> L9d
            java.lang.Object r5 = r9.tag     // Catch: java.io.IOException -> L8a java.lang.Throwable -> L9d
            r4.<init>(r10, r5)     // Catch: java.io.IOException -> L8a java.lang.Throwable -> L9d
            enqueueCacheRead(r2, r4, r1)     // Catch: java.io.IOException -> L8a java.lang.Throwable -> L9d
        L86:
            r10 = r0
            r4 = r10
            r2 = 0
            goto L96
        L8a:
            r4 = move-exception
            r10 = r0
            r2 = 0
            goto Lae
        L8e:
            java.io.InputStream r10 = com.facebook.internal.ImageResponseCache.interceptAndCacheImageStream(r10, r3)     // Catch: java.lang.Throwable -> L9d java.io.IOException -> L9f
            android.graphics.Bitmap r4 = android.graphics.BitmapFactory.decodeStream(r10)     // Catch: java.lang.Throwable -> L56 java.io.IOException -> L59
        L96:
            com.facebook.internal.Utility.closeQuietly(r10)
            com.facebook.internal.Utility.disconnectQuietly(r3)
            goto Lb7
        L9d:
            r9 = move-exception
            goto La4
        L9f:
            r4 = move-exception
            r10 = r0
            goto Lae
        La2:
            r9 = move-exception
            r3 = r0
        La4:
            com.facebook.internal.Utility.closeQuietly(r0)
            com.facebook.internal.Utility.disconnectQuietly(r3)
            throw r9
        Lab:
            r4 = move-exception
            r10 = r0
            r3 = r10
        Lae:
            com.facebook.internal.Utility.closeQuietly(r10)
            com.facebook.internal.Utility.disconnectQuietly(r3)
            r8 = r4
            r4 = r0
            r0 = r8
        Lb7:
            if (r2 == 0) goto Lbc
            issueResponse(r9, r0, r4, r1)
        Lbc:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.facebook.internal.ImageDownloader.download(com.facebook.internal.ImageDownloader$RequestKey, android.content.Context):void");
    }

    public static void downloadAsync(ImageRequest imageRequest) {
        if (imageRequest == null) {
            return;
        }
        RequestKey requestKey = new RequestKey(imageRequest.getImageUri(), imageRequest.getCallerTag());
        synchronized (pendingRequests) {
            DownloaderContext downloaderContext = pendingRequests.get(requestKey);
            if (downloaderContext != null) {
                downloaderContext.request = imageRequest;
                downloaderContext.isCancelled = false;
                downloaderContext.workItem.moveToFront();
            } else {
                enqueueCacheRead(imageRequest, requestKey, imageRequest.isCachedRedirectAllowed());
            }
        }
    }

    private static void enqueueCacheRead(ImageRequest imageRequest, RequestKey requestKey, boolean z) {
        enqueueRequest(imageRequest, requestKey, cacheReadQueue, new CacheReadWorkItem(imageRequest.getContext(), requestKey, z));
    }

    private static void enqueueDownload(ImageRequest imageRequest, RequestKey requestKey) {
        enqueueRequest(imageRequest, requestKey, downloadQueue, new DownloadImageWorkItem(imageRequest.getContext(), requestKey));
    }

    private static void enqueueRequest(ImageRequest imageRequest, RequestKey requestKey, WorkQueue workQueue, Runnable runnable) {
        synchronized (pendingRequests) {
            DownloaderContext downloaderContext = new DownloaderContext();
            downloaderContext.request = imageRequest;
            pendingRequests.put(requestKey, downloaderContext);
            downloaderContext.workItem = workQueue.addActiveWorkItem(runnable);
        }
    }

    private static synchronized Handler getHandler() {
        if (handler == null) {
            handler = new Handler(Looper.getMainLooper());
        }
        return handler;
    }

    private static void issueResponse(RequestKey requestKey, final Exception exc, final Bitmap bitmap, final boolean z) {
        final ImageRequest imageRequest;
        final ImageRequest.Callback callback;
        DownloaderContext downloaderContextRemovePendingRequest = removePendingRequest(requestKey);
        if (downloaderContextRemovePendingRequest == null || downloaderContextRemovePendingRequest.isCancelled || (callback = (imageRequest = downloaderContextRemovePendingRequest.request).getCallback()) == null) {
            return;
        }
        getHandler().post(new Runnable() { // from class: com.facebook.internal.ImageDownloader.1
            @Override // java.lang.Runnable
            public void run() {
                callback.onCompleted(new ImageResponse(imageRequest, exc, z, bitmap));
            }
        });
    }

    public static void prioritizeRequest(ImageRequest imageRequest) {
        RequestKey requestKey = new RequestKey(imageRequest.getImageUri(), imageRequest.getCallerTag());
        synchronized (pendingRequests) {
            DownloaderContext downloaderContext = pendingRequests.get(requestKey);
            if (downloaderContext != null) {
                downloaderContext.workItem.moveToFront();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void readFromCache(RequestKey requestKey, Context context, boolean z) {
        InputStream cachedImageStream;
        Uri redirectedUri;
        boolean z2 = false;
        if (!z || (redirectedUri = UrlRedirectCache.getRedirectedUri(requestKey.uri)) == null) {
            cachedImageStream = null;
        } else {
            cachedImageStream = ImageResponseCache.getCachedImageStream(redirectedUri, context);
            if (cachedImageStream != null) {
                z2 = true;
            }
        }
        if (!z2) {
            cachedImageStream = ImageResponseCache.getCachedImageStream(requestKey.uri, context);
        }
        if (cachedImageStream != null) {
            Bitmap bitmapDecodeStream = BitmapFactory.decodeStream(cachedImageStream);
            Utility.closeQuietly(cachedImageStream);
            issueResponse(requestKey, null, bitmapDecodeStream, z2);
        } else {
            DownloaderContext downloaderContextRemovePendingRequest = removePendingRequest(requestKey);
            if (downloaderContextRemovePendingRequest == null || downloaderContextRemovePendingRequest.isCancelled) {
                return;
            }
            enqueueDownload(downloaderContextRemovePendingRequest.request, requestKey);
        }
    }

    private static DownloaderContext removePendingRequest(RequestKey requestKey) {
        DownloaderContext downloaderContextRemove;
        synchronized (pendingRequests) {
            downloaderContextRemove = pendingRequests.remove(requestKey);
        }
        return downloaderContextRemove;
    }
}
