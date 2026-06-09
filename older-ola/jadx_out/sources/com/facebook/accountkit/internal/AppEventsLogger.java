package com.facebook.accountkit.internal;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.Log;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitException;
import com.facebook.accountkit.LoggingBehavior;
import com.facebook.accountkit.internal.AccountKitGraphRequest;
import com.facebook.appevents.internal.Constants;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileNotFoundException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Executor;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
final class AppEventsLogger {
    private static final String APP_EVENT_PREFERENCES = "com.facebook.accountkit.sdk.appEventPreferences";
    private static final int FLUSH_PERIOD_IN_SECONDS = 15;
    private static final int MAX_POOL_SIZE = 4;
    private static final int NUM_LOG_EVENTS_TO_TRY_TO_FLUSH_AFTER = 30;
    private static String anonymousAppDeviceGUID;
    private static boolean requestInFlight;
    private final Context applicationContext;
    private final SessionEventsStateKey stateKey;
    private static final String TAG = AppEventsLogger.class.getCanonicalName();
    private static final Object APP_EVENTS_LOGGER_LOCK = new Object();
    private static final Map<SessionEventsStateKey, SessionEventsState> stateMap = new ConcurrentHashMap();
    private static final Executor sAppEventExecutor = new ThreadPoolExecutor(1, 4, 0, TimeUnit.MILLISECONDS, new LinkedBlockingQueue(256), new ThreadFactory() { // from class: com.facebook.accountkit.internal.AppEventsLogger.1
        private final AtomicInteger mCount = new AtomicInteger(1);

        @Override // java.util.concurrent.ThreadFactory
        public Thread newThread(Runnable runnable) {
            return new Thread(runnable, "App Event Thread #" + this.mCount.getAndIncrement());
        }
    }, new ThreadPoolExecutor.DiscardPolicy() { // from class: com.facebook.accountkit.internal.AppEventsLogger.2
        @Override // java.util.concurrent.ThreadPoolExecutor.DiscardPolicy, java.util.concurrent.RejectedExecutionHandler
        public void rejectedExecution(Runnable runnable, ThreadPoolExecutor threadPoolExecutor) {
            super.rejectedExecution(runnable, threadPoolExecutor);
            Log.e(AppEventsLogger.TAG, "App Event Dropped");
        }
    });

    private static class AppEvent implements Serializable {
        private static final String IDENTIFIER_REGEX = "^[0-9a-zA-Z_]+[0-9a-zA-Z _-]*$";
        private static final int MAX_IDENTIFIER_LENGTH = 40;
        private static final HashSet<String> VALIDATED_IDENTIFIERS = new HashSet<>();
        private static final long serialVersionUID = 1;
        final boolean isImplicit;
        final JSONObject jsonObject;

        private static class SerializationProxyV1 implements Serializable {
            private static final long serialVersionUID = -2488473066578201069L;
            private final boolean isImplicit;
            private final String jsonString;

            private SerializationProxyV1(String str, boolean z) {
                this.jsonString = str;
                this.isImplicit = z;
            }

            private Object readResolve() {
                return new AppEvent(this.jsonString, this.isImplicit);
            }
        }

