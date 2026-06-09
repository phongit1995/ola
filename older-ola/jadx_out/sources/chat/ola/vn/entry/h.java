package chat.ola.vn.entry;

import chat.ola.vn.util.m;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class h {
    public long a = 0;
    public String[] b;
    public short c;
    public int d;
    private int[] e;

    public h(int i, short s, int... iArr) {
        this.e = iArr;
        this.d = i;
        this.c = s;
    }

    public h(int i, short s, String... strArr) {
        this.b = strArr;
        this.d = i;
        this.c = s;
    }

    public int[] a() {
        return this.e;
    }

    public int b() {
        if (this.e == null || this.e.length == 0) {
            return 0;
        }
        return this.e[0];
    }

    public JSONObject c() {
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("smileyType", (int) this.c);
            if (this.c == 0) {
                jSONObject.put("smileyTextContent", this.b[0]);
            } else if (this.c == 1) {
                jSONObject.put("emojiCode", this.e[0]);
            }
            jSONObject.put("lastHitTime", this.a);
            return jSONObject;
        } catch (Throwable unused) {
            return null;
        }
    }

    public boolean equals(Object obj) {
        h hVar;
        try {
            hVar = (h) obj;
        } catch (Throwable unused) {
        }
        if (this.c != hVar.c) {
            return false;
        }
        switch (hVar.c) {
            case 0:
                return m.b(this.b[0], hVar.b[0]);
            case 1:
                return m.b(String.valueOf(Character.toChars(b())), String.valueOf(Character.toChars(hVar.b())));
        }
        return super.equals(obj);
    }
}
