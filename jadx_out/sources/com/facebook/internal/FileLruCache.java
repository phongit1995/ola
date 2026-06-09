package com.facebook.internal;

import com.facebook.FacebookSdk;
import com.facebook.LoggingBehavior;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.InvalidParameterException;
import java.util.Date;
import java.util.PriorityQueue;
import java.util.concurrent.atomic.AtomicLong;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

/* JADX INFO: loaded from: classes.dex */
public final class FileLruCache {
    private static final String HEADER_CACHEKEY_KEY = "key";
    private static final String HEADER_CACHE_CONTENT_TAG_KEY = "tag";
    static final String TAG = "FileLruCache";
    private static final AtomicLong bufferIndex = new AtomicLong();
    private final File directory;
    private boolean isTrimInProgress;
    private boolean isTrimPending;
    private final Limits limits;
    private final String tag;
    private AtomicLong lastClearCacheTime = new AtomicLong(0);
    private final Object lock = new Object();

    private static class BufferFile {
        private static final String FILE_NAME_PREFIX = "buffer";
        private static final FilenameFilter filterExcludeBufferFiles = new FilenameFilter() { // from class: com.facebook.internal.FileLruCache.BufferFile.1
            @Override // java.io.FilenameFilter
            public boolean accept(File file, String str) {
                return !str.startsWith(BufferFile.FILE_NAME_PREFIX);
            }
        };
        private static final FilenameFilter filterExcludeNonBufferFiles = new FilenameFilter() { // from class: com.facebook.internal.FileLruCache.BufferFile.2
            @Override // java.io.FilenameFilter
            public boolean accept(File file, String str) {
                return str.startsWith(BufferFile.FILE_NAME_PREFIX);
            }
        };

        private BufferFile() {
        }

        static void deleteAll(File file) {
            File[] fileArrListFiles = file.listFiles(excludeNonBufferFiles());
            if (fileArrListFiles != null) {
                for (File file2 : fileArrListFiles) {
                    file2.delete();
                }
            }
        }

        static FilenameFilter excludeBufferFiles() {
            return filterExcludeBufferFiles;
        }

        static FilenameFilter excludeNonBufferFiles() {
            return filterExcludeNonBufferFiles;
        }

        static File newFile(File file) {
            return new File(file, FILE_NAME_PREFIX + Long.valueOf(FileLruCache.bufferIndex.incrementAndGet()).toString());
        }
    }

    private static class CloseCallbackOutputStream extends OutputStream {
        final StreamCloseCallback callback;
        final OutputStream innerStream;

        CloseCallbackOutputStream(OutputStream outputStream, StreamCloseCallback streamCloseCallback) {
            this.innerStream = outputStream;
            this.callback = streamCloseCallback;
        }

        @Override // java.io.OutputStream, java.io.Closeable, java.lang.AutoCloseable
        public void close() {
            try {
                this.innerStream.close();
            } finally {
                this.callback.onClose();
            }
        }

        @Override // java.io.OutputStream, java.io.Flushable
        public void flush() throws IOException {
            this.innerStream.flush();
        }

        @Override // java.io.OutputStream
        public void write(int i) throws IOException {
            this.innerStream.write(i);
        }

        @Override // java.io.OutputStream
        public void write(byte[] bArr) throws IOException {
            this.innerStream.write(bArr);
        }

        @Override // java.io.OutputStream
        public void write(byte[] bArr, int i, int i2) throws IOException {
            this.innerStream.write(bArr, i, i2);
        }
    }

    private static final class CopyingInputStream extends InputStream {
        final InputStream input;
        final OutputStream output;

        CopyingInputStream(InputStream inputStream, OutputStream outputStream) {
            this.input = inputStream;
            this.output = outputStream;
        }

        @Override // java.io.InputStream
        public int available() {
            return this.input.available();
        }

        @Override // java.io.InputStream, java.io.Closeable, java.lang.AutoCloseable
        public void close() throws IOException {
            try {
                this.input.close();
            } finally {
                this.output.close();
            }
        }

        @Override // java.io.InputStream
        public void mark(int i) {
            throw new UnsupportedOperationException();
        }

        @Override // java.io.InputStream
        public boolean markSupported() {
            return false;
        }

