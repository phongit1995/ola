package bolts;

import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class e {
    private final g a;

    public boolean a() {
        return this.a.a();
    }

    public String toString() {
        return String.format(Locale.US, "%s@%s[cancellationRequested=%s]", getClass().getName(), Integer.toHexString(hashCode()), Boolean.toString(this.a.a()));
    }
}