        AppEvent(String str, Double d, Bundle bundle, boolean z) {
            LoggingBehavior loggingBehavior;
            String str2;
            String str3;
            Object[] objArr;
            this.isImplicit = z;
            JSONObject jSONObject = null;
            try {
                validateIdentifier(str);
                JSONObject jSONObject2 = new JSONObject();
                jSONObject2.put(Constants.EVENT_NAME_EVENT_KEY, str);
                jSONObject2.put(Constants.LOG_TIME_APP_EVENT_KEY, System.currentTimeMillis() / 1000);
                if (d != null) {
                    jSONObject2.put("_valueToSum", d.doubleValue());
                }
                if (z) {
                    jSONObject2.put("_implicitlyLogged", "1");
                }
                if (bundle != null) {
                    for (String str4 : bundle.keySet()) {
                        validateIdentifier(str4);
                        Object obj = bundle.get(str4);
                        if (!(obj instanceof String) && !(obj instanceof Number)) {
                            throw new AccountKitException(AccountKitError.Type.ARGUMENT_ERROR, new InternalAccountKitError(InternalAccountKitError.INVALID_PARAMETER_TYPE, obj, str4));
                        }
                        jSONObject2.put(str4, obj.toString());
                    }
                }
                if (!z) {
                    ConsoleLogger.log(LoggingBehavior.APP_EVENTS, "AppEvents", "Created app event '%s'", jSONObject2.toString());
                }
                jSONObject = jSONObject2;
            } catch (AccountKitException e) {
                loggingBehavior = LoggingBehavior.APP_EVENTS;
                str2 = "AppEvents";
                str3 = "Invalid app event name or parameter:";
                objArr = new Object[]{e.toString()};
                ConsoleLogger.log(loggingBehavior, str2, str3, objArr);
            } catch (JSONException e2) {
                loggingBehavior = LoggingBehavior.APP_EVENTS;
                str2 = "AppEvents";
                str3 = "JSON encoding for app event failed: '%s'";
                objArr = new Object[]{e2.toString()};
                ConsoleLogger.log(loggingBehavior, str2, str3, objArr);
            }
            this.jsonObject = jSONObject;
        }

        private AppEvent(String str, boolean z) {
            this.jsonObject = new JSONObject(str);
            this.isImplicit = z;
        }