        @Override // java.io.InputStream
        public int read() throws IOException {
            int i = this.input.read();
            if (i >= 0) {
                this.output.write(i);
            }
            return i;
        }

        @Override // java.io.InputStream
        public int read(byte[] bArr) throws IOException {
            int i = this.input.read(bArr);
            if (i > 0) {
                this.output.write(bArr, 0, i);
            }
            return i;
        }

        @Override // java.io.InputStream
        public int read(byte[] bArr, int i, int i2) throws IOException {
            int i3 = this.input.read(bArr, i, i2);
            if (i3 > 0) {
                this.output.write(bArr, i, i3);
            }
            return i3;
        }

        @Override // java.io.InputStream
        public synchronized void reset() {
            throw new UnsupportedOperationException();
        }

        @Override // java.io.InputStream
        public long skip(long j) {
            int i;
            byte[] bArr = new byte[1024];
            long j2 = 0;
            while (j2 < j && (i = read(bArr, 0, (int) Math.min(j - j2, bArr.length))) >= 0) {
                j2 += (long) i;
            }
            return j2;
        }
    }

    public static final class Limits {
        private int fileCount = 1024;
        private int byteCount = 1048576;

        int getByteCount() {
            return this.byteCount;
        }

        int getFileCount() {
            return this.fileCount;
        }

        void setByteCount(int i) {
            if (i < 0) {
                throw new InvalidParameterException("Cache byte-count limit must be >= 0");
            }
            this.byteCount = i;
        }

        void setFileCount(int i) {
            if (i < 0) {
                throw new InvalidParameterException("Cache file count limit must be >= 0");
            }
            this.fileCount = i;
        }
    }

    private static final class ModifiedFile implements Comparable<ModifiedFile> {
        private static final int HASH_MULTIPLIER = 37;
        private static final int HASH_SEED = 29;
        private final File file;
        private final long modified;

        ModifiedFile(File file) {
            this.file = file;
            this.modified = file.lastModified();
        }

        @Override // java.lang.Comparable
        public int compareTo(ModifiedFile modifiedFile) {
            if (getModified() < modifiedFile.getModified()) {
                return -1;
            }
            if (getModified() > modifiedFile.getModified()) {
                return 1;
            }
            return getFile().compareTo(modifiedFile.getFile());
        }

        public boolean equals(Object obj) {
            return (obj instanceof ModifiedFile) && compareTo((ModifiedFile) obj) == 0;
        }

        File getFile() {
            return this.file;
        }

        long getModified() {
            return this.modified;
        }

        public int hashCode() {
            return ((1073 + this.file.hashCode()) * 37) + ((int) (this.modified % 2147483647L));
        }
    }

    private interface StreamCloseCallback {
        void onClose();
    }

    private static final class StreamHeader {
        private static final int HEADER_VERSION = 0;

        private StreamHeader() {
        }

        static JSONObject readHeader(InputStream inputStream) throws IOException {
            if (inputStream.read() != 0) {
                return null;
            }
            int i = 0;
            int i2 = 0;
            for (int i3 = 0; i3 < 3; i3++) {
                int i4 = inputStream.read();
                if (i4 == -1) {
                    Logger.log(LoggingBehavior.CACHE, FileLruCache.TAG, "readHeader: stream.read returned -1 while reading header size");
                    return null;
                }
                i2 = (i2 << 8) + (i4 & 255);
            }
            byte[] bArr = new byte[i2];
            while (i < bArr.length) {
                int i5 = inputStream.read(bArr, i, bArr.length - i);
                if (i5 < 1) {
                    Logger.log(LoggingBehavior.CACHE, FileLruCache.TAG, "readHeader: stream.read stopped at " + Integer.valueOf(i) + " when expected " + bArr.length);
                    return null;
                }
                i += i5;
            }
            try {
                Object objNextValue = new JSONTokener(new String(bArr)).nextValue();
                if (objNextValue instanceof JSONObject) {
                    return (JSONObject) objNextValue;
                }
                Logger.log(LoggingBehavior.CACHE, FileLruCache.TAG, "readHeader: expected JSONObject, got " + objNextValue.getClass().getCanonicalName());
                return null;
            } catch (JSONException e) {
                throw new IOException(e.getMessage());
            }
        }

