package com.facebook.internal;

import android.graphics.Bitmap;
import android.net.Uri;
import android.util.Log;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.UUID;

/* JADX INFO: loaded from: classes.dex */
public final class NativeAppCallAttachmentStore {
    static final String ATTACHMENTS_DIR_NAME = "com.facebook.NativeAppCallAttachmentStore.files";
    private static final String TAG = "com.facebook.internal.NativeAppCallAttachmentStore";
    private static File attachmentsDirectory;

    public static final class Attachment {
        private final String attachmentName;
        private final String attachmentUrl;
        private Bitmap bitmap;
        private final UUID callId;
        private boolean isContentUri;
        private Uri originalUri;
        private boolean shouldCreateFile;

        /* JADX WARN: Removed duplicated region for block: B:23:0x0061  */
        /* JADX WARN: Removed duplicated region for block: B:24:0x0063  */
        /* JADX WARN: Removed duplicated region for block: B:27:0x0071  */
        /* JADX WARN: Removed duplicated region for block: B:28:0x0078  */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        private Attachment(java.util.UUID r4, android.graphics.Bitmap r5, android.net.Uri r6) {
            /*
                r3 = this;
                r3.<init>()
                r3.callId = r4
                r3.bitmap = r5
                r3.originalUri = r6
                r0 = 1
                if (r6 == 0) goto L59
                java.lang.String r5 = r6.getScheme()
                java.lang.String r1 = "content"
                boolean r1 = r1.equalsIgnoreCase(r5)
                if (r1 == 0) goto L2f
                r3.isContentUri = r0
                java.lang.String r5 = r6.getAuthority()
                if (r5 == 0) goto L2d
                java.lang.String r5 = r6.getAuthority()
                java.lang.String r6 = "media"
                boolean r5 = r5.startsWith(r6)
                if (r5 != 0) goto L2d
                goto L5b
            L2d:
                r0 = 0
                goto L5b
            L2f:
                java.lang.String r1 = "file"
                java.lang.String r2 = r6.getScheme()
                boolean r1 = r1.equalsIgnoreCase(r2)
                if (r1 == 0) goto L3c
                goto L5b
            L3c:
                boolean r6 = com.facebook.internal.Utility.isWebUri(r6)
                if (r6 != 0) goto L5d
                com.facebook.FacebookException r4 = new com.facebook.FacebookException
                java.lang.StringBuilder r6 = new java.lang.StringBuilder
                r6.<init>()
                java.lang.String r0 = "Unsupported scheme for media Uri : "
                r6.append(r0)
                r6.append(r5)
                java.lang.String r5 = r6.toString()
                r4.<init>(r5)
                throw r4
            L59:
                if (r5 == 0) goto L85
            L5b:
                r3.shouldCreateFile = r0
            L5d:
                boolean r5 = r3.shouldCreateFile
                if (r5 != 0) goto L63
                r5 = 0
                goto L6b
            L63:
                java.util.UUID r5 = java.util.UUID.randomUUID()
                java.lang.String r5 = r5.toString()
            L6b:
                r3.attachmentName = r5
                boolean r5 = r3.shouldCreateFile
                if (r5 != 0) goto L78
                android.net.Uri r4 = r3.originalUri
                java.lang.String r4 = r4.toString()
                goto L82
            L78:
                java.lang.String r5 = com.facebook.FacebookSdk.getApplicationId()
                java.lang.String r6 = r3.attachmentName
                java.lang.String r4 = com.facebook.FacebookContentProvider.getAttachmentUrl(r5, r4, r6)
            L82:
                r3.attachmentUrl = r4
                return
            L85:
                com.facebook.FacebookException r4 = new com.facebook.FacebookException
                java.lang.String r5 = "Cannot share media without a bitmap or Uri set"
                r4.<init>(r5)
                throw r4
            */
            throw new UnsupportedOperationException("Method not decompiled: com.facebook.internal.NativeAppCallAttachmentStore.Attachment.<init>(java.util.UUID, android.graphics.Bitmap, android.net.Uri):void");
        }

        public String getAttachmentUrl() {
            return this.attachmentUrl;
        }
    }

    private NativeAppCallAttachmentStore() {
    }

