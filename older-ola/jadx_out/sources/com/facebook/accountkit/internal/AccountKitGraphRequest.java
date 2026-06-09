package com.facebook.accountkit.internal;

import android.graphics.Bitmap;
import android.net.TrafficStats;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.util.Log;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitException;
import com.facebook.accountkit.AccountKitSdkVersion;
import com.facebook.accountkit.LoggingBehavior;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;
import java.util.regex.Pattern;
import java.util.zip.GZIPOutputStream;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
final class AccountKitGraphRequest {
    private static final String ACCESS_TOKEN_PREFIX = "AA";
    private static final int DEFAULT_TIMEOUT_MILLISECONDS = 10000;
    private static final String GRAPH_API_VERSION = "v1.3";
    private static final String HEADER_CONTENT_ENCODING = "Content-Encoding";
    private static final String HEADER_CONTENT_TYPE = "Content-Type";
    private static final String ISO_8601_FORMAT_STRING = "yyyy-MM-dd'T'HH:mm:ssZ";
    private static final String MIME_BOUNDARY = "3i2ndDfv2rTHiSisAbouNdArYfORhtTPEefj3q2f";
    private static final String PARAMETER_ACCESS_TOKEN = "access_token";
    private static final int SOCKET_TAG = 61453;
    public static final String TAG = "AccountKitGraphRequest";
    private static final String USER_AGENT_BASE = "AccountKitAndroidSDK";
    private static final String USER_AGENT_HEADER = "User-Agent";
    private static final Pattern versionPattern = Pattern.compile("^/?v\\d+\\.\\d+/(.*)");
    private AccessToken accessToken;
    private Handler callbackHandler;
    private final String graphPath;
    private HttpMethod httpMethod;
    private final boolean isLoginRequest;
    private Bundle parameters;
    private JSONObject requestObject;
    private Object tag;
    private String version;

    public interface Callback {
        void onCompleted(AccountKitGraphResponse accountKitGraphResponse);
    }

    private interface KeyValueSerializer {
        void writeString(String str, String str2);
    }

    private static class LazyUserAgentHolder {
        static final String userAgent = buildUserAgent();

        private LazyUserAgentHolder() {
        }

        private static String buildUserAgent() {
            String property = System.getProperty("http.agent");
            if (property == null) {
                property = "";
            }
            return property + " " + AccountKitGraphRequest.USER_AGENT_BASE + "/" + AccountKitSdkVersion.BUILD;
        }
    }

    private static class ParcelableResourceWithMimeType<RESOURCE extends Parcelable> implements Parcelable {
        public static final Parcelable.Creator<ParcelableResourceWithMimeType> CREATOR = new Parcelable.Creator<ParcelableResourceWithMimeType>() { // from class: com.facebook.accountkit.internal.AccountKitGraphRequest.ParcelableResourceWithMimeType.1
            /* JADX WARN: Can't rename method to resolve collision */
            @Override // android.os.Parcelable.Creator
            public ParcelableResourceWithMimeType createFromParcel(Parcel parcel) {
                return new ParcelableResourceWithMimeType(parcel);
            }

            /* JADX WARN: Can't rename method to resolve collision */
            @Override // android.os.Parcelable.Creator
            public ParcelableResourceWithMimeType[] newArray(int i) {
                return new ParcelableResourceWithMimeType[i];
            }
        };
        private final String mimeType;
        private final RESOURCE resource;

        private ParcelableResourceWithMimeType(Parcel parcel) {
            this.mimeType = parcel.readString();
            this.resource = (RESOURCE) parcel.readParcelable(AccountKitController.getApplicationContext().getClassLoader());
        }

        @Override // android.os.Parcelable
        public int describeContents() {
            return 1;
        }

        String getMimeType() {
            return this.mimeType;
        }

        public RESOURCE getResource() {
            return this.resource;
        }

