package chat.ola.vn.b;

import android.content.Context;
import android.graphics.Bitmap;
import android.view.MotionEvent;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.model.Marker;

/* JADX INFO: loaded from: classes.dex */
public class d implements GoogleMap.InfoWindowAdapter {
    private Context a;
    private a b;
    private String c = null;

    private class a extends FrameLayout {
        public Marker a;
        private ImageView c;
        private ImageView d;
        private TextView e;
        private TextView f;

        public a(Context context) {
            super(context);
            inflate(getContext(), R.layout.map_marker_info_layout, this);
            this.c = (ImageView) findViewById(R.id.imgMarketInfoConver);
            this.d = (ImageView) findViewById(R.id.imgMarketInfoAvatar);
            this.e = (TextView) findViewById(R.id.txtMarkerInfoTitle);
            this.f = (TextView) findViewById(R.id.txtMarkerInfoStatus);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void a() {
            String strD;
            TextView textView;
            int i;
            if (this.a == null) {
                return;
            }
            d.this.b.a = this.a;
            String snippet = this.a.getSnippet();
            if (snippet != null) {
                this.e.setText(snippet);
                if (chat.ola.vn.util.m.b(snippet, chat.ola.vn.h.a())) {
                    strD = chat.ola.vn.c.x.c;
                } else {
                    chat.ola.vn.message.f fVarA = chat.ola.vn.h.x.a(snippet);
                    strD = fVarA != null ? fVarA.d() : null;
                }
                String strD2 = chat.ola.vn.util.m.a(strD) ? null : chat.ola.vn.util.i.d(strD, "");
                if (chat.ola.vn.util.m.a(strD2)) {
                    textView = this.f;
                    i = 4;
                } else {
                    this.f.setText(chat.ola.vn.util.g.a().a(chat.ola.vn.util.h.a().a((CharSequence) strD2)));
                    textView = this.f;
                    i = 0;
                }
                textView.setVisibility(i);
            }
            c();
            b();
        }

        private void b() {
            String snippet;
            if (this.a == null || (snippet = this.a.getSnippet()) == null) {
                return;
            }
            this.d.setImageResource(R.drawable.ic_contact_photo);
            Bitmap bitmapC = chat.ola.vn.c.t.a().c(snippet);
            if (bitmapC != null) {
                this.d.setImageBitmap(bitmapC);
                return;
            }
            chat.ola.vn.c.f fVarB = chat.ola.vn.c.f.b(snippet);
            fVarB.a(new chat.ola.vn.c.g() { // from class: chat.ola.vn.b.d.a.1
                @Override // chat.ola.vn.c.g
                public void a(chat.ola.vn.c.f fVar) {
                    if (a.this.a == null || a.this.a.getSnippet() == null || !chat.ola.vn.util.m.b(a.this.a.getSnippet(), fVar.f())) {
                        return;
                    }
                    a.this.d.setImageBitmap(fVar.c());
                    a.this.a.showInfoWindow();
                }

                @Override // chat.ola.vn.c.g
                public void b(chat.ola.vn.c.f fVar) {
                }
            });
            try {
                new chat.ola.vn.c.e().a(fVarB);
            } catch (Throwable unused) {
            }
        }

        private void c() {
            if (this.a == null) {
                return;
            }
            this.c.setImageBitmap(null);
            if (this.a.getSnippet() != null) {
                Bitmap bitmapD = chat.ola.vn.c.t.a().d(this.a.getSnippet());
                if (bitmapD != null) {
                    this.c.setImageBitmap(bitmapD);
                    return;
                }
                if (chat.ola.vn.util.m.b(d.this.c, this.a.getSnippet())) {
                    this.c.setBackgroundColor(chat.ola.vn.f.K);
                    return;
                }
                chat.ola.vn.c.f fVarH = chat.ola.vn.c.f.h(this.a.getSnippet(), chat.ola.vn.e.c);
                fVarH.a(new chat.ola.vn.c.g() { // from class: chat.ola.vn.b.d.a.2
                    @Override // chat.ola.vn.c.g
                    public void a(chat.ola.vn.c.f fVar) {
                        if (a.this.a == null || a.this.a.getSnippet() == null || !chat.ola.vn.util.m.b(a.this.a.getSnippet(), fVar.f())) {
                            return;
                        }
                        a.this.c.setImageBitmap(fVar.c());
                        a.this.a.showInfoWindow();
                    }

                    @Override // chat.ola.vn.c.g
                    public void b(chat.ola.vn.c.f fVar) {
                        if (a.this.a == null || a.this.a.getSnippet() == null || !chat.ola.vn.util.m.b(a.this.a.getSnippet(), fVar.f())) {
                            return;
                        }
                        a.this.c.setBackgroundColor(chat.ola.vn.f.K);
                        a.this.a.showInfoWindow();
                        d.this.c = a.this.a.getSnippet();
                    }
                });
                try {
                    new chat.ola.vn.c.e().a(fVarH);
                } catch (Throwable unused) {
                }
            }
        }

        @Override // android.view.ViewGroup, android.view.View
        public boolean dispatchTouchEvent(MotionEvent motionEvent) {
            return true;
        }

        @Override // android.view.ViewGroup
        public boolean onInterceptTouchEvent(MotionEvent motionEvent) {
            return super.onInterceptTouchEvent(motionEvent);
        }

        @Override // android.view.View
        public boolean onTouchEvent(MotionEvent motionEvent) {
            return super.onTouchEvent(motionEvent);
        }
    }

    public d(Context context, View.OnClickListener onClickListener) {
        this.a = context;
    }

    @Override // com.google.android.gms.maps.GoogleMap.InfoWindowAdapter
    public View getInfoContents(Marker marker) {
        return null;
    }

    @Override // com.google.android.gms.maps.GoogleMap.InfoWindowAdapter
    public View getInfoWindow(Marker marker) {
        if (this.b == null) {
            this.b = new a(this.a);
        }
        this.b.a = marker;
        this.b.a();
        return this.b;
    }
}
