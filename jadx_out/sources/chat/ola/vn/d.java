package chat.ola.vn;

import android.annotation.SuppressLint;
import android.media.ExifInterface;
import android.os.AsyncTask;
import android.os.Environment;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class d implements chat.ola.vn.f.a {
    public static final String a = OlaApplication.a + "_temp";
    public static final String b = OlaApplication.a;
    public static final String c = OlaApplication.a + "Camera";
    public static final String d = OlaApplication.a + "Photo";
    public static final String e = OlaApplication.a + "Sound";
    public static final String f = "." + OlaApplication.a + "Voice";
    public static final String g;
    public static final String h;

    static {
        StringBuilder sb = new StringBuilder();
        sb.append(OlaApplication.a);
        sb.append("Video");
        g = sb.toString();
        h = OlaApplication.a + "YouTube";
    }

    public static File a(String str) {
        if (m.a(str)) {
            return null;
        }
        File file = new File(j(), "." + str.toLowerCase());
        if (!file.exists()) {
            file.mkdir();
        }
        return file;
    }

    public static String a() {
        File file = new File(e() + "/.temp");
        if (!file.exists()) {
            file.mkdirs();
        }
        return file.getAbsolutePath();
    }

    public static String a(long j) {
        return g() + "/" + o.a("Ocam" + System.currentTimeMillis() + ".jpg", j);
    }

    public static String a(String str, String str2) {
        String str3 = k() + "/" + h;
        String strA = chat.ola.vn.j.a.a(str);
        try {
            if (strA.length() > 10) {
                strA = strA.substring(strA.length() - 10);
            }
            File[] fileArrListFiles = new File(str3).listFiles();
            if (fileArrListFiles != null && fileArrListFiles.length > 0) {
                for (File file : fileArrListFiles) {
                    if (file.isFile() && com.mg.ola.common.d.d.a(file.getAbsolutePath()).endsWith(strA)) {
                        return file.getAbsolutePath();
                    }
                }
            }
        } catch (Throwable unused) {
        }
        return str3 + "/" + strA + "." + str2;
    }

    /* JADX WARN: Removed duplicated region for block: B:11:0x004b  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static java.lang.String a(short r2) {
        /*
            java.lang.StringBuilder r0 = new java.lang.StringBuilder
            r0.<init>()
            java.lang.String r1 = k()
            r0.append(r1)
            java.lang.String r1 = "/"
            r0.append(r1)
            java.lang.String r0 = r0.toString()
            switch(r2) {
                case 1: goto L2f;
                case 2: goto L24;
                case 3: goto L19;
                default: goto L18;
            }
        L18:
            goto L40
        L19:
            java.lang.StringBuilder r2 = new java.lang.StringBuilder
            r2.<init>()
            r2.append(r0)
            java.lang.String r0 = chat.ola.vn.d.e
            goto L39
        L24:
            java.lang.StringBuilder r2 = new java.lang.StringBuilder
            r2.<init>()
            r2.append(r0)
            java.lang.String r0 = chat.ola.vn.d.g
            goto L39
        L2f:
            java.lang.StringBuilder r2 = new java.lang.StringBuilder
            r2.<init>()
            r2.append(r0)
            java.lang.String r0 = chat.ola.vn.d.d
        L39:
            r2.append(r0)
            java.lang.String r0 = r2.toString()
        L40:
            java.io.File r2 = new java.io.File
            r2.<init>(r0)
            boolean r0 = r2.exists()
            if (r0 != 0) goto L4e
            r2.mkdirs()
        L4e:
            java.lang.String r2 = r2.getAbsolutePath()
            return r2
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.d.a(short):java.lang.String");
    }

    private static void a(List<String> list, File file) {
        try {
            if (file.exists()) {
                File file2 = new File(file, "Download");
                if (file2.exists()) {
                    list.add(file2.getAbsolutePath());
                }
                File file3 = new File(file, "Downloads");
                if (file3.exists()) {
                    list.add(file3.getAbsolutePath());
                }
                File file4 = new File(file, "download");
                if (file4.exists()) {
                    list.add(file4.getAbsolutePath());
                }
                File file5 = new File(file, "downloads");
                if (file5.exists()) {
                    list.add(file5.getAbsolutePath());
                }
            }
        } catch (Throwable unused) {
        }
    }

    public static File b(String str) {
        File file = new File(a(str), ".draft");
        if (!file.exists()) {
            file.mkdir();
        }
        return file;
    }

    public static File b(String str, String str2) {
        return new File(a(o.g(str)) + "/" + str + "." + str2);
    }

    public static List<String> b() {
        try {
            LinkedList linkedList = new LinkedList();
            String absolutePath = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM).getAbsolutePath();
            if (com.mg.ola.common.d.c.b(absolutePath)) {
                linkedList.add(absolutePath);
            }
            Map<String, File> mapN = n();
            c(linkedList, mapN.get("sdCard"));
            c(linkedList, mapN.get("externalSdCard"));
            c(linkedList, new File("storage/MicroSD/"));
            c(linkedList, new File("storage/extSdCard/"));
            if (linkedList.size() > 0) {
                return linkedList;
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    private static void b(List<String> list, File file) {
        try {
            if (file.exists()) {
                File file2 = new File(file, "Pictures");
                if (file2.exists()) {
                    list.add(file2.getAbsolutePath());
                }
                File file3 = new File(file, "Picture");
                if (file3.exists()) {
                    list.add(file3.getAbsolutePath());
                }
                File file4 = new File(file, "pictures");
                if (file4.exists()) {
                    list.add(file4.getAbsolutePath());
                }
                File file5 = new File(file, "picture");
                if (file5.exists()) {
                    list.add(file5.getAbsolutePath());
                }
            }
        } catch (Throwable unused) {
        }
    }

    public static File c(String str) {
        File file = new File(b(str), ".album");
        if (!file.exists()) {
            file.mkdir();
        }
        return file;
    }

    public static List<String> c() {
        try {
            LinkedList linkedList = new LinkedList();
            String absolutePath = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).getAbsolutePath();
            if (com.mg.ola.common.d.c.b(absolutePath)) {
                linkedList.add(absolutePath);
            }
            Map<String, File> mapN = n();
            a(linkedList, mapN.get("sdCard"));
            a(linkedList, mapN.get("externalSdCard"));
            a(linkedList, new File("storage/MicroSD/"));
            a(linkedList, new File("storage/extSdCard/"));
            if (linkedList.size() > 0) {
                return linkedList;
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static void c(String str, String str2) {
        try {
            if (m.a(str2) || !com.mg.ola.common.d.c.a(str2)) {
                return;
            }
            OlaNetworkService.E(str2);
            ExifInterface exifInterface = new ExifInterface(str2);
            if (m.a(str)) {
                exifInterface.setAttribute("Model", "");
            } else {
                exifInterface.setAttribute("Model", "Ocam" + str);
            }
            exifInterface.saveAttributes();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private static void c(List<String> list, File file) {
        try {
            if (file.exists()) {
                File file2 = new File(file, "DCIM");
                if (file2.exists()) {
                    list.add(file2.getAbsolutePath());
                }
                File file3 = new File(file, "Camera");
                if (file3.exists()) {
                    list.add(file3.getAbsolutePath());
                }
                File file4 = new File(file, "100ANDRO");
                if (file4.exists()) {
                    list.add(file4.getAbsolutePath());
                }
                File file5 = new File(file, "100MEDIA");
                if (file5.exists()) {
                    list.add(file5.getAbsolutePath());
                }
            }
        } catch (Throwable unused) {
        }
    }

    public static File d(String str) {
        File file = new File(b(str), ".note");
        if (!file.exists()) {
            file.mkdir();
        }
        return file;
    }

    public static List<String> d() {
        try {
            LinkedList linkedList = new LinkedList();
            String absolutePath = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).getAbsolutePath();
            if (com.mg.ola.common.d.c.b(absolutePath)) {
                linkedList.add(absolutePath);
            }
            Map<String, File> mapN = n();
            b(linkedList, mapN.get("sdCard"));
            b(linkedList, mapN.get("externalSdCard"));
            b(linkedList, new File("storage/MicroSD/"));
            b(linkedList, new File("storage/extSdCard/"));
            if (linkedList.size() > 0) {
                return linkedList;
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static File e(String str) {
        File file = new File(a(str, "mp4"));
        if (file.exists()) {
            return file;
        }
        File file2 = new File(a(str, "3gp"));
        if (file2.exists()) {
            return file2;
        }
        File file3 = new File(a(str, "flv"));
        if (file3.exists()) {
            return file3;
        }
        File file4 = new File(a(str, "webm"));
        if (file4.exists()) {
            return file4;
        }
        return null;
    }

    public static String e() {
        File externalStorageDirectory = Environment.getExternalStorageDirectory();
        if (!externalStorageDirectory.exists()) {
            externalStorageDirectory = Environment.getDataDirectory();
        }
        if (!externalStorageDirectory.exists()) {
            externalStorageDirectory = Environment.getRootDirectory();
        }
        File file = new File(externalStorageDirectory, b);
        if (!file.exists()) {
            file.mkdir();
        }
        return file.getAbsolutePath();
    }

    public static File f() {
        File file = new File(Environment.getExternalStorageDirectory(), b);
        if (!file.exists()) {
            file.mkdir();
        }
        return file;
    }

    public static String f(String str) {
        String attribute;
        try {
            if (m.a(str) || !com.mg.ola.common.d.c.a(str) || (attribute = new ExifInterface(str).getAttribute("Model")) == null || !attribute.startsWith("Ocam") || attribute.length() <= "Ocam".length()) {
                return null;
            }
            return attribute.substring("Ocam".length());
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public static String g() {
        File file = new File(k() + "/" + c);
        if (!file.exists()) {
            file.mkdirs();
        }
        return file.getAbsolutePath();
    }

    public static void g(String str) {
        try {
            if (m.a(str) || !com.mg.ola.common.d.c.a(str)) {
                return;
            }
            OlaNetworkService.E(str);
            ExifInterface exifInterface = new ExifInterface(str);
            exifInterface.setAttribute("Model", "");
            exifInterface.saveAttributes();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX WARN: Type inference failed for: r0v0, types: [chat.ola.vn.d$1] */
    public static void h() {
        try {
            new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.d.1
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    try {
                        File[] fileArrListFiles = d.c(h.a()).listFiles();
                        if (fileArrListFiles == null || fileArrListFiles.length <= 0) {
                            return null;
                        }
                        for (File file : fileArrListFiles) {
                            try {
                                if (file.exists()) {
                                    if (file.length() == 0) {
                                        file.delete();
                                    } else {
                                        String absolutePath = file.getAbsolutePath();
                                        String strB = com.mg.ola.common.d.d.b(absolutePath);
                                        String strSubstring = absolutePath.substring(0, absolutePath.length() - strB.length());
                                        if (strB.startsWith(".temp")) {
                                            file.renameTo(new File(strSubstring + strB.replace(".temp", ".archived")));
                                        }
                                    }
                                }
                            } catch (Throwable unused) {
                            }
                        }
                        return null;
                    } catch (Throwable unused2) {
                        return null;
                    }
                }
            }.execute(new Void[0]);
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Type inference failed for: r0v0, types: [chat.ola.vn.d$2] */
    public static void i() {
        try {
            new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.d.2
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    try {
                        File[] fileArrListFiles = d.d(h.a()).listFiles();
                        if (fileArrListFiles == null || fileArrListFiles.length <= 0) {
                            return null;
                        }
                        for (File file : fileArrListFiles) {
                            try {
                                if (file.exists()) {
                                    if (file.length() == 0) {
                                        file.delete();
                                    } else {
                                        String absolutePath = file.getAbsolutePath();
                                        String strB = com.mg.ola.common.d.d.b(absolutePath);
                                        String strSubstring = absolutePath.substring(0, absolutePath.length() - strB.length());
                                        if (strB.startsWith(".temp")) {
                                            file.renameTo(new File(strSubstring + strB.replace(".temp", ".archived")));
                                        }
                                    }
                                }
                            } catch (Throwable unused) {
                            }
                        }
                        return null;
                    } catch (Throwable unused2) {
                        return null;
                    }
                }
            }.execute(new Void[0]);
        } catch (Throwable unused) {
        }
    }

    public static File j() {
        File file = new File(e(), ".acc");
        if (!file.exists()) {
            file.mkdir();
        }
        return file;
    }

    public static String k() {
        File file = new File(e() + "/Media");
        if (!file.exists()) {
            file.mkdirs();
        }
        return file.getAbsolutePath();
    }

    public static File l() {
        File file = new File((k() + "/") + f);
        if (!file.exists()) {
            file.mkdirs();
        }
        return file;
    }

    public static File m() {
        File file = new File((k() + "/") + d);
        if (!file.exists()) {
            file.mkdirs();
        }
        return file;
    }

    public static Map<String, File> n() {
        HashMap map = new HashMap(10);
        ArrayList arrayList = new ArrayList(10);
        ArrayList arrayList2 = new ArrayList(10);
        arrayList.add("/mnt/sdcard");
        arrayList2.add("/mnt/sdcard");
        try {
            File file = new File("/proc/mounts");
            if (file.exists()) {
                Scanner scanner = new Scanner(file);
                while (scanner.hasNext()) {
                    String strNextLine = scanner.nextLine();
                    if (strNextLine.startsWith("/dev/block/vold/")) {
                        String str = strNextLine.split(" ")[1];
                        if (!str.equals("/mnt/sdcard")) {
                            arrayList.add(str);
                        }
                    }
                }
                scanner.close();
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        try {
            File file2 = new File("/system/etc/vold.fstab");
            if (file2.exists()) {
                Scanner scanner2 = new Scanner(file2);
                while (scanner2.hasNext()) {
                    String strNextLine2 = scanner2.nextLine();
                    if (strNextLine2.startsWith("dev_mount")) {
                        String strSubstring = strNextLine2.split(" ")[2];
                        if (strSubstring.contains(":")) {
                            strSubstring = strSubstring.substring(0, strSubstring.indexOf(":"));
                        }
                        if (!strSubstring.equals("/mnt/sdcard")) {
                            arrayList2.add(strSubstring);
                        }
                    }
                }
                scanner2.close();
            }
        } catch (Throwable th2) {
            th2.printStackTrace();
        }
        int i = 0;
        while (i < arrayList.size()) {
            if (!arrayList2.contains((String) arrayList.get(i))) {
                arrayList.remove(i);
                i--;
            }
            i++;
        }
        arrayList2.clear();
        ArrayList arrayList3 = new ArrayList(10);
        Iterator it2 = arrayList.iterator();
        while (it2.hasNext()) {
            File file3 = new File((String) it2.next());
            if (file3.exists() && file3.isDirectory() && file3.canWrite()) {
                File[] fileArrListFiles = file3.listFiles();
                String str2 = "[";
                if (fileArrListFiles != null) {
                    String str3 = "[";
                    for (File file4 : fileArrListFiles) {
                        str3 = str3 + file4.getName().hashCode() + ":" + file4.length() + ", ";
                    }
                    str2 = str3;
                }
                String str4 = str2 + "]";
                if (!arrayList3.contains(str4)) {
                    String str5 = "sdCard_" + map.size();
                    if (map.size() == 0) {
                        str5 = "sdCard";
                    } else if (map.size() == 1) {
                        str5 = "externalSdCard";
                    }
                    arrayList3.add(str4);
                    map.put(str5, file3);
                }
            }
        }
        arrayList.clear();
        if (map.isEmpty()) {
            map.put("sdCard", Environment.getExternalStorageDirectory());
        }
        return map;
    }
}