        @Override // android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeString(this.mimeType);
            parcel.writeParcelable(this.resource, i);
        }
    }

    private static class Serializer implements KeyValueSerializer {
        private boolean firstWrite = true;
        private final OutputStream outputStream;
        private boolean useUrlEncode;

        Serializer(OutputStream outputStream, boolean z) {
            this.useUrlEncode = false;
            this.outputStream = outputStream;
            this.useUrlEncode = z;
        }

        private RuntimeException getInvalidTypeError() {
            return new IllegalArgumentException("value is not a supported type.");
        }

        void write(String str, Object... objArr) throws IOException {
            OutputStream outputStream;
            String strEncode;
            if (this.useUrlEncode) {
                outputStream = this.outputStream;
                strEncode = URLEncoder.encode(String.format(Locale.US, str, objArr), "UTF-8");
            } else {
                if (this.firstWrite) {
                    this.outputStream.write("--".getBytes());
                    this.outputStream.write(AccountKitGraphRequest.MIME_BOUNDARY.getBytes());
                    this.outputStream.write("\r\n".getBytes());
                    this.firstWrite = false;
                }
                outputStream = this.outputStream;
                strEncode = String.format(str, objArr);
            }
            outputStream.write(strEncode.getBytes());
        }

        void writeBitmap(String str, Bitmap bitmap) throws IOException {
            writeContentDisposition(str, str, "image/png");
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, this.outputStream);
            writeLine("", new Object[0]);
            writeRecordBoundary();
        }

        void writeBytes(String str, byte[] bArr) throws IOException {
            writeContentDisposition(str, str, "content/unknown");
            this.outputStream.write(bArr);
            writeLine("", new Object[0]);
            writeRecordBoundary();
        }

        void writeContentDisposition(String str, String str2, String str3) throws IOException {
            if (this.useUrlEncode) {
                this.outputStream.write(String.format("%s=", str).getBytes());
                return;
            }
            write("Content-Disposition: form-data; name=\"%s\"", str);
            if (str2 != null) {
                write("; filename=\"%s\"", str2);
            }
            writeLine("", new Object[0]);
            if (str3 != null) {
                writeLine("%s: %s", AccountKitGraphRequest.HEADER_CONTENT_TYPE, str3);
            }
            writeLine("", new Object[0]);
        }

        void writeContentUri(String str, Uri uri, String str2) throws Throwable {
            if (str2 == null) {
                str2 = "content/unknown";
            }
            writeContentDisposition(str, str, str2);
            Utility.copyAndCloseInputStream(AccountKitController.getApplicationContext().getContentResolver().openInputStream(uri), this.outputStream);
            writeLine("", new Object[0]);
            writeRecordBoundary();
        }

        void writeFile(String str, ParcelFileDescriptor parcelFileDescriptor, String str2) throws Throwable {
            if (str2 == null) {
                str2 = "content/unknown";
            }
            writeContentDisposition(str, str, str2);
            Utility.copyAndCloseInputStream(new ParcelFileDescriptor.AutoCloseInputStream(parcelFileDescriptor), this.outputStream);
            writeLine("", new Object[0]);
            writeRecordBoundary();
        }

        void writeLine(String str, Object... objArr) throws IOException {
            write(str, objArr);
            if (this.useUrlEncode) {
                return;
            }
            write("\r\n", new Object[0]);
        }

        void writeObject(String str, Object obj) throws Throwable {
            if (AccountKitGraphRequest.isSupportedParameterType(obj)) {
                writeString(str, AccountKitGraphRequest.parameterToString(obj));
                return;
            }
            if (obj instanceof Bitmap) {
                writeBitmap(str, (Bitmap) obj);
                return;
            }
            if (obj instanceof byte[]) {
                writeBytes(str, (byte[]) obj);
                return;
            }
            if (obj instanceof Uri) {
                writeContentUri(str, (Uri) obj, null);
                return;
            }
            if (obj instanceof ParcelFileDescriptor) {
                writeFile(str, (ParcelFileDescriptor) obj, null);
                return;
            }
            if (!(obj instanceof ParcelableResourceWithMimeType)) {
                throw getInvalidTypeError();
            }
            ParcelableResourceWithMimeType parcelableResourceWithMimeType = (ParcelableResourceWithMimeType) obj;
            Parcelable resource = parcelableResourceWithMimeType.getResource();
            String mimeType = parcelableResourceWithMimeType.getMimeType();
            if (resource instanceof ParcelFileDescriptor) {
                writeFile(str, (ParcelFileDescriptor) resource, mimeType);
            } else {
                if (!(resource instanceof Uri)) {
                    throw getInvalidTypeError();
                }
                writeContentUri(str, (Uri) resource, mimeType);
            }
        }

        void writeRecordBoundary() throws IOException {
            if (this.useUrlEncode) {
                this.outputStream.write("&".getBytes());
            } else {
                writeLine("--%s", AccountKitGraphRequest.MIME_BOUNDARY);
            }
        }

        @Override // com.facebook.accountkit.internal.AccountKitGraphRequest.KeyValueSerializer
        public void writeString(String str, String str2) throws IOException {
            writeContentDisposition(str, null, null);
            writeLine("%s", str2);
            writeRecordBoundary();
        }
    }

    public AccountKitGraphRequest(AccessToken accessToken, String str, Bundle bundle, boolean z, HttpMethod httpMethod) {
        this(accessToken, str, bundle, z, httpMethod, null);
    }

    public AccountKitGraphRequest(AccessToken accessToken, String str, Bundle bundle, boolean z, HttpMethod httpMethod, String str2) {
        this.accessToken = accessToken;
        this.graphPath = str;
        this.isLoginRequest = z;
        setHttpMethod(httpMethod);
        this.parameters = bundle != null ? new Bundle(bundle) : new Bundle();
        this.version = str2 == null ? GRAPH_API_VERSION : str2;
    }

    private void addCommonParameters() {
        String token;
        Utility.putNonNullString(this.parameters, AccountKitGraphConstants.PARAMETER_LOCALE, LocaleMapper.getSystemLocale());
        Utility.putNonNullString(this.parameters, "sdk", AccountKitGraphConstants.SDK_TYPE_ANDROID);
        this.parameters.putBoolean(AccountKitGraphConstants.PARAMETER_FACEBOOK_APP_EVENTS_ENABLED, AccountKit.getAccountKitFacebookAppEventsEnabled());
        if (this.accessToken != null) {
            if (this.parameters.containsKey("access_token")) {
                return;
            } else {
                token = this.accessToken.getToken();
            }
        } else {
            if (this.parameters.containsKey("access_token")) {
                return;
            }
            String applicationId = AccountKit.getApplicationId();
            String clientToken = AccountKit.getClientToken();
            if (Utility.isNullOrEmpty(applicationId) || Utility.isNullOrEmpty(clientToken)) {
                Log.d(TAG, "Warning: Request without access token missing application ID or client token.");
                return;
            }
            token = "AA|" + applicationId + "|" + clientToken;
        }
        this.parameters.putString("access_token", token);
    }

    private void appendQueryParametersToUri(Uri.Builder builder) {
        ArrayList<String> arrayList = new ArrayList(this.parameters.keySet());
        Collections.sort(arrayList);
        for (String str : arrayList) {
            Object obj = this.parameters.get(str);
            if (obj == null) {
                obj = "";
            }
            builder.appendQueryParameter(str, parameterToString(obj));
        }
    }

    private static HttpURLConnection createConnection(URL url) {
        HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
        httpURLConnection.setRequestProperty(USER_AGENT_HEADER, LazyUserAgentHolder.userAgent);
        httpURLConnection.setChunkedStreamingMode(0);
        return httpURLConnection;
    }

    static AccountKitGraphRequestAsyncTask executeAsync(@NonNull AccountKitGraphRequest accountKitGraphRequest, Callback callback) {
        AccountKitGraphRequestAsyncTask accountKitGraphRequestAsyncTask = new AccountKitGraphRequestAsyncTask(accountKitGraphRequest, callback);
        accountKitGraphRequestAsyncTask.executeOnExecutor(Utility.getThreadPoolExecutor(), new Void[0]);
        return accountKitGraphRequestAsyncTask;
    }

    static AccountKitGraphResponse executeConnectionAndWait(HttpURLConnection httpURLConnection, AccountKitGraphRequest accountKitGraphRequest) {
        AccountKitGraphResponse accountKitGraphResponseFromHttpConnection = AccountKitGraphResponse.fromHttpConnection(httpURLConnection, accountKitGraphRequest);
        Utility.disconnectQuietly(httpURLConnection);
        return accountKitGraphResponseFromHttpConnection;
    }

    private static String getMimeContentType() {
        return String.format("multipart/form-data; boundary=%s", MIME_BOUNDARY);
    }

    private String getUrlForSingleRequest() {
        Uri.Builder builderAuthority = new Uri.Builder().scheme("https").authority(AccountKitController.getBaseGraphHost());
        if (!versionPattern.matcher(this.graphPath).matches()) {
            builderAuthority.appendPath(this.version);
        }
        builderAuthority.appendPath(this.graphPath);
        addCommonParameters();
        if (this.httpMethod != HttpMethod.POST) {
            appendQueryParametersToUri(builderAuthority);
        }
        return builderAuthority.toString();
    }

    private static boolean isMultiPart(Bundle bundle) {
        Iterator<String> it2 = bundle.keySet().iterator();
        while (it2.hasNext()) {
            if (isMultipartType(bundle.get(it2.next()))) {
                return true;
            }
        }
        return false;
    }

    private static boolean isMultipartType(Object obj) {
        return (obj instanceof Bitmap) || (obj instanceof byte[]) || (obj instanceof Uri) || (obj instanceof ParcelFileDescriptor) || (obj instanceof ParcelableResourceWithMimeType);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean isSupportedParameterType(Object obj) {
        return (obj instanceof String) || (obj instanceof Boolean) || (obj instanceof Number) || (obj instanceof Date);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String parameterToString(Object obj) {
        if (obj instanceof String) {
            return (String) obj;
        }
        if ((obj instanceof Boolean) || (obj instanceof Number)) {
            return obj.toString();
        }
        if (obj instanceof Date) {
            return new SimpleDateFormat(ISO_8601_FORMAT_STRING, Locale.US).format(obj);
        }
        throw new IllegalArgumentException("Unsupported parameter type.");
    }

    private static void processRequest(AccountKitGraphRequest accountKitGraphRequest, OutputStream outputStream, boolean z) throws Throwable {
        Serializer serializer = new Serializer(outputStream, !z);
        serializeParameters(accountKitGraphRequest.parameters, serializer);
        if (accountKitGraphRequest.requestObject != null) {
            processRequestObject(accountKitGraphRequest.requestObject, serializer);
        }
    }

    private static void processRequestObject(JSONObject jSONObject, KeyValueSerializer keyValueSerializer) {
        Iterator<String> itKeys = jSONObject.keys();
        while (itKeys.hasNext()) {
            String next = itKeys.next();
            processRequestObjectProperty(next, jSONObject.opt(next), keyValueSerializer);
        }
    }

    private static void processRequestObjectProperty(String str, Object obj, KeyValueSerializer keyValueSerializer) {
        String string;
        Class<?> cls = obj.getClass();
        if (String.class.isAssignableFrom(cls) || Number.class.isAssignableFrom(cls) || Boolean.class.isAssignableFrom(cls)) {
            string = obj.toString();
        } else {
            if (!Date.class.isAssignableFrom(cls)) {
                return;
            }
            string = new SimpleDateFormat(ISO_8601_FORMAT_STRING, Locale.US).format((Date) obj);
        }
        keyValueSerializer.writeString(str, string);
    }

    private static void serializeParameters(Bundle bundle, Serializer serializer) throws Throwable {
        for (String str : bundle.keySet()) {
            serializer.writeObject(str, bundle.get(str));
        }
    }

    private static void serializeToUrlConnection(AccountKitGraphRequest accountKitGraphRequest, HttpURLConnection httpURLConnection) throws Throwable {
        ConsoleLogger consoleLogger = new ConsoleLogger(LoggingBehavior.REQUESTS, "Request");
        HttpMethod httpMethod = accountKitGraphRequest.httpMethod;
        httpURLConnection.setRequestMethod(httpMethod.name());
        boolean zIsMultiPart = isMultiPart(accountKitGraphRequest.parameters);
        setConnectionContentType(httpURLConnection, zIsMultiPart);
        URL url = httpURLConnection.getURL();
        consoleLogger.appendLine("Request:");
        consoleLogger.appendKeyValue("AccessToken", accountKitGraphRequest.getAccessToken());
        consoleLogger.appendKeyValue("URL", url);
        consoleLogger.appendKeyValue("Method", httpURLConnection.getRequestMethod());
        consoleLogger.appendKeyValue(USER_AGENT_HEADER, httpURLConnection.getRequestProperty(USER_AGENT_HEADER));
        consoleLogger.appendKeyValue(HEADER_CONTENT_TYPE, httpURLConnection.getRequestProperty(HEADER_CONTENT_TYPE));
        consoleLogger.log();
        httpURLConnection.setConnectTimeout(DEFAULT_TIMEOUT_MILLISECONDS);
        httpURLConnection.setReadTimeout(DEFAULT_TIMEOUT_MILLISECONDS);
        if (httpMethod != HttpMethod.POST) {
            return;
        }
        httpURLConnection.setDoOutput(true);
        OutputStream bufferedOutputStream = null;
        try {
            OutputStream outputStream = httpURLConnection.getOutputStream();
            try {
                bufferedOutputStream = new BufferedOutputStream(outputStream);
                if (!zIsMultiPart) {
                    bufferedOutputStream = new GZIPOutputStream(bufferedOutputStream);
                }
                processRequest(accountKitGraphRequest, bufferedOutputStream, zIsMultiPart);
                if (bufferedOutputStream != null) {
                    bufferedOutputStream.close();
                }
            } catch (Throwable th) {
                th = th;
                bufferedOutputStream = outputStream;
                if (bufferedOutputStream != null) {
                    bufferedOutputStream.close();
                }
                throw th;
            }
        } catch (Throwable th2) {
            th = th2;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private static void setConnectionContentType(HttpURLConnection httpURLConnection, boolean z) {
        String str;
        String mimeContentType;
        if (z) {
            str = HEADER_CONTENT_TYPE;
            mimeContentType = getMimeContentType();
        } else {
            httpURLConnection.setRequestProperty(HEADER_CONTENT_TYPE, "application/x-www-form-urlencoded");
            str = HEADER_CONTENT_ENCODING;
            mimeContentType = "gzip";
        }
        httpURLConnection.setRequestProperty(str, mimeContentType);
    }

    static HttpURLConnection toHttpConnection(AccountKitGraphRequest accountKitGraphRequest) {
        try {
            try {
                HttpURLConnection httpURLConnectionCreateConnection = createConnection(new URL(accountKitGraphRequest.getUrlForSingleRequest()));
                serializeToUrlConnection(accountKitGraphRequest, httpURLConnectionCreateConnection);
                return httpURLConnectionCreateConnection;
            } catch (UnknownHostException unused) {
                throw new AccountKitException(AccountKitError.Type.NETWORK_CONNECTION_ERROR, InternalAccountKitError.NO_NETWORK_CONNECTION);
            } catch (IOException | JSONException e) {
                throw new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, InternalAccountKitError.CANNOT_CONSTRUCT_MESSAGE_BODY, e);
            }
        } catch (MalformedURLException e2) {
            throw new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, InternalAccountKitError.CANNOT_CONSTRUCT_URL, e2);
        }
    }

    AccountKitGraphResponse executeAndWait() {
        try {
            TrafficStats.setThreadStatsTag(SOCKET_TAG);
            AccountKitGraphResponse accountKitGraphResponseExecuteConnectionAndWait = executeConnectionAndWait(toHttpConnection(this), this);
            if (accountKitGraphResponseExecuteConnectionAndWait == null) {
                throw new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, InternalAccountKitError.INVALID_GRAPH_RESPONSE);
            }
            return accountKitGraphResponseExecuteConnectionAndWait;
        } catch (AccountKitException e) {
            return new AccountKitGraphResponse(this, null, new AccountKitRequestError(e));
        } catch (Exception e2) {
            return new AccountKitGraphResponse(this, null, new AccountKitRequestError(new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, e2)));
        }
    }

    public AccessToken getAccessToken() {
        return this.accessToken;
    }

    Handler getCallbackHandler() {
        return this.callbackHandler;
    }

    String getGraphPath() {
        return this.graphPath;
    }

    HttpMethod getHttpMethod() {
        return this.httpMethod;
    }

    public Bundle getParameters() {
        return this.parameters;
    }

    JSONObject getRequestObject() {
        return this.requestObject;
    }

    public Object getTag() {
        return this.tag;
    }

    public String getVersion() {
        return this.version;
    }

    boolean isLoginRequest() {
        return this.isLoginRequest;
    }

    public void setAccessToken(AccessToken accessToken) {
        this.accessToken = accessToken;
    }

    void setCallbackHandler(Handler handler) {
        this.callbackHandler = handler;
    }

    void setHttpMethod(HttpMethod httpMethod) {
        if (httpMethod == null) {
            httpMethod = HttpMethod.GET;
        }
        this.httpMethod = httpMethod;
    }

    public void setParameters(Bundle bundle) {
        this.parameters = bundle;
    }

    void setRequestObject(JSONObject jSONObject) {
        this.requestObject = jSONObject;
    }

    public void setTag(Object obj) {
        this.tag = obj;
    }

    public void setVersion(String str) {
        this.version = str;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("{Request:  accessToken: ");
        sb.append(this.accessToken == null ? "null" : this.accessToken);
        sb.append(", graphPath: ");
        sb.append(this.graphPath);
        sb.append(", requestObject: ");
        sb.append(this.requestObject);
        sb.append(", httpMethod: ");
        sb.append(this.httpMethod);
        sb.append(", parameters: ");
        sb.append(this.parameters);
        sb.append("}");
        return sb.toString();
    }
}