        static void writeHeader(OutputStream outputStream, JSONObject jSONObject) throws IOException {
            byte[] bytes = jSONObject.toString().getBytes();
            outputStream.write(0);
            outputStream.write((bytes.length >> 16) & 255);
            outputStream.write((bytes.length >> 8) & 255);
            outputStream.write((bytes.length >> 0) & 255);
            outputStream.write(bytes);
        }
    }

    public FileLruCache(String str, Limits limits) {
        this.tag = str;
        this.limits = limits;
        this.directory = new File(FacebookSdk.getCacheDir(), str);
        if (this.directory.mkdirs() || this.directory.isDirectory()) {
            BufferFile.deleteAll(this.directory);
        }
    }

    private void postTrim() {
        synchronized (this.lock) {
            if (!this.isTrimPending) {
                this.isTrimPending = true;
                FacebookSdk.getExecutor().execute(new Runnable() { // from class: com.facebook.internal.FileLruCache.3
                    @Override // java.lang.Runnable
                    public void run() throws Throwable {
                        FileLruCache.this.trim();
                    }
                });
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void renameToTargetAndTrim(String str, File file) {
        if (!file.renameTo(new File(this.directory, Utility.md5hash(str)))) {
            file.delete();
        }
        postTrim();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void trim() throws Throwable {
        Throwable th;
        PriorityQueue priorityQueue;
        long j;
        FileLruCache fileLruCache = this;
        synchronized (fileLruCache.lock) {
            fileLruCache.isTrimPending = false;
            fileLruCache.isTrimInProgress = true;
        }
        try {
            Logger.log(LoggingBehavior.CACHE, TAG, "trim started");
            PriorityQueue priorityQueue2 = new PriorityQueue();
            File[] fileArrListFiles = fileLruCache.directory.listFiles(BufferFile.excludeBufferFiles());
            long j2 = 0;
            if (fileArrListFiles != null) {
                int length = fileArrListFiles.length;
                long length2 = 0;
                j = 0;
                int i = 0;
                while (i < length) {
                    File file = fileArrListFiles[i];
                    ModifiedFile modifiedFile = new ModifiedFile(file);
                    priorityQueue2.add(modifiedFile);
                    LoggingBehavior loggingBehavior = LoggingBehavior.CACHE;
                    String str = TAG;
                    StringBuilder sb = new StringBuilder();
                    sb.append("  trim considering time=");
                    PriorityQueue priorityQueue3 = priorityQueue2;
                    try {
                        sb.append(Long.valueOf(modifiedFile.getModified()));
                        sb.append(" name=");
                        sb.append(modifiedFile.getFile().getName());
                        Logger.log(loggingBehavior, str, sb.toString());
                        i++;
                        j++;
                        priorityQueue2 = priorityQueue3;
                        fileLruCache = this;
                        length2 += file.length();
                    } catch (Throwable th2) {
                        th = th2;
                        fileLruCache = this;
                        synchronized (fileLruCache.lock) {
                            fileLruCache.isTrimInProgress = false;
                            fileLruCache.lock.notifyAll();
                        }
                        throw th;
                    }
                }
                priorityQueue = priorityQueue2;
                j2 = length2;
            } else {
                priorityQueue = priorityQueue2;
                j = 0;
            }
            while (true) {
                if (j2 <= fileLruCache.limits.getByteCount() && j <= fileLruCache.limits.getFileCount()) {
                    synchronized (fileLruCache.lock) {
                        fileLruCache.isTrimInProgress = false;
                        fileLruCache.lock.notifyAll();
                    }
                    return;
                }
                PriorityQueue priorityQueue4 = priorityQueue;
                File file2 = ((ModifiedFile) priorityQueue4.remove()).getFile();
                Logger.log(LoggingBehavior.CACHE, TAG, "  trim removing " + file2.getName());
                long length3 = j2 - file2.length();
                long j3 = j - 1;
                file2.delete();
                priorityQueue = priorityQueue4;
                j = j3;
                j2 = length3;
            }
        } catch (Throwable th3) {
            th = th3;
        }
    }

    public void clearCache() {
        final File[] fileArrListFiles = this.directory.listFiles(BufferFile.excludeBufferFiles());
        this.lastClearCacheTime.set(System.currentTimeMillis());
        if (fileArrListFiles != null) {
            FacebookSdk.getExecutor().execute(new Runnable() { // from class: com.facebook.internal.FileLruCache.2
                @Override // java.lang.Runnable
                public void run() {
                    for (File file : fileArrListFiles) {
                        file.delete();
                    }
                }
            });
        }
    }

    public InputStream get(String str) {
        return get(str, null);
    }

    public InputStream get(String str, String str2) throws IOException {
        File file = new File(this.directory, Utility.md5hash(str));
        try {
            BufferedInputStream bufferedInputStream = new BufferedInputStream(new FileInputStream(file), 8192);
            try {
                JSONObject header = StreamHeader.readHeader(bufferedInputStream);
                if (header == null) {
                    return null;
                }
                String strOptString = header.optString(HEADER_CACHEKEY_KEY);
                if (strOptString != null && strOptString.equals(str)) {
                    String strOptString2 = header.optString(HEADER_CACHE_CONTENT_TAG_KEY, null);
                    if ((str2 == null && strOptString2 != null) || (str2 != null && !str2.equals(strOptString2))) {
                        return null;
                    }
                    long time = new Date().getTime();
                    Logger.log(LoggingBehavior.CACHE, TAG, "Setting lastModified to " + Long.valueOf(time) + " for " + file.getName());
                    file.setLastModified(time);
                    return bufferedInputStream;
                }
                return null;
            } finally {
                bufferedInputStream.close();
            }
        } catch (IOException unused) {
            return null;
        }
    }

    public String getLocation() {
        return this.directory.getPath();
    }

    public InputStream interceptAndPut(String str, InputStream inputStream) {
        return new CopyingInputStream(inputStream, openPutStream(str));
    }

    public OutputStream openPutStream(String str) {
        return openPutStream(str, null);
    }

    public OutputStream openPutStream(final String str, String str2) throws IOException {
        final File fileNewFile = BufferFile.newFile(this.directory);
        fileNewFile.delete();
        if (!fileNewFile.createNewFile()) {
            throw new IOException("Could not create file at " + fileNewFile.getAbsolutePath());
        }
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(fileNewFile);
            final long jCurrentTimeMillis = System.currentTimeMillis();
            BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(new CloseCallbackOutputStream(fileOutputStream, new StreamCloseCallback() { // from class: com.facebook.internal.FileLruCache.1
                @Override // com.facebook.internal.FileLruCache.StreamCloseCallback
                public void onClose() {
                    if (jCurrentTimeMillis < FileLruCache.this.lastClearCacheTime.get()) {
                        fileNewFile.delete();
                    } else {
                        FileLruCache.this.renameToTargetAndTrim(str, fileNewFile);
                    }
                }
            }), 8192);
            try {
                try {
                    JSONObject jSONObject = new JSONObject();
                    jSONObject.put(HEADER_CACHEKEY_KEY, str);
                    if (!Utility.isNullOrEmpty(str2)) {
                        jSONObject.put(HEADER_CACHE_CONTENT_TAG_KEY, str2);
                    }
                    StreamHeader.writeHeader(bufferedOutputStream, jSONObject);
                    return bufferedOutputStream;
                } catch (JSONException e) {
                    Logger.log(LoggingBehavior.CACHE, 5, TAG, "Error creating JSON header for cache file: " + e);
                    throw new IOException(e.getMessage());
                }
            } catch (Throwable th) {
                bufferedOutputStream.close();
                throw th;
            }
        } catch (FileNotFoundException e2) {
            Logger.log(LoggingBehavior.CACHE, 5, TAG, "Error creating buffer output stream: " + e2);
            throw new IOException(e2.getMessage());
        }
    }

    long sizeInBytesForTest() {
        synchronized (this.lock) {
            while (true) {
                if (!this.isTrimPending && !this.isTrimInProgress) {
                    break;
                }
                try {
                    this.lock.wait();
                } catch (InterruptedException unused) {
                }
            }
        }
        File[] fileArrListFiles = this.directory.listFiles();
        long j = 0;
        if (fileArrListFiles != null) {
            int length = fileArrListFiles.length;
            int i = 0;
            while (i < length) {
                long length2 = j + fileArrListFiles[i].length();
                i++;
                j = length2;
            }
        }
        return j;
    }

    public String toString() {
        return "{FileLruCache: tag:" + this.tag + " file:" + this.directory.getName() + "}";
    }
}
