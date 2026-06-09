package chat.ola.vn.e;

import chat.ola.vn.entity.w;
import java.io.File;
import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class b implements Comparator<File> {
    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(File file, File file2) {
        boolean zB = w.b(file.getName());
        boolean zB2 = w.b(file2.getName());
        if (zB && zB2) {
            return 0;
        }
        if (zB) {
            return 1;
        }
        if (zB2) {
            return -1;
        }
        if (file.lastModified() > file2.lastModified()) {
            return 1;
        }
        return file.lastModified() < file2.lastModified() ? -1 : 0;
    }
}
