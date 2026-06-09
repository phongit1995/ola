package com.mg.ola.common.widget.image.viewer;

import android.annotation.TargetApi;
import android.content.Context;
import android.os.Build;
import android.widget.OverScroller;
import android.widget.Scroller;

/* JADX INFO: loaded from: classes2.dex */
public abstract class d {

    @TargetApi(9)
    private static class a extends d {
        private OverScroller a;

        public a(Context context) {
            this.a = new OverScroller(context);
        }

        @Override // com.mg.ola.common.widget.image.viewer.d
        public void a(int i, int i2, int i3, int i4, int i5, int i6, int i7, int i8, int i9, int i10) {
            this.a.fling(i, i2, i3, i4, i5, i6, i7, i8, i9, i10);
        }

        @Override // com.mg.ola.common.widget.image.viewer.d
        public void a(boolean z) {
            this.a.forceFinished(z);
        }

        @Override // com.mg.ola.common.widget.image.viewer.d
        public boolean a() {
            return this.a.computeScrollOffset();
        }

        @Override // com.mg.ola.common.widget.image.viewer.d
        public int b() {
            return this.a.getCurrX();
        }

        @Override // com.mg.ola.common.widget.image.viewer.d
        public int c() {
            return this.a.getCurrY();
        }
    }

    private static class b extends d {
        private Scroller a;

        public b(Context context) {
            this.a = new Scroller(context);
        }

        @Override // com.mg.ola.common.widget.image.viewer.d
        public void a(int i, int i2, int i3, int i4, int i5, int i6, int i7, int i8, int i9, int i10) {
            this.a.fling(i, i2, i3, i4, i5, i6, i7, i8);
        }

        @Override // com.mg.ola.common.widget.image.viewer.d
        public void a(boolean z) {
            this.a.forceFinished(z);
        }

        @Override // com.mg.ola.common.widget.image.viewer.d
        public boolean a() {
            return this.a.computeScrollOffset();
        }

        @Override // com.mg.ola.common.widget.image.viewer.d
        public int b() {
            return this.a.getCurrX();
        }

        @Override // com.mg.ola.common.widget.image.viewer.d
        public int c() {
            return this.a.getCurrY();
        }
    }

    public static d a(Context context) {
        return Build.VERSION.SDK_INT < 9 ? new b(context) : new a(context);
    }

    public abstract void a(int i, int i2, int i3, int i4, int i5, int i6, int i7, int i8, int i9, int i10);

    public abstract void a(boolean z);

    public abstract boolean a();

    public abstract int b();

    public abstract int c();
}