        private void validateIdentifier(String str) {
            boolean zContains;
            if (str == null || str.length() == 0 || str.length() > 40) {
                if (str == null) {
                    str = "<None Provided>";
                }
                throw new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, new InternalAccountKitError(InternalAccountKitError.INVALID_PARAMETER_TYPE, str, 40));
            }
            synchronized (VALIDATED_IDENTIFIERS) {
                zContains = VALIDATED_IDENTIFIERS.contains(str);
            }
            if (zContains) {
                return;
            }
            if (!str.matches(IDENTIFIER_REGEX)) {
                throw new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, new InternalAccountKitError(InternalAccountKitError.INVALID_PARAMETER_TYPE, str));
            }
            synchronized (VALIDATED_IDENTIFIERS) {
                VALIDATED_IDENTIFIERS.add(str);
            }
        }

        private Object writeReplace() {
            return new SerializationProxyV1(this.jsonObject.toString(), this.isImplicit);
        }

        public String toString() {
            return String.format("\"%s\", implicit: %b, json: %s", this.jsonObject.optString(Constants.EVENT_NAME_EVENT_KEY), Boolean.valueOf(this.isImplicit), this.jsonObject.toString());
        }
    }

    private enum FlushReason {
        EXPLICIT,
        TIMER,
        SESSION_CHANGE,
        PERSISTED_EVENTS,
        EVENT_THRESHOLD,
        EAGER_FLUSHING_EVENT
    }

    private enum FlushResult {
        SUCCESS,
        SERVER_ERROR,
        NO_CONNECTIVITY,
        UNKNOWN_ERROR
    }

    private static class FlushStatistics {
        int numEvents;
        public FlushResult result;

        private FlushStatistics() {
            this.numEvents = 0;
            this.result = FlushResult.SUCCESS;
        }
    }

    private static class PersistedEvents {
        private static final String PERSISTED_EVENTS_FILENAME = "AccountKitAppEventsLogger.persistedevents";
        private static final Object PERSISTED_EVENTS_LOCK = new Object();
        private final Context context;
        private HashMap<SessionEventsStateKey, List<AppEvent>> persistedEvents = new HashMap<>();

        private PersistedEvents(Context context) {
            this.context = context;
        }

        static void persistEvents(Context context, SessionEventsStateKey sessionEventsStateKey, SessionEventsState sessionEventsState) {
            List<AppEvent> eventsToPersist = sessionEventsState.getEventsToPersist();
            if (eventsToPersist.size() == 0) {
                return;
            }
            synchronized (PERSISTED_EVENTS_LOCK) {
                PersistedEvents andClearStore = readAndClearStore(context);
                andClearStore.addEvents(sessionEventsStateKey, eventsToPersist);
                andClearStore.write();
            }
        }

        static PersistedEvents readAndClearStore(Context context) {
            PersistedEvents persistedEvents;
            synchronized (PERSISTED_EVENTS_LOCK) {
                persistedEvents = new PersistedEvents(context);
                persistedEvents.readAndClearStore();
            }
            return persistedEvents;
        }

        /* JADX WARN: Multi-variable type inference failed */
        /* JADX WARN: Type inference failed for: r0v0 */
        /* JADX WARN: Type inference failed for: r0v1 */
        /* JADX WARN: Type inference failed for: r0v10 */
        /* JADX WARN: Type inference failed for: r0v11, types: [java.io.ObjectInputStream] */
        /* JADX WARN: Type inference failed for: r0v12 */
        /* JADX WARN: Type inference failed for: r0v2 */
        /* JADX WARN: Type inference failed for: r0v4 */
        /* JADX WARN: Type inference failed for: r0v5, types: [java.io.Closeable] */
        /* JADX WARN: Type inference failed for: r0v9 */
        private void readAndClearStore() throws Throwable {
            BufferedInputStream bufferedInputStream;
            ?? objectInputStream = 0;
            BufferedInputStream bufferedInputStream2 = null;
            objectInputStream = 0;
            try {
                try {
                    bufferedInputStream = new BufferedInputStream(this.context.openFileInput(PERSISTED_EVENTS_FILENAME));
                } catch (Throwable th) {
                    th = th;
                }
            } catch (FileNotFoundException unused) {
            } catch (Exception e) {
                e = e;
            }
            try {
                objectInputStream = new ObjectInputStream(bufferedInputStream);
                HashMap<SessionEventsStateKey, List<AppEvent>> map = (HashMap) objectInputStream.readObject();
                if (!this.context.getFileStreamPath(PERSISTED_EVENTS_FILENAME).delete()) {
                    Log.d(AppEventsLogger.TAG, "Error deleting file: AccountKitAppEventsLogger.persistedevents");
                }
                this.persistedEvents = map;
            } catch (FileNotFoundException unused2) {
                objectInputStream = bufferedInputStream;
            } catch (Exception e2) {
                e = e2;
                objectInputStream = bufferedInputStream;
                Log.d(AppEventsLogger.TAG, "Got unexpected exception: " + e.toString());
            } catch (Throwable th2) {
                th = th2;
                bufferedInputStream2 = bufferedInputStream;
                Utility.closeQuietly(bufferedInputStream2);
                throw th;
            }
            Utility.closeQuietly(objectInputStream);
        }

        /* JADX WARN: Multi-variable type inference failed */
        /* JADX WARN: Type inference failed for: r0v0 */
        /* JADX WARN: Type inference failed for: r0v1 */
        /* JADX WARN: Type inference failed for: r0v11 */
        /* JADX WARN: Type inference failed for: r0v2 */
        /* JADX WARN: Type inference failed for: r0v3, types: [java.io.Closeable] */
        /* JADX WARN: Type inference failed for: r0v4, types: [java.io.Closeable] */
        /* JADX WARN: Type inference failed for: r0v6 */
        /* JADX WARN: Type inference failed for: r0v8 */
        /* JADX WARN: Type inference failed for: r0v9, types: [java.io.BufferedOutputStream, java.io.OutputStream] */
        /* JADX WARN: Type inference failed for: r1v10 */
        /* JADX WARN: Type inference failed for: r1v12, types: [java.io.Closeable, java.io.ObjectOutputStream] */
        /* JADX WARN: Type inference failed for: r1v7, types: [java.io.FileOutputStream, java.io.OutputStream] */
        /* JADX WARN: Type inference failed for: r1v8 */
        /* JADX WARN: Type inference failed for: r5v0 */
        /* JADX WARN: Type inference failed for: r5v1 */
        private void write() throws Throwable {
            ?? OpenFileOutput;
            ?? bufferedOutputStream = 0;
            bufferedOutputStream = 0;
            try {
                try {
                    OpenFileOutput = this.context.openFileOutput(PERSISTED_EVENTS_FILENAME, 0);
                } catch (Exception e) {
                    e = e;
                }
            } catch (Throwable th) {
                th = th;
            }
            try {
                bufferedOutputStream = new BufferedOutputStream(OpenFileOutput);
                OpenFileOutput = new ObjectOutputStream(bufferedOutputStream);
                OpenFileOutput.writeObject(this.persistedEvents);
                Utility.closeQuietly(OpenFileOutput);
            } catch (Exception e2) {
                ?? r5 = OpenFileOutput;
                e = e2;
                bufferedOutputStream = r5;
                Log.d(AppEventsLogger.TAG, "Got unexpected exception: " + e.toString());
                Utility.closeQuietly(bufferedOutputStream);
            } catch (Throwable th2) {
                ?? r52 = OpenFileOutput;
                th = th2;
                bufferedOutputStream = r52;
                Utility.closeQuietly(bufferedOutputStream);
                throw th;
            }
        }

        void addEvents(SessionEventsStateKey sessionEventsStateKey, List<AppEvent> list) {
            if (!this.persistedEvents.containsKey(sessionEventsStateKey)) {
                this.persistedEvents.put(sessionEventsStateKey, new ArrayList());
            }
            this.persistedEvents.get(sessionEventsStateKey).addAll(list);
        }
    }

    private static class SessionEventsState {
        private static final int MAX_ACCUMULATED_LOG_EVENTS = 1000;
        private final String anonymousAppDeviceGUID;
        private final Context applicationContext;
        private int numSkippedEventsDueToFullBuffer;
        private List<AppEvent> accumulatedEvents = new ArrayList();
        private final List<AppEvent> inFlightEvents = new ArrayList();

        SessionEventsState(Context context, String str) {
            this.applicationContext = context;
            this.anonymousAppDeviceGUID = str;
        }

        private byte[] getStringAsByteArray(String str) {
            try {
                return str.getBytes("UTF-8");
            } catch (UnsupportedEncodingException e) {
                Utility.logd("Encoding exception: ", e);
                return null;
            }
        }

        synchronized void addEvent(AppEvent appEvent) {
            if (this.accumulatedEvents.size() + this.inFlightEvents.size() >= 1000) {
                this.numSkippedEventsDueToFullBuffer++;
            } else {
                this.accumulatedEvents.add(appEvent);
            }
        }

        synchronized void clearInFlightAndStats(boolean z) {
            if (z) {
                try {
                    this.accumulatedEvents.addAll(this.inFlightEvents);
                } catch (Throwable th) {
                    throw th;
                }
            }
            this.inFlightEvents.clear();
            this.numSkippedEventsDueToFullBuffer = 0;
        }

        synchronized int getAccumulatedEventCount() {
            return this.accumulatedEvents.size();
        }

        synchronized List<AppEvent> getEventsToPersist() {
            List<AppEvent> list;
            list = this.accumulatedEvents;
            this.accumulatedEvents = new ArrayList();
            return list;
        }

        public JSONObject getJSONObject() throws JSONException {
            JSONObject jSONObject = new JSONObject();
            Utility.setAppEventAttributionParameters(jSONObject, this.anonymousAppDeviceGUID);
            try {
                Utility.setAppEventExtendedDeviceInfoParameters(jSONObject, this.applicationContext);
                return jSONObject;
            } catch (Exception e) {
                ConsoleLogger.log(LoggingBehavior.APP_EVENTS, "AppEvents", "Fetching extended device info parameters failed: '%s'", e.toString());
                return jSONObject;
            }
        }

        int populateRequest(AccountKitGraphRequest accountKitGraphRequest) {
            JSONObject jSONObject;
            synchronized (this) {
                int i = this.numSkippedEventsDueToFullBuffer;
                this.inFlightEvents.addAll(this.accumulatedEvents);
                this.accumulatedEvents.clear();
                JSONArray jSONArray = new JSONArray();
                Iterator<AppEvent> it2 = this.inFlightEvents.iterator();
                while (it2.hasNext()) {
                    jSONArray.put(it2.next().jsonObject);
                }
                if (jSONArray.length() == 0) {
                    return 0;
                }
                try {
                    jSONObject = getJSONObject();
                    if (this.numSkippedEventsDueToFullBuffer > 0) {
                        jSONObject.put("num_skipped_events", i);
                    }
                } catch (JSONException unused) {
                    jSONObject = new JSONObject();
                }
                accountKitGraphRequest.setRequestObject(jSONObject);
                Bundle parameters = accountKitGraphRequest.getParameters();
                if (parameters == null) {
                    parameters = new Bundle();
                }
                String string = jSONArray.toString();
                if (string != null) {
                    parameters.putByteArray("events_file", getStringAsByteArray(string));
                    accountKitGraphRequest.setTag(string);
                }
                accountKitGraphRequest.setParameters(parameters);
                return jSONArray.length();
            }
        }
    }

    private static class SessionEventsStateKey implements Serializable {
        private static final long serialVersionUID = 1;
        private final String accessTokenString;
        public final String applicationId;

        private static class SerializationProxyV1 implements Serializable {
            private static final long serialVersionUID = -1;
            private final String accessTokenString;
            private final String appId;

            private SerializationProxyV1(String str, String str2) {
                this.accessTokenString = str;
                this.appId = str2;
            }

            private Object readResolve() {
                return new SessionEventsStateKey(this.accessTokenString, this.appId);
            }
        }

        SessionEventsStateKey(AccessToken accessToken) {
            this(accessToken.getToken(), AccountKit.getApplicationId());
        }

        SessionEventsStateKey(String str, String str2) {
            this.accessTokenString = Utility.isNullOrEmpty(str) ? null : str;
            this.applicationId = str2;
        }

        private Object writeReplace() {
            return new SerializationProxyV1(this.accessTokenString, this.applicationId);
        }

        public boolean equals(Object obj) {
            if (!(obj instanceof SessionEventsStateKey)) {
                return false;
            }
            SessionEventsStateKey sessionEventsStateKey = (SessionEventsStateKey) obj;
            return Utility.areObjectsEqual(sessionEventsStateKey.accessTokenString, this.accessTokenString) && Utility.areObjectsEqual(sessionEventsStateKey.applicationId, this.applicationId);
        }

        public int hashCode() {
            return Utility.getHashCode(this.accessTokenString) ^ Utility.getHashCode(this.applicationId);
        }
    }

    AppEventsLogger(@NonNull Context context, String str) {
        AccessToken currentAccessToken = AccountKit.getCurrentAccessToken();
        if (currentAccessToken == null || !(str == null || str.equals(currentAccessToken.getApplicationId()))) {
            this.stateKey = new SessionEventsStateKey(null, str == null ? Utility.getMetadataApplicationId() : str);
        } else {
            this.stateKey = new SessionEventsStateKey(currentAccessToken);
        }
        this.applicationContext = context;
        initializeTimersIfNeeded();
    }

    private void buildAndExecuteRequests(FlushReason flushReason, Set<SessionEventsStateKey> set) {
        AccountKitGraphRequestAsyncTask accountKitGraphRequestAsyncTaskBuildRequestForSession;
        FlushStatistics flushStatistics = new FlushStatistics();
        ArrayList arrayList = new ArrayList();
        for (SessionEventsStateKey sessionEventsStateKey : set) {
            SessionEventsState sessionEventsState = getSessionEventsState(sessionEventsStateKey);
            if (sessionEventsState != null && (accountKitGraphRequestAsyncTaskBuildRequestForSession = buildRequestForSession(sessionEventsStateKey, sessionEventsState, flushStatistics)) != null) {
                arrayList.add(accountKitGraphRequestAsyncTaskBuildRequestForSession);
            }
        }
        if (arrayList.size() > 0) {
            ConsoleLogger.log(LoggingBehavior.APP_EVENTS, TAG, "Flushing %d events due to %s.", Integer.valueOf(flushStatistics.numEvents), flushReason.toString());
            Iterator it2 = arrayList.iterator();
            while (it2.hasNext()) {
                ((AccountKitGraphRequestAsyncTask) it2.next()).executeOnExecutor(sAppEventExecutor, new Void[0]);
            }
        }
    }

    private AccountKitGraphRequestAsyncTask buildRequestForSession(final SessionEventsStateKey sessionEventsStateKey, final SessionEventsState sessionEventsState, final FlushStatistics flushStatistics) {
        final AccountKitGraphRequest accountKitGraphRequest = new AccountKitGraphRequest(null, String.format("%s/events", sessionEventsStateKey.applicationId), null, false, HttpMethod.POST);
        int iPopulateRequest = sessionEventsState.populateRequest(accountKitGraphRequest);
        if (iPopulateRequest == 0) {
            return null;
        }
        flushStatistics.numEvents += iPopulateRequest;
        return new AccountKitGraphRequestAsyncTask(accountKitGraphRequest, new AccountKitGraphRequest.Callback() { // from class: com.facebook.accountkit.internal.AppEventsLogger.6
            @Override // com.facebook.accountkit.internal.AccountKitGraphRequest.Callback
            public void onCompleted(AccountKitGraphResponse accountKitGraphResponse) {
                AppEventsLogger.this.handleResponse(sessionEventsStateKey, accountKitGraphRequest, accountKitGraphResponse, sessionEventsState, flushStatistics);
            }
        });
    }

    private void flush(final FlushReason flushReason) {
        sAppEventExecutor.execute(new Runnable() { // from class: com.facebook.accountkit.internal.AppEventsLogger.5
            @Override // java.lang.Runnable
            public void run() {
                AppEventsLogger.this.flushAndWait(flushReason);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void flushAndWait(FlushReason flushReason) {
        synchronized (APP_EVENTS_LOGGER_LOCK) {
            if (requestInFlight) {
                return;
            }
            requestInFlight = true;
            HashSet hashSet = new HashSet(stateMap.keySet());
            try {
                buildAndExecuteRequests(flushReason, hashSet);
            } catch (Exception e) {
                Utility.logd(TAG, "Caught unexpected exception while flushing: ", e);
            }
            synchronized (APP_EVENTS_LOGGER_LOCK) {
                requestInFlight = false;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void flushIfNecessary() {
        synchronized (APP_EVENTS_LOGGER_LOCK) {
            if (getAccumulatedEventCount() > 30) {
                flush(FlushReason.EVENT_THRESHOLD);
            }
        }
    }

    private static int getAccumulatedEventCount() {
        int accumulatedEventCount;
        synchronized (APP_EVENTS_LOGGER_LOCK) {
            accumulatedEventCount = 0;
            Iterator<SessionEventsState> it2 = stateMap.values().iterator();
            while (it2.hasNext()) {
                accumulatedEventCount += it2.next().getAccumulatedEventCount();
            }
        }
        return accumulatedEventCount;
    }

    private static String getAnonymousAppDeviceGUID(Context context) {
        if (anonymousAppDeviceGUID == null) {
            synchronized (APP_EVENTS_LOGGER_LOCK) {
                if (anonymousAppDeviceGUID == null) {
                    SharedPreferences sharedPreferences = context.getSharedPreferences(APP_EVENT_PREFERENCES, 0);
                    anonymousAppDeviceGUID = sharedPreferences.getString("anonymousAppDeviceGUID", null);
                    if (anonymousAppDeviceGUID == null) {
                        anonymousAppDeviceGUID = "XZ" + UUID.randomUUID().toString();
                        sharedPreferences.edit().putString("anonymousAppDeviceGUID", anonymousAppDeviceGUID).apply();
                    }
                }
            }
        }
        return anonymousAppDeviceGUID;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public SessionEventsState getSessionEventsState(SessionEventsStateKey sessionEventsStateKey) {
        SessionEventsState sessionEventsState;
        SessionEventsState sessionEventsState2 = stateMap.get(sessionEventsStateKey);
        if (sessionEventsState2 != null) {
            return sessionEventsState2;
        }
        synchronized (APP_EVENTS_LOGGER_LOCK) {
            sessionEventsState = stateMap.get(sessionEventsStateKey);
            if (sessionEventsState == null) {
                sessionEventsState = new SessionEventsState(this.applicationContext, getAnonymousAppDeviceGUID(this.applicationContext));
                stateMap.put(sessionEventsStateKey, sessionEventsState);
            }
        }
        return sessionEventsState;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void handleResponse(SessionEventsStateKey sessionEventsStateKey, AccountKitGraphRequest accountKitGraphRequest, @Nullable AccountKitGraphResponse accountKitGraphResponse, SessionEventsState sessionEventsState, FlushStatistics flushStatistics) {
        String string;
        AccountKitRequestError error = accountKitGraphResponse == null ? null : accountKitGraphResponse.getError();
        String str = "Success";
        FlushResult flushResult = FlushResult.SUCCESS;
        if (error != null) {
            if (error.getErrorCode() == -1) {
                str = "Failed: No Connectivity";
                flushResult = FlushResult.NO_CONNECTIVITY;
            } else {
                str = String.format("Failed:\n  Response: %s\n  Error %s", accountKitGraphResponse.toString(), error.toString());
                flushResult = FlushResult.SERVER_ERROR;
            }
        }
        if (AccountKit.getLoggingBehaviors().isEnabled(LoggingBehavior.APP_EVENTS)) {
            try {
                string = new JSONArray((String) accountKitGraphRequest.getTag()).toString(2);
            } catch (JSONException unused) {
                string = "<Can't encode events for debug logging>";
            }
            ConsoleLogger.log(LoggingBehavior.APP_EVENTS, TAG, "Flush completed\nParams: %s\n  Result: %s\n  Events JSON: %s", accountKitGraphRequest.getRequestObject().toString(), str, string);
        }
        sessionEventsState.clearInFlightAndStats(error != null);
        if (flushResult == FlushResult.NO_CONNECTIVITY) {
            PersistedEvents.persistEvents(this.applicationContext, sessionEventsStateKey, sessionEventsState);
        }
        if (flushResult == FlushResult.SUCCESS || flushStatistics.result == FlushResult.NO_CONNECTIVITY) {
            return;
        }
        flushStatistics.result = flushResult;
    }

    private void initializeTimersIfNeeded() {
        Utility.getBackgroundExecutor().scheduleAtFixedRate(new Runnable() { // from class: com.facebook.accountkit.internal.AppEventsLogger.4
            @Override // java.lang.Runnable
            public void run() {
                AppEventsLogger.this.flushAndWait(FlushReason.TIMER);
            }
        }, 0L, 15L, TimeUnit.SECONDS);
    }

    public String getApplicationId() {
        return this.stateKey.applicationId;
    }

    void logSdkEvent(String str, Double d, Bundle bundle) {
        final AppEvent appEvent = new AppEvent(str, d, bundle, true);
        sAppEventExecutor.execute(new Runnable() { // from class: com.facebook.accountkit.internal.AppEventsLogger.3
            @Override // java.lang.Runnable
            public void run() {
                AppEventsLogger.this.getSessionEventsState(AppEventsLogger.this.stateKey).addEvent(appEvent);
                AppEventsLogger.this.flushIfNecessary();
            }
        });
    }
}
