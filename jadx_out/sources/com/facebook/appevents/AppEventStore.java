package com.facebook.appevents;

import android.content.Context;
import android.util.Log;
import com.facebook.FacebookSdk;
import com.facebook.appevents.AccessTokenAppIdPair;
import com.facebook.appevents.AppEvent;
import com.facebook.appevents.internal.AppEventUtility;
import com.facebook.internal.Utility;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.ObjectStreamClass;

/* JADX INFO: loaded from: classes.dex */
class AppEventStore {
    private static final String PERSISTED_EVENTS_FILENAME = "AppEventsLogger.persistedevents";
    private static final String TAG = "com.facebook.appevents.AppEventStore";

    private static class MovedClassObjectInputStream extends ObjectInputStream {
        private static final String ACCESS_TOKEN_APP_ID_PAIR_SERIALIZATION_PROXY_V1_CLASS_NAME = "com.facebook.appevents.AppEventsLogger$AccessTokenAppIdPair$SerializationProxyV1";
        private static final String APP_EVENT_SERIALIZATION_PROXY_V1_CLASS_NAME = "com.facebook.appevents.AppEventsLogger$AppEvent$SerializationProxyV1";

        public MovedClassObjectInputStream(InputStream inputStream) {
            super(inputStream);
        }

        @Override // java.io.ObjectInputStream
        protected ObjectStreamClass readClassDescriptor() throws ClassNotFoundException, IOException {
            Class cls;
            ObjectStreamClass classDescriptor = super.readClassDescriptor();
            if (classDescriptor.getName().equals(ACCESS_TOKEN_APP_ID_PAIR_SERIALIZATION_PROXY_V1_CLASS_NAME)) {
                cls = AccessTokenAppIdPair.SerializationProxyV1.class;
            } else {
                if (!classDescriptor.getName().equals(APP_EVENT_SERIALIZATION_PROXY_V1_CLASS_NAME)) {
                    return classDescriptor;
                }
                cls = AppEvent.SerializationProxyV1.class;
            }
            return ObjectStreamClass.lookup(cls);
        }
    }

    AppEventStore() {
    }

    public static synchronized void persistEvents(AccessTokenAppIdPair accessTokenAppIdPair, SessionEventsState sessionEventsState) {
        AppEventUtility.assertIsNotMainThread();
        PersistedEvents andClearStore = readAndClearStore();
        if (andClearStore.containsKey(accessTokenAppIdPair)) {
            andClearStore.get(accessTokenAppIdPair).addAll(sessionEventsState.getEventsToPersist());
        } else {
            andClearStore.addEvents(accessTokenAppIdPair, sessionEventsState.getEventsToPersist());
        }
        saveEventsToDisk(andClearStore);
    }