    public static void addAttachments(Collection<Attachment> collection) {
        if (collection == null || collection.size() == 0) {
            return;
        }
        if (attachmentsDirectory == null) {
            cleanupAllAttachments();
        }
        ensureAttachmentsDirectoryExists();
        ArrayList arrayList = new ArrayList();
        try {
            for (Attachment attachment : collection) {
                if (attachment.shouldCreateFile) {
                    File attachmentFile = getAttachmentFile(attachment.callId, attachment.attachmentName, true);
                    arrayList.add(attachmentFile);
                    if (attachment.bitmap != null) {
                        processAttachmentBitmap(attachment.bitmap, attachmentFile);
                    } else if (attachment.originalUri != null) {
                        processAttachmentFile(attachment.originalUri, attachment.isContentUri, attachmentFile);
                    }
                }
            }
        } catch (IOException e) {
            Log.e(TAG, "Got unexpected exception:" + e);
            Iterator it2 = arrayList.iterator();
            while (it2.hasNext()) {
                try {
                    ((File) it2.next()).delete();
                } catch (Exception unused) {
                }
            }
            throw new FacebookException(e);
        }
    }

    public static void cleanupAllAttachments() {
        Utility.deleteDirectory(getAttachmentsDirectory());
    }

    public static void cleanupAttachmentsForCall(UUID uuid) {
        File attachmentsDirectoryForCall = getAttachmentsDirectoryForCall(uuid, false);
        if (attachmentsDirectoryForCall != null) {
            Utility.deleteDirectory(attachmentsDirectoryForCall);
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    public static Attachment createAttachment(UUID uuid, Bitmap bitmap) {
        Validate.notNull(uuid, "callId");
        Validate.notNull(bitmap, "attachmentBitmap");
        return new Attachment(uuid, bitmap, null);
    }

    /* JADX WARN: Multi-variable type inference failed */
    public static Attachment createAttachment(UUID uuid, Uri uri) {
        Validate.notNull(uuid, "callId");
        Validate.notNull(uri, "attachmentUri");
        return new Attachment(uuid, null, uri);
    }

    static File ensureAttachmentsDirectoryExists() {
        File attachmentsDirectory2 = getAttachmentsDirectory();
        attachmentsDirectory2.mkdirs();
        return attachmentsDirectory2;
    }

    static File getAttachmentFile(UUID uuid, String str, boolean z) {
        File attachmentsDirectoryForCall = getAttachmentsDirectoryForCall(uuid, z);
        if (attachmentsDirectoryForCall == null) {
            return null;
        }
        try {
            return new File(attachmentsDirectoryForCall, URLEncoder.encode(str, "UTF-8"));
        } catch (UnsupportedEncodingException unused) {
            return null;
        }
    }

    static synchronized File getAttachmentsDirectory() {
        if (attachmentsDirectory == null) {
            attachmentsDirectory = new File(FacebookSdk.getApplicationContext().getCacheDir(), ATTACHMENTS_DIR_NAME);
        }
        return attachmentsDirectory;
    }

    static File getAttachmentsDirectoryForCall(UUID uuid, boolean z) {
        if (attachmentsDirectory == null) {
            return null;
        }
        File file = new File(attachmentsDirectory, uuid.toString());
        if (z && !file.exists()) {
            file.mkdirs();
        }
        return file;
    }

    public static File openAttachment(UUID uuid, String str) {
        if (Utility.isNullOrEmpty(str) || uuid == null) {
            throw new FileNotFoundException();
        }
        try {
            return getAttachmentFile(uuid, str, false);
        } catch (IOException unused) {
            throw new FileNotFoundException();
        }
    }

    private static void processAttachmentBitmap(Bitmap bitmap, File file) {
        FileOutputStream fileOutputStream = new FileOutputStream(file);
        try {
            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fileOutputStream);
        } finally {
            Utility.closeQuietly(fileOutputStream);
        }
    }

    private static void processAttachmentFile(Uri uri, boolean z, File file) {
        FileOutputStream fileOutputStream = new FileOutputStream(file);
        try {
            Utility.copyAndCloseInputStream(!z ? new FileInputStream(uri.getPath()) : FacebookSdk.getApplicationContext().getContentResolver().openInputStream(uri), fileOutputStream);
            Utility.closeQuietly(fileOutputStream);
        } catch (Throwable th) {
            Utility.closeQuietly(fileOutputStream);
            throw th;
        }
    }
}