    public static synchronized void persistEvents(AppEventCollection appEventCollection) {
        AppEventUtility.assertIsNotMainThread();
        PersistedEvents andClearStore = readAndClearStore();
        for (AccessTokenAppIdPair accessTokenAppIdPair : appEventCollection.keySet()) {
            andClearStore.addEvents(accessTokenAppIdPair, appEventCollection.get(accessTokenAppIdPair).getEventsToPersist());
        }
        saveEventsToDisk(andClearStore);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:42:0x008a A[Catch: all -> 0x0091, TRY_LEAVE, TryCatch #0 {, blocks: (B:4:0x0003, B:8:0x0021, B:9:0x0024, B:42:0x008a, B:12:0x002f, B:21:0x0045, B:22:0x0048, B:25:0x0053, B:26:0x0057, B:29:0x005e, B:30:0x0061, B:34:0x0073, B:33:0x006c, B:36:0x0075, B:37:0x0078, B:40:0x0083), top: B:49:0x0003, inners: #1, #4, #9, #10 }] */
    /* JADX WARN: Type inference failed for: r1v1, types: [android.content.Context] */
    /* JADX WARN: Type inference failed for: r1v11 */
    /* JADX WARN: Type inference failed for: r1v17 */
    /* JADX WARN: Type inference failed for: r1v18 */
    /* JADX WARN: Type inference failed for: r1v2, types: [android.content.Context] */
    /* JADX WARN: Type inference failed for: r1v5 */
    /* JADX WARN: Type inference failed for: r2v0 */
    /* JADX WARN: Type inference failed for: r2v1, types: [java.io.Closeable] */
    /* JADX WARN: Type inference failed for: r2v5 */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static synchronized com.facebook.appevents.PersistedEvents readAndClearStore() {
        /*
            java.lang.Class<com.facebook.appevents.AppEventStore> r0 = com.facebook.appevents.AppEventStore.class
            monitor-enter(r0)
            com.facebook.appevents.internal.AppEventUtility.assertIsNotMainThread()     // Catch: java.lang.Throwable -> L91
            android.content.Context r1 = com.facebook.FacebookSdk.getApplicationContext()     // Catch: java.lang.Throwable -> L91
            r2 = 0
            java.lang.String r3 = "AppEventsLogger.persistedevents"
            java.io.FileInputStream r3 = r1.openFileInput(r3)     // Catch: java.lang.Throwable -> L3a java.lang.Exception -> L3c java.io.FileNotFoundException -> L74
            com.facebook.appevents.AppEventStore$MovedClassObjectInputStream r4 = new com.facebook.appevents.AppEventStore$MovedClassObjectInputStream     // Catch: java.lang.Throwable -> L3a java.lang.Exception -> L3c java.io.FileNotFoundException -> L74
            java.io.BufferedInputStream r5 = new java.io.BufferedInputStream     // Catch: java.lang.Throwable -> L3a java.lang.Exception -> L3c java.io.FileNotFoundException -> L74
            r5.<init>(r3)     // Catch: java.lang.Throwable -> L3a java.lang.Exception -> L3c java.io.FileNotFoundException -> L74
            r4.<init>(r5)     // Catch: java.lang.Throwable -> L3a java.lang.Exception -> L3c java.io.FileNotFoundException -> L74
            java.lang.Object r3 = r4.readObject()     // Catch: java.lang.Exception -> L38 java.lang.Throwable -> L5b java.io.FileNotFoundException -> L75
            com.facebook.appevents.PersistedEvents r3 = (com.facebook.appevents.PersistedEvents) r3     // Catch: java.lang.Exception -> L38 java.lang.Throwable -> L5b java.io.FileNotFoundException -> L75
            com.facebook.internal.Utility.closeQuietly(r4)     // Catch: java.lang.Throwable -> L91
            java.lang.String r2 = "AppEventsLogger.persistedevents"
            java.io.File r1 = r1.getFileStreamPath(r2)     // Catch: java.lang.Exception -> L2e java.lang.Throwable -> L91
            r1.delete()     // Catch: java.lang.Exception -> L2e java.lang.Throwable -> L91
            goto L36
        L2e:
            r1 = move-exception
            java.lang.String r2 = com.facebook.appevents.AppEventStore.TAG     // Catch: java.lang.Throwable -> L91
            java.lang.String r4 = "Got unexpected exception when removing events file: "
            android.util.Log.w(r2, r4, r1)     // Catch: java.lang.Throwable -> L91
        L36:
            r2 = r3
            goto L88
        L38:
            r3 = move-exception
            goto L3e
        L3a:
            r3 = move-exception
            goto L5e
        L3c:
            r3 = move-exception
            r4 = r2
        L3e:
            java.lang.String r5 = com.facebook.appevents.AppEventStore.TAG     // Catch: java.lang.Throwable -> L5b
            java.lang.String r6 = "Got unexpected exception while reading events: "
            android.util.Log.w(r5, r6, r3)     // Catch: java.lang.Throwable -> L5b
            com.facebook.internal.Utility.closeQuietly(r4)     // Catch: java.lang.Throwable -> L91
            java.lang.String r3 = "AppEventsLogger.persistedevents"
            java.io.File r1 = r1.getFileStreamPath(r3)     // Catch: java.lang.Exception -> L52 java.lang.Throwable -> L91
            r1.delete()     // Catch: java.lang.Exception -> L52 java.lang.Throwable -> L91
            goto L88
        L52:
            r1 = move-exception
            java.lang.String r3 = com.facebook.appevents.AppEventStore.TAG     // Catch: java.lang.Throwable -> L91
            java.lang.String r4 = "Got unexpected exception when removing events file: "
        L57:
            android.util.Log.w(r3, r4, r1)     // Catch: java.lang.Throwable -> L91
            goto L88
        L5b:
            r2 = move-exception
            r3 = r2
            r2 = r4
        L5e:
            com.facebook.internal.Utility.closeQuietly(r2)     // Catch: java.lang.Throwable -> L91
            java.lang.String r2 = "AppEventsLogger.persistedevents"
            java.io.File r1 = r1.getFileStreamPath(r2)     // Catch: java.lang.Exception -> L6b java.lang.Throwable -> L91
            r1.delete()     // Catch: java.lang.Exception -> L6b java.lang.Throwable -> L91
            goto L73
        L6b:
            r1 = move-exception
            java.lang.String r2 = com.facebook.appevents.AppEventStore.TAG     // Catch: java.lang.Throwable -> L91
            java.lang.String r4 = "Got unexpected exception when removing events file: "
            android.util.Log.w(r2, r4, r1)     // Catch: java.lang.Throwable -> L91
        L73:
            throw r3     // Catch: java.lang.Throwable -> L91
        L74:
            r4 = r2
        L75:
            com.facebook.internal.Utility.closeQuietly(r4)     // Catch: java.lang.Throwable -> L91
            java.lang.String r3 = "AppEventsLogger.persistedevents"
            java.io.File r1 = r1.getFileStreamPath(r3)     // Catch: java.lang.Exception -> L82 java.lang.Throwable -> L91
            r1.delete()     // Catch: java.lang.Exception -> L82 java.lang.Throwable -> L91
            goto L88
        L82:
            r1 = move-exception
            java.lang.String r3 = com.facebook.appevents.AppEventStore.TAG     // Catch: java.lang.Throwable -> L91
            java.lang.String r4 = "Got unexpected exception when removing events file: "
            goto L57
        L88:
            if (r2 != 0) goto L8f
            com.facebook.appevents.PersistedEvents r2 = new com.facebook.appevents.PersistedEvents     // Catch: java.lang.Throwable -> L91
            r2.<init>()     // Catch: java.lang.Throwable -> L91
        L8f:
            monitor-exit(r0)
            return r2
        L91:
            r1 = move-exception
            monitor-exit(r0)
            throw r1
        */
        throw new UnsupportedOperationException("Method not decompiled: com.facebook.appevents.AppEventStore.readAndClearStore():com.facebook.appevents.PersistedEvents");
    }

    private static void saveEventsToDisk(PersistedEvents persistedEvents) throws Throwable {
        ObjectOutputStream objectOutputStream;
        Context applicationContext = FacebookSdk.getApplicationContext();
        ObjectOutputStream objectOutputStream2 = null;
        try {
            try {
                objectOutputStream = new ObjectOutputStream(new BufferedOutputStream(applicationContext.openFileOutput(PERSISTED_EVENTS_FILENAME, 0)));
            } catch (Throwable th) {
                th = th;
            }
        } catch (Exception e) {
            e = e;
        }
        try {
            objectOutputStream.writeObject(persistedEvents);
            Utility.closeQuietly(objectOutputStream);
        } catch (Exception e2) {
            e = e2;
            objectOutputStream2 = objectOutputStream;
            Log.w(TAG, "Got unexpected exception while persisting events: ", e);
            try {
                applicationContext.getFileStreamPath(PERSISTED_EVENTS_FILENAME).delete();
            } catch (Exception unused) {
            }
            Utility.closeQuietly(objectOutputStream2);
        } catch (Throwable th2) {
            th = th2;
            objectOutputStream2 = objectOutputStream;
            Utility.closeQuietly(objectOutputStream2);
            throw th;
        }
    }
}
